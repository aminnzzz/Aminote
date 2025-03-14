//
//  ContentViewModel.swift
//  Aminote
//
//  Created by amin nazemzadeh on 2/6/25.
//

import Foundation

extension ContentView {
    @dynamicMemberLookup
    class ViewModel: ObservableObject {
        var dataController: DataController

        var shouldRequestReview: Bool {
            if dataController.count(for: Tag.fetchRequest()) >= 5 {
                let reviewRequestCount = UserDefaults.standard.integer(forKey: "reviewRequestCount")
                UserDefaults.standard.set(reviewRequestCount + 1, forKey: "reviewRequestCount")
                if reviewRequestCount.isMultiple(of: 10) {
                    return true
                }
            }

            return false
        }

        init(dataController: DataController) {
            self.dataController = dataController
        }

        func delete(_ offsets: IndexSet) {
            let issues = dataController.issuesForSelectedFilter()

            for offset in offsets {
                let issue = issues[offset]
                dataController.delete(issue)
            }
        }

        func openURL(_ url: URL) {
            if url.absoluteString.contains("newIssue") {
                dataController.newIssue()
            } else if let issue = dataController.issue(with: url.absoluteString) {
                dataController.selectedIssue = issue
                dataController.selectedFilter = .all
            }
        }

        subscript<Value>(dynamicMember keyPath: KeyPath<DataController, Value>) -> Value {
            dataController[keyPath: keyPath]
        }

        subscript<Value>(dynamicMember keyPath: ReferenceWritableKeyPath<DataController, Value>) -> Value {
            get { dataController[keyPath: keyPath] }
            set { dataController[keyPath: keyPath] = newValue }
        }
    }
}
