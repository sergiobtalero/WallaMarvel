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
        let characters = [Character(id: 0, name: "test", description: "desciption", thumbnail: Thumbnail(path: "image", extension: "jpg"))]
        return DataContainer<Character>(count: 100, limit: 100, offset: 0, total: 100, results: characters)
    }
    
    func getDetailsOfHero(id: Int) async throws -> Character {
        return Character(id: 0, name: "test", description: "desciption", thumbnail: Thumbnail(path: "image", extension: "jpg"))
    }
    
    func getComicsOfHero(id: Int) async throws -> [Comic] {
        let thumbnail = Thumbnail(path: "image", extension: "jpg")
        return [
            Comic(id: 1, title: "Comic 1", description: "Description", pageCount: 100, thumbnail: thumbnail, images: [thumbnail]),
            Comic(id: 2, title: "Comic 2", description: "Description", pageCount: 100, thumbnail: thumbnail, images: [thumbnail])
        ]
    }
    
    func getSeriesOfHero(id: Int) async throws -> [Series] {
        let thumbnail = Thumbnail(path: "image", extension: "jpg")
        return [
            Series(id: 1, title: "Series 1", description: "Description", startYear: 2000, endYear: 2010, thumbnail: thumbnail)
        ]
    }
}
