//
//  ListHeroesUISpy.swift
//  WallaMarvel
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import XCTest
@testable import WallaMarvel

class ListHeroesUISpy: ListHeroesUI {
    var updateCalledCount = 0
    
    func update() {
        updateCalledCount += 1
    }
}
