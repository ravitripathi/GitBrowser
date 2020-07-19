//
//  RepoView.swift
//  GitBrowser
//
//  Created by Ravi Tripathi on 19/07/20.
//

import SwiftUI

struct RepoView: View {
    var repo: Repo
    @Environment(\.openURL) var openURL
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(repo.name ?? "")
                    .font(.title)
                    .fontWeight(.semibold)
                Text(repo.description ?? "")
                
                Text("Language: \(repo.language ?? "")")
                    .font(.caption)
            }
            .padding(.all, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .border(colorScheme == .dark ? Color.white : Color.black, width: 3)
            .cornerRadius(5.0)
            .onTapGesture {
                if let urlS = repo.html_url, let url = URL(string: urlS)  {
                    openURL(url)
                }
            }
        }
    }
}

struct RepoView_Previews: PreviewProvider {
    
    static var repo: Repo {
        let repo = Repo()
        repo.name = "Your repo"
        repo.description = "Your awesome repo description"
        repo.language = "Swift"
        repo.html_url = "https://www.google.com"
        repo.watchers = 10
        return repo
    }
    
    static var previews: some View {
        RepoView(repo: repo)
    }
}
