//
//  UserAccountView.swift
//  Blossom


import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI
struct UserAccountView: View {
    @AppStorage("uid") var userID : String = ""
    @ObservedObject private var vm = UserProfileDetailViewModel()
    var body: some View {
        NavigationView{
            ScrollView (.vertical, showsIndicators: false){
                ZStack{
                    Color.pinkColor.opacity(0.5)
                        .frame(height: UIScreen.main.bounds.height / 1.1)
                    VStack{
                        if vm.userDetails?.profileImageUrl != nil{
                            WebImage(url : URL(string: vm.userDetails?.profileImageUrl ?? ""))
                                .resizable()
                                .frame(width: 128, height: 128)
                                .scaledToFill()
                                .cornerRadius(64)
                        } else
                        {
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 128, height: 128)
                                .scaledToFill()
                                .cornerRadius(64)
                        }
                        
                    }.offset(y: -UIScreen.main.bounds.height / 3.5)
                    ZStack(alignment:.top){
                        Color.white
                            .edgesIgnoringSafeArea(.bottom)
                            .frame(height: UIScreen.main.bounds.height / 1.6)
                            .cornerRadius(40, corners: [.topLeft,.topRight])
                        VStack{
                            HStack{
                                Text("User Name : ").bold()
                                Text("\(vm.userDetails?.Username ?? "Not Present")")
                                Spacer()
                            }.padding(30)
                            Divider()
                            HStack{
                                Text("Email : ").bold()
                                Text("\(vm.userDetails?.email ?? "Not Present")").accentColor(.black)
                                Spacer()
                            }.padding(30)
                            Divider()
                            
                            
                            // Logout Block
                            VStack{
                                Button(action: {
                                    let firebaseAuth = Auth.auth()
                                    do{
                                        try firebaseAuth.signOut()
                                        withAnimation{
                                            userID = ""
                                        }
                                    }
                                    catch let signOutError as NSError{
                                        print("Error signing out: %@",signOutError)
                                    }
                                }){
                                    Text("Logout")
                                        .font(.custom("Lato-Regular", size: 18))
                                        .underline()
                                        .foregroundColor(.greenColor)
                                }
                                
                                
                            }.frame(width: 306, height: 60)
                                .background(Color.white)
                            
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                }
            }
            .navigationTitle("ACCOUNT INFORMATION")
            .navigationBarTitleDisplayMode(.inline)
            .font(.custom("Lato-Bold", size: 20))
            
        }
        
    }
}

struct UserAccountInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserAccountView()
        
    }
}
