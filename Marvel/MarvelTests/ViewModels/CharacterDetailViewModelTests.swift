//
//  HeroDetailViewModelTests.swift
//  MarvelTests
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain
import Testing
@testable import Marvel

struct CharacterDetailViewModelTests {
    @Test func loadDetails_WhenSuccess_SetsLoadedStateWithCharacter() async throws {
        let characterId = 1001
        let useCase = GetHeroDetailsUseCaseMock()
        let sut = CharacterDetailViewModel(characterId: characterId, getHeroDetailsUseCase: useCase)

        await sut.loadDetails()

        guard case .loaded(let character) = sut.state else {
            throw TestError(description: "Unexpected state")
        }
        #expect(characterId == character.id)
    }

    @Test func loadDetails_WhenNoMatchIsFound_SetsErrorState() async throws {
        let characterId = 1000
        let useCase = GetHeroDetailsUseCaseMock()
        let sut = CharacterDetailViewModel(characterId: characterId, getHeroDetailsUseCase: useCase)

        await sut.loadDetails()

        guard case .error = sut.state else {
            throw TestError(description: "Unexpected state")
        }
    }
}
