//
//  HeroesTableViewCell.swift
//  MarvelHeroes
//
//  Created by Israel on 13/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import UIKit


protocol HeroesTableViewDelegating {
    func markAsFavorite(heroData: HeroData) -> Bool
    func deleteHeroData(heroId: Int) -> Bool
}

final class HeroesTableViewCell: UITableViewCell {
    
    private var task: URLSessionTask?
    var delegate: HeroesTableViewDelegating?
    var hero: Hero?
    
    // MARK: - View Code
    
    private lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 50
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var heroLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var accessoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0)
        button.addTarget(self, action: #selector(toggleAsFavorite), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = .black
        contentView.addSubview(heroImageView)
        contentView.addSubview(heroLabel)
        accessoryView = accessoryButton
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heroImageView.heightAnchor.constraint(equalToConstant: 100.0),
            heroImageView.widthAnchor.constraint(equalToConstant: 100.0),
            heroImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            heroImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            
            heroLabel.leadingAnchor.constraint(equalTo: heroImageView.trailingAnchor, constant: 16.0),
            heroLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            heroLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            heroLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        heroImageView.image = nil
    }
    
    func setupCell(hero: Hero) {
        self.hero = hero
        heroLabel.text = hero.name
        accessoryButton.tintColor = (hero.isFavorite ?? false) ? .yellow : .white
        guard let urlImage = URL(string: hero.thumbnail.url) else {
            imageView?.image = nil
            return }
        loadImage(urlImage)
    }
    
    func setupCellForFavorites(hero: Hero, heroImage: UIImage) {
        self.hero = hero
        heroLabel.text = hero.name
        accessoryButton.isHidden = true
        heroImageView.image = heroImage
    }
    
    private func loadImage(_ urlImage: URL) {
        task = URLSession.shared.dataTask(with: urlImage, completionHandler: { (data, _, error) in
            if error == nil, let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.heroImageView.image = image
                }
            }
        })
        task?.resume()
    }
    
    private func updateAccessoryButtonForFavorites() {
        accessoryButton.tintColor = hero?.isFavorite ?? false ? .yellow : .white
    }
    
    @objc func toggleAsFavorite() {
        guard let heroId = hero?.id else { return }
        if hero?.isFavorite ?? false {
            hero?.isFavorite = delegate?.deleteHeroData(heroId: heroId) ?? hero?.isFavorite
            updateAccessoryButtonForFavorites()
            return
        }
        guard let heroName = heroLabel.text,
            let heroImage = heroImageView.image else { return }
        let heroData = HeroData(id: heroId, name: heroName, image: heroImage)
        hero?.isFavorite = delegate?.markAsFavorite(heroData: heroData) ?? false
        updateAccessoryButtonForFavorites()
    }
}
