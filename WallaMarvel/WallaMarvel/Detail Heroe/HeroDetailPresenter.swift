//
//  HeroDetailPresenter.swift
//  WallaMarvel
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Composition
import Domain
import Foundation

protocol HeroDetailPresenterProtocol: AnyObject {
    var ui: HeroDetailUI? { get set }
    var navigationTitle: String { get }
    
    func loadDetails() async
}

protocol HeroDetailUI: AnyObject {
    func update()
}

final class HeroDetailPresenter {
    private var hero: Hero
    
    var ui: HeroDetailUI?
    var navigationTitle: String { hero.name }
    
    private let getHeroDetailsUseCase: GetHeroDetailsUseCaseProtocol
    
    init(hero: Hero,
         getHeroDetailsUseCase: GetHeroDetailsUseCaseProtocol = ModuleFactory.makeGetHeroDetailsUseCase()) {
        self.hero = hero
        self.getHeroDetailsUseCase = getHeroDetailsUseCase
    }
}

extension HeroDetailPresenter: HeroDetailPresenterProtocol {
    func loadDetails() async {
        if let details = try? await getHeroDetailsUseCase.execute(id: hero.id) {
            hero = details
            ui?.update()
        }
    }
}
