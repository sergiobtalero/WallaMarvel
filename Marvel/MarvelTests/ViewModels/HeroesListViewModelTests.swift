//
//  HeroesListViewModelTests.swift
//  MarvelTests
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain
import Testing
@testable import Marvel

struct HeroesListViewModelTests {
    @Test
    func loadFirstPage_WhenSucceeds_SetsStateWithCharacters() async throws {
        let getHeroesUseCaseMock = GetCharactersUseCaseMock()
        let sut = CharactersListViewModel(getHeroesUseCase: getHeroesUseCaseMock)
        
        await sut.loadFirstPage()
        
        guard case .loaded(let characters) = sut.state else {
            throw TestError(description: "Invalid state.")
        }
        #expect(characters.count == 10)
    }
    
    @Test
    func searchText_WhenChanges_AndValuesFound_UpdatesViewStateWithMatches() async throws {
        let getHeroesUseCaseMock = GetCharactersUseCaseMock()
        let sut = CharactersListViewModel(getHeroesUseCase: getHeroesUseCaseMock)
        await sut.loadFirstPage()
        
        guard case .loaded(let initialCharacters) = sut.state else {
            throw TestError(description: "Invalid state.")
        }
        #expect(initialCharacters.count == 10)
        
        sut.searchText = "Star"
        
        guard case .loaded(let filteredCharacters) = sut.state else {
            throw TestError(description: "Invalid state.")
        }
        
        #expect(filteredCharacters.count == 1)
    }
    
    @Test
    func onCharacterAppearCalled_WhenThresholdIsMet_UpdatesViewStateWithCharactersOfNewPage() async throws {
        let getHeroesUseCaseMock = GetCharactersUseCaseMock()
        let sut = CharactersListViewModel(getHeroesUseCase: getHeroesUseCaseMock)
        
        await sut.loadFirstPage()
        
        let nextResponse = DataContainer<Character>(count: 100, limit: 100, offset: 0, total: 100, results: moreMarvelCharacters)
        getHeroesUseCaseMock.nextResponse = nextResponse
        
        for character in marvelCharacters {
            sut.onCharacterAppear(character)
        }
        try await Task.sleep(nanoseconds: 1_000_000)
        guard case .loaded(let characters) = sut.state else {
            throw TestError(description: "Invalid state.")
        }
        #expect(characters.count == 15)
    }
    
    @Test
    func loadFirstPage_WhenFails_UpdatesStateToEmpty() async throws {
        let getHeroesUseCaseMock = GetCharactersUseCaseMock()
        getHeroesUseCaseMock.error = TestError(description: "Bad server response")
        let sut = CharactersListViewModel(getHeroesUseCase: getHeroesUseCaseMock)
        
        await sut.loadFirstPage()
        
        guard case .empty = sut.state else {
            throw TestError(description: "Invalid state.")
        }
    }
    
//    @Test
//    func didSelectHero_setsSelectedHero() {
//        let getHeroesUseCaseMock = GetHeroesUseCaseMock()
//        let viewModel = HeroesListViewModel(getHeroesUseCase: getHeroesUseCaseMock)
//        let hero = Hero(id: 1, name: "Spider Man", description: "Spider Man", thumbnail: Thumbnail(path: "path", extension: "extension"))
//        viewModel.didSelectHero(hero)
//        
//        #expect(viewModel.heroSelected == hero)
//    }
//
}
