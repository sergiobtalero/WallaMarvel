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
    let scrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let contentStack : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let descriptionLabel = UILabel()
    
    let comicsTitleLabel = UILabel()
    let comicsCollectionView: UICollectionView
    
    let seriesTitleLabel = UILabel()
    let seriesCollectionView: UICollectionView
    
    // MARK: - Initializers
    override init(frame: CGRect) {
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
    
    // MARK: - Configure
    func configure(imageURL: URL?, description: String?, showComics: Bool, showSeries: Bool) {
        if let imageURL {
            imageView.kf.setImage(with: imageURL)
        } else {
            imageView.isHidden = true
        }
        
        if let description, !description.isEmpty {
            descriptionTitleLabel.text = "Description"
            descriptionLabel.text = description
            descriptionLabel.numberOfLines = .zero
            contentStack.addArrangedSubview(descriptionTitleLabel)
            contentStack.addArrangedSubview(descriptionLabel)
        }
        
        if showComics {
            comicsTitleLabel.text = "Comics"
            comicsCollectionView.backgroundColor = .clear
            comicsCollectionView.showsHorizontalScrollIndicator = false
            comicsCollectionView.heightAnchor.constraint(equalToConstant: Constant.carouselHeight).isActive = true
            contentStack.addArrangedSubview(comicsTitleLabel)
            contentStack.addArrangedSubview(comicsCollectionView)
            comicsCollectionView.reloadData()
        }
        
        if showSeries {
            seriesTitleLabel.text = "Series"
            seriesCollectionView.backgroundColor = .clear
            seriesCollectionView.showsHorizontalScrollIndicator = false
            seriesCollectionView.heightAnchor.constraint(equalToConstant: Constant.carouselHeight).isActive = true
            contentStack.addArrangedSubview(seriesTitleLabel)
            contentStack.addArrangedSubview(seriesCollectionView)
            seriesCollectionView.reloadData()
        }
    }
}

// MARK: - Constants
private extension HeroDetailView {
    enum Constant {
        static let imageViewHeight: CGFloat = 300
        static let carouselHeight: CGFloat = 160
        static let horizontalPadding: CGFloat = 16
    }
}

// MARK: - Private
private extension HeroDetailView {
    func setupViews() {
        backgroundColor = .systemBackground
        addSubviews()
    }
    
    func addSubviews() {
        setupScrollViewAndContentStack()
        setupImageView()
    }
    
    func setupScrollViewAndContentStack() {
        addSubview(scrollView)
        scrollView.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constant.horizontalPadding),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Constant.horizontalPadding),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }
    
    private func setupImageView() {
        imageView.heightAnchor.constraint(equalToConstant: Constant.imageViewHeight).isActive = true
        contentStack.addArrangedSubview(imageView)
    }
}
