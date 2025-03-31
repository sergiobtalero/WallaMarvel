//
//  GetHeroesUseCaseMock.swift
//  MarvelTests
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain
import Foundation

final class GetHeroesUseCaseMock: GetHeroesUseCaseProtocol {
    var response: CharacterDataContainer
    var nextResponse: CharacterDataContainer?
    var executeCallCount = 0
    
    init(response: CharacterDataContainer) {
        self.response = response
    }
    
    convenience init() {
        let characters = [
            Hero(id: 1, name: "Spider Man", description: "Spider Man", thumbnail: Thumbnail(path: "path", extension: "extension")),
            Hero(id: 2, name: "Hulk", description: "Hulk", thumbnail: Thumbnail(path: "path", extension: "extension"))
        ]
        self.init(response: CharacterDataContainer(count: 10, limit: 100, offset: 0, total: 100, characters: characters))
    }

    func execute(page: Int) async throws -> CharacterDataContainer {
        executeCallCount += 1
        return nextResponse ?? response
    }
}
