//
//  ContentView.swift
//  Aminote
//
//  Created by amin nazemzadeh on 10/24/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.requestReview) var requestReview
    @StateObject var viewModel: ViewModel

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        List(selection: $viewModel.selectedIssue) {
            ForEach(viewModel.dataController.issuesForSelectedFilter()) { issue in
                IssueRow(issue: issue)
            }
            .onDelete(perform: viewModel.delete)
        }
        .navigationTitle("Issues")
        .searchable(
            text: $viewModel.filterText,
            tokens: $viewModel.filterTokens,
            prompt: "Filter issues, or type # to add tags"
        ) { tag in
            Text(tag.tagName)
        }
        .searchSuggestions {
            ForEach(viewModel.suggestedFilterTokens) { token in
                Text(token.tagName).onTapGesture {
                    viewModel.filterTokens.append(token)
                    viewModel.filterText = ""
                }
            }
        }
        .toolbar(content: ContentViewToolbar.init)
        .onAppear(perform: askForReview)
    }

    func askForReview() {
        if viewModel.shouldRequestReview {
            requestReview()
        }
    }
}

#Preview {
    ContentView(dataController: .preview)
}
