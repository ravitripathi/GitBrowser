//
//  UserHeader.swift
//  GitBrowser
//
//  Created by Ravi Tripathi on 18/07/20.
//

import SwiftUI
import KingfisherSwiftUI

struct UserHeader: View {
    let user: User
    var body: some View {
        HStack {
            if let urlS = user.avatar_url, let url = URL(string: urlS) {
                KFImage(url)
                    .resizable()
                    .frame(width: 100.0, height: 100.0)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
            }
            VStack(alignment: .leading) {
                Text(user.name ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                Text("@\(user.login ?? "")")
                    .font(.title2)
            }
        }.frame(height: 120)
        
    }
}

struct UserHeader_Previews: PreviewProvider {
    
    static let user: User = {
        let u = User()
        u.avatar_url = "https://github.com/onevcat/Kingfisher/blob/master/images/kingfisher-1.jpg?raw=true"
        u.name = "John Doe"
        u.login = "johndoe"
        return u
    }()
    
    static var previews: some View {
        UserHeader(user: user)
    }
}
