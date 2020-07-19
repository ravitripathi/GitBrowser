//
//  NetworkStore.swift
//  GitBrowser
//
//  Created by Ravi Tripathi on 19/07/20.
//

import SwiftUI
import Combine

class NetworkStore: ObservableObject {
    @Published private(set) var repos: [Repo] = []
    @Published private(set) var following: [FollowingUser] = []
    
    func fetch() {
        NetworkManager.shared.getRepoList { (repos) -> (Void) in
            if let repos = repos {
                DispatchQueue.main.async {
                    self.repos = repos
                }
            }
        }
    }
    
    func fetchFollowing() {
        NetworkManager.shared.getFollowingList { (followingUser) -> (Void) in
            if let fU = followingUser {
                DispatchQueue.main.async {
                    self.following = fU
                }
            }
        }
    }
    
    func fetchRepo(forUsername username: String) {
        NetworkManager.shared.getRepoList(forUsername: username) { (repoList) -> (Void) in
            if let rL = repoList {
                DispatchQueue.main.async {
                    self.repos = rL
                }
            }
        }
    }
}
