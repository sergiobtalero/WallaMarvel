import Domain
import UIKit

final class ListHeroesViewController: UIViewController {
    var mainView: ListHeroesView { return view as! ListHeroesView  }
    
    var presenter: ListHeroesPresenterProtocol?
    var listHeroesProvider: ListHeroesAdapter?
    
    override func loadView() {
        view = ListHeroesView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        listHeroesProvider = ListHeroesAdapter(tableView: mainView.heroesTableView)
        presenter?.getHeroes()
        presenter?.ui = self
        
        title = presenter?.screenTitle()
        
        mainView.heroesTableView.delegate = self
    }
}

extension ListHeroesViewController: ListHeroesUI {
    func update(heroes: [CharacterDataModel]) {
        listHeroesProvider?.heroes.append(contentsOf: heroes)
    }
}

extension ListHeroesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let presenter = ListHeroesPresenter()
        let listHeroesViewController = ListHeroesViewController()
        listHeroesViewController.presenter = presenter
        
        navigationController?.pushViewController(listHeroesViewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height
        
        let threshold: CGFloat = 200
        if offsetY > contentHeight - frameHeight - threshold {
            presenter?.getHeroes()
        }
    }
}
