//
//  UserFilterRow.swift
//  Aminote
//
//  Created by amin nazemzadeh on 1/9/25.
//

import SwiftUI

struct UserFilterRow: View {
    @EnvironmentObject var dataController: DataController

    var filter: Filter
    var rename: (Filter) -> Void
    var delete: (Filter) -> Void

    var body: some View {
        NavigationLink(value: filter) {
            Label(filter.tag?.name ?? "No name", systemImage: filter.icon)
                .numberBadge(filter.activeIssuesCount)
                .contextMenu {
                    Button {
                        rename(filter)
                    } label: {
                        Label("Rename", systemImage: "pencil")
                    }

                    Button(role: .destructive) {
                        delete(filter)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                .accessibilityElement()
                .accessibilityLabel(filter.name)
                .accessibilityHint("\(filter.activeIssuesCount) issue")
        }
    }
}

#Preview {
    UserFilterRow(filter: .all, rename: { _ in }, delete: { _ in })
}
