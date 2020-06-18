//
//  HeroDetailsWorkerTests.swift
//  MarvelHeroes
//
//  Created by Israel on 18/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import XCTest
@testable import MarvelHeroes

final class HeroDetailsWorkerTests: XCTestCase {
    
    var sut: HeroDetailsWorker!
    
    override func setUp() {
        super.setUp()
        sut = HeroDetailsWorker()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFetchHeroImageSuccess() {
        //Arranje
        let expectation = XCTestExpectation(description: "fetchHeroImageExpectation")
        let url = "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg"
        //ACT
        sut.fetchHeroImage(url: url) { result in
            switch result {
            case .success(let image):
                //Assert
                XCTAssertNotNil(image, "image should not be nil")
                expectation.fulfill()
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchHeroImageErrorInvalidUrl() {
        //Arranje
        let expectation = XCTestExpectation(description: "fetchHeroImageExpectation")
        //ACT
        sut.fetchHeroImage(url: "") { result in
            switch result {
            case .failure(let error):
                if case HeroesError.invalidUrl = error {
                    //Assert
                    XCTAssertNotNil(error, "error invalidUrl should not be nil")
                    expectation.fulfill()
                } else {
                    XCTFail("error is not type invalidUrl")
                }
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchHeroImageErrorInternetFailure() {
        //Arranje
        let expectation = XCTestExpectation(description: "fetchHeroImageExpectation")
        let url = "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784"
        //ACT
        sut.fetchHeroImage(url: url) { result in
            switch result {
            case .failure(let error):
                if case HeroesError.internetFailure = error {
                    //Assert
                    XCTAssertNotNil(error, "error internetFailure should not be nil")
                    expectation.fulfill()
                } else {
                    XCTFail("error is not type internetFailure")
                }
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
