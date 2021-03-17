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
        viewControllerSpy = HeroDetailsViewControllerSpy()
        sut = HeroDetailsPresenter(viewController: viewControllerSpy)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDisplayHeroImageCalledInPresentHeroDetails() {
        //Arranje
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
        //ACT
        sut.presentError(errorDescription: "some error")
        //Assert
        XCTAssertTrue(viewControllerSpy.displayErrorCalled, "displayError() should be called in presentError() from HeroDetailsPresenter")
    }
    
    func testDisplayAlertErrorCalledInPresentAlertError() {
        //Arranje
        //ACT
        sut.presentAlertError(errorDescription: "some error")
        //Assert
        XCTAssertTrue(viewControllerSpy.displayAlertErrorCalled, "displayAlertError() should be called in presentAlertError() from HeroDetailsPresenter")
    }
}
