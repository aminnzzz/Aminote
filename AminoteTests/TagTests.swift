//
//  TagTests.swift
//  AminoteTests
//
//  Created by amin nazemzadeh on 1/27/25.
//

import CoreData
import XCTest
@testable import Aminote

final class TagTests: BaseTestCase {
    func testCreatingTagsAndIssues() {
        let count = 10

        for _ in 0..<count {
            let tag = Tag(context: managedObjectContext)

            for _ in 0..<count {
                let issue = Issue(context: managedObjectContext)
                tag.addToIssues(issue)
            }
        }

        XCTAssertEqual(
            dataController.count(for: Tag.fetchRequest()),
            count,
            "Expected: \(count) tags."
        )
        XCTAssertEqual(
            dataController.count(for: Issue.fetchRequest()),
            count * count,
            "Expected: \(count * count) issues."
        )
    }

    func testDeletingTagsDoesNotDeleteIssues() throws {
        dataController.createSampleData()

        let request = Tag.fetchRequest()
        let tags = try managedObjectContext.fetch(request)

        dataController.delete(tags[0])

        XCTAssertEqual(
            dataController.count(for: Tag.fetchRequest()),
            4,
            "There should be 4 tags after deleting 1 from our sample data."
        )
        XCTAssertEqual(
            dataController.count(for: Issue.fetchRequest()),
            50,
            "There should still be 50 issues after deleting a tag from our sample data."
        )
    }
}
