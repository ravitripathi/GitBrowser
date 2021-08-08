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
    case search
    
    func getURL(forUsername userName: String) -> URL? {
        var composedURLString = ""
        switch self {
        case .search:
            composedURLString = "https://api.github.com/search/repositories"
        case .userDetail:
            composedURLString = "\(NetworkManager.baseURL)\(userName)"
        default:
            composedURLString = "\(NetworkManager.baseURL)\(userName)/\(self.rawValue)"
        }
        return URL(string: composedURLString)
    }
}

public class NetworkManager: ObservableObject {
    
    public static let shared = NetworkManager()
    static let baseURL = "https://api.github.com/users/"
    //By default, the URLSessions are GET requests
    func getFollowingList(forUsername username: String? = AppData.currentUser.login,
                          completion: @escaping ([FollowingUser]?) -> (Void)) {
        guard let name = username, let url = API.following.getURL(forUsername: name) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
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
    
    func getRepoList(forUsername username: String? = AppData.currentUser.login, pageNumber page: Int = 1, completion: @escaping ([Repo]?) -> (Void)) {
        guard let name = username, let urlS = API.repos.getURL(forUsername: name)?.absoluteString, let url = URL(string: "\(urlS)?page=\(page)") else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
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
    
    func searchRepo(withName name: String, userName: String, completion: @escaping ([Repo]?)->(Void)) {
        guard !name.isEmpty, let absoluteString = API.search.getURL(forUsername: userName)?.absoluteString, let url = URL(string: "\(absoluteString)?q=\(name)+user:\(userName)") else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode), let data = data else {
                completion(nil)
                return
            }
            if let decodedResponse = try? JSONDecoder().decode(SearchResponse.self, from: data) {
                completion(decodedResponse.items)
            }
        }
        task.resume()
    }
    
    public func getUserDetails(forUsername username: String? = AppData.currentUser.login, completion: @escaping (User?)->(Void)) {
        guard let name = username, let url = API.userDetail.getURL(forUsername: name) else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
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
