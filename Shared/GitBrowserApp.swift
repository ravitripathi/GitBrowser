//
//  GitBrowserApp.swift
//  Shared
//
//  Created by Ravi Tripathi on 18/07/20.
//

import SwiftUI

@main
public struct GitBrowserApp: App {
    public init() {}
    public var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(NetworkStore())
        }
    }
}
