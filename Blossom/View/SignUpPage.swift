//
//  SignUpPage.swift
//  Blossom


import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
struct SignUpPage: View {
    @State var image: UIImage?
    @State var shouldShowImagePicker = false
    @State private var showErrorAlert=false
    @State var isVisible = false
    @AppStorage("uid") var userID : String = ""
    @Binding var currentViewShowing: String
    @State private var email : String = ""
    @State private var password: String = ""
    @State private var username : String = ""
    @State var loginStatusMsg = ""
    
    // Password Validation
    private func isValidPassword(_ pwd: String)-> Bool{
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^.*(?=.{6,})(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*\\d)|(?=.*[!#$%&? ]).*")
        
        return passwordRegex.evaluate(with: pwd)
    }
    
    var body: some View {
        ScrollView(showsIndicators:false){
            ZStack{
                ZStack(alignment: .topTrailing){
                    Image("ig-lines")
                        .frame(width: 266.9, height: 96.97)
                        .position(x:UIScreen.main.bounds.width - 315, y: 30)
                    Image("ig-leaf")
                        .frame(width: 109.54, height: 192.74)
                        .position(x: UIScreen.main.bounds.width - 60, y: 90)
                    Image("ig-jungle")
                        .frame(width: 523,height: 307)
                        .position(x:UIScreen.main.bounds.width / 1.8, y: UIScreen.main.bounds.height - 80)
                        .opacity(0.5)
                }
                
                
                VStack{
                    // Title:
                    Text("SIGN UP").font(.custom("Lato-Bold", size: 24))
                        .foregroundColor(.greenColor)
                        .padding(.bottom,44)
                    // Calling the Credentials Block for emailid, username and pwd
                    VStack(spacing: 44){
                        // Begin of Image Uoload
                        Button(action:{
                            shouldShowImagePicker.toggle()
                        },
                               label: {
                            
                            VStack{
                                if let image = self.image{
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 110, height: 110)
                                        .scaledToFill()
                                        .cornerRadius(64)
                                } else
                                {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 54))
                                        .foregroundColor(.greenColor)
                                    
                                }
                                Text("Upload Profile Image")
                                    .foregroundColor(.greenColor)
                                    .font(.custom("Lato-Regular", size: 12))
                                    .padding(10)
                                
                            }
                        })// end of Image Upload
                        // BEGIN OF USERNAME BLOCK
                        VStack(alignment: .leading){
                            Text("Username")
                                .font(.custom("Lato-Regular", size: 16))
                                .foregroundColor(.greenColor)
                            TextField("Enter Username Here", text: $username)
                                .padding(10)
                                .autocorrectionDisabled(true)
                                .autocapitalization(.none)
                                .background((RoundedRectangle(cornerRadius: 10))
                                    .foregroundColor(.greenColor)
                                    .opacity(0.15))
                        }.frame(width: 294.22, height: 63)
                        // END OF USERNAME BLOCK
                        
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
                                }
                                
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
                            if (password.count != 0 && !isValidPassword(password)){
                                Text("Invalid Password")
                                    .foregroundColor(.red)
                                    .bold()
                                    .font(.custom("Lato-Bold", size: 12))
                            }
                            
                        }.frame(width: 294.22, height: 63)
                            .padding(.bottom,20)
                        // END OF PASSWORD BLOCK
                        
                        
                        // SignUp Button
                        Button {
                            createNewAccount()
                        }label:{
                            Text("Sign Up")
                                .foregroundColor(.white)
                            
                        }.frame(width: 294.22, height: 47)
                            .background((RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(.greenColor))
                            .padding(.bottom,5)
                            .alert(isPresented: $showErrorAlert) {
                                Alert(
                                    title: Text("Error"),
                                    message: Text("Account already exists!"),
                                    dismissButton: .default(Text("OK"))
                                )
                            }
                            .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil){
                                ImagePicker(image: $image)
                            }
                        
                        // End of Sign Up Button
                    }.padding()
                    // Begin of Already have an account button
                    Button(action:{
                        withAnimation{
                            self.currentViewShowing = "login"
                        }
                    }){
                        Text("Already a customer?")
                            .frame(width: 294.22,height: 16)
                            .font(.custom("Lato-Regular", size: 15))
                            .foregroundColor(.greenColor)
                            .underline()
                            .bold()
                        
                    }// end of "Already Have an account button"
                    
                }.padding()
                    .frame(width: 303.22,height: 900)
                    .navigationBarBackButtonHidden()
                
                // End of ZStack
            }
        }
        
    }
    private func createNewAccount(){
        UserManager.shared.auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error{
                print(error)
                self.loginStatusMsg = "Failed to create user : \(error)"
                self.showErrorAlert = true
                
                return
            }
            print("succesfully login : \(authResult?.user.uid ?? "" )")
            if let authResult = authResult{
                print(authResult.user.uid)
                userID = authResult.user.uid
            }
            self.persistImageToStorage()
            
        }
        
    }
    private func persistImageToStorage(){
        guard let uid = UserManager.shared.auth.currentUser?.uid
        else{return}
        let ref = UserManager.shared.storage.reference(withPath: uid)
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else{return}
        ref.putData(imageData, metadata: nil){
            metaData, err in
            if let err=err{
                print("Error to push image to storage \(err)")
                return
            }
            
            ref.downloadURL{url, err in
                if let err = err{
                    print(err)
                    self.loginStatusMsg = "Error to "
                    return
                }
                print("Succesfully stored \(String(describing: url?.absoluteString))")
                
                guard let url = url else{return}
                self.storeUserInformation(imageProfileUrl: url)
            }
            
        }
        
    }
    
    private func storeUserInformation(imageProfileUrl: URL){
        guard let uid = UserManager.shared.auth.currentUser?.uid else{
            return
        }
        let userData = ["email": self.email, "uid": uid,  "Username": self.username, "profileImageUrl": imageProfileUrl.absoluteString]
        UserManager.shared.firestore.collection("users")
            .document(uid).setData(userData){
                err in
                if let err = err {
                    print(err)
                    self.loginStatusMsg = "Data not uploaded\(err)"
                    return
                }
            }
    }
}
