//
//  MainTabBarController.swift
//  MarvelHeroes
//
//  Created by Israel Pinheiro Mesquita on 16/03/21.
//  Copyright © 2021 israel3D. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let heroesNavigationController = HeroesFactory.makeNavigationController()
        heroesNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let favoriteHeroesViewController = FavoriteHeroesFactory.makeFavoriteHeroesViewController()
        favoriteHeroesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let tabBarList = [heroesNavigationController, favoriteHeroesViewController]
        tabBar.barStyle = .black
        tabBar.tintColor = .white
        viewControllers = tabBarList
    }
}
