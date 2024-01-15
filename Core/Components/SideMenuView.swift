//
//  SideMenuView.swift
//  Twitter App
//
//  Created by Moha Maanka on 12/12/23.
//

import SwiftUI

struct SideMenuView: View {
    @Environment(\.dismiss) var dismiss
    @State private var navigateToLogin = false
    @EnvironmentObject private var authService : AuthService
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                VStack(alignment: .leading, spacing: 3){
                    Image("Good")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 68, height: 68)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal, 1)
                    
                    Text("Hello , \( authService.profile.name != "" ? "\( authService.profile.name )" : "there" )")
                        .font(.subheadline)
                        .bold()
                        .padding(.top)
                }
                Spacer()
            }
            .padding()
            
            
            ForEach(SideMenuViewModel.allCases, id: \.rawValue ){viewModel in
                
                if viewModel == .home {
                    Button {
                        print("Home")
                    } label: {
                        SideMenuOptionRowView(viewModel: viewModel)
                    }
                }
                else if viewModel == .account {
                    Button {
                        print("My Account")
                    } label: {
                        SideMenuOptionRowView(viewModel: viewModel)
                    }
                    
                }
                else if viewModel == .transfer {
                    Button {
                        print("Transfer")
                    } label: {
                        SideMenuOptionRowView(viewModel: viewModel)
                    }
                    
                }
                else if viewModel == .setting {
                    Button {
                        print("Setting")
                    } label: {
                        SideMenuOptionRowView(viewModel: viewModel)
                    }
                    
                }
                else if viewModel == .logout {
                    Button {
                        logout()
                    } label: {
                        SideMenuOptionRowView(viewModel: viewModel)
                    }
                    
                }
                else{
                    SideMenuOptionRowView(viewModel: viewModel)
                }
            }
            
            Spacer()
            
        }
        .onReceive(authService.$uid) { uid in
            if uid != "" {
                Task<Void, Never>(priority: .userInitiated) {
                    do {
                        try await authService.fetchProfile()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
    }
    
    // Function Logout
    
    
    func logout() {
        Task {
            do {
                try  authService.logout()
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}
