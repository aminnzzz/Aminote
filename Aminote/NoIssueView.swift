//
//  NoIssueView.swift
//  Aminote
//
//  Created by amin nazemzadeh on 11/17/24.
//

import SwiftUI

struct NoIssueView: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        Text("No Issues Selected")
            .font(.title)
            .foregroundStyle(.secondary)

        Button("New Issue") {
            
        }
    }
}

#Preview {
    NoIssueView()
}
