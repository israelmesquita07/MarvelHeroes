//
//  HeroDetailsViewScreen.swift
//  MarvelHeroes
//
//  Created by Israel on 14/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import UIKit

final class HeroDetailsViewScreen: UIView {
    
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
        label.font = .systemFont(ofSize: 20.0, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    init() {
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
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: self.topAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            heroImageView.heightAnchor.constraint(equalToConstant: 400.0),
            
            heroLabel.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 24.0),
            heroLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            heroLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            heroLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor)
        ])
    }
}
