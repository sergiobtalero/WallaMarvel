//
//  HeroDetailViewModel.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Composition
import Domain
import Foundation

protocol HeroDetailViewModelProtocol: ObservableObject {
    func loadDetails() async
    var hero: Hero { get set }
}

final class HeroDetailViewModel {
    private let getHeroDetailsUseCase: GetHeroDetailsUseCaseProtocol
    
    @Published var hero: Hero
    
    init(hero: Hero,
         getHeroDetailsUseCase: GetHeroDetailsUseCaseProtocol = ModuleFactory.makeGetHeroDetailsUseCase()) {
        self.hero = hero
        self.getHeroDetailsUseCase = getHeroDetailsUseCase
    }
}

// MARK: - HeroDetailViewModelProtocol
extension HeroDetailViewModel: HeroDetailViewModelProtocol {
    @MainActor func loadDetails() async {
        if let updatedHero = try? await getHeroDetailsUseCase.execute(id: hero.id) {
            objectWillChange.send()
            self.hero = updatedHero
        }
    }
}
