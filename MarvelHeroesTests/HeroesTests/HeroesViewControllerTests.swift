//
//  HeroesViewControllerTests.swift
//  MarvelHeroes
//
//  Created by Israel on 17/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import XCTest
@testable import MarvelHeroes

final class HeroesViewControllerTests: XCTestCase {
    
    var sut: HeroesViewController!
    var interactorSpy: HeroesInteractorSpy!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        sut = HeroesViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testLoadHeroesCalledInViewDidLoad() {
        //Arranje
        setupSpies()
        //ACT
        sut.viewDidLoad()
        //Assert
        XCTAssertTrue(interactorSpy.loadHeroesCalled, "loadHeroes() should be called in viewDidLoad() from HeroesViewController")
    }
    
    func testSearchHeroesCalledInRefreshItems() {
        //Arranje
        setupSpies()
        //ACT
        sut.refreshItems()
        //Assert
        XCTAssertTrue(interactorSpy.searchHeroesCalled, "searchHeroes() should be called in refreshItems() from HeroesViewController")
    }
    
    func testFillDataToDetailsCalledInDidSelectRowAt() {
        //Arranje
        setupSpies()
        let thumbnail = Thumbnail(path: "path", ext: "extension")
        let hero = Hero(id: -1, name: "", description: "", thumbnail: thumbnail)
        //ACT
        sut.didSelectRowAt(hero: hero)
        //Assert
        XCTAssertTrue(interactorSpy.fillDataToDetailsCalled, "fillDataToDetails() should be called in didSelectRowAt() from HeroesViewController")
    }
    
    func testMarkAsFavoriteCalledInMarkAsFavorite() {
        //Arranje
        setupSpies()
        let heroData = HeroData(id: -1, name: "", image: UIImage())
        //ACT
        _ = sut.markAsFavorite(heroData: heroData)
        //Assert
        XCTAssertTrue(interactorSpy.markAsFavoriteCalled, "markAsFavorite() should be called in markAsFavorite() from HeroesViewController")
    }
    
    func testDeleteHeroDataCalledInDeleteHeroData() {
        //Arranje
        setupSpies()
        //ACT
        _ = sut.deleteHeroData(heroId: -1)
        //Assert
        XCTAssertTrue(interactorSpy.deleteHeroDataCalled, "deleteHeroData() should be called in deleteHeroData() from HeroesViewController")
    }
}

//MARK: - Spies
extension HeroesViewControllerTests {
    func setupSpies() {
        interactorSpy = HeroesInteractorSpy()
        sut.interactor = interactorSpy
    }
}
