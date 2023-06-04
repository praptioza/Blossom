//
//  SettingsView.swift
//  Blossom


import SwiftUI
import FirebaseAuth
import Firebase

struct SettingsView: View {
    @AppStorage("uid") var userID : String = ""
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                VStack{
                    Text("SETTINGS")
                        .font(.custom("Lato-Regular", size: 18))
                    
                }.frame(width: 306, height: 105)
                    .background(Color.pinkColor.opacity(0.4))
                
                VStack{
                    NavigationLink(destination: UserAccountView()){
                        Text("Account")
                            .font(.custom("Lato-Regular", size: 18))
                    }
                }.frame(width: 306, height: 60)
                    .background(Color.white)
                
                
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
                    }
                }.frame(width: 306, height: 60)
                    .background(Color.white)
                
                // Endo of Logout Block
                
                // Delete Block
                VStack{
                    Button(action: {
                        
                        let alert = UIAlertController(title: "Delete Account", message: "Are you sure you want to delete your account?", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
                            
                            let collections = ["UserTrade", "users"]
                            collections.forEach { collection in
                                UserManager.shared.firestore.collection(collection)
                                    .whereField("userID", isEqualTo: userID)
                                    .getDocuments { (querySnapshot, error) in
                                        if let error = error {
                                            print("Error getting documents from \(collection) collection: \(error.localizedDescription)")
                                            return
                                        }
                                        
                                        // Delete all documents in the collection that have the userID field equal to the user ID
                                        querySnapshot?.documents.forEach { document in
                                            UserManager.shared.firestore.collection(collection).document(document.documentID).delete { error in
                                                if let error = error {
                                                    print("Error deleting document \(document.documentID) from \(collection) collection: \(error.localizedDescription)")
                                                } else {
                                                    print("Document \(document.documentID) deleted from \(collection) collection.")
                                                }
                                            }
                                        }
                                    }
                            }
                            
                            
                            // Delete user account from Authentication
                            UserManager.shared.auth.currentUser?.delete { error in
                                if let error = error {
                                    print("Error deleting user: \(error.localizedDescription)")
                                } else {
                                    print("User account deleted.")
                                    // Logout the user after the account has been deleted
                                    try? UserManager.shared.auth.signOut()
                                    userID = ""
                                }
                            }
                        }))
                        if let window = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).first?.windows.first {
                            window.rootViewController?.present(alert, animated: true, completion: nil)
                        }
                    }){
                        Text("Delete Account")
                            .font(.custom("Lato-Regular", size: 18))
                    }
                    
                }.frame(width: 306, height: 60)
                    .background(Color.white)
                // End of Delete Account block
                Spacer()
            }
        }.background(Color.white)
            .edgesIgnoringSafeArea(.bottom)
            .frame( height: 740)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
