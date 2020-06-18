//
//  FavoriteHeroesPresenterTests.swift
//  MarvelHeroes
//
//  Created by Israel on 18/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import XCTest
@testable import MarvelHeroes

final class FavoriteHeroesPresenterTests: XCTestCase {
    
    var sut: FavoriteHeroesPresenter!
    var viewControllerSpy: FavoriteHeroesViewControllerSpy!
    
    override func setUp() {
        super.setUp()
        sut = FavoriteHeroesPresenter()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDisplayFavoriteHeroesCalledInPresentFavoriteHeroes() {
        //Arranje
        setupSpies()
        let heroData = HeroData(id: -1, name: "", image: UIImage())
        let response = FavoriteHeroes.List.Response(heroes: [heroData])
        //ACT
        sut.presentFavoriteHeroes(response: response)
        //Assert
        XCTAssertTrue(viewControllerSpy.displayFavoriteHeroesCalled, "displayFavoriteHeroes() should be called in presentFavoriteHeroes() from FavoriteHeroesPresenter")
    }
    
    func testDisplayErrorCalledInPresentError() {
        //Arranje
        setupSpies()
        //ACT
        sut.presentError(errorDescription: "some error")
        //Assert
        XCTAssertTrue(viewControllerSpy.displayErrorCalled, "displayError() should be called in presentError() from FavoriteHeroesPresenter")
    }
}

//MARK: - Spies
extension FavoriteHeroesPresenterTests {
    func setupSpies() {
        viewControllerSpy = FavoriteHeroesViewControllerSpy()
        sut.viewController = viewControllerSpy
    }
}
