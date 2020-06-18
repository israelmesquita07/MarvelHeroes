//
//  FavoriteHeroesInteractorTests.swift
//  MarvelHeroes
//
//  Created by Israel on 18/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import XCTest
@testable import MarvelHeroes

final class FavoriteHeroesInteractorTests: XCTestCase {

    var sut: FavoriteHeroesInteractor!
    var presenterSpy: FavoriteHeroesPresenterSpy!
    
    override func setUp() {
        super.setUp()
        sut = FavoriteHeroesInteractor()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testPresentFavoriteHeroesCalledInLoadFavoriteHeroes() {
        //Arranje
        setupSpies()
        let request = FavoriteHeroes.List.Request()
        //ACT
        sut.loadFavoriteHeroes(request: request)
        //Assert
        XCTAssertTrue(presenterSpy.presentFavoriteHeroesCalled || presenterSpy.presentErrorCalled, "presentFavoriteHeroes() or presentError() should be called in loadFavoriteHeroes() from FavoriteHeroesInteractor - It depends of heroes.count")
    }
}

//MARK: - Spies
extension FavoriteHeroesInteractorTests {
    func setupSpies() {
        presenterSpy = FavoriteHeroesPresenterSpy()
        sut.presenter = presenterSpy
    }
}
