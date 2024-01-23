//
//  Profile.swift
//  My Wallet App
//
//  Created by Moha Maanka on 1/13/24.
//

import SwiftUI

struct UserProfile : Codable {
    var name : String
    
    init(name: String? = nil ) {
        self.name = name ?? ""
    }
}
