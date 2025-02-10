//
//  IssueView.swift
//  Aminote
//
//  Created by amin nazemzadeh on 11/17/24.
//

import SwiftUI

struct IssueView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var issue: Issue

    @State private var showingNotificationsAlert = false

    @Environment(\.openURL) var openURL

    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    TextField("Title", text: $issue.issueTitle, prompt: Text("Enter the issue title here"))
                        .font(.title)

                    Text("**Modified:** \(issue.issueModificationDate.formatted(date: .long, time: .shortened))")
                        .foregroundStyle(.secondary)

                    Text("**Status:** \(issue.issueStatus)")
                        .foregroundStyle(.secondary)
                }

                Picker("Priority", selection: $issue.priority) {
                    Text("Low").tag(Int16(0))
                    Text("Medium").tag(Int16(1))
                    Text("High").tag(Int16(2))
                }

                TagsMenuView(issue: issue)
            }

            Section {
                VStack(alignment: .leading) {
                    Text("Basic Information")
                        .font(.title2)
                        .foregroundStyle(.secondary)

                    TextField(
                        "Decription",
                        text: $issue.issueContent,
                        prompt: Text("Enter the issue description here"),
                        axis: .vertical
                    )
                }
            }

            Section("Reminders") {
                Toggle("Show reminders", isOn: $issue.reminderEnabled.animation())

                if issue.reminderEnabled {
                    DatePicker(
                        "Reminder time",
                        selection: $issue.issueReminderTime,
                        displayedComponents: .hourAndMinute
                    )
                }
            }
        }
        .disabled(issue.isDeleted)
        .onReceive(issue.objectWillChange) { _ in
            dataController.queueSave()
        }
        .onSubmit(dataController.save)
        .toolbar {
            IssueViewToolbar(issue: issue)
        }
        .alert("Oops!", isPresented: $showingNotificationsAlert) {
            Button("Check Settigns", action: showAppSettings)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("There was a problem setting your notifications. Please check you have notifications enabled.")
        }
        .onChange(of: issue.reminderEnabled, updateReminder)
        .onChange(of: issue.reminderTime, updateReminder)
    }

    func showAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openNotificationSettingsURLString) else { return }

        openURL(settingsURL)
    }

    func updateReminder() {
        dataController.removeReminder(for: issue)

        Task { @MainActor in
            if issue.reminderEnabled {
                let success = await dataController.addReminder(for: issue)

                if !success {
                    issue.reminderEnabled = false
                    showingNotificationsAlert = true
                }
            }
        }
    }
}

#Preview {
    IssueView(issue: .example)
}
