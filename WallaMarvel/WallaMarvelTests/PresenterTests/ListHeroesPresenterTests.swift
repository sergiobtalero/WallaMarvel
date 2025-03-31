//
//  ListHeroesPresenterTests.swift
//  WallaMarvelTests
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Foundation
import XCTest
@testable import WallaMarvel

final class ListHeroesPresenterTests: XCTestCase {
    func test_loadHeroes_callsUpdateOnUI() async {
        let getHeroesUseCase = GetHeroesUseCaseMock()
        let sut = ListHeroesPresenter(getHeroesUseCase: getHeroesUseCase)
        let spy = ListHeroesUISpy()
        sut.ui = spy
        await sut.getHeroes()
        XCTAssertEqual(spy.updateCalledCount, 1)
    }
    
    func test_loadHeroes_whenFails_doesNotUpdateUI() async {
        let getHeroesUseCase = GetHeroesUseCaseMock()
        getHeroesUseCase.error = .init(description: "Random error")
        let sut = ListHeroesPresenter(getHeroesUseCase: getHeroesUseCase)
        let spy = ListHeroesUISpy()
        sut.ui = spy
        await sut.getHeroes()
        XCTAssertEqual(spy.updateCalledCount, 0)
    }
    
    func test_loadNextPage_callsUpdateOnUI() async {
        let getHeroesUseCase = GetHeroesUseCaseMock()
        let sut = ListHeroesPresenter(getHeroesUseCase: getHeroesUseCase)
        let spy = ListHeroesUISpy()
        sut.ui = spy
        await sut.getHeroes()
        await sut.loadNextPage()
        XCTAssertEqual(sut.heroes.count, 2)
        XCTAssertEqual(spy.updateCalledCount, 2)
    }
    
    func test_loadNextPage_onFiltering_doesNotUPdateUI() async {
        let getHeroesUseCase = GetHeroesUseCaseMock()
        let sut = ListHeroesPresenter(getHeroesUseCase: getHeroesUseCase)
        let spy = ListHeroesUISpy()
        sut.ui = spy
        await sut.getHeroes()
        sut.query("Spider")
        await sut.loadNextPage()
        XCTAssertEqual(sut.heroes.count, 1)
        XCTAssertEqual(spy.updateCalledCount, 2)
    }
}
