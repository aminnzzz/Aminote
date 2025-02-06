//
//  SidebarViewModel.swift
//  Aminote
//
//  Created by amin nazemzadeh on 2/5/25.
//

import CoreData
import Foundation

extension SidebarView {
    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
        var dataController: DataController

        private var tagsController: NSFetchedResultsController<Tag>
        @Published var tags = [Tag]()

        @Published var tagToRename: Tag?
        @Published var renamingTag = false
        @Published var tagName = ""

        var tagFilters: [Filter] {
            tags.map { Filter(id: $0.tagID, name: $0.tagName, icon: "tag", tag: $0) }
        }

        init(dataController: DataController) {
            self.dataController = dataController

            let request = Tag.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Tag.name, ascending: true)]

            tagsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: dataController.container.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil
            )

            super.init()

            tagsController.delegate = self

            do {
                try tagsController.performFetch()
                tags = tagsController.fetchedObjects ?? []
            } catch {
                print("Failed to fetch tags.")
            }
        }

        func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
            if let newTags = controller.fetchedObjects as? [Tag] {
                tags = newTags
            }
        }

        func delete(_ offsets: IndexSet) {
            for offset in offsets {
                let tag = tags[offset]
                dataController.delete(tag)
            }
        }

        func delete(_ filter: Filter) {
            guard let tag = filter.tag else { return }
            dataController.delete(tag)
            dataController.save()
        }

        func rename(_ filter: Filter) {
            tagToRename = filter.tag
            tagName = filter.name
            renamingTag = true
        }

        func completeRename() {
            tagToRename?.name = tagName
            dataController.save()
        }
    }
}
