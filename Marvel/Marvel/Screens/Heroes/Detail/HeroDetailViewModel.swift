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
    var state: CharacterDetailScreenState { get set }
    
    func loadDetails() async
}

enum CharacterDetailScreenState {
    case idle
    case loading
    case error
    case loaded(character: Character)
}

final class CharacterDetailViewModel {
    private let getHeroDetailsUseCase: GetCharacterDetailsUseCaseProtocol
    
    private let characterId: Int
    @Published var state: CharacterDetailScreenState = .idle
    
    init(characterId: Int,
         getHeroDetailsUseCase: GetCharacterDetailsUseCaseProtocol = ModuleFactory.makeGetHeroDetailsUseCase()) {
        self.characterId = characterId
        self.getHeroDetailsUseCase = getHeroDetailsUseCase
    }
}

// MARK: - CharacterDetailViewModelProtocol
extension CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    @MainActor func loadDetails() async {
        state = .loading
        do {
            let character = try await getHeroDetailsUseCase.execute(id: characterId)
            state = .loaded(character: character)
        } catch {
            state = .error
        }
    }
}
