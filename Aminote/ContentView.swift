//
//  ContentView.swift
//  Aminote
//
//  Created by amin nazemzadeh on 10/24/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        List(selection: $dataController.selectedIssue) {
            ForEach(dataController.issuesForSelectedFilter()) { issue in
                IssueRow(issue: issue)
            }
            .onDelete(perform: delete)
        }
        .navigationTitle("Issues")
        .searchable(
            text: $dataController.filterText,
            tokens: $dataController.filterTokens,
            prompt: "Filter issues, or type # to add tags"
        ) { tag in
            Text(tag.tagName)
        }
        .searchSuggestions {
            ForEach(dataController.suggestedFilterTokens) { token in
                Text(token.tagName).onTapGesture {
                    dataController.filterTokens.append(token)
                    dataController.filterText = ""
                }
            }
        }
        .toolbar(content: ContentViewToolbar.init)
    }

    func delete(_ offsets: IndexSet) {
        let issues = dataController.issuesForSelectedFilter()

        for offset in offsets {
            let issue = issues[offset]
            dataController.delete(issue)
        }
    }
}

#Preview {
    ContentView()
}
