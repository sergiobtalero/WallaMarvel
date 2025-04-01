//
//  GetHeroDetailsUseCaseMock.swift
//  MarvelTests
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain

final class GetHeroDetailsUseCaseMock: GetHeroDetailsUseCaseProtocol {
    var heroToReturn: Character?
    
    func execute(id: Int) async throws -> Character {
        return heroToReturn!
    }
}
