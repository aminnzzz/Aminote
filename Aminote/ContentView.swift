//
//  ContentView.swift
//  Aminote
//
//  Created by amin nazemzadeh on 10/24/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController

    var issues: [Issue] {
        let filter = dataController.selectedFilter ?? .all
        var issues = [Issue]()

        if let tag = filter.tag {
            issues = tag.issues?.allObjects as? [Issue] ?? []
        } else {
            let request = Issue.fetchRequest()
            request.predicate = NSPredicate(format: "modificationDate > %@", filter.minModificationDate as NSDate)
            issues = (try? dataController.container.viewContext.fetch(request)) ?? []
        }

        return issues
    }

    var body: some View {
        List(selection: $dataController.selectedIssue) {
            ForEach(issues) { issue in
                IssueRow(issue: issue)
            }
            .onDelete(perform: delete)
        }
        .navigationTitle("Issues")
    }

    func delete(_ offsets: IndexSet) {
        for offset in offsets {
            let issue = issues[offset]
            dataController.delete(issue)
        }
    }
}

#Preview {
    ContentView()
}
