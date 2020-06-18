//
//  FavoriteHeroesViewControllerTests.swift
//  MarvelHeroes
//
//  Created by Israel on 18/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import XCTest
@testable import MarvelHeroes

final class FavoriteHeroesViewControllerTests: XCTestCase {
    
    var sut: FavoriteHeroesViewController!
    var interactorSpy: FavoriteHeroesInteractorSpy!
    
    override func setUp() {
        super.setUp()
        sut = FavoriteHeroesViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testLoadFavoriteHeroesCalledInViewWillAppear() {
        //Arranje
        setupSpies()
        //ACT
        sut.viewWillAppear(false)
        //Assert
        XCTAssertTrue(interactorSpy.loadFavoriteHeroesCalled, "loadFavoriteHeroes() should be called in viewWillAppear() from FavoriteHeroesViewController")
    }
}

//MARK: - Spies
extension FavoriteHeroesViewControllerTests {
    func setupSpies() {
        interactorSpy = FavoriteHeroesInteractorSpy()
        sut.interactor = interactorSpy
    }
}
