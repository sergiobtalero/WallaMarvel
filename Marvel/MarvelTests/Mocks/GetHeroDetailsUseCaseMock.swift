//
//  GetHeroDetailsUseCaseMock.swift
//  MarvelTests
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain

final class GetHeroDetailsUseCaseMock: GetCharacterDetailsUseCaseProtocol {
    var heroToReturn: Character?
    
    func execute(id: Int) async throws -> Character {
        return heroToReturn!
    }
}
