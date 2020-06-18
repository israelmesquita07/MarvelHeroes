//
//  HeroesPresenterTests.swift
//  MarvelHeroes
//
//  Created by Israel on 17/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import XCTest
@testable import MarvelHeroes

final class HeroesPresenterTests: XCTestCase {
    
    var sut: HeroesPresenter!
    var viewControllerSpy: HeroesViewControllerSpy!
    
    override func setUp() {
        super.setUp()
        sut = HeroesPresenter()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDisplayHeroesCalledInPresentHeroes() {
        //Arranje
        setupSpies()
        let thumbnail = Thumbnail(path: "path", ext: "extension")
        let hero = Hero(id: -1, name: "", description: "", thumbnail: thumbnail)
        let response = Heroes.List.Response(heroes: [hero])
        //ACT
        sut.presentHeroes(response: response)
        //Assert
        XCTAssertTrue(viewControllerSpy.displayHeroesCalled, "displayHeroes() should be called in presentHeroes() from HeroesPresenter")
    }
    
    func testDisplayErrorCalledInPresentError() {
        //Arranje
        setupSpies()
        //ACT
        sut.presentError(errorDescription: "some error")
        //Assert
        XCTAssertTrue(viewControllerSpy.displayErrorCalled, "displayError() should be called in presentError() from HeroesPresenter")
    }
    
    func testDisplayAlertErrorCalledInPresentAlertError() {
        //Arranje
        setupSpies()
        //ACT
        sut.presentAlertError(errorDescription: "some error")
        //Assert
        XCTAssertTrue(viewControllerSpy.displayAlertErrorCalled, "displayAlertError() should be called in presentAlertError() from HeroesPresenter")
    }
    
    func testToggleLoadingCalledInToggleLoading() {
        //Arranje
        setupSpies()
        //ACT
        sut.toggleLoading(false)
        //Assert
        XCTAssertTrue(viewControllerSpy.toggleLoadingCalled, "toggleLoading() should be called in toggleLoading() from HeroesPresenter")
    }
}

//MARK: - Spies
extension HeroesPresenterTests {
    func setupSpies() {
        viewControllerSpy = HeroesViewControllerSpy()
        sut.viewController = viewControllerSpy
    }
}
