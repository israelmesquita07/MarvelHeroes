//
//  HeroDetailsViewScreen.swift
//  MarvelHeroes
//
//  Created by Israel on 14/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import UIKit

protocol HeroDetailsViewScreenDelegating: AnyObject {
    func markAsFavorite(heroData: HeroData) -> Bool
    func deleteHeroData(heroId: Int) -> Bool
}

final class HeroDetailsViewScreen: UIView {
    
    var hero: Hero?
    weak var delegate: HeroDetailsViewScreenDelegating?
    
    // MARK: - View Code
    
    private lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var heroLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = .white
        label.font = .systemFont(ofSize: 18.0, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
       let button = UIButton()
        button.setTitle(NSLocalizedString("favorite_button_title", comment: String()), for: .normal)
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
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    
    func setupViewScreen(_ imageHero: UIImage,_ hero: Hero) {
        self.hero = hero
        heroImageView.image = imageHero
        heroLabel.text = hero.description
        favoriteButton.setTitle(hero.isFavorite ?? false ? NSLocalizedString("favorited_button_title", comment: String()) : NSLocalizedString("favorite_button_title", comment: String()), for: .normal)
        favoriteButton.setTitleColor(hero.isFavorite ?? false ? .yellow : .white, for: .normal)
    }
    
    @objc func toggleAsFavorite() {
        guard let heroId = hero?.id else { return }
        if hero?.isFavorite ?? false {
            hero?.isFavorite = delegate?.deleteHeroData(heroId: heroId) ?? hero?.isFavorite
            updateFavoriteButtonForFavorites()
            return
        }
        guard let heroName = hero?.name, 
            let heroImage = heroImageView.image else { return }
        let heroData = HeroData(id: heroId, name: heroName, image: heroImage)
        hero?.isFavorite = delegate?.markAsFavorite(heroData: heroData) ?? false
        updateFavoriteButtonForFavorites()
    }
    
    private func updateFavoriteButtonForFavorites() {
        favoriteButton.setTitle(hero?.isFavorite ?? false ? NSLocalizedString("favorited_button_title", comment: String()) : NSLocalizedString("favorite_button_title", comment: String()), for: .normal)
        favoriteButton.setTitleColor(hero?.isFavorite ?? false ? .yellow : .white, for: .normal)
    }
}

// MARK: - ViewSetupLayoutProtocol
extension HeroDetailsViewScreen: ViewSetupLayoutProtocol {
    func setupHierarchy() {
        addSubview(heroImageView)
        addSubview(heroLabel)
        addSubview(favoriteButton)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            heroImageView.heightAnchor.constraint(equalToConstant: 380.0),
            
            heroLabel.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 10.0),
            heroLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
            heroLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
            heroLabel.bottomAnchor.constraint(lessThanOrEqualTo: favoriteButton.topAnchor),
            
            favoriteButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            favoriteButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: 70.0)
        ])
    }
    
    func setupAdditionalStuff() {
        backgroundColor = .black
    }
}
