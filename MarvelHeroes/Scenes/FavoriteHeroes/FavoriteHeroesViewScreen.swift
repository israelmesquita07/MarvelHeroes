//
//  FavoriteHeroesViewScreen.swift
//  MarvelHeroes
//
//  Created by Israel on 16/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import UIKit

final class FavoriteHeroesViewScreen: UIView {
    
    var favoriteHeroes: [Hero] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - View Code
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120.0
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HeroesTableViewCell.self, forCellReuseIdentifier: String(describing: HeroesTableViewCell.self))
        return tableView
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
    
    private func setupView() {
        addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
         NSLayoutConstraint.activate([
             tableView.topAnchor.constraint(equalTo: self.topAnchor),
             tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
             tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
         ])
     }
}

//MARK: - UITableViewDataSource
extension FavoriteHeroesViewScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteHeroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeroesTableViewCell.self), for: indexPath) as? HeroesTableViewCell else {
            return UITableViewCell()
        }
        let hero = favoriteHeroes[indexPath.row]
        cell.setupCell(hero: hero)
        cell.selectionStyle = .none
        cell.backgroundColor = .black
        return cell
    }
}

//MARK: - UITableViewDelegate
extension FavoriteHeroesViewScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        delegate?.didSelectRowAt(hero: favoriteHeroes[indexPath.row])
    }
}
