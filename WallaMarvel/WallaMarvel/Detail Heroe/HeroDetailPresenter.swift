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
    var hero: Hero { get }
    
    func loadDetails() async
}

protocol HeroDetailUI: AnyObject {
    func update(imageURL: URL?, description: String?, showComics: Bool, showSeries: Bool)
}

final class HeroDetailPresenter {
    private(set) var hero: Hero
    
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
    @MainActor func loadDetails() async {
        if let details = try? await getHeroDetailsUseCase.execute(id: hero.id) {
            hero = details
            ui?.update(imageURL: hero.imageURL,
                       description: hero.description != "" ? hero.description : nil,
                       showComics: !hero.comics.isEmpty,
                       showSeries: !hero.series.isEmpty)
        }
    }
}
