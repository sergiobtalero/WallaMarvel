import Domain
import Data

public enum ModuleFactory {
    public static func makeGetHeroesUseCase() -> GetHeroesUseCaseProtocol {
        let repository = MarvelRepository(baseURL: "https://gateway.marvel.com:443/v1/public")
        return GetHeroesUseCase(repository: repository)
    }
}
