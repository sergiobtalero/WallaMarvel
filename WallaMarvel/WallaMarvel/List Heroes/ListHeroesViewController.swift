import Domain
import UIKit

final class ListHeroesViewController: UIViewController {
    var mainView: ListHeroesView { return view as! ListHeroesView  }
    
    var presenter: ListHeroesPresenterProtocol?
    
    override func loadView() {
        view = ListHeroesView()
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getHeroes()
        presenter?.ui = self
        
        title = presenter?.screenTitle()
        
        mainView.heroesTableView.delegate = self
        mainView.heroesTableView.dataSource = self
        mainView.searchBar.delegate = self
    }
}

// MARK: - ListHeroesUI
extension ListHeroesViewController: ListHeroesUI {
    func update() {
        mainView.heroesTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ListHeroesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.heroes.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = presenter?.heroes[indexPath.row],
              let cell = tableView.dequeueReusableCell(withIdentifier: "ListHeroesTableViewCell", for: indexPath) as? ListHeroesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(model: model)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListHeroesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let presenter = ListHeroesPresenter()
        let listHeroesViewController = ListHeroesViewController()
        listHeroesViewController.presenter = presenter
        
        navigationController?.pushViewController(listHeroesViewController, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension ListHeroesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.query(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
