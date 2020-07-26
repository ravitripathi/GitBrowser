//
//  GitBrowserWidget.swift
//  GitBrowserWidget
//
//  Created by Ravi Tripathi on 25/07/20.
//

import WidgetKit
import SwiftUI
import Intents

// Struct for data in widget
struct GithubUserEntry: TimelineEntry {
    let date: Date
    let userData: User
}

//Contains logic for updating/viewing the widget
struct Provider: TimelineProvider {

    
    typealias Entry = GithubUserEntry
    
    //Renders snapshot on home page. Dummy data. Fast returning
    func snapshot(with context: Context, completion: @escaping (GithubUserEntry) -> ()) {
        
        let entry = GithubUserEntry(date: Date(), userData: User())
        completion(entry)
    }
    
    func timeline(with context: Context, completion: @escaping (Timeline<GithubUserEntry>) -> ()) {
        NetworkManager.shared.getUserDetails(forUsername: AppData.lastCurrentUsername) { (user) -> (Void) in
            guard let user = user else {
                let entry = GithubUserEntry(date: Date(), userData: User())
                let timeline = Timeline(entries: [entry], policy: .atEnd)
                completion(timeline)
                return
            }
            let entry = GithubUserEntry(date: Date(), userData: user)
            //Policy decides when to reload the widget. We pass never (so remains fixed)
    //        let timeline = Timeline(entries: [entry], policy: .never)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
 }

//What the widget should look like
struct WidgetEntryView: View {
    
    let entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder //Allows adding switch statements to the view
    var body: some View {
        switch family {
        default:
            MediumWidget(user: entry.userData)
        }
        
    }
}


//This is the actual widget
@main
struct ArcWidget: Widget {
    
    private let kind = "ArcWidget"
   
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
//        Use this to set what sizes of widgets you want to support. Also works without it
//
    }
}
