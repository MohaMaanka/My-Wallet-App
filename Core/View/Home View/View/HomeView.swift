//
//  HomeView.swift
//  My Wallet
//
//  Created by Moha Maanka on 1/7/24.
//

import SwiftUI
import Contacts

struct HomeView: View {
    @State var balance = 100
    @State private var sendMoney = ""
    @State private var showMenu = false
    @State var nextPage = false
    static var transactions: [Transaction] = []
    @ObservedObject private var viewModel = TransactionViewModel()
    @EnvironmentObject private var authService : AuthService
    

    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                VStack {
                    
                    // Balance Section
                    HStack {
                        Text("Balance: $\(balance)")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding()
                    .padding(.top)
                    
                    
                    // Button
                    
                    Button(action: {
                        nextPage.toggle()
                    }, label: {
                        CustomButtonText(title: "Send Money")
                    })
                    
                    // Transaction
                    
                    VStack(alignment: .leading) {
                      
                        titleSection
                        
                        List {
                            ForEach(HomeView.transactions) { transaction in
                                VStack(alignment: .leading) {
                                    Text("Sent: $\(String(format: "%.0f", transaction.amount)) \( authService.profile.name )")
                                    Text("Recieved: $\(String(format: "%.0f", transaction.amount)) \(transaction.recievedName)")
                                }
                            }
                            .onDelete(perform: deleteTransactions)
                        }
                        .padding(.horizontal)
                    }
                    .fullScreenCover(isPresented: $nextPage, content: {
                        PhoneBookView(transactions: HomeView.transactions, viewModel: viewModel)
                            .environmentObject(authService)
                    })
                    .navigationTitle("My Wallet")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden()
                }
                Spacer()
                
                // Side bar
                
                    .navigationBarHidden(showMenu)
                if showMenu {
                    ZStack {
                        Color(.black)
                            .opacity(0.25)
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            showMenu = false
                        }
                    }
                    .ignoresSafeArea()
                }
                
                SideMenuView()
                    .frame(width: 300)
                    .offset(x: showMenu ? 0: -300 , y: 0)
                    .background(showMenu ? Color.white: Color.clear)
            }
            
            
            //  Top Bar Section
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showMenu.toggle()
                    }, label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .fontWeight(.medium)
                    })
                }
            }
            
            
            
            
        }
    }
    
    func deleteTransactions(at offsets: IndexSet) {
        HomeView.transactions.remove(atOffsets: offsets)
    }
    
}




extension HomeView {
    
    
    // title Section
    var titleSection : some View {
        HStack {
            Text("Transactions")
                .font(.headline)
                .fontWeight(.semibold)
            Spacer()
            
        }
        .padding(.horizontal)
    }
    
    
    
    
}
