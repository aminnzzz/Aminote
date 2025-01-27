//
//  AminoteTests.swift
//  AminoteTests
//
//  Created by amin nazemzadeh on 1/27/25.
//

import CoreData
import XCTest
@testable import Aminote

class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}
