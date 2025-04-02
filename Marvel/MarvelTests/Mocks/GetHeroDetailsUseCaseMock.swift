//
//  GetHeroDetailsUseCaseMock.swift
//  MarvelTests
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain

final class GetHeroDetailsUseCaseMock: GetCharacterDetailsUseCaseProtocol {
    func execute(id: Int) async throws -> Character {
        if let character = marvelCharacters.first(where: { $0.id == id }) {
            return character
        } else {
            throw TestError(description: "Default error")
        }
    }
}
