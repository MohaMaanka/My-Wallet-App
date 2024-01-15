//
//  ContentView.swift
//  My Wallet App
//
//  Created by Moha Maanka on 1/13/24.
//


import SwiftUI

struct ContentView: View {
    @State private var nextScreen = false
    var body: some View {
        NavigationStack {
           HomeView()
        }
        
    }
}
#Preview {
    ContentView()
}



