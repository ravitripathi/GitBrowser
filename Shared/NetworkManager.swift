//
//  NetworkManager.swift
//  MVVM-RxSwift
//
//  Created by Ravi Tripathi on 29/11/19.
//  Copyright © 2019 Ravi Tripathi. All rights reserved.
//

import Foundation

enum API: String {
    case following
    case repos
    case userDetail
    
    func getURL(forUsername userName: String) -> URL? {
        var composedURLString = ""
        if self != .userDetail {
            composedURLString = "\(NetworkManager.baseURL)\(userName)/\(self.rawValue)"
        } else {
            composedURLString = "\(NetworkManager.baseURL)\(userName)"
        }
        return URL(string: composedURLString)
    }
}

class NetworkManager: ObservableObject {
    
    static let shared = NetworkManager()
    static let baseURL = "https://api.github.com/users/"
    //By default, the URLSessions are GET requests
    func getFollowingList(forUsername username: String? = AppData.currentUser.login,
                          completion: @escaping ([FollowingUser]?) -> (Void)) {
        guard let name = username, let url = API.following.getURL(forUsername: name) else {
            return
        }
        let task = URLSession(configuration: URLSessionConfiguration.default).dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(nil)
                return
            }
            
            if let data = data, let decodedResponse = try? JSONDecoder().decode([FollowingUser].self, from: data) {
                completion(decodedResponse)
            }
        }
        task.resume()
    }
    
    func getRepoList(forUsername username: String? = AppData.currentUser.login, completion: @escaping ([Repo]?) -> (Void)) {
        guard let name = username, let url = API.repos.getURL(forUsername: name) else {
            completion(nil)
            return
        }
        let task = URLSession(configuration: URLSessionConfiguration.default).dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(nil)
                return
            }
            
            if let data = data, let decodedResponse = try? JSONDecoder().decode([Repo].self, from: data) {
                completion(decodedResponse)
            }
        }
        task.resume()
    }
    
    func getUserDetails(forUsername username: String? = AppData.currentUser.login, completion: @escaping (User?)->(Void)) {
        guard let name = username, let url = API.userDetail.getURL(forUsername: name) else {
            completion(nil)
            return
        }
        let task = URLSession(configuration: URLSessionConfiguration.default).dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(nil)
                return
            }
            
            if let data = data, let decodedResponse = try? JSONDecoder().decode(User.self, from: data) {
                completion(decodedResponse)
            }
        }
        task.resume()
    }
}
