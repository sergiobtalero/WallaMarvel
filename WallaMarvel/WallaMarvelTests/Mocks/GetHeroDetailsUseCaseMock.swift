//
//  GetHeroDetailsUseCaseMock.swift
//  WallaMarvelTests
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain
import Foundation

final class GetHeroDetailsUseCaseMock: GetHeroDetailsUseCaseProtocol {
    var error: TestError?
    
    func execute(id: Int) async throws -> Hero {
        if let error { throw error }
        let thumbnail = Thumbnail(path: "path", extension: "jpg")
        var hero = Hero(id: 1, name: "Spider Man", description: "Defender of NYC", thumbnail: thumbnail)
        let comics = [Comic(id: 1, title: "title", description: "desc", pageCount: 100, thumbnail: thumbnail, images: [thumbnail])]
        hero.comics = comics
        return hero
    }
}
