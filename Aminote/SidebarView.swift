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
        tags.map { Filter(id: $0.id ?? UUID(), name: $0.name ?? "No name", icon: "tag", tag: $0) }
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
                    }
                }
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
}

#Preview {
    SidebarView()
        .environmentObject(DataController.preview)
}
