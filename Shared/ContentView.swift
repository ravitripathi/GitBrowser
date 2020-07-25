//
//  ContentView.swift
//  Shared
//
//  Created by Ravi Tripathi on 18/07/20.
//

import SwiftUI

struct ContentView: View {
    @State var enteredTitle: String = AppData.currentUser.login ?? ""
    @State var doneLoading: Bool? = false
    @State var loaderStarted: Bool = false
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
                    loaderStarted = true
                    AppData.currentUser.login = self.enteredTitle.trimmingCharacters(in: .whitespacesAndNewlines)
                    AppData.selectedUser.login = AppData.currentUser.login
                    hitApi()
                }, label: {
                    Text("Let's go")
                })
                if loaderStarted {
                    ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                }
                Spacer()
                
                NavigationLink(destination: MainView(user: AppData.currentUser), tag: true, selection: $doneLoading) {
                    EmptyView()
                }
                
            }
            .navigationTitle("Welcome")
        }
    }
    
    func hitApi() {
        NetworkManager.shared.getUserDetails { user  in
            if let user = user {
                AppData.currentUser = user
                doneLoading = true
                loaderStarted = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
