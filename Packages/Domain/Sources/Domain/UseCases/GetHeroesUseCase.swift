//
//  GetHeroesUseCase.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Foundation

public protocol GetHeroesUseCaseProtocol {
    func execute(page: Int) async throws -> DataContainer<CharacterDataModel>
}

public final class GetHeroesUseCase {
    private let repository: MarvelRepositoryProtocol
    
    public init(repository: MarvelRepositoryProtocol) {
        self.repository = repository
    }
}

extension GetHeroesUseCase: GetHeroesUseCaseProtocol {
    public func execute(page: Int) async throws -> DataContainer<CharacterDataModel> {
        try await repository.getHeroes(page: page)
    }
}
