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
}

final class HeroDetailViewModel {
    private let hero: CharacterDataModel
    private let getHeroDetailsUseCase: GetHeroDetailsUseCaseProtocol
    
    init(hero: CharacterDataModel,
         getHeroDetailsUseCase: GetHeroDetailsUseCaseProtocol = ModuleFactory.makeGetHeroDetailsUseCase()) {
        self.hero = hero
        self.getHeroDetailsUseCase = getHeroDetailsUseCase
    }
}

extension HeroDetailViewModel: HeroDetailViewModelProtocol {
    func loadDetails() async {
        do {
            let details = try await getHeroDetailsUseCase.execute(id: hero.id)
            print(details)
        } catch {
            print(error.localizedDescription)
        }
    }
}
