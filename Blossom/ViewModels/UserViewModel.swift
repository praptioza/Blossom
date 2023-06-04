
//
//  UserViewModel.swift
//  Blossom


import Foundation

// Model of UserDetails that has been stored on the Firestore collection "users"
struct UserDetails{
    let uid, email, Username , profileImageUrl:String
}

// ViewModel
class UserProfileDetailViewModel: ObservableObject{
    @Published var errorMsg = ""
    @Published var userDetails : UserDetails?
    init(){
        fetchCurrentUser()
    }
    
    // to fetch current user that has logged in 
    private func fetchCurrentUser(){
        
        guard let uid = UserManager.shared.auth.currentUser?.uid
        else{
            self.errorMsg = "Could Not Found uid"
            return
        }
        
        UserManager.shared.firestore.collection("users").document(uid).getDocument{snapshot , error in
            if let error = error{
                print("Failed to fetch current user:", error)
                return
            }
            
            self.errorMsg = "\(uid)"
            guard let data = snapshot?.data()else {
                self.errorMsg="No data found"
                return
            }
            let uid = data["uid"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let Username = data["Username"] as? String ?? ""
            let profileImageUrl = data["profileImageUrl"] as? String ?? ""
            
            self.userDetails = UserDetails(uid: uid, email:email, Username: Username, profileImageUrl: profileImageUrl)
            
            
        }
    }
}
