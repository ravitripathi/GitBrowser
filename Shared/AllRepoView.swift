//
//  AllRepoView.swift
//  GitBrowser
//
//  Created by Ravi Tripathi on 25/07/20.
//

import SwiftUI

struct AllRepoView: View {
    
    var viewModel: AllRepoViewModel
    @State var list: [Repo] = []
    
    var body: some View {
        VStack {
            SearchBar { (text) in
                viewModel.search(name: text) { (repo) in
                    self.list = repo
                }
            }.disableAutocorrection(true)
            .padding()
            List(list.indices, id: \.self) { index in
                RepoView(repo: list[index]).onAppear {
                    if index > (list.count - 3) {
                        viewModel.fetchRepos { (repoList) in
                            self.list = repoList
                        }
                    }
                }
            }
        }.onAppear {
            viewModel.fetchRepos { (repoList) in
                self.list = repoList
            }
        }.navigationTitle(viewModel.userName)
    }
}

struct AllRepoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        AllRepoView(viewModel: AllRepoViewModel(withName: "ravitripathi"))
        }
    }
}

class AllRepoViewModel {
    
    private(set) var repoList: [Repo] = []
    private var currentPage = 0
    var userName: String
    private(set) var hasMoreRows: Bool = true
    
    init(withName name: String) {
        self.userName = name
    }
    
    func fetchRepos(completion: @escaping ([Repo])->()) {
        guard hasMoreRows else {
            return
        }
        currentPage = currentPage + 1
        NetworkManager.shared.getRepoList(forUsername: userName, pageNumber: currentPage) { [unowned self] (repo) -> (Void) in
            
            DispatchQueue.main.async {
                if let repo = repo, !repo.isEmpty {
                    //                    dummy.append(contentsOf: repo)
                    self.repoList.append(contentsOf: repo)
                    completion(self.repoList)
                } else {
                    self.hasMoreRows = false
                }
            }
        }
    }
    
    
    func search(name: String, completion: @escaping ([Repo])->()) {
        if name.isEmpty {
            completion(self.repoList)
            return
        }
        NetworkManager.shared.searchRepo(withName: name, userName: self.userName) { (repos) -> (Void) in
            DispatchQueue.main.async {
                if let repos = repos {
                    completion(repos)
                } else {
                    completion(self.repoList)
                }
            }
            
        }
    }
}
