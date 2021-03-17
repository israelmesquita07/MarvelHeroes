//
//  HeroesInteractorTests.swift
//  MarvelHeroes
//
//  Created by Israel on 17/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import XCTest
@testable import MarvelHeroes

final class HeroesInteractorTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: HeroesInteractor!
    var presenterSpy: HeroesPresenterSpy!
    var workerSpy: HeroesWorkerSpy!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        workerSpy = HeroesWorkerSpy()
        presenterSpy = HeroesPresenterSpy()
        sut = HeroesInteractor(presenter: presenterSpy, worker: workerSpy)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testPresentAlertErrorCalledInDeleteHeroData() {
        //Arranje
        //ACT
        _ = sut.deleteHeroData(heroId: -1)
        //Assert
        XCTAssertTrue(presenterSpy.presentAlertErrorCalled, "presentAlertError() should be called in deleteHeroData() from HeroesInteractor")
    }
    
    func testPresentAlertErrorCalledInMarkAsFavorite() {
        //Arranje
        let heroData = HeroData(id: -1, name: "", image: UIImage())
        //ACT
        _ = sut.markAsFavorite(heroData: heroData)
        //Assert
        XCTAssertTrue(presenterSpy.presentAlertErrorCalled, "presentAlertError() should be called in markAsFavorite() from HeroesInteractor")
    }
    
    func testToggleLoadingCalledInLoadHeroes() {
        //Arranje
        let request = Heroes.List.Request(heroName: "spider")
        //ACT
        sut.loadHeroes(request: request)
        //Assert
        XCTAssertTrue(presenterSpy.toggleLoadingCalled, "toggleLoading() should be called in loadHeroes() from HeroesInteractor")
    }
    
    func testFetchHeroesCalledInLoadHeroes() {
        //Arranje
        let request = Heroes.List.Request(heroName: "spider")
        //ACT
        sut.loadHeroes(request: request)
        //Assert
        XCTAssertTrue(workerSpy.fetchHeroesCalled, "fetchHeroes() should be called in loadHeroes() from HeroesInteractor")
    }
    
    func testFillDataToDetails() {
        //Arranje
        let thumbnail = Thumbnail(path: "path", ext: "extension")
        let hero = Hero(id: -1, name: "", description: "", thumbnail: thumbnail)
        //ACT
        sut.fillDataToDetails(hero: hero)
        //Assert
        XCTAssertNotNil(sut.hero, "sut.hero should be not nil when fillDataToDetails() is called")
    }
}
