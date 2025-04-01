//
//  GetCharacterDetailsUseCase.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Foundation

public protocol GetCharacterDetailsUseCaseProtocol {
    func execute(id: Int) async throws -> Character
}

public final class GetCharacterDetailsUseCase {
    private let repository: MarvelRepositoryProtocol
    
    public init(repository: MarvelRepositoryProtocol) {
        self.repository = repository
    }
}

extension GetCharacterDetailsUseCase: GetCharacterDetailsUseCaseProtocol {
    public func execute(id: Int) async throws -> Character {
        var details = try await repository.getDetailsOfHero(id: id)
        let comics = try? await repository.getComicsOfHero(id: id)
        let series = try? await repository.getSeriesOfHero(id: id)
        comics.map { details.comics = $0 }
        series.map { details.series = $0 }
        return details
    }
}
