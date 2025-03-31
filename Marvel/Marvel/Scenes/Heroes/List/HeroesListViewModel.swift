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
    var heroes: [CharacterDataModel] { get set }
    var heroSelected: CharacterDataModel? { get set }
    var query: String { get set }
    var isLoading: Bool { get }
    
    func loadFirstPage() async
    func loadNextPage() async
    func didSelectHero(_ hero: CharacterDataModel?)
}

final class HeroesListViewModel {
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    
    private var subscriptions = Set<AnyCancellable>()
    private let heroesSubject = CurrentValueSubject<[CharacterDataModel], Never>([])
    
    var navigationTitle: String { "Heroes" }
    
    private var currentPage: Int = 1
    private var canLoadMore: Bool = true
    private var totalHeroes: Int = .min
    private(set) var isLoading: Bool = false
    
    @Published var heroSelected: CharacterDataModel?
    @Published var heroes: [CharacterDataModel] = []
    @Published var query: String = ""
    
    init(getHeroesUseCase: GetHeroesUseCaseProtocol = ModuleFactory.makeGetHeroesUseCase()) {
        self.getHeroesUseCase = getHeroesUseCase
        setupBindings()
    }
}

// MARK: - HeroesListViewModelProtocol
extension HeroesListViewModel: HeroesListViewModelProtocol {
    @MainActor func loadFirstPage() async {
        isLoading = true
        currentPage = 1
        
        defer {
            isLoading = false
        }
        
        if let container = try? await getHeroesUseCase.execute(page: currentPage) {
            totalHeroes = max(container.total, totalHeroes)
            updateHeroes(container.results)
        }
    }
    
    @MainActor func loadNextPage() async {
        guard !isLoading && canLoadMore && query.isEmpty else {
            return
        }
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        if let container = try? await getHeroesUseCase.execute(page: currentPage) {
            updateHeroes(container.results)
        }
    }
    
    func didSelectHero(_ hero: CharacterDataModel?) {
        heroSelected = hero
    }
}

// MARK: - Bindings
private extension HeroesListViewModel {
    func setupBindings() {
        bindQuery()
    }
    
    func bindQuery() {
        heroesSubject
            .combineLatest($query)
            .sink { [weak self] allHeroes, query in
                guard let self else { return }
                if query.isEmpty {
                    heroes = allHeroes
                } else {
                    heroes = allHeroes.filter { $0.name.localizedCaseInsensitiveContains(query) }
                }
            }
            .store(in: &subscriptions)
    }
}

// MARK: - Private
private extension HeroesListViewModel {
    func updateHeroes(_ heroes: [CharacterDataModel]) {
        var loadedHeroes = heroesSubject.value
        loadedHeroes.append(contentsOf: heroes)
        heroesSubject.send(loadedHeroes)
        canLoadMore = loadedHeroes.count < totalHeroes
        currentPage += 1
    }
}
