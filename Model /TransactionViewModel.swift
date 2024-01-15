//
//  TransactionViewModel.swift
//  test
//
//  Created by Moha Maanka on 1/11/24.
//

import Foundation


class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    func addTransaction(amount: Double, recievedName: String) {
        let transaction = Transaction(recievedName: recievedName, amount: amount)
        transactions.append(transaction)
    }
    
}
