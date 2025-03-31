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
    func test_loadHeroes_callsUpdateOnUI() {
        let updateExpectation = expectation(description: "update called")
        let getHeroesUseCase = GetHeroesUseCaseMock()
        let sut = ListHeroesPresenter(getHeroesUseCase: getHeroesUseCase)
        let spy = ListHeroesUISpy(updateExpectation: updateExpectation)
        sut.ui = spy
        sut.getHeroes()
        wait(for: [updateExpectation], timeout: 5)
        XCTAssertEqual(spy.updateCalledCount, 1)
    }
    
    func test_loadHeroes_whenFails_doesNotUpdateUI() {
        let getHeroesUseCase = GetHeroesUseCaseMock()
        let sut = ListHeroesPresenter(getHeroesUseCase: getHeroesUseCase)
        let spy = ListHeroesUISpy(updateExpectation: nil)
        sut.ui = spy
        sut.getHeroes()
        XCTAssertEqual(spy.updateCalledCount, 0)
    }
}
