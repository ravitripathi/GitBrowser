//
//  User.swift
//  MVVM-RxSwift
//
//  Created by Ravi Tripathi on 30/11/19.
//  Copyright © 2019 Ravi Tripathi. All rights reserved.
//

import Foundation

class User: Codable {
    var login: String?
    var avatar_url: String?
    var html_url: String?
    var starred_url: String?
    var name: String?
    var company: String?
    var blog: String?
    var location: String?
    var email: String?
    var bio: String?
    var public_repos: Int?
    var followers: Int?
    var following: Int?
}
