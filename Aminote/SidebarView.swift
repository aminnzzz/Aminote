//
//  SidebarView.swift
//  Aminote
//
//  Created by amin nazemzadeh on 11/10/24.
//

import SwiftUI

struct SidebarView: View {
    @EnvironmentObject var dataController: DataController

    @FetchRequest(sortDescriptors: [SortDescriptor(\Tag.name)]) var tags: FetchedResults<Tag>

    let smartFilters: [Filter] = [.all, .recent]

    var tagFilters: [Filter] {
        tags.map { Filter(id: $0.tagID, name: $0.tagName, icon: "tag", tag: $0) }
    }

    var body: some View {
        List(selection: $dataController.selectedFilter) {
            Section("Smart Filters") {
                ForEach(smartFilters) { filter in
                    NavigationLink(value: filter) {
                        Label(filter.name, systemImage: filter.icon)
                    }
                }
            }

            Section("Tags") {
                ForEach(tagFilters) { filter in
                    NavigationLink(value: filter) {
                        Label(filter.name, systemImage: filter.icon)
                            .badge(filter.tag?.tagActiveIssues.count ?? 0)
                    }
                }
                .onDelete(perform: delete)
            }
        }
        .toolbar {
            Button {
                dataController.deleteAll()
                dataController.createSampleData()
            } label: {
                Label("ADD SAMPLES", systemImage: "flame")
            }
        }
    }

    func delete(_ offsets: IndexSet) {
        for offset in offsets {
            let tag = tags[offset]
            dataController.delete(tag)
        }
    }
}

#Preview {
    SidebarView()
        .environmentObject(DataController.preview)
}
