//
//  RegistrationView.swift
//  My Wallet
//
//  Created by Moha Maanka on 1/7/24.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) var dismiss
    @State private var emailText = ""
    @State private var passwordText = ""
    @State private var confirmPasswordText = ""
    @State private var isValidEmail = true
    @State private var isValidPassword = true
    @State private var isConfirmPasswordValid = true
    
    @EnvironmentObject private var authService : AuthService
    
    @State var showSheet = false
    
    @FocusState private var focusField: FocusField?
    
    @State var name = ""
    
    var canProceed: Bool {
        Validator.validateEmail(emailText) &&
        Validator.validatePassword(passwordText)
    }
    
    var body: some View {
        
        NavigationStack{
          
                
                VStack{
                    
                    TitleView(title: "Create Account")
                    registrationSubTitleView(subTitle1: "Welcome to My Wallet App! To get started,  ", subTitle2: "Please create your account")
                    
                    
                    TextField("Full Name", text: $name)
                        .padding()
                        .background(Color.kLight)
                        .background(Color.kSecondary)
                        .disableAutocorrection(true)
                        .overlay{
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 2)
                        }
                        .padding(.horizontal)
                        .padding(.bottom,13)
                    
                    TextFieldView(placeholder: "Email", emailText: $emailText)
                    PasswordView(placehoplder: "Password", pass: $passwordText, validatePassword: Validator.validatePassword, errorText: "Your password is not valid")
                    
                    PasswordView(placehoplder: "Confirm Password", pass: $confirmPasswordText, validatePassword: validateConfirm, errorText: "Your password is not matched")
                    
                    Button {
                        authenticate()
                    } label: {
                        CustomButtonText(title: "Sign Up")
                            .opacity(canProceed ? 1.0 : 0.5)
                            .disabled(!canProceed)
                            .padding(.top,20)
                    }
                    
                    
                    Button {
                        showSheet.toggle()
                    } label: {
                        Text("Don't have an account?")
                            .fontWeight(.semibold)
                            .foregroundColor(.black.opacity(0.8))
                    }
                    .padding(.top,5)
                    
                    // or continue with
                    
                    Text("Or continue with")
                        .foregroundColor(Color(.systemBlue))
                        .padding(.top)
                    
                    CustomBotton(googleAction: {}, facebookAction: {}, appleAction: {})
                        .padding(.top)
                }
                
            }
            .fullScreenCover(isPresented: $showSheet) {
            LoginView()
                .navigationBarBackButtonHidden()
        }
        
        }
     
    func validateConfirm(_ password : String) -> Bool{
        passwordText == password
    }
    
    
    func authenticate() {
        Task {
            do {
               try await  authService.signUp(emailText, password: passwordText, name: name)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    RegistrationView()
}





struct registrationSubTitleView: View {
    @State var subTitle1: String
    @State var subTitle2: String
    var body: some View {
        VStack {
            Text(subTitle1)
            Text(subTitle2)
        }
        .font(.footnote)
        .foregroundColor(.black)
        .padding(.top,1)
        .padding(.bottom,20)
    }
}
