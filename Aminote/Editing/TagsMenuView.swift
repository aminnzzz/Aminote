//
//  TagsMenuView.swift
//  Aminote
//
//  Created by amin nazemzadeh on 1/9/25.
//

import SwiftUI

struct TagsMenuView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var issue: Issue

    var body: some View {
        #if os(watchOS)
        LabeledContent("Tags", value: issue.issueTagsList)
        #else
        Menu {
            ForEach(issue.issueTags) { tag in
                Button {
                    issue.removeFromTags(tag)
                } label: {
                    Label(tag.tagName, systemImage: "checkmark")
                }
            }

            let otherTags = dataController.missingTags(from: issue)

            if !otherTags.isEmpty {
                Divider()

                Section("Add Tags") {
                    ForEach(otherTags) { tag in
                        Button(tag.tagName) {
                            issue.addToTags(tag)
                        }
                    }
                }
            }
        } label: {
            Text(issue.issueTagsList)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .animation(nil, value: issue.issueTagsList)
        }
        #endif
    }
}

#Preview {
    TagsMenuView(issue: .example)
        .environmentObject(DataController.preview)
}
