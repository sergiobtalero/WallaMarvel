//
//  MarvelRepositoryMock.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Domain
import Foundation

final class MarvelRepositoryMock: MarvelRepositoryProtocol {
    var error: Error?
    
    func getHeroes(page: Int) async throws -> CharacterDataContainer {
        if let error = error {
            throw error
        }
        let characters = [CharacterDataModel(id: 0, name: "test", thumbnail: Thumbnail(path: "image", extension: "jpg"))]
        return CharacterDataContainer(count: 100, limit: 100, offset: 0, characters: characters)
    }
}
