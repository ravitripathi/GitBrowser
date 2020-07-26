//
//  MediumWidget.swift
//  GitBrowser (iOS)
//
//  Created by Ravi Tripathi on 26/07/20.
//

import SwiftUI
import WidgetKit
import KingfisherSwiftUI

struct MediumWidget: View {
    
    @State var user: User
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
                Text("Followers: \(user.followers ?? 0)")
                Text("Followers: \(user.following ?? 0)")
                Text("Location: \(user.location ?? "Location")")
            }
        }
    }
}

struct MediumWidget_Previews: PreviewProvider {
    
    static var dummyUser: User = {
        let user = User()
        user.name = "John Doe"
        user.login = "johndoe"
        user.company = "Company brrrr"
        user.avatar_url = "https://github.com/onevcat/Kingfisher/blob/master/images/kingfisher-1.jpg?raw=true"
        return user
    }()
    
    static var previews: some View {
        Group {
            MediumWidget(user: MediumWidget_Previews.dummyUser)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
