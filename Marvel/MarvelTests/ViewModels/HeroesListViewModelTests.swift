//
//  HeroesListViewModelTests.swift
//  MarvelTests
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain
import Testing
@testable import Marvel

struct TestError: Error {
    let description: String
}

struct HeroesListViewModelTests {
    @Test
    func loadFirstPage_WhenSucceeds_SetsLoadedStateWithCharacters() async throws {
        let getHeroesUseCaseMock = GetHeroesUseCaseMock()
        let sut = HeroesListViewModel(getHeroesUseCase: getHeroesUseCaseMock)
        
        await sut.loadFirstPage()
        
        guard case .loaded(let characters) = sut.state else {
            throw TestError(description: "Invalid state.")
        }
        #expect(characters.count == 2)
        #expect(characters.first?.name == "Spider Man")
    }
    
    @Test
    func query_filtersResults() async throws {
        let getHeroesUseCaseMock = GetHeroesUseCaseMock()
        let sut = HeroesListViewModel(getHeroesUseCase: getHeroesUseCaseMock)
        await sut.loadFirstPage()
        
        sut.searchText = "Spider"
        
        guard case .loaded(let characters) = sut.state else {
            throw TestError(description: "Invalid state.")
        }
        
        #expect(characters.count == 1)
        #expect(characters.first?.name == "Spider Man")
    }
    
//    @Test
//    func loadNextPage_appendsHeroes() async throws {
//        let initialCharacters = [
//            Hero(id: 1, name: "Spider Man", description: "Spider Man", thumbnail: Thumbnail(path: "path", extension: "extension"))
//        ]
//        let response = DataContainer<Hero>(count: 100, limit: 100, offset: 0, total: 100, results: initialCharacters)
//        let nextCharacters = [
//            Hero(id: 2, name: "Hulk", description: "Hulk", thumbnail: Thumbnail(path: "path", extension: "extension"))
//        ]
//        let nextResponse = DataContainer<Hero>(count: 100, limit: 100, offset: 0, total: 100, results: nextCharacters)
//        
//        let getHeroesUseCaseMock = GetHeroesUseCaseMock(response: response)
//        let viewModel = HeroesListViewModel(getHeroesUseCase: getHeroesUseCaseMock)
//        
//        await viewModel.loadFirstPage()
//        
//        getHeroesUseCaseMock.nextResponse = nextResponse
//        await viewModel.loadNextPage()
//        
//        #expect(viewModel.heroes.count == 2)
//        #expect(viewModel.heroes.last?.name == "Hulk")
//    }
//    
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

//    
//    @Test
//    func loadNextPage_doesNotTrigger_whenQueryIsNotEmpty() async throws {
//        let initialCharacters = [
//            Hero(id: 1, name: "Spider Man", description: "Spider Man", thumbnail: Thumbnail(path: "path", extension: "extension"))
//        ]
//        let response = DataContainer<Hero>(count: 100, limit: 100, offset: 0, total: 100, results: initialCharacters)
//        let getHeroesUseCaseMock = GetHeroesUseCaseMock(response: response)
//        let viewModel = HeroesListViewModel(getHeroesUseCase: getHeroesUseCaseMock)
//        
//        await viewModel.loadFirstPage()
//        
//        viewModel.query = "Iron"
//        try await Task.sleep(for: .milliseconds(100))
//        
//        await viewModel.loadNextPage()
//        
//        #expect(getHeroesUseCaseMock.executeCallCount == 1)
//    }
}
