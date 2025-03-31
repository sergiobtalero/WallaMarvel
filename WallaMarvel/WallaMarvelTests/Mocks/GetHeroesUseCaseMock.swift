//
//  GetHeroesUseCaseMock.swift
//  WallaMarvelTests
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain
import Foundation

struct TestError: Error {
    let description: String
}

final class GetHeroesUseCaseMock: GetHeroesUseCaseProtocol {
    var error: TestError?
    
    func execute(page: Int) async throws -> DataContainer<Hero> {
        if let error {
            throw error
        }
        
        let thumbnail = Thumbnail(path: "path", extension: "jpg")
        let heroes: [Hero] = [
            Hero(id: 1, name: "Spider Man", description: "Defender of NYC", thumbnail: thumbnail)
        ]
        return DataContainer<Hero>(count: 20, limit: 100, offset: 0, total: 100, results: heroes)
    }
}
