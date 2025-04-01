import Foundation
import UIKit

final class ListHeroesView: UIView {
    
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Type character name to search"
        searchBar.showsCancelButton = true
        searchBar.sizeToFit()
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.returnKeyType = .done
            textField.enablesReturnKeyAutomatically = true
        }
        return searchBar
    }()
    
    let heroesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ListHeroesTableViewCell.self, forCellReuseIdentifier: "ListHeroesTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constant.estimatedRowHeight
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constants
private extension ListHeroesView {
    enum Constant {
        static let estimatedRowHeight: CGFloat = 120
    }
}

// MARK: - Private
private extension ListHeroesView {
    func setup() {
        addSubviews()
        addContraints()
    }
    
    func addSubviews() {
        addSubview(searchBar)
        addSubview(heroesTableView)
    }
    
    func addContraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            heroesTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            heroesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            heroesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heroesTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
