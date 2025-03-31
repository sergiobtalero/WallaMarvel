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
        
        mainView.comicsCollectionView.dataSource = self
        mainView.comicsCollectionView.delegate = self
        mainView.seriesCollectionView.dataSource = self
        mainView.seriesCollectionView.delegate = self
        
        Task {
            await presenter?.loadDetails()
        }
    }
}

// MARK: - HeroDetailUI
extension HeroDetailViewController: HeroDetailUI {
    func update(imageURL: URL?, description: String?, showComics: Bool, showSeries: Bool) {
        mainView.configure(imageURL: imageURL, description: description, showComics: showComics, showSeries: showSeries)
    }
}

extension HeroDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.comicsCollectionView {
            return presenter!.hero.comics.count
        } else if collectionView == mainView.seriesCollectionView {
            return presenter!.hero.series.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.comicsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
            cell.configure(with: presenter!.hero.comics[indexPath.item].thumbailImage)
            return cell
        } else if collectionView == mainView.seriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
            cell.configure(with: presenter!.hero.series[indexPath.item].thumbailImage)
            return cell
        }
        return UICollectionViewCell()
    }
}
