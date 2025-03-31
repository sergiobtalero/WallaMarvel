//import Domain
//import Foundation
//import UIKit
//
//final class ListHeroesAdapter: NSObject {
//    var heroes: [Hero] {
//        didSet {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
//    
//    private let tableView: UITableView
//    
//    init(tableView: UITableView, heroes: [Hero] = []) {
//        self.tableView = tableView
//        self.heroes = heroes
//        super.init()
//        self.tableView.dataSource = self
//    }
//}
//
//
