//
//  InputAmountView.swift
//  My Wallet
//
//  Created by Moha Maanka on 1/7/24.
//

import SwiftUI
import ContactsUI

struct InputAmountView: View {
    
    @ObservedObject var viewModel: TransactionViewModel
    
    @State var nextPage = false
    @Binding  var receiverName: String
    @State  var amount = ""
    
    var body: some View {
        NavigationStack{
            
            VStack{
                
                silderSection
                
                VStack(alignment: .leading){
                    
                    titleSection
                    
                    TextField("Amount", text: $amount)
                        .padding()
                        .background(Color.kLight)
                        .background(Color.kSecondary)
                        .overlay{
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.black, lineWidth: 2)
                        }
                        .padding()
                    
                }
                
                Spacer()
                
                Button(action: {
                    if let amount = Double(amount) {
                        viewModel.addTransaction(amount: amount, recievedName: receiverName)
                    }
                    nextPage.toggle()
                }, label: {
                    buttonStyle
                })
                
            }
            .fullScreenCover(isPresented: $nextPage, content: {
                if let lastTransaction = viewModel.transactions.last {
                    ConfirmationViewController(transaction: lastTransaction, isPresented: $nextPage)
                        .edgesIgnoringSafeArea(.all)
                } else {
                    Text("Error: No transaction data")
                }
            })
            .navigationTitle("Send Money")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    
}

extension InputAmountView {
    
    // Slider Section
    
    var silderSection : some View {
        
        HStack {
            ForEach(0...3, id: \.self){ index in
                
                HStack {
                    Capsule()
                        .frame(width: 70, height: 5)
                        .foregroundColor(index == 1 ? .kPrimary : .gray)
                }
                .padding(.horizontal,10)
            }
        }
        .padding()
        .padding(.top,15)
    }
    
    
    // title Section
    
    var titleSection : some View {
        HStack {
            Text("Input Amount")
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
            VStack{
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


struct ConfirmationViewController: UIViewControllerRepresentable {
    let transaction: Transaction
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> UIViewController {
        let confirmationView = ConfirmationView(transaction: transaction)
        let hostingController = UIHostingController(rootView: confirmationView)
        return hostingController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update any configurations if needed
    }
}
