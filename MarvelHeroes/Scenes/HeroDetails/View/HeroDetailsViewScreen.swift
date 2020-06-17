//
//  HeroDetailsViewScreen.swift
//  MarvelHeroes
//
//  Created by Israel on 14/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import UIKit

protocol HeroDetailsViewScreenDelegating {
    func markAsFavorite(heroData: HeroData) -> Bool
    func deleteHeroData(heroId: Int) -> Bool
}

final class HeroDetailsViewScreen: UIView {
    
    var hero: Hero?
    var delegate: HeroDetailsViewScreenDelegating?
//    var updateFavorite: Bool = false {
//        didSet {
//            updateForFavorites()
//        }
//    }
    
    // MARK: - View Code
    
    lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var heroLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 18.0, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
       let button = UIButton()
        button.setTitle("Favoritar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .medium)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleAsFavorite), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    init(delegate: HeroDetailsViewScreenDelegating) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        addSubview(heroImageView)
        addSubview(heroLabel)
        addSubview(favoriteButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            heroImageView.heightAnchor.constraint(equalToConstant: 400.0),
            
            heroLabel.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 24.0),
            heroLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            heroLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            heroLabel.bottomAnchor.constraint(lessThanOrEqualTo: favoriteButton.topAnchor),
            
            favoriteButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            favoriteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: 100.0)
        ])
    }
    
    func setupViewScreen(_ imageHero: UIImage,_ hero: Hero) {
        self.hero = hero
        heroImageView.image = imageHero
        heroLabel.text = hero.description
        favoriteButton.setTitle(hero.isFavorite ?? false ? "Favorito!" : "Favoritar", for: .normal)
        favoriteButton.setTitleColor(hero.isFavorite ?? false ? .yellow : .white, for: .normal)
    }
    
//    func updateForFavorites() {
//        hero?.isFavorite = updateFavorite
//        favoriteButton.setTitle(updateFavorite ? "Favorito!" : "Favoritar", for: .normal)
//        favoriteButton.setTitleColor(updateFavorite ? .yellow : .white, for: .normal)
//    }
    
    @objc func toggleAsFavorite() {
        guard let heroId = hero?.id else { return }
        if hero?.isFavorite ?? false {
//            updateFavorite = delegate?.deleteHeroData(heroId: heroId) ?? updateFavorite
            hero?.isFavorite = delegate?.deleteHeroData(heroId: heroId) ?? hero?.isFavorite
            favoriteButton.setTitle(hero?.isFavorite ?? false ? "Favorito!" : "Favoritar", for: .normal)
            favoriteButton.setTitleColor(hero?.isFavorite ?? false ? .yellow : .white, for: .normal)
            return
        }
        guard let heroName = hero?.name, 
            let heroImage = heroImageView.image else { return }
        let heroData = HeroData(id: heroId, name: heroName, image: heroImage)
//        updateFavorite = delegate?.markAsFavorite(heroData: heroData) ?? false
        hero?.isFavorite = delegate?.markAsFavorite(heroData: heroData) ?? false
        favoriteButton.setTitle(hero?.isFavorite ?? false ? "Favorito!" : "Favoritar", for: .normal)
        favoriteButton.setTitleColor(hero?.isFavorite ?? false ? .yellow : .white, for: .normal)
    }
}
