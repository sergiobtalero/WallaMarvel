import Composition
import Domain
import Foundation

protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getHeroes()
}

protocol ListHeroesUI: AnyObject {
    func update(heroes: [CharacterDataModel])
}

final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    var ui: ListHeroesUI?
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    
    
    init(getHeroesUseCase: GetHeroesUseCaseProtocol = ModuleFactory.makeGetHeroesUseCase()) {
        self.getHeroesUseCase = getHeroesUseCase
    }
    
    func screenTitle() -> String {
        "List of Heroes"
    }
    
    // MARK: UseCases
    
    func getHeroes() {
//        getHeroesUseCase.execute { characterDataContainer in
//            print("Characters \(characterDataContainer.characters)")
//            self.ui?.update(heroes: characterDataContainer.characters)
//        }
        Task {
            guard let heroes = try? await getHeroesUseCase.execute() else {
                print("OOOPS")
                return
            }
            ui?.update(heroes: heroes.characters)
        }
    }
}

