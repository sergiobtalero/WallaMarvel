//
//  GetHeroDetailsUseCase.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Foundation

public protocol GetHeroDetailsUseCaseProtocol {
    func execute(id: Int) async throws -> CharacterDataModel
}

public final class GetHeroDetailsUseCase {
    private let repository: MarvelRepositoryProtocol
    
    public init(repository: MarvelRepositoryProtocol) {
        self.repository = repository
    }
}

extension GetHeroDetailsUseCase: GetHeroDetailsUseCaseProtocol {
    public func execute(id: Int) async throws -> CharacterDataModel {
        let heroDetails = try await repository.getDetailsOfHero(id: id)
        let comics = try await repository.getComicsOfHero(id: id)
        try await repository.getSeriesOfHero(id: id)
        return heroDetails
    }
}
