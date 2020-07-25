//
//  AppData.swift
//  GitBrowser
//
//  Created by Ravi Tripathi on 25/07/20.
//

import Foundation

struct AppData {
    @Storage(key: "selected_user", defaultValue: User())
    static var selectedUser: User
    @Storage(key: "current_user", defaultValue: User())
    static var currentUser: User
}
