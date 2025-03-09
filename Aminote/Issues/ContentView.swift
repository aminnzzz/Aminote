//
//  ContentView.swift
//  Aminote
//
//  Created by amin nazemzadeh on 10/24/24.
//

import SwiftUI

struct ContentView: View {
    #if !os(watchOS)
    @Environment(\.requestReview) var requestReview
    #endif
    @StateObject var viewModel: ViewModel

    private let newIssueActivity = "com.amin.nazemzadeh.Aminote.newIssue"

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        List(selection: $viewModel.selectedIssue) {
            ForEach(viewModel.dataController.issuesForSelectedFilter()) { issue in
                #if os(watchOS)
                IssueRowWatch(issue: issue)
                #else
                IssueRow(issue: issue)
                #endif
            }
            .onDelete(perform: viewModel.delete)
        }
        .macFrame(minWidth: 220)
        .navigationTitle("Issues")
        #if !os(watchOS)
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
        #endif
        .toolbar(content: ContentViewToolbar.init)
        .onAppear(perform: askForReview)
        .onOpenURL(perform: viewModel.openURL)
        .userActivity(newIssueActivity) { activity in
            #if !os(macOS)
            activity.isEligibleForPrediction = true
            #endif
            activity.title = "New Issue"
        }
        .onContinueUserActivity(newIssueActivity, perform: resumeActivity)
    }

    func askForReview() {
        #if !os(watchOS)
        if viewModel.shouldRequestReview {
            requestReview()
        }
        #endif
    }

    func resumeActivity(_ userActivity: NSUserActivity) {
        viewModel.dataController.newIssue()
    }
}

#Preview {
    ContentView(dataController: .preview)
}
