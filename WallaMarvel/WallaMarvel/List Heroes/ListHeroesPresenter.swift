import Composition
import Domain
import Foundation

protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    var heroes: [Hero] { get }
    
    func screenTitle() -> String
    func getHeroes()
    func query(_ searchText: String)
}

protocol ListHeroesUI: AnyObject {
    func update()
}

final class ListHeroesPresenter {
    var ui: ListHeroesUI?
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    private var allHeroes: [Hero] = []
    private(set) var heroes: [Hero] = []
    
    init(getHeroesUseCase: GetHeroesUseCaseProtocol = ModuleFactory.makeGetHeroesUseCase()) {
        self.getHeroesUseCase = getHeroesUseCase
    }
    
    func screenTitle() -> String {
        "List of Heroes"
    }
}

// MARK: - ListHeroesPresenterProtocol
extension ListHeroesPresenter: ListHeroesPresenterProtocol {
    func getHeroes() {
        Task {
            if let container = try? await getHeroesUseCase.execute(page: 1) {
                allHeroes = container.results
                heroes = container.results
                await MainActor.run {
                    self.ui?.update()
                }
            }
        }
    }
    
    func query(_ searchText: String) {
        if searchText.isEmpty {
            heroes = allHeroes
        } else {
            heroes = allHeroes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        ui?.update()
    }
}
