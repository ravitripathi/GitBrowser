//
//  User.swift
//  MVVM-RxSwift
//
//  Created by Ravi Tripathi on 30/11/19.
//  Copyright © 2019 Ravi Tripathi. All rights reserved.
//

import Foundation

public class User: Codable {
    public var login: String?
    public var avatar_url: String?
    public var html_url: String?
    public var starred_url: String?
    public var name: String?
    public var company: String?
    public var blog: String?
    public var location: String?
    public var email: String?
    public var bio: String?
    public var public_repos: Int?
    public var followers: Int?
    public var following: Int?
    public init() {}
}
