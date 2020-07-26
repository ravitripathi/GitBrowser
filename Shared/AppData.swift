//
//  AppData.swift
//  GitBrowser
//
//  Created by Ravi Tripathi on 25/07/20.
//

import Foundation
import WidgetKit

struct AppData {
    static var selectedUser = User()
    static var currentUser = User()
    @Storage(key: "current_user", defaultValue: "")
    static var lastCurrentUsername: String {
        didSet {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}
