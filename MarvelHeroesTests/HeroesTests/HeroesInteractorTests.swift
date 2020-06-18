//
//  HeroesInteractorTests.swift
//  MarvelHeroes
//
//  Created by Israel on 17/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import XCTest
@testable import MarvelHeroes

class HeroesInteractorTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: HeroesInteractor!
    var presenterSpy: HeroesPresenterSpy!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        sut = HeroesInteractor()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testpresentHeroesCalledInLoadHeroes() {
        //Arranje
        setupSpies()
        let request = Heroes.List.Request(heroName: "spider")
        //ACT
        sut.loadHeroes(request: request)
        //Assert
        XCTAssertTrue(presenterSpy.presentHeroesCalled, "presentHeroesCalled() should be called in loadHeroes() from HeroesInteractor")
    }
    
    func testPresentErrorCalledInLoadHeroes() {
        //Arranje
        setupSpies()
        let request = Heroes.List.Request(heroName: "spider")
        //ACT
        sut.loadHeroes(request: request)
        //Assert
        XCTAssertTrue(presenterSpy.presentErrorCalled, "presentErrorCalled() should be called in loadHeroes() from HeroesInteractor")
    }
    
    func testPresentAlertErrorCalledInDeleteHeroData() {
        //Arranje
        setupSpies()
        //ACT
        _ = sut.deleteHeroData(heroId: -1)
        //Assert
        XCTAssertTrue(presenterSpy.presentAlertErrorCalled, "presentAlertError() should be called in deleteHeroData() from HeroesInteractor")
    }
    
    func testPresentAlertErrorCalledInMarkAsFavorite() {
        //Arranje
        setupSpies()
        let heroData = HeroData(id: -1, name: "", image: UIImage())
        //ACT
        _ = sut.markAsFavorite(heroData: heroData)
        //Assert
        XCTAssertTrue(presenterSpy.presentAlertErrorCalled, "presentAlertError() should be called in markAsFavorite() from HeroesInteractor")
    }
    
    func testToggleLoadingCalledInLoadHeroes() {
        //Arranje
        setupSpies()
        let request = Heroes.List.Request(heroName: "spider")
        //ACT
        sut.loadHeroes(request: request)
        //Assert
        XCTAssertTrue(presenterSpy.toggleLoadingCalled, "toggleLoading() should be called in loadHeroes() from HeroesInteractor")
    }
}

//MARK: - Spies
extension HeroesInteractorTests {
    func setupSpies() {
        presenterSpy = HeroesPresenterSpy()
        sut.presenter = presenterSpy
    }
}
