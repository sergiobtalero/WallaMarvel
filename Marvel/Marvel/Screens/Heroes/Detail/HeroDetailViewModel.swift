//
//  HeroDetailViewModel.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Composition
import Domain
import Foundation

protocol CharacterDetailViewModelProtocol: ObservableObject {
    func loadDetails() async
    var character: Character { get set }
}

final class CharacterDetailViewModel {
    private let getHeroDetailsUseCase: GetCharacterDetailsUseCaseProtocol
    
    @Published var character: Character
    
    init(character: Character,
         getHeroDetailsUseCase: GetCharacterDetailsUseCaseProtocol = ModuleFactory.makeGetHeroDetailsUseCase()) {
        self.character = character
        self.getHeroDetailsUseCase = getHeroDetailsUseCase
    }
}

// MARK: - CharacterDetailViewModelProtocol
extension CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    @MainActor func loadDetails() async {
        if let character = try? await getHeroDetailsUseCase.execute(id: character.id) {
            objectWillChange.send()
            self.character = character
        }
    }
}
