//
//  HeroDetailsInteractorTests.swift
//  MarvelHeroes
//
//  Created by Israel on 18/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import XCTest
@testable import MarvelHeroes

final class HeroDetailsInteractorTests: XCTestCase {
    
    var sut: HeroDetailsInteractor!
    var presenterSpy: HeroDetailsPresenterSpy!
    var workerSpy: HeroDetailsWorkerSpy!
    
    override func setUp() {
        super.setUp()
        sut = HeroDetailsInteractor()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testPresentAlertErrorCalledInDeleteHeroData() {
        //Arranje
        setupSpies()
        //ACT
        _ = sut.deleteHeroData(heroId: -1)
        //Assert
        XCTAssertTrue(presenterSpy.presentAlertErrorCalled, "presentAlertError() should be called in deleteHeroData() from HeroDetailsInteractor")
    }
    
    func testPresentErrorCalledInLoadHeroImage() {
        //Arranje
        setupSpies()
        //ACT
        sut.loadHeroImage(request: HeroDetails.Details.Request())
        //Assert
        XCTAssertTrue(presenterSpy.presentErrorCalled, "presentError() should be called in loadHeroImage() from HeroDetailsInteractor")
    }
    
    func testFetchHeroImageCalledInLoadHeroImage() {
        //Arranje
        setupSpies()
        let thumbnail = Thumbnail(path: "path", ext: "extension")
        let hero = Hero(id: -1, name: "", description: "", thumbnail: thumbnail)
        sut.hero = hero
        //ACT
        sut.loadHeroImage(request: HeroDetails.Details.Request())
        //Assert
        XCTAssertTrue(workerSpy.fetchHeroImageCalled, "fetchHeroImage() should be called in loadHeroImage() from HeroDetailsInteractor")
    }
}

//MARK: - Spies
extension HeroDetailsInteractorTests {
    func setupSpies() {
        workerSpy = HeroDetailsWorkerSpy()
        sut.worker = workerSpy
        presenterSpy = HeroDetailsPresenterSpy()
        sut.presenter = presenterSpy
    }
}
