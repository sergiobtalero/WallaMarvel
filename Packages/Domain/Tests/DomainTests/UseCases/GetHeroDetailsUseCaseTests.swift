//
//  GetHeroDetailsUseCaseTests.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Testing
@testable import Domain

struct GetHeroDetailsUseCaseTests {
    @Test func testExecute() async throws {
        let repository = MarvelRepositoryMock()
        let sut = GetHeroDetailsUseCase(repository: repository)
        let hero = try await sut.execute(id: 1)
        #expect(hero.comics.count == 2)
        #expect(hero.series.count == 1)
    }

}
