//
//  Transaction.swift
//  test
//
//  Created by Moha Maanka on 1/11/24.
//

import Foundation


struct Transaction: Identifiable, Hashable {
    var id = UUID()
    var recievedName: String
    var amount: Double
}
