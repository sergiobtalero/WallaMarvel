//
//  GetHeroesUseCase.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Foundation

public protocol GetCharactersUseCaseProtocol {
    func execute(page: Int) async throws -> DataContainer<Character>
}

public final class GetCharactersUseCase {
    private let repository: MarvelRepositoryProtocol
    
    public init(repository: MarvelRepositoryProtocol) {
        self.repository = repository
    }
}

extension GetCharactersUseCase: GetCharactersUseCaseProtocol {
    public func execute(page: Int) async throws -> DataContainer<Character> {
        try await repository.getHeroes(page: page)
    }
}
