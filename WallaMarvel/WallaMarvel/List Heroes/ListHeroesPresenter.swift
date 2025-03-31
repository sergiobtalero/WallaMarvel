import Composition
import Domain
import Foundation

protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    var heroes: [Hero] { get }
    var navigationTitle: String { get }
    
    func getHeroes() async
    func query(_ searchText: String)
    func loadNextPage() async
}

protocol ListHeroesUI: AnyObject {
    func update()
}

final class ListHeroesPresenter {
    var ui: ListHeroesUI?
    var navigationTitle: String { "List of Heroes" }
    
    private var isFiltering = false
    private var isLoading = false
    private var currentPage: Int = 1
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    private var allHeroes: [Hero] = []
    private(set) var heroes: [Hero] = []
    
    init(getHeroesUseCase: GetHeroesUseCaseProtocol = ModuleFactory.makeGetHeroesUseCase()) {
        self.getHeroesUseCase = getHeroesUseCase
    }
}

// MARK: - ListHeroesPresenterProtocol
extension ListHeroesPresenter: ListHeroesPresenterProtocol {
    @MainActor func getHeroes() async {
        if let container = try? await getHeroesUseCase.execute(page: currentPage) {
            allHeroes = container.results
            heroes = container.results
            currentPage += 1
            ui?.update()
        }
    }
    
    func query(_ searchText: String) {
        if searchText.isEmpty {
            heroes = allHeroes
            isFiltering = false
        } else {
            isFiltering = true
            heroes = allHeroes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        ui?.update()
    }
    
    @MainActor func loadNextPage() async {
        guard !isLoading, !isFiltering else { return }
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        if let newHeroes = try? await getHeroesUseCase.execute(page: currentPage) {
            heroes.append(contentsOf: newHeroes.results)
            currentPage += 1
            ui?.update()
        }
    }
}
