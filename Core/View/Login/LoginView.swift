//
//  LoginView.swift
//  My Wallet
//
//  Created by Moha Maanka on 1/6/24.
//

import SwiftUI

enum FocusField {
    case email
    case password
}


struct LoginView: View {
    @State private var emailText = ""
    @State private var passwordText = ""
    @State private var isValidEmail = true
    @State private var isValidPassword = true
    @State var showSheet = false
    @State var showForgetPassword = false
    @FocusState private var focusField: FocusField?
    @EnvironmentObject private var authService : AuthService
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    
    
    var canProceed: Bool {
        Validator.validateEmail(emailText) &&
        Validator.validatePassword(passwordText)
    }
    
    
    var body: some View {
        NavigationStack {
           
                
                VStack{
                    
                    // Title
                    
                    TitleView(title: "Login")
                    
                    // Sub title
                    
                    SubTitleView(subTitle1: "Welcome to My Wallet Application,", subTitle2: "Please to continue")
                    
                    
                    // Email
                    
                    TextFieldView(placeholder: "Email", emailText: $emailText)
                    
                    
                    
                    // Password
                    
                    
                    PasswordView(placehoplder: "Password", pass: $passwordText, validatePassword: Validator.validatePassword, errorText: "Your password is not valid")
                    
                    //                // Forget Passsword
                    //
                    Button(action: {
                        showForgetPassword.toggle()
                    }, label: {
                        HStack{
                            Spacer()
                            Text("Forget Password?")
                                .font(.subheadline)
                                .foregroundColor(.kPrimary)
                                .fontWeight(.heavy)
                        }
                    })
                    .padding(.horizontal)
                    .padding(.top,12)
                    
                    // Login
                    
                    Button {
                        
                        authenticate()
                        
                    } label: {
                        CustomButtonText(title: "Sign In")
                            .opacity(canProceed ? 1.0 : 0.5)
                            .disabled(!canProceed)
                    }
                    .padding(.top)
                    
                    // Create New Account
                    
                    Button {
                        showSheet.toggle()
                    } label: {
                        Text("Create new account")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    .padding(.top,5)
                    
                    // or continue with
                    
                    Text("Or continue with")
                        .foregroundColor(Color(.systemBlue))
                        .padding(.top)
                    
                    // Images
                    
                    CustomBotton(googleAction: {}, facebookAction: {}, appleAction: {})
                    
                    
                }
            }

        .fullScreenCover(isPresented: $showSheet) {
            RegistrationView()
                .navigationBarBackButtonHidden()
        }
        .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
        
        .fullScreenCover(isPresented: $showForgetPassword) {
           ResetPasswordView()
                .navigationBarBackButtonHidden()
        }
        
        
        
     
    }
    
    
    
    func authenticate() {
        Task {
            do {
                try await authService.login(emailText, password: passwordText)
            } catch {
                alertMessage = error.localizedDescription
                showingAlert = true
            }
        }
    }
}




struct CustomBotton: View {
    
    var googleAction : () -> Void
    var facebookAction : () -> Void
    var appleAction : () -> Void
    
    var body: some View {
        HStack{
            
            Button(action: {
                googleAction()
            }, label: {
                Image("google-logo")
            })
            .padding()
            .background(Color.kLightLogo)
            .cornerRadius(8)
            
            Button(action: {
                facebookAction()
            }, label: {
                Image("facebook-logo")
            })
            .padding()
            .background(Color.kLightLogo)
            .cornerRadius(8)
            
            
            Button(action: {
                appleAction()
            }, label: {
                Image("apple-logo")
            })
            .padding()
            .background(Color.kLightLogo)
            .cornerRadius(8)
            
        }
        .padding(.top,7)
    }
}


struct TextFieldView: View {
    @State  var placeholder: String
    @Binding var emailText : String
    @State private var isValidEmail = true
    @State private var isValidPassword = true
    
    
    @FocusState private var focusField: FocusField?
    
    var body: some View {
        
        TextField(placeholder, text: $emailText)
            .focused($focusField, equals: .email)
            .padding()
            .background(Color.kLight)
            .background(Color.kSecondary)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .overlay{
                RoundedRectangle(cornerRadius: 12)
                    .stroke(!isValidEmail ? .red : focusField == .email ? Color.kSecondary : Color.gray, lineWidth: 2)
            }
            .padding(.horizontal)
            .onChange(of: emailText) { oldValue, newValue in
                isValidEmail =  Validator.validateEmail(newValue)
            }
            .padding(.bottom , isValidEmail ? 3 : 0)
        
        
        if !isValidEmail {
            HStack {
                Text("Your email is not valid")
                    .foregroundColor(.red)
                
                Spacer()
            }
            .padding(.horizontal)
            
        }
        
        
    }
}


struct PasswordView: View {
    @State var placehoplder: String
    @Binding var pass: String
    @State private var isValidEmail = true
    @State private var isValidPassword = true
    let validatePassword : (String) -> Bool
    
    let errorText : String
    
    @FocusState private var focusField: FocusField?
    
    var body: some View {
        
        
        SecureField(placehoplder, text: $pass)
            .focused($focusField, equals: .password)
            .padding()
            .background(Color.kLight)
            .background(Color.kSecondary)
            .overlay{
                RoundedRectangle(cornerRadius: 12)
                    .stroke(!isValidPassword ? .red : focusField == .password ? Color.kSecondary : Color.gray, lineWidth: 2)
            }
            .padding(.horizontal)
            .padding(.top,10)
            .onChange(of: pass) { oldValue, newValue in
                isValidPassword = validatePassword(newValue)
            }
        
        
        if !isValidPassword {
            HStack {
                Text(errorText)
                    .foregroundColor(.red)
                
                Spacer()
            }
            .padding(.horizontal)
            
        }
    }
}

struct TitleView: View {
    @State var title : String
    var body: some View {
        Text(title)
            .font(.system(size: 35, weight: .semibold))
            .foregroundColor(Color.kPrimary)
    }
}

struct SubTitleView: View {
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
        .padding(.bottom,80)
    }
}
