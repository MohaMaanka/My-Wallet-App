//
//  ConfirmView.swift
//  My Wallet
//
//  Created by Moha Maanka on 1/7/24.
//

import SwiftUI
import ContactsUI
struct ConfirmationView: View {
    @State private var nextPage = false
    @State private var fee = 1.0
    var transaction: Transaction
    
    var total: Double {
        return transaction.amount + fee
    }
    
    var formattedTotal: String {
        return String(format: "%.0f", total)
    }
    
    init(transaction: Transaction) {
        self.transaction = transaction
    }
    
    
    @State var navigationLinkIsActive = false
    
    var body: some View {
        NavigationStack {
            VStack {
               
                sliderSection
                
                VStack(alignment: .leading) {
                  
                    titleSection
                    
                    GroupBox {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Sending to \t\t\t    ")
                                +
                                Text(transaction.recievedName)
                                    .foregroundColor(Color.blue)
                                    .fontWeight(.heavy)
                                
                                Spacer()
                            }
                            .padding(.vertical, 4)
                            
                            HStack {
                                Text("Amount\t\t\t\t\t\t")
                                + Text(" $\(String(format: "%.0f", transaction.amount))")
                                    .foregroundColor(Color.blue)
                                    .fontWeight(.heavy)
                                
                                Spacer()
                            }
                            .padding(.vertical, 4)
                            
                            HStack {
                                Text("fee \t\t\t\t\t\t\t")
                                + Text("$\(String(format: "%.0f", fee))")
                                    .foregroundColor(Color.blue)
                                    .fontWeight(.heavy)
                                
                                Spacer()
                            }
                            .padding(.vertical, 4)
                            
                            HStack {
                                Text("Total \t\t\t\t\t\t\t")
                                + Text("$\(formattedTotal)")
                                    .foregroundColor(Color.blue)
                                    .fontWeight(.heavy)
                                
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal)
                    .font(.headline)
                    .fontWeight(.semibold)
                }
                
                Spacer()
                
                Button(action: {
                    nextPage.toggle()
                }, label: {
                   buttonStyle
                })
            }
            .fullScreenCover(isPresented: $nextPage, content: {
                OutputView(transaction: transaction)
            })
            
            .navigationTitle("Send Money")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}



extension ConfirmationView {
    
    
    // Slider Section
    
    var sliderSection : some View {
        HStack {
            ForEach(0...3, id: \.self) { index in
                HStack {
                    Capsule()
                        .frame(width: 70, height: 5)
                        .foregroundColor(index == 2 ? .kPrimary : .gray)
                }
                .padding(.horizontal, 10)
            }
        }
        .padding()
        .padding(.top, 15)
    }
    
    // Tile Section
    
    var titleSection : some View {
        HStack {
            Text("Confirm")
                .font(.title2)
                .fontWeight(.medium)
            
            Spacer()
        }
        .padding()
    }
    
   
    // button Style
    
    var buttonStyle : some View {
        HStack {
            Spacer()
            VStack {
                Image(systemName: "arrow.right")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
            }
            .frame(width: 70, height: 70)
            .background(Color.kPrimary)
            .cornerRadius(50)
        }
        .padding()
        .padding(.trailing)
    }
    
    
}
