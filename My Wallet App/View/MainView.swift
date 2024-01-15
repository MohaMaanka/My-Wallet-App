//
//  MainView.swift
//  My Wallet App
//
//  Created by Moha Maanka on 1/13/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var authService : AuthService
    var body: some View {
        Group {
            switch authService.authState {
            case .undefined :
                ProgressView()
            case .notauthenticated:
               WelcomeView()
            case .authenticated:
                ContentView()
                
            }
        }
    }
}

#Preview {
    MainView()
}
