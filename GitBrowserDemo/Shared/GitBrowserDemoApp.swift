//
//  GitBrowserDemoApp.swift
//  Shared
//
//  Created by Ravi Tripathi on 08/08/21.
//

import SwiftUI
import GitBrowser

@main
struct GitBrowserDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(NetworkStore())
        }
    }
}
