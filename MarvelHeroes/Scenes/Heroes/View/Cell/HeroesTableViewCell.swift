//
//  HeroesTableViewCell.swift
//  MarvelHeroes
//
//  Created by Israel on 13/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import UIKit

final class HeroesTableViewCell: UITableViewCell {
    
    private var task: URLSessionTask?
    
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
        heroLabel.text = hero.name
        guard let urlImage = URL(string: hero.thumbnail.url) else {
            imageView?.image = nil
            return }
        loadImage(urlImage)
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
}
