//
//  CharactersListViewModel.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Combine
import Composition
import Domain
import Foundation

protocol CharactersListViewModelProtocol: ObservableObject {
    var navigationTitle: String { get }
    var searchText: String { get set }
    var state: CharactersListScreenState { get }
    
    func loadFirstPage() async
    func onCharacterAppear(_ character: Character)
}

enum CharactersListScreenState: Equatable {
    case idle
    case empty
    case loading
    case loaded(characters: [Character])
}

final class CharactersListViewModel {
    @Published private(set) var state: CharactersListScreenState = .idle
    @Published var searchText: String = ""
    
    private let getHeroesUseCase: GetCharactersUseCaseProtocol
    private let nameFilter: HeroFilterStrategy
    
    private let heroesSubject = CurrentValueSubject<[Character], Never>([])
    private var subscriptions = Set<AnyCancellable>()
    
    private var currentPage = 1
    private var totalHeroes: Int = .min
    private var isLoadingNextPage = false
    private var currentTask: Task<Void, Never>? {
        willSet {
            if let currentTask {
                if currentTask.isCancelled { return }
                currentTask.cancel()
            }
        }
    }
    
    var navigationTitle: String {
        "Heroes"
    }
    
    private var canLoadMorePages: Bool {
        heroesSubject.value.count < totalHeroes
    }
    
    private var canLoadNextPage: Bool {
        !isLoadingNextPage && canLoadMorePages && searchText.isEmpty
    }
    
    // MARK: - Initializer
    init(getHeroesUseCase: GetCharactersUseCaseProtocol = ModuleFactory.makeGetHeroesUseCase(),
         nameFilter: HeroFilterStrategy = NameFilter()) {
        self.getHeroesUseCase = getHeroesUseCase
        self.nameFilter = nameFilter
        setupBindings()
    }
}

// MARK: - CharactersListViewModelProtocol
extension CharactersListViewModel: CharactersListViewModelProtocol {
    @MainActor func loadFirstPage() async {
        state = .loading
        
        if let container = try? await getHeroesUseCase.execute(page: 1) {
            totalHeroes = max(container.total, totalHeroes)
            updateHeroes(container.results)
        } else {
            state = .empty
        }
    }
    
    func onCharacterAppear(_ character: Character) {
        guard canLoadNextPage else {
            return
        }
        
        guard
            case .loaded(let characters) = state,
            let index = characters.firstIndex(where: { $0.id == character.id }) else {
            return
        }
        
        let threshold = 5 // Launch n characters before last one
        let thresholdIndex = characters.index(characters.endIndex, offsetBy: -threshold)
        
        if index != thresholdIndex {
            return
        }
        isLoadingNextPage = true
        currentTask = Task {
            async let container = getHeroesUseCase.execute(page: currentPage)
            if let container = try? await container {
                await updateHeroes(container.results)
            }
            isLoadingNextPage = false
        }
    }
}

// MARK: - Bindings
private extension CharactersListViewModel {
    func setupBindings() {
        bindSearchText()
    }
    
    func bindSearchText() {
        heroesSubject
            .combineLatest($searchText)
            .sink { [weak self] allHeroes, searchText in
                guard let self else { return }
                
                if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    state = .loaded(characters: allHeroes)
                } else {
                    state = .loaded(characters: nameFilter.filter(heroes: allHeroes, withSearchText: searchText))
                }
            }
            .store(in: &subscriptions)
    }
}

// MARK: - Private
private extension CharactersListViewModel {
    @MainActor func updateHeroes(_ heroes: [Character]) {
        var loadedHeroes = heroesSubject.value
        loadedHeroes.append(contentsOf: heroes)
        
        heroesSubject.send(loadedHeroes)
        state = .loaded(characters: loadedHeroes)
        currentPage += 1
    }
}
