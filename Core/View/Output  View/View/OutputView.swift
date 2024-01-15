//
//  OutputView.swift
//  My Wallet
//
//  Created by Moha Maanka on 1/7/24.
//

import SwiftUI
import ContactsUI
import SwiftUI

struct OutputView: View {
    @State private var nextPage = false
    @State private var fee = 1.0
    var transaction: Transaction
    
    // New properties
    var total: Double {
        return transaction.amount + fee
    }
    
    var formattedTotal: String {
        return String(format: "%.0f", total)
    }
    
    init(transaction: Transaction) {
        self.transaction = transaction
    }
    
    

    var body: some View {
        NavigationStack {
            VStack {
                
                // Slider
                sliderSection
                iconSection
             
                VStack(alignment: .center) {
                    HStack {
                        Text("Send Money Successfully 🤑")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.blue)
                    }
                    .padding()
                    
                    GroupBox {
                        HStack {
                            Text("Amount\t\t\t\t\t\t")
                            + Text("$\(String(format: "%.0f", transaction.amount))")
                                .foregroundColor(Color.blue)
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        .padding(.vertical, 4)
                        
                        HStack {
                            Text("Fee \t\t\t\t\t\t\t")
                            + Text("$\(String(format: "%.0f", fee))")
                                .foregroundColor(Color.blue)
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        .padding(.vertical, 4)
                        
                        HStack {
                            Text("Total \t\t\t\t\t\t\t")
                            + Text(formattedTotal)
                                .foregroundColor(Color.blue)
                                .fontWeight(.heavy)
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.top, 20)
                }
                
                Spacer()
                
                Button(action: {
                    HomeView.transactions.append(transaction)
                    nextPage.toggle()
                }, label: {
                    CustomButtonText(title: "Ok")
                })
            }
            .fullScreenCover(isPresented: $nextPage, content: {
                HomeView()
            })
            .navigationTitle("Send Money")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}



extension OutputView {
    
    // Section Slider
    var sliderSection: some View {
        HStack {
            ForEach(0...3, id: \.self) { index in
                HStack {
                    Capsule()
                        .frame(width: 70, height: 5)
                        .foregroundColor(index == 3 ? .blue : .gray)
                }
                .padding(.horizontal, 10)
            }
        }
        .padding()
        .padding(.top, 15)
    }
    
    // Section Icon
    
    var iconSection : some View {
        VStack {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.blue)
        }
        .padding(.top, 35)
        
    }
}
