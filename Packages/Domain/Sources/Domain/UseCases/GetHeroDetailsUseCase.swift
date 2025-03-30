//
//  GetHeroDetailsUseCase.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Foundation

public protocol GetHeroDetailsUseCaseProtocol {
    func execute(id: String) async throws
}

public final class GetHeroDetailsUseCase {
    private let repository: MarvelRepositoryProtocol
    
    public init(repository: MarvelRepositoryProtocol) {
        self.repository = repository
    }
}

extension GetHeroDetailsUseCase: GetHeroDetailsUseCaseProtocol {
    public func execute(id: String) async throws {
        try await repository.getDetailsOfHero(id: id)
    }
}
