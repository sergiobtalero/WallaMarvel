//
//  HeroDetailView.swift
//  WallaMarvel
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Foundation
import UIKit
import Kingfisher

final class HeroDetailView: UIView {
    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()
    
    let imageView = UIImageView()
    
    let descriptionTitleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    let comicsTitleLabel = UILabel()
    let comicsCollectionView: UICollectionView
    
    let seriesTitleLabel = UILabel()
    let seriesCollectionView: UICollectionView
    
    override init(frame: CGRect) {
        // Layout for horizontal carousels
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 150)
        layout.minimumLineSpacing = 10
        
        comicsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        comicsCollectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        seriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        seriesCollectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        
        contentStack.axis = .vertical
        contentStack.spacing = 16
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
        setupImageView()
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        contentStack.addArrangedSubview(imageView)
    }
    
    func configure(imageURL: URL?, description: String?, showComics: Bool, showSeries: Bool) {
        if let imageURL {
            imageView.kf.setImage(with: imageURL)
        } else {
            imageView.isHidden = true
        }
        if let desc = description, !desc.isEmpty {
            let descTitle = sectionTitleLabel("Description")
            descriptionLabel.text = desc
            descriptionLabel.numberOfLines = 0
            contentStack.addArrangedSubview(descTitle)
            contentStack.addArrangedSubview(descriptionLabel)
        }
        
        if showComics {
            comicsTitleLabel.text = "Comics"
            comicsCollectionView.backgroundColor = .clear
            comicsCollectionView.showsHorizontalScrollIndicator = false
            comicsCollectionView.heightAnchor.constraint(equalToConstant: 160).isActive = true
            contentStack.addArrangedSubview(comicsTitleLabel)
            contentStack.addArrangedSubview(comicsCollectionView)
            comicsCollectionView.reloadData()
        }
        
        if showSeries {
            seriesTitleLabel.text = "Series"
            seriesCollectionView.backgroundColor = .clear
            seriesCollectionView.showsHorizontalScrollIndicator = false
            seriesCollectionView.heightAnchor.constraint(equalToConstant: 160).isActive = true
            contentStack.addArrangedSubview(seriesTitleLabel)
            contentStack.addArrangedSubview(seriesCollectionView)
            seriesCollectionView.reloadData()
        }
    }
    
    private func sectionTitleLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }
}
