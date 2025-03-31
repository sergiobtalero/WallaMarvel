//
//  HeroDetailViewController.swift
//  WallaMarvel
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import UIKit

final class HeroDetailViewController: UIViewController {
    private var mainView: HeroDetailView { return view as! HeroDetailView }
    var presenter: HeroDetailPresenterProtocol?
    
    // MARK: - Life cycle
    override func loadView() {
        view = HeroDetailView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.ui = self
        title = presenter?.navigationTitle
        
        Task {
            await presenter?.loadDetails()
        }
    }
}

// MARK: - HeroDetailUI
extension HeroDetailViewController: HeroDetailUI {
    func update() {
        
    }
}
