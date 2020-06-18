//
//  HeroDetailsViewControllerTests.swift
//  MarvelHeroes
//
//  Created by Israel on 18/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import XCTest
@testable import MarvelHeroes

class HeroDetailsViewControllerTests: XCTestCase {
    
    var sut: HeroDetailsViewController!
    var interactorSpy: HeroDetailsInteractorSpy!
    
    override func setUp() {
        super.setUp()
        sut = HeroDetailsViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testLoadHeroImageCalledInViewDidLoad() {
        //Arranje
        setupSpies()
        //ACT
        sut.viewDidLoad()
        //Assert
        XCTAssertTrue(interactorSpy.loadHeroImageCalled, "loadHeroImage() should be called in viewDidLoad() from HeroDetailsViewController")
    }
    
    func testMarkAsFavoriteCalledInMarkAsFavorite() {
        //Arranje
        setupSpies()
        let heroData = HeroData(id: -1, name: "", image: UIImage())
        //ACT
        _ = sut.markAsFavorite(heroData: heroData)
        //Assert
        XCTAssertTrue(interactorSpy.markAsFavoriteCalled, "markAsFavorite() should be called in markAsFavorite() from HeroDetailsViewController")
    }
    
    func testDeleteHeroDataCalledInDeleteHeroData() {
        //Arranje
        setupSpies()
        //ACT
        _ = sut.deleteHeroData(heroId: -1)
        //Assert
        XCTAssertTrue(interactorSpy.deleteHeroDataCalled, "deleteHeroData() should be called in deleteHeroData() from HeroDetailsViewController")
    }
}

//MARK: - Spies
extension HeroDetailsViewControllerTests {
    func setupSpies() {
        interactorSpy = HeroDetailsInteractorSpy()
        sut.interactor = interactorSpy
    }
}
