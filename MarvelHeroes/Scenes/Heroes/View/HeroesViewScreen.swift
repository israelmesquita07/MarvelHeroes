//
//  HeroesViewScreen.swift
//  MarvelHeroes
//
//  Created by Israel on 13/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import UIKit

protocol ViewScreenDelegating: AnyObject {
    func didSelectRowAt(hero: Hero)
    func markAsFavorite(heroData: HeroData) -> Bool
    func deleteHeroData(heroId: Int) -> Bool
    func notifyTableViewEnds()
    func refreshItems()
}

final class HeroesViewScreen: UIView {

    weak var delegate: ViewScreenDelegating?
    var heroes: [Hero] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - View Code

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Atualizando heróis...")
        refreshControl.addTarget(self, action: #selector(refreshItems(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        activityIndicator.color = .white
        activityIndicator.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.refreshControl = refreshControl
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120.0
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HeroesTableViewCell.self, forCellReuseIdentifier: String(describing: HeroesTableViewCell.self))
        return tableView
    }()
    
    // MARK: - Init
    
    init(delegate: ViewScreenDelegating) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(tableView)
        addSubview(activityIndicator)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    // MARK: - Animation Loading
    
    func startLoading() {
        activityIndicator.startAnimating()
        tableView.addSubview(activityIndicator)
        tableView.isUserInteractionEnabled = false
    }
    
    func stopLoading() {
        refreshControl.endRefreshing()
        activityIndicator.stopAnimating()
        tableView.isUserInteractionEnabled = true
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    @objc private func refreshItems(_ sender: Any) {
        delegate?.refreshItems()
    }
}

//MARK: - UITableViewDataSource
extension HeroesViewScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeroesTableViewCell.self), for: indexPath) as? HeroesTableViewCell else {
            return UITableViewCell()
        }
        let hero = heroes[indexPath.row]
        cell.setupCell(hero: hero)
        cell.selectionStyle = .none
        cell.backgroundColor = .black
        cell.delegate = self
        return cell
    }
}

//MARK: - UITableViewDelegate
extension HeroesViewScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRowAt(hero: heroes[indexPath.row])
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == heroes.count - 1 && !activityIndicator.isAnimating {
            delegate?.notifyTableViewEnds()
        }
    }
}

//MARK: - HeroesTableViewDelegating
extension HeroesViewScreen: HeroesTableViewDelegating {
    func markAsFavorite(heroData: HeroData) -> Bool {
        delegate?.markAsFavorite(heroData: heroData) ?? false
    }
    
    func deleteHeroData(heroId: Int) -> Bool {
        delegate?.deleteHeroData(heroId: heroId) ?? true
    }
}
