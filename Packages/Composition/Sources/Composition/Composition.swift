import Domain
import Data

public enum ModuleFactory {
    public static func makeGetHeroesUseCase() -> GetCharactersUseCaseProtocol {
        let networkManager = NetworkManager()
        let repository = MarvelRepository(baseURL: "https://gateway.marvel.com:443/v1/public", networkManager: networkManager)
        return GetCharactersUseCase(repository: repository)
    }
    
    public static func makeGetHeroDetailsUseCase() -> GetCharacterDetailsUseCaseProtocol {
        let networkManager = NetworkManager()
        let repository = MarvelRepository(baseURL: "https://gateway.marvel.com:443/v1/public", networkManager: networkManager)
        return GetCharacterDetailsUseCase(repository: repository)
    }
}
