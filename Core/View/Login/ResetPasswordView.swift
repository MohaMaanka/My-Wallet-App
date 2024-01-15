//
//  ResetPasswordView.swift
//  My Wallet App
//
//  Created by Moha Maanka on 1/13/24.
//
import SwiftUI
import Firebase

struct ResetPasswordView: View {
    @State private var email: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State var showSheet = false

    var body: some View {
        VStack {
            
            TextField("Email", text: $email)
                .frame(width: 326)
                .padding()
                .background(Color.kLight)
                .background(Color.kSecondary)
                .disableAutocorrection(true)
                .overlay{
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray, lineWidth: 2)
                }
                .padding(.horizontal)
                .padding(.bottom,13)

            Button(action: {
                resetPassword()
            }) {
                CustomButtonText(title: "Reset Password")
            }
            
            
            Spacer()
            
            Button {
                showSheet.toggle()
            } label: {
                Text("Back")
                    .fontWeight(.bold)
                    .foregroundColor(Color.kPrimary)
            }
            .padding(.top,5)
            
          
        }
        .padding()
        .padding(.top, 30)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Password Reset"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        
        .fullScreenCover(isPresented: $showSheet) {
           LoginView()
                .navigationBarBackButtonHidden()
        }
    }

    private func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.alertMessage = error.localizedDescription
            } else {
                self.alertMessage = "Password reset email sent. Check your inbox."
            }
            self.showingAlert = true
        }
    }
}

#Preview {
    ResetPasswordView()
}
