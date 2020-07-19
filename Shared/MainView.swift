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
    
    let user: User
    
    var followingView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(netStore.following) { user in
                    FollowingUserView(followingUser: user)
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
            
            Text("Following")
                .font(.title)
            followingView
            
            Text("Your repos")
                .font(.title)
            repoListView
            
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
