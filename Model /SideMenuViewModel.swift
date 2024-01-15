//
//  SideMenuViewModel.swift
//  My Wallet
//
//  Created by Moha Maanka on 1/9/24.
//

import Foundation


enum SideMenuViewModel: Int, CaseIterable {
    case home
    case account
    case transfer
    case setting
    case logout
    
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .account: return "My Account"
        case .transfer: return "Transfers"
        case .setting: return "Setting"
        case .logout: return "Logout"
        }
    }
    
    
    var imageName: String {
        switch self{
        case .home: return "house"
        case .account: return "person"
        case .transfer: return "arrow.right.arrow.left.circle"
        case.setting: return "gearshape.fill"
        case .logout: return "arrow.left.square"
            
        }
    }
    
    
    
}
