//
//  UserManager.swift
//  Blossom


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI
import FirebaseAuth
import FirebaseStorage

// class to create innstances of Firebase Authenication, Storage and Firestore
class UserManager: NSObject{
  
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    static let shared = UserManager()
    override init() {
        self.firestore = Firestore.firestore()
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        super.init()
        
    }
    
    
}

