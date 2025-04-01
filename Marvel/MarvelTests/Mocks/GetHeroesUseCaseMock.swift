//
//  GetHeroesUseCaseMock.swift
//  MarvelTests
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain
import Foundation

final class GetHeroesUseCaseMock: GetCharactersUseCaseProtocol {
    var response: DataContainer<Character>
    var nextResponse: DataContainer<Character>?
    var executeCallCount = 0
    
    init(response: DataContainer<Character>) {
        self.response = response
    }
    
    convenience init() {
        let characters = [
            Character(id: 1, name: "Spider Man", description: "Spider Man", thumbnailURL: nil),
            Character(id: 2, name: "Hulk", description: "Hulk", thumbnailURL: nil)
        ]
        self.init(response: DataContainer(count: 10, limit: 100, offset: 0, total: 100, results: characters))
    }

    func execute(page: Int) async throws -> DataContainer<Character> {
        executeCallCount += 1
        return nextResponse ?? response
    }
}
