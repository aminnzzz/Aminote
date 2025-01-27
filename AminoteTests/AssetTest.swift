//
//  AssetTest.swift
//  AminoteTests
//
//  Created by amin nazemzadeh on 1/27/25.
//

import XCTest
@testable import Aminote

final class AssetTest: XCTestCase {
    func testColorExists() {
        let allColors = ["Dark Blue", "Dark Gray", "Gold", "Gray", "Green",
                         "Light Blue", "Midnight", "Orange", "Pink", "Purple", "Red", "Teal"]

        for color in allColors {
            XCTAssertNotNil(UIColor(named: color), "Failed to load color '\(color)' from asset catalog")
        }
    }

    func testAwardsLoadCorrectly() {
        XCTAssertTrue(Award.allAwards.isEmpty == false, "Failed to load awards from JSON.")
    }
}
