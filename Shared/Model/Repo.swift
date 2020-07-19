//
//  Repo.swift
//  MVVM-RxSwift
//
//  Created by Ravi Tripathi on 29/11/19.
//  Copyright © 2019 Ravi Tripathi. All rights reserved.
//

import Foundation

class Repo: Codable, Identifiable {
    var id: Double?
    var name: String?
    var html_url: String?
    var description: String?
    var fork: Bool?
    var language: String?
    var watchers: Int?
}
