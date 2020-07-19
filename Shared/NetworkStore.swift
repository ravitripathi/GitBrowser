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
    @Published private(set) var isLoadingRepos: Bool = false
    @Published private(set) var following: [FollowingUser] = []
    @Published private(set) var isLoadingFollowList: Bool = false
    
    func fetch() {
        self.isLoadingRepos = true
        NetworkManager.shared.getRepoList { (repos) -> (Void) in
            if let repos = repos {
                DispatchQueue.main.async {
                    self.repos = repos
                    self.isLoadingRepos = false
                }
            }
        }
    }
    
    func fetchFollowing() {
        self.isLoadingFollowList = true
        NetworkManager.shared.getFollowingList { (followingUser) -> (Void) in
            if let fU = followingUser {
                DispatchQueue.main.async {
                    self.following = fU
                    self.isLoadingFollowList = false
                }
            }
        }
    }
    
    func fetchRepo(forUsername username: String) {
        self.isLoadingRepos = true
        NetworkManager.shared.getRepoList(forUsername: username) { (repoList) -> (Void) in
            DispatchQueue.main.async {
                if let rL = repoList {
                    self.repos = rL
                    self.isLoadingRepos = false
                }
            }
        }
    }
}
