//
//  Repo.swift
//  MVVM-RxSwift
//
//  Created by Ravi Tripathi on 29/11/19.
//  Copyright © 2019 Ravi Tripathi. All rights reserved.
//

import Foundation

class Repo: Codable, Identifiable {
    var id: Int?
    var name: String?
    var html_url: String?
    var description: String?
    var fork: Bool?
    var language: String?
    var watchers: Int?
}
// MARK: - SearchResponse
struct SearchResponse: Codable {
    var total_count: Int?
    var incomplete_results: Bool?
    var items: [Repo]?
//    var repo = [Repo]()
    
    /*mutating func generateRepoArray() {
        guard let items = self.items else {
            return
        }
        for item in items {
            let repo = Repo()
            repo.id = item.id
            repo.name = item.name
            repo.html_url = item.htmlURL
            repo.description = item.itemDescription
            repo.fork = item.fork
            repo.language = item.language
            repo.watchers = item.watchers
            self.repo.append(repo)
        }
    }*/
}

// MARK: - Item
struct Item: Codable {
    var id: Int?
    var nodeID, name, fullName: String?
    var itemPrivate: Bool?
    var owner: Owner?
    var htmlURL: String?
    var itemDescription: String?
    var fork: Bool?
    var url, forksURL: String?
    var keysURL, collaboratorsURL: String?
    var teamsURL, hooksURL: String?
    var issueEventsURL: String?
    var eventsURL: String?
    var assigneesURL, branchesURL: String?
    var tagsURL: String?
    var blobsURL, gitTagsURL, gitRefsURL, treesURL: String?
    var statusesURL: String?
    var languagesURL, stargazersURL, contributorsURL, subscribersURL: String?
    var subscriptionURL: String?
    var commitsURL, gitCommitsURL, commentsURL, issueCommentURL: String?
    var contentsURL, compareURL: String?
    var mergesURL: String?
    var archiveURL: String?
    var downloadsURL: String?
    var issuesURL, pullsURL, milestonesURL, notificationsURL: String?
    var labelsURL, releasesURL: String?
    var deploymentsURL: String?
    var createdAt, updatedAt, pushedAt: Date?
    var gitURL, sshURL: String?
    var cloneURL: String?
    var svnURL: String?
    var size, stargazersCount, watchersCount: Int?
    var language: String?
    var hasIssues, hasProjects, hasDownloads, hasWiki: Bool?
    var hasPages: Bool?
    var forksCount: Int?
    var archived, disabled: Bool?
    var openIssuesCount, forks, openIssues, watchers: Int?
    var defaultBranch: String?
    var score: Int?
    var homepage: String?
    var license: LicenseUnion?

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case itemPrivate = "private"
        case owner
        case htmlURL = "html_url"
        case itemDescription = "description"
        case fork, url
        case forksURL = "forks_url"
        case keysURL = "keys_url"
        case collaboratorsURL = "collaborators_url"
        case teamsURL = "teams_url"
        case hooksURL = "hooks_url"
        case issueEventsURL = "issue_events_url"
        case eventsURL = "events_url"
        case assigneesURL = "assignees_url"
        case branchesURL = "branches_url"
        case tagsURL = "tags_url"
        case blobsURL = "blobs_url"
        case gitTagsURL = "git_tags_url"
        case gitRefsURL = "git_refs_url"
        case treesURL = "trees_url"
        case statusesURL = "statuses_url"
        case languagesURL = "languages_url"
        case stargazersURL = "stargazers_url"
        case contributorsURL = "contributors_url"
        case subscribersURL = "subscribers_url"
        case subscriptionURL = "subscription_url"
        case commitsURL = "commits_url"
        case gitCommitsURL = "git_commits_url"
        case commentsURL = "comments_url"
        case issueCommentURL = "issue_comment_url"
        case contentsURL = "contents_url"
        case compareURL = "compare_url"
        case mergesURL = "merges_url"
        case archiveURL = "archive_url"
        case downloadsURL = "downloads_url"
        case issuesURL = "issues_url"
        case pullsURL = "pulls_url"
        case milestonesURL = "milestones_url"
        case notificationsURL = "notifications_url"
        case labelsURL = "labels_url"
        case releasesURL = "releases_url"
        case deploymentsURL = "deployments_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case gitURL = "git_url"
        case sshURL = "ssh_url"
        case cloneURL = "clone_url"
        case svnURL = "svn_url"
        case size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasDownloads = "has_downloads"
        case hasWiki = "has_wiki"
        case hasPages = "has_pages"
        case forksCount = "forks_count"
        case archived, disabled
        case openIssuesCount = "open_issues_count"
        case forks
        case openIssues = "open_issues"
        case watchers
        case defaultBranch = "default_branch"
        case score, homepage, license
    }
}

enum LicenseUnion: Codable {
    case licenseClass(LicenseClass)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(LicenseClass.self) {
            self = .licenseClass(x)
            return
        }
        throw DecodingError.typeMismatch(LicenseUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for LicenseUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .licenseClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - LicenseClass
struct LicenseClass: Codable {
    var key, name, spdxID: String?
    var url: String?
    var nodeID: String?

    enum CodingKeys: String, CodingKey {
        case key, name
        case spdxID = "spdx_id"
        case url
        case nodeID = "node_id"
    }
}

// MARK: - Owner
struct Owner: Codable {
    var login: String?
    var id: Int?
    var nodeID: String?
    var avatarURL: String?
    var gravatarID: String?
    var url, htmlURL, followersURL: String?
    var followingURL, gistsURL, starredURL: String?
    var subscriptionsURL, organizationsURL, reposURL: String?
    var eventsURL: String?
    var receivedEventsURL: String?
    var type: String?
    var siteAdmin: Bool?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}
