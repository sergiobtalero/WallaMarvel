import Composition
import Domain
import Foundation

protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getHeroes()
    func getHeroDetail(id: String)
}

protocol ListHeroesUI: AnyObject {
    func update(heroes: [CharacterDataModel])
}

final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    var ui: ListHeroesUI?
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    private let getHeroDetailsUseCase: GetHeroDetailsUseCaseProtocol
    private var currentPage: Int = 1
    private var isLoading = false
    
    init(getHeroesUseCase: GetHeroesUseCaseProtocol = ModuleFactory.makeGetHeroesUseCase(),
         getHeroDetailsUseCase: GetHeroDetailsUseCaseProtocol = ModuleFactory.makeGetHeroDetailsUseCase()) {
        self.getHeroesUseCase = getHeroesUseCase
        self.getHeroDetailsUseCase = getHeroDetailsUseCase
    }
    
    func screenTitle() -> String {
        "List of Heroes"
    }
    
    // MARK: UseCases
    
    func getHeroes() {
        guard !isLoading else { return }
        Task {
            do {
                isLoading = true
                let heroes = try await getHeroesUseCase.execute(page: currentPage)
                ui?.update(heroes: heroes.characters)
                currentPage += 1
                isLoading = false
            } catch {
                // TODO: Handle error
                isLoading = false
            }
        }
    }
    
    func getHeroDetail(id: String) {
        Task {
            try await getHeroDetailsUseCase.execute(id: id)
        }
    }
}

