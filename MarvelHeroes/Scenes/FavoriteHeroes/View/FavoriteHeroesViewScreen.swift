//
//  FavoriteHeroesViewScreen.swift
//  MarvelHeroes
//
//  Created by Israel on 16/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import UIKit

final class FavoriteHeroesViewScreen: UIView {
    
    var favoriteHeroes: [HeroData] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - View Code
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.rowHeight = 120.0
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavoriteHeroesTableViewCell.self, forCellReuseIdentifier: String(describing: FavoriteHeroesTableViewCell.self))
        return tableView
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewSetupLayoutProtocol
extension FavoriteHeroesViewScreen: ViewSetupLayoutProtocol {
    func setupHierarchy() {
        addSubview(tableView)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setupAdditionalStuff() {
        backgroundColor = .black
    }
}

//MARK: - UITableViewDataSource
extension FavoriteHeroesViewScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteHeroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FavoriteHeroesTableViewCell.self), for: indexPath) as? FavoriteHeroesTableViewCell else {
            return UITableViewCell()
        }
        let heroData = favoriteHeroes[indexPath.row]
        cell.setupCell(heroName: heroData.name, heroImage: heroData.image)
        cell.selectionStyle = .none
        cell.backgroundColor = .black
        return cell
    }
}
