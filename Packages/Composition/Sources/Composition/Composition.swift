import Domain
import Data

public enum ModuleFactory {
    public static func makeGetHeroesUseCase() -> GetHeroesUseCaseProtocol {
        let repository = MarvelRepository(baseURL: "")
        return GetHeroesUseCase(repository: repository)
    }
}
