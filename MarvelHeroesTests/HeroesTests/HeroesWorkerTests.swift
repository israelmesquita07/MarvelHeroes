//
//  HeroesWorkerTests.swift
//  MarvelHeroes
//
//  Created by Israel on 17/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import XCTest
@testable import MarvelHeroes

final class HeroesWorkerTests: XCTestCase {
    
    var sut: HeroesWorker!
    
    override func setUp() {
        super.setUp()
        sut = HeroesWorker()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFetchHeroesSuccess() {
        //Arranje
        let expectation = XCTestExpectation(description: "heroesExpectation")
        //ACT
        sut.fetchHeroes(name: "spider", page: 0) { result in
            switch result {
            case .success(let heroes):
                //Assert
                XCTAssertNotNil(heroes, "heroes should not be nil")
                expectation.fulfill()
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchHeroImageDecodeError() {
        //Arranje
        let expectation = XCTestExpectation(description: "heroesExpectation")
        //ACT
        sut.fetchHeroes(name: "-1", page: -1) { result in
            switch result {
            case .failure(let error):
                if case HeroesError.decodeError = error {
                    //Assert
                    XCTAssertNotNil(error, "error invalidUrl should not be nil")
                    expectation.fulfill()
                }
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
