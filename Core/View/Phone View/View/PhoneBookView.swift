
//  PhoneBookView.swift
//  My Wallet
//
//  Created by Moha Maanka on 1/7/24.
//

import SwiftUI
import ContactsUI

struct PhoneBookView: View {
    @State private var isContactPickerPresented = false
    @State private var selectedContact: CNContact?
    @State var nextPage = false
    @State private var receiverName: String = ""
    
    //  Instance
    var transactions: [Transaction]
    var viewModel: TransactionViewModel
    
    init(transactions: [Transaction], viewModel: TransactionViewModel) {
        self.transactions = transactions
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                
                sliderSection
                
                VStack(alignment: .leading){
                    
                    titleSection
                    
                    // Conatct Start
                    
                    HStack {
                        TextField("Select From Phone Book ", text: $receiverName)
                            .foregroundColor(selectedContact != nil ? .blue : .gray)
                            .onAppear {
                                receiverName = selectedContact.map { "\($0.givenName) \($0.familyName)" } ?? ""
                            }
                            .padding()
                            .fontWeight(.semibold)
                        
                        Button(action: {
                            isContactPickerPresented.toggle()
                        }) {
                            Image(systemName: "person.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.black)
                        }
                        .padding()
                        
                        .sheet(isPresented: $isContactPickerPresented) {
                            ContactPicker(isPresented: $isContactPickerPresented, onContactSelected: { contact in
                                selectedContact = contact
                                receiverName = "\(contact.givenName) \(contact.familyName)"
                            })
                        }
                    }
                    .background(Color("kLightColor"))
                    .cornerRadius(12)
                    .padding()
                    
                    // Contact End
                    
                    Spacer()
                    
                    Button(action: {
                        nextPage.toggle()
                    }, label: {
                        buttonStyle
                    })
                    
                }
                .fullScreenCover(isPresented: $nextPage, content: {
                    InputAmountView(viewModel: viewModel, receiverName: $receiverName)
                })
                .navigationTitle("Send Money")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                
            }
        }
    }
}


extension PhoneBookView {
    
    // slider Section
    
    var sliderSection: some View {
        HStack {
            ForEach(0...3, id: \.self){ index in
                
                HStack {
                    Capsule()
                        .frame(width: 70, height: 5)
                        .foregroundColor(index == 0 ? .kPrimary : .gray)
                }
                .padding(.horizontal,10)
                
            }
        }
        .padding()
        .padding(.top,15)
        
    }
    
    
    // Title Section
    
    var titleSection: some View {
        HStack {
            Text("Select Receiver")
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




// import Phone


struct ContactPicker: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var onContactSelected: (CNContact) -> Void
    
    class Coordinator: NSObject, CNContactPickerDelegate {
        var parent: ContactPicker
        
        init(parent: ContactPicker) {
            self.parent = parent
        }
        
        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            // Handle the selected contact
            parent.onContactSelected(contact)
            parent.isPresented = false
        }
        
        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            parent.isPresented = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = context.coordinator
        uiViewController.present(contactPicker, animated: true, completion: nil)
    }
}


