//
//  HeroDetailPresenterTests.swift
//  WallaMarvelTests
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain
import XCTest
@testable import WallaMarvel

final class HeroDetailPresenterTests: XCTestCase {
    func test_getDetails_callsUpdateUI() async {
        let thumbnail = Thumbnail(path: "path", extension: "jpg")
        let hero = Hero(id: 1, name: "Spider Man", description: "Defender of NYC", thumbnail: thumbnail)
        let useCase = GetHeroDetailsUseCaseMock()
        let sut =  HeroDetailPresenter(hero: hero, getHeroDetailsUseCase: useCase)
        await sut.loadDetails()
        XCTAssertEqual(sut.hero.comics.count, 1)
    }
}
