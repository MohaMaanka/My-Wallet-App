//
//  WelcomeView.swift
//  My Wallet App
//
//  Created by Moha Maanka on 1/13/24.
//

import SwiftUI

struct WelcomeView: View {
    @State private var nextScreen = false
    var body: some View {
        NavigationStack {
            VStack {
                Text("My Wallet")
                    .font(.title)
                    .foregroundColor(Color.kPrimary)
                    .bold()
                    .padding(.top,30)
                
                Spacer()
                
                Image("money")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Spacer()
                
                Button {
                    nextScreen.toggle()
                } label: {
                    CustomButtonText(title: "Get Started")
                }

            }
            
            // Navigate Login Page 
            
            .navigationDestination(isPresented: $nextScreen) {
                LoginView()
                    .navigationBarBackButtonHidden()
            }
 
        }
    }
}

#Preview {
    WelcomeView()
}
