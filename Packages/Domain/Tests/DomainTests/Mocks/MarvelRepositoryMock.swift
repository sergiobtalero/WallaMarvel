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
    
    func getHeroes(page: Int) async throws -> DataContainer<Character> {
        if let error = error {
            throw error
        }
        let characters = [Character(id: 0, name: "test", description: "desciption", thumbnailURL: nil)]
        return DataContainer<Character>(count: 100, limit: 100, offset: 0, total: 100, results: characters)
    }
    
    func getDetailsOfHero(id: Int) async throws -> Character {
        return Character(id: 0, name: "test", description: "description", thumbnailURL: nil)
    }
    
    func getComicsOfHero(id: Int) async throws -> [Comic] {
        return [
            Comic(id: 1, title: "Comic 1", description: "Description", pageCount: 100, thumbnailURL: nil, images: [URL(string: "www.test.com")!]),
            Comic(id: 2, title: "Comic 2", description: "Description", pageCount: 100, thumbnailURL: nil, images: [URL(string: "www.test.com")!])
        ]
    }
    
    func getSeriesOfHero(id: Int) async throws -> [Series] {
        return [
            Series(id: 1, title: "Series 1", description: "Description", startYear: 2000, endYear: 2010, thumbnailURL: URL(string: "www.test.com")!)
        ]
    }
}
