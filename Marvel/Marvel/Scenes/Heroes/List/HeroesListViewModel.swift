//
//  HeroesListViewModel.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Combine
import Composition
import Domain
import Foundation

protocol HeroesListViewModelProtocol: ObservableObject {
    var navigationTitle: String { get }
    var heroSelected: Hero? { get set }
    var searchText: String { get set }
    var state: HeroesListViewState { get }
    
    func loadFirstPage() async
    func loadNextPage() async
    func didSelectHero(_ hero: Hero?)
}

enum HeroesListViewState: Equatable {
    case idle
    case loading
    case loaded(characters: [Hero])
}

final class HeroesListViewModel {
    @Published private(set) var state: HeroesListViewState = .idle
    @Published var heroSelected: Hero?
    @Published var searchText: String = ""
    
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    private let nameFilter: HeroFilterStrategy
    
    private let heroesSubject = CurrentValueSubject<[Hero], Never>([])
    private var subscriptions = Set<AnyCancellable>()
    
    private var currentPage = 1
    private var totalHeroes: Int = .min
    private var isLoadingNextPage = false
    
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
    init(getHeroesUseCase: GetHeroesUseCaseProtocol = ModuleFactory.makeGetHeroesUseCase(),
         nameFilter: HeroFilterStrategy = NameFilter()) {
        self.getHeroesUseCase = getHeroesUseCase
        self.nameFilter = nameFilter
        setupBindings()
    }
}

// MARK: - HeroesListViewModelProtocol
extension HeroesListViewModel: HeroesListViewModelProtocol {
    @MainActor func loadFirstPage() async {
        state = .loading
        
        if let container = try? await getHeroesUseCase.execute(page: 1) {
            totalHeroes = max(container.total, totalHeroes)
            updateHeroes(container.results)
        }
    }
    
    @MainActor func loadNextPage() async {
        guard canLoadNextPage else { return }
        
        isLoadingNextPage = true
        defer { isLoadingNextPage = false }
        
        if let container = try? await getHeroesUseCase.execute(page: currentPage) {
            updateHeroes(container.results)
        }
    }
    
    func didSelectHero(_ hero: Hero?) {
        heroSelected = hero
    }
}

// MARK: - Bindings
private extension HeroesListViewModel {
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
private extension HeroesListViewModel {
    func updateHeroes(_ heroes: [Hero]) {
        var loadedHeroes = heroesSubject.value
        loadedHeroes.append(contentsOf: heroes)
        
        heroesSubject.send(loadedHeroes)
        state = .loaded(characters: loadedHeroes)
        currentPage += 1
    }
}
