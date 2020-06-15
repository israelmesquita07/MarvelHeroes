//
//  ErrorView.swift
//  MarvelHeroes
//
//  Created by Israel on 15/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import UIKit

protocol ErrorViewHeroesReloading {
    func tryAgain()
}

final class ErrorView: UIView {
    
    let delegate: ErrorViewHeroesReloading
    
    // MARK: - View Code
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment =  .center
        label.font =  .systemFont(ofSize: 20.0, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSAttributedString(string: NSLocalizedString("Tentar novamente", comment: ""), attributes:[
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0),
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.underlineStyle: 1.0
        ])
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }()
        
    // MARK: - Init
    
    init(delegate: ErrorViewHeroesReloading, errorText: String) {
        self.delegate = delegate
        super.init(frame: .zero)
        errorLabel.text = "Ops!\n\(errorText)"
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        self.backgroundColor = .black
        addSubview(errorLabel)
        addSubview(tryAgainButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            errorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            
            tryAgainButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor),
            tryAgainButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            tryAgainButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
        ])
    }
    
    @objc private func tryAgain() {
        delegate.tryAgain()
    }
}
