//
//  AminoteWidget.swift
//  AminoteWidget
//
//  Created by amin nazemzadeh on 3/4/25.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date.now, issues: [.example])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date.now, issues: loadIssues())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let entry = SimpleEntry(date: .now, issues: loadIssues())
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }

    func loadIssues() -> [Issue] {
        let dataController = DataController()
        let request = dataController.fetchRequestForTopIssues(count: 1)
        return dataController.results(for: request)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let issues: [Issue]
}

struct AminoteWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Up next...")
                .font(.title)

            if let issue = entry.issues.first {
                Text(issue.issueTitle)
            } else {
                Text("Nothing!")
            }
        }
    }
}

struct AminoteWidget: Widget {
    let kind: String = "AminoteWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                AminoteWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                AminoteWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Up next...")
        .description("Your #1 top-priority issue.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    AminoteWidget()
} timeline: {
    SimpleEntry(date: .now, issues: [.example])
    SimpleEntry(date: .now, issues: [.example])
}
