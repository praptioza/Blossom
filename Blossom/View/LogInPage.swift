//
//  LogInPage.swift
//  Blossom


import SwiftUI
import FirebaseAuth
struct LogInPage: View {
    
    @AppStorage("uid") var userID : String = ""
    @Binding var currentShowingView: String
    @State var email = ""
    @State var password = ""
    @State var isVisible = false
    @State var showErrorAlert = false
    
    private func isValidPassword(_ password: String)-> Bool{
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^.*(?=.{6,})(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*\\d)|(?=.*[!#$%&? ]).*")
        
        return passwordRegex.evaluate(with: password)
    }
    
    private func loginUser(){
        UserManager.shared.auth.signIn(withEmail: email, password: password){authResult, error in
            if let error = error{
                print(error)
                self.showErrorAlert = true
            }
            if let authResult = authResult{
                print(authResult.user.uid)
                withAnimation{
                    userID = authResult.user.uid
                }
                
            }
        }
    }
    var body: some View {
        ScrollView(showsIndicators:false){
            VStack{
                ZStack{
                    VStack{
                        Text("LOG IN").font(.custom("Lato-Bold", size: 24)).foregroundColor(.greenColor)
                            .padding(.top,20)
                        
                        // Image
                        Image("ig-login")
                            .frame(width: 294.22,height: 278)
                            .padding(.top,14)
                        
                        // EMAIL BLOCK
                        VStack(alignment: .leading){
                            Text("Email")
                                .font(.custom("Lato-Regular", size: 16))
                                .foregroundColor(.greenColor)
                            TextField("Enter Email Here", text: $email)
                                .padding(10)
                                .autocorrectionDisabled(true)
                                .autocapitalization(.none)
                                .background((RoundedRectangle(cornerRadius: 10))
                                    .foregroundColor(.greenColor)
                                    .opacity(0.15))
                            if (email.count != 0 && !email.isValidEmail()){
                                Text("Invalid Email")
                                    .foregroundColor(.red)
                                    .bold()
                                    .font(.custom("Lato-Bold", size: 12))
                            }
                        }.frame(width: 294.22, height: 63)
                            .padding(.top,10)
                        // END OF EMAIL BLOCK
                        
                        // BEGIN OF PASSWORD BLOCK
                        VStack(alignment: .leading){
                            Text("Password")
                                .font(.custom("Lato-Regular", size: 16))
                                .foregroundColor(.greenColor)
                            HStack{
                                VStack{
                                    if self.isVisible{
                                        TextField("Enter Password Here", text: $password)
                                    }
                                    else{
                                        SecureField("Enter Password Here", text: $password)
                                    }
                                } // End of VStack
                                
                                Button(action:{
                                    self.isVisible.toggle()
                                }){Image(systemName: self.isVisible ? "eye.fill" : "eye.fill")
                                        .foregroundColor(.greenColor)
                                }
                            }
                            .padding(10)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                            .background((RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(.greenColor)
                                .opacity(0.15))
                            
                            // END OF PASSWORD BLOCK
                            
                        }.frame(width: 294.22, height: 63)
                            .padding(.top,36)
                        
                        // SignUp Button
                        Button{
                            loginUser()
                            
                        }label:
                        {
                            Text("Log In")
                                .foregroundColor(.white)
                            
                        }.frame(width: 294.22, height: 47)
                            .background((RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(.greenColor))
                            .padding(.top,40)
                            .alert(isPresented: $showErrorAlert) {
                                Alert(
                                    title: Text("Error"),
                                    message: Text("Invalid Email or Password!"),
                                    dismissButton: .default(Text("OK"))
                                )
                            }
                        
                        // End of Sign Up Button
                        // Begin of Already have an account button
                        Button(action:{
                            withAnimation{
                                self.currentShowingView = "signup"
                            }
                        }){
                            Text("Create New Account?")
                                .frame(width: 294.22,height: 16)
                                .font(.custom("Lato-Regular", size: 13))
                                .foregroundColor(.greenColor)
                                .underline()
                                .padding(.top,41)
                            
                        }// end of "Already Have an account button"
                        
                    }
                }.frame(width: 303.22, height: 688)
                
            }.navigationBarBackButtonHidden()
            
        }
        
    }
}


