//
//  DatabaseHelperTests.swift
//  MarvelHeroesTests
//
//  Created by Israel on 18/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import XCTest
@testable import MarvelHeroes

class DatabaseHelperTests: XCTestCase {
    
    var sut: DatabaseHelper!

    override func setUp() {
        super.setUp()
        sut = DatabaseHelper()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSavingAndDeleteHeroInCoreData() {
        //Arranje
        let heroData = HeroData(id: 0, name: "Antman", image: UIImage(named: "LaunchScreen")!)

        //ACT
        let saved = sut.saveHeroData(data: heroData)
        //Assert
        XCTAssertTrue(saved, "saveHeroData() should save data")
        
        //ACT
        let fetched = sut.fetchHeroData()
        //Assert
        XCTAssertNotNil(fetched?.count, "fetchHeroData() should fill fetched variable")

        //ACT
        let deleted = sut.deleteHeroData(heroId: 0)
        //Assert
        XCTAssertTrue(deleted, "saveHeroData() should save data")
    }
}
