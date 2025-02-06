//
//  AminoteApp.swift
//  Aminote
//
//  Created by amin nazemzadeh on 10/24/24.
//

import SwiftUI

@main
struct AminoteApp: App {
    @StateObject var dataController = DataController()
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                SidebarView(dataController: dataController)
            } content: {
                ContentView()
            } detail: {
                DetailView()
            }
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
            .onChange(of: scenePhase) {
                if scenePhase != .active {
                    dataController.save()
                }
            }
        }
    }
}
