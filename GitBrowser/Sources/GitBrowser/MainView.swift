//
//  MainView.swift
//  GitBrowser
//
//  Created by Ravi Tripathi on 19/07/20.
//

import SwiftUI
import Combine

struct MainView: View {
    @EnvironmentObject var netStore: NetworkStore
    @State var selectedUser = FollowingUser()
    let user: User
    
    var followingView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                if netStore.isLoadingFollowList {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
                ForEach(netStore.following) { user in
                    let isSelected = (user.login == self.selectedUser.login)
                    FollowingUserView(followingUser: user, selected: isSelected).onTapGesture {
                        self.selectedUser = user
                        if let username = user.login {
                            AppData.selectedUser.login = username
                            netStore.fetchRepo(forUsername: username)
                        }
                    }
                }
            }
        }
    }
    
    var repoListView: some View {
        List(netStore.repos) { repo in
            RepoView(repo: repo)
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            UserHeader(user: user)
                .onTapGesture {
                    self.selectedUser = FollowingUser()
                    AppData.selectedUser.login = AppData.currentUser.login
                    netStore.fetch()
                }
            
            Text("Following")
                .font(.title)
            followingView
            
            let str: String = {
                if AppData.selectedUser.login == AppData.currentUser.login {
                    return "Your repos"
                } else {
                    return "\(AppData.selectedUser.login ?? "")'s repos"
                }
            }()
            
            HStack {
                Text(str).font(.title)
                Spacer()
                NavigationLink(destination:
                                AllRepoView(viewModel: AllRepoViewModel(withName: AppData.selectedUser.login ?? ""))){
                    Text("See All").foregroundColor(Color.blue)
                }
            }
            
            if netStore.isLoadingRepos {
                VStack {
                    Spacer()
                    HStack{
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                        Spacer()
                    }
                    Spacer()
                }
            } else {
                repoListView
            }
            
        }.padding(EdgeInsets(top: 0.0, leading: 10.0, bottom: 0.0, trailing: 10.0))
        .onAppear {
            UITableView.appearance().separatorStyle = .none
            netStore.fetch()
            netStore.fetchFollowing()
        }
        .navigationBarTitle(Text("GitBrowser"), displayMode: .inline)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(user: UserHeader_Previews.user)
    }
}
