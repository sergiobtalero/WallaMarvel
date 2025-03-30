import Domain
import Data

public enum ModuleFactory {
    public static func makeGetHeroesUseCase() -> GetHeroesUseCaseProtocol {
        let networkManager = NetworkManager()
        let repository = MarvelRepository(baseURL: "https://gateway.marvel.com:443/v1/public", networkManager: networkManager)
        return GetHeroesUseCase(repository: repository)
    }
}
