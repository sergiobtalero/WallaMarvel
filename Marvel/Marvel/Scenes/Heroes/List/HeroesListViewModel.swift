//
//  HeroesListViewModel.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Composition
import Domain
import Foundation

final class HeroesListViewModel: ObservableObject {
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    private var currentPage: Int = 1
    private var canLoadMore: Bool = true
    
    var navigationTitle: String { "Heroes" }
    
    @Published var isLoading: Bool = false
    @Published var heroes: [CharacterDataModel] = []
    @Published var filteredHeroes: [CharacterDataModel] = []
    @Published var query: String = ""
    
    init(getHeroesUseCase: GetHeroesUseCaseProtocol = ModuleFactory.makeGetHeroesUseCase()) {
        self.getHeroesUseCase = getHeroesUseCase
    }
    
    @MainActor func fetchHeroes() async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            let container = try await getHeroesUseCase.execute(page: currentPage)
            heroes = container.characters
            canLoadMore = heroes.count < container.total
            currentPage += 1
        } catch {
            // TODO: Handle error
        }
    }
    
    @MainActor func loadNextPage() async {
        guard !isLoading, canLoadMore else {
            return
        }
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        if let container = try? await getHeroesUseCase.execute(page: currentPage) {
            heroes.append(contentsOf: container.characters)
            canLoadMore = heroes.count < container.total
            currentPage += 1
        }
    }
    
    func search(for query: String) {
        guard !query.isEmpty else {
            filteredHeroes.removeAll()
            return
        }
        filteredHeroes = heroes.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }
}
