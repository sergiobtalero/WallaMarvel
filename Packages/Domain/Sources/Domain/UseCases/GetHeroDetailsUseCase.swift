//
//  GetHeroDetailsUseCase.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Foundation

public protocol GetHeroDetailsUseCaseProtocol {
    func execute(id: Int) async throws -> Hero
}

public final class GetHeroDetailsUseCase {
    private let repository: MarvelRepositoryProtocol
    
    public init(repository: MarvelRepositoryProtocol) {
        self.repository = repository
    }
}

extension GetHeroDetailsUseCase: GetHeroDetailsUseCaseProtocol {
    public func execute(id: Int) async throws -> Hero {
        var details = try await repository.getDetailsOfHero(id: id)
        let comics = try? await repository.getComicsOfHero(id: id)
        let series = try? await repository.getSeriesOfHero(id: id)
        comics.map { details.comics = $0 }
        series.map { details.series = $0 }
        return details
    }
}
