//
//  HeroDetailViewModelTests.swift
//  MarvelTests
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain
import Testing
@testable import Marvel

struct HeroDetailViewModelTests {
    @Test func testHeroDetailViewModel() async {
        let originalHero = Character(id: 1, name: "Hulk", description: "", thumbnailURL: nil)
        var updatedHero = Character(
            id: 1,
            name: "Hulk",
            description: "The green man",
            thumbnailURL: nil
        )
        let comics: [Comic] = [
            Comic(
                id: 1,
                title: "Hulk 1st comic",
                description: "First comic",
                pageCount: 20,
                thumbnailURL: nil,
                images: []
            )
        ]
        let series: [Series] = [
            Series(
                id: 1,
                title: "Hulk series",
                description: "First series",
                startYear: 2000,
                endYear: 2010,
                thumbnailURL: nil
            ),
            Series(
                id: 2,
                title: "Hulk series 2",
                description: "Second series",
                startYear: 2000,
                endYear: 2010,
                thumbnailURL: nil
            )
        ]
        updatedHero.comics = comics
        updatedHero.series = series

        let useCase = GetHeroDetailsUseCaseMock()
        useCase.heroToReturn = updatedHero
        let viewModel = HeroDetailViewModel(hero: originalHero, getHeroDetailsUseCase: useCase)

        await viewModel.loadDetails()

        #expect(viewModel.hero.description == "The green man")
        #expect(viewModel.hero.comics.count == 1)
        #expect(viewModel.hero.series.count == 2)
    }

}
