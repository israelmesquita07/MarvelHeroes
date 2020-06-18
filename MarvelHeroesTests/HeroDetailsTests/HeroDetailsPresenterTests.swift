//
//  HeroDetailsPresenterTests.swift
//  MarvelHeroes
//
//  Created by Israel on 18/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import XCTest
@testable import MarvelHeroes

class HeroDetailsPresenterTests: XCTestCase {
    
    var sut: HeroDetailsPresenter!
    var viewControllerSpy: HeroDetailsViewControllerSpy!
    
    override func setUp() {
        super.setUp()
        sut = HeroDetailsPresenter()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDisplayHeroImageCalledInPresentHeroDetails() {
        //Arranje
        setupSpies()
        let thumbnail = Thumbnail(path: "path", ext: "extension")
        let hero = Hero(id: -1, name: "", description: "", thumbnail: thumbnail)
        let response = HeroDetails.Details.Response(imageHero: UIImage(), hero: hero)
        //ACT
        sut.presentHeroImage(response: response)
        //Assert
        XCTAssertTrue(viewControllerSpy.displayHeroImageCalled, "displayHeroImage() should be called in presentHeroDetails() from HeroDetailsPresenter")
    }
    
    func testDisplayErrorCalledInPresentError() {
        //Arranje
        setupSpies()
        //ACT
        sut.presentError(errorDescription: "some error")
        //Assert
        XCTAssertTrue(viewControllerSpy.displayErrorCalled, "displayError() should be called in presentError() from HeroDetailsPresenter")
    }
    
    func testDisplayAlertErrorCalledInPresentAlertError() {
        //Arranje
        setupSpies()
        //ACT
        sut.presentAlertError(errorDescription: "some error")
        //Assert
        XCTAssertTrue(viewControllerSpy.displayAlertErrorCalled, "displayAlertError() should be called in presentAlertError() from HeroDetailsPresenter")
    }
}

//MARK: - Spies
extension HeroDetailsPresenterTests {
    func setupSpies() {
        viewControllerSpy = HeroDetailsViewControllerSpy()
        sut.viewController = viewControllerSpy
    }
}
