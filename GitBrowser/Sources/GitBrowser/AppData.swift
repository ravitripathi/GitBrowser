//
//  AppData.swift
//  GitBrowser
//
//  Created by Ravi Tripathi on 25/07/20.
//

import Foundation
import WidgetKit

public struct AppData {
    public static var selectedUser = User()
    public static var currentUser = User()
    @Storage(key: "current_user", defaultValue: "")
    public static var lastCurrentUsername: String {
        didSet {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}
