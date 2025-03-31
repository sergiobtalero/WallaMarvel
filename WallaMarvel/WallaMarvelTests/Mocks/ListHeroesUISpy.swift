//
//  ListHeroesUISpy.swift
//  WallaMarvel
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import XCTest
@testable import WallaMarvel

class ListHeroesUISpy: ListHeroesUI {
    let updateExpectation: XCTestExpectation?
    var updateCalledCount = 0
    
    init(updateExpectation: XCTestExpectation?) {
        self.updateExpectation = updateExpectation
    }
    
    func update() {
        updateCalledCount += 1
        updateExpectation?.fulfill()
    }
}
