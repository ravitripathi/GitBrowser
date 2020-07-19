//
//  ContentView.swift
//  Shared
//
//  Created by Ravi Tripathi on 18/07/20.
//

import SwiftUI

struct ContentView: View {
    @State var enteredTitle: String = ""
    @State var doneLoading: Bool? = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 50)
                Text("Enter a github username to begin")
                
                HStack {
                    Spacer().frame(width: 30)
                    TextField("Enter the usernname", text: $enteredTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    Spacer().frame(width: 30)
                }
                
                Button(action: {
                    User.current.login = self.enteredTitle.trimmingCharacters(in: .whitespacesAndNewlines)
                    User.selected.login = User.current.login
                    hitApi()
                }, label: {
                    Text("Let's go")
                })
                Spacer()
                
                NavigationLink(destination: MainView(user: User.current), tag: true, selection: $doneLoading) {
                    EmptyView()
                }
                
            }
            .navigationTitle("Welcome")
        }
    }
    
    func hitApi() {
        NetworkManager.shared.getUserDetails { user  in
            if let user = user {
                User.current = user
                doneLoading = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
