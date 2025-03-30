//
//  GetHeroesUseCase.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Foundation

public protocol GetHeroesUseCaseProtocol {
    func execute() async throws -> CharacterDataContainer
}

final class GetHeroesUseCase {
    private let repository: MarvelRepositoryProtocol
    
    init(repository: MarvelRepositoryProtocol) {
        self.repository = repository
    }
}

extension GetHeroesUseCase: GetHeroesUseCaseProtocol {
    func execute() async throws -> CharacterDataContainer {
        try await repository.getHeroes()
    }
}
