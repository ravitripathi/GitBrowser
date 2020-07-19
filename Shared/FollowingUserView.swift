//
//  FollowingUserView.swift
//  GitBrowser
//
//  Created by Ravi Tripathi on 19/07/20.
//

import SwiftUI
import KingfisherSwiftUI

struct FollowingUserView: View {
    var followingUser: FollowingUser
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            if let urlS = followingUser.avatar_url, let url = URL(string: urlS) {
                KFImage(url)
                    .resizable()
                    .frame(width: 65.0, height: 65.0)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 4))
            }
            Text(followingUser.login ?? "")
                .font(.headline)
                .frame(height: 35.0)
        }.frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 120)
    }
}

struct FollowingUserView_Previews: PreviewProvider {
    
    static var fU: FollowingUser {
        let f = FollowingUser()
        f.avatar_url = "https://github.com/onevcat/Kingfisher/blob/master/images/kingfisher-1.jpg?raw=true"
        f.login = "johndsdksjdlksdkjskldjslkjdlksjdkjskdjslkdjlksjdkldoe"
        return f
    }
    
    static var previews: some View {
        FollowingUserView(followingUser: fU)
    }
}
