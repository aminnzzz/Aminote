//
//  PerformanceTests.swift
//  AminoteTests
//
//  Created by amin nazemzadeh on 2/4/25.
//

import XCTest
@testable import Aminote

final class PerformanceTests: BaseTestCase {
    func testAwardCalculationPerformance() {
        for _ in 0...100 {
            dataController.createSampleData()
        }

        let awards = Array(repeating: Award.allAwards, count: 25).joined()
        XCTAssertEqual(awards.count, 1, "This checks the awards count is constant. Change this if you add awards.")

        measure {
            _ = awards.filter(dataController.hasEarned)
        }
    }
}
