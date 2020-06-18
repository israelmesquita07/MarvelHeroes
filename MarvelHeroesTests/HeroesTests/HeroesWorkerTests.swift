//
//  HeroesWorkerTests.swift
//  MarvelHeroes
//
//  Created by Israel on 17/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

@testable import MarvelHeroes
import XCTest

class HeroesWorkerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: HeroesWorker!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupHeroesWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupHeroesWorker() {
        sut = HeroesWorker()
    }
    
    // MARK: Test doubles
    
    // MARK: Tests
    
    func testSomething() {
        // Given
        
        // When
        
        // Then
    }
}
