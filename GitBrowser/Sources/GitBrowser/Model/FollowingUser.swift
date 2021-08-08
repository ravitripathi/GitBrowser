//
//  FollowingUser.swift
//  MVVM-RxSwift
//
//  Created by Ravi Tripathi on 29/11/19.
//  Copyright © 2019 Ravi Tripathi. All rights reserved.
//

import Foundation

class FollowingUser: Codable, Identifiable {
    var login: String?
    var id: Double?
    var avatar_url: String?
    var html_url: String?
    var followers_url: String?
    var following_url: String?
    var repos_url: String?
}
