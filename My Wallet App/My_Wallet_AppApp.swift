//
//  My_Wallet_AppApp.swift
//  My Wallet App
//
//  Created by Moha Maanka on 1/13/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct My_Wallet_AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var authService = AuthService()

    var body: some Scene {
        WindowGroup {
           MainView()
                .environmentObject(authService)
        }
    }
}
