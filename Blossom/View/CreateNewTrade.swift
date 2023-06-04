//
//  CreateNewTrade.swift
//  Blossom


import SwiftUI

struct CreateNewTrade: View {
    @State var shouldShowImagePicker = false
    @State var image: UIImage?
    @State var plant_name : String = ""
    @State var plant_age : String = ""
    @State var plant_grown: String = ""
    @State var plant_size: String = ""
    @State var user_location: String = ""
    @State var mode_of_contact: String = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ScrollView(showsIndicators:false){
            VStack{
                Button(action:{
                    shouldShowImagePicker.toggle()
                },label: {
                    VStack{
                        if let image = self.image{
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 128, height: 128)
                                .scaledToFit()
                        }
                        else
                        {
                            Image(systemName: "camera.macro.circle")
                                .font(.system(size: 128))
                                .foregroundColor(.greenColor)
                                .frame(width: 128, height: 128)
                            
                        }
                    }
                }).padding(.top,43)
                
                Text("Upload Plant Image")
                    .padding(.top, 15)
                    .foregroundColor(.greenColor)
                
                // Plant Name Block
                VStack(alignment: .leading){
                    Text("Plant Name")
                        .font(.custom("Lato-Regular", size: 16))
                        .foregroundColor(.greenColor)
                    TextField("Enter Plant Name Here", text: $plant_name)
                        .padding(10)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .background((RoundedRectangle(cornerRadius: 10))
                            .foregroundColor(.greenColor)
                            .opacity(0.15))
                    
                }.frame(width: 294.22, height: 63)
                    .padding(.top,20)
                // End of Plant Name Block
                // Plant Age Block
                VStack(alignment: .leading){
                    Text("Plant Age")
                        .font(.custom("Lato-Regular", size: 16))
                        .foregroundColor(.greenColor)
                    TextField("Enter Plant Age Here", text: $plant_age)
                        .padding(10)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .background((RoundedRectangle(cornerRadius: 10))
                            .foregroundColor(.greenColor)
                            .opacity(0.15))
                    
                }.frame(width: 294.22, height: 63)
                    .padding(.top,20)
                // End of Plant Age Block
                // Plant Grown Block
                VStack(alignment: .leading){
                    Text("Plant Grown")
                        .font(.custom("Lato-Regular", size: 16))
                        .foregroundColor(.greenColor)
                    TextField("Enter Plant Grown Here", text: $plant_grown)
                        .padding(10)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .background((RoundedRectangle(cornerRadius: 10))
                            .foregroundColor(.greenColor)
                            .opacity(0.15))
                    
                }.frame(width: 294.22, height: 63)
                    .padding(.top,20)
                // End of Plant Grown Block
                // Plant Size Block
                VStack(alignment: .leading){
                    Text("Plant Size")
                        .font(.custom("Lato-Regular", size: 16))
                        .foregroundColor(.greenColor)
                    TextField("Enter Plant Size Here", text: $plant_size)
                        .padding(10)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .background((RoundedRectangle(cornerRadius: 10))
                            .foregroundColor(.greenColor)
                            .opacity(0.15))
                    
                }.frame(width: 294.22, height: 63)
                    .padding(.top,20)
                // End of Plant Size Block
                // User Location Block
                VStack(alignment: .leading){
                    Text("User Location")
                        .font(.custom("Lato-Regular", size: 16))
                        .foregroundColor(.greenColor)
                    TextField("Enter Your Location Here", text: $user_location)
                        .padding(10)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .background((RoundedRectangle(cornerRadius: 10))
                            .foregroundColor(.greenColor)
                            .opacity(0.15))
                    
                }.frame(width: 294.22, height: 63)
                    .padding(.top,20)
                // End of Plant Location Block
                
                // User Mode of contact
                VStack(alignment: .leading){
                    Text("How you want others to contact you?")
                        .font(.custom("Lato-Regular", size: 16))
                        .foregroundColor(.greenColor)
                    TextField("Enter Your Mode of Contact Here", text: $mode_of_contact)
                        .padding(10)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .background((RoundedRectangle(cornerRadius: 10))
                            .foregroundColor(.greenColor)
                            .opacity(0.15))
                    
                }.frame(width: 294.22, height: 63)
                    .padding(.top,20)
                // End of Plant Location Block
                
                // Add to Trade Button
                Button{
                    addUserTrade(plant_name: plant_name, plant_age: plant_age, plant_grown: plant_grown, user_location: user_location, plant_size: plant_size, mode_of_contact: mode_of_contact)
                    
                    // dismissing the current view after adding the trade into firebase
                    self.presentationMode.wrappedValue.dismiss()
                    
                }label:
                {
                    Text("Let's Trade")
                        .foregroundColor(.white)
                    
                }.frame(width: 294.22, height: 47)
                    .background((RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.greenColor))
                    .padding(.top,20)
                
                // End of Add to trade Button
                
                
            }
        }
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil){
            ImagePicker(image: $image)
        }
    }
    
    
    private func addUserTrade(plant_name: String, plant_age: String, plant_grown : String, user_location: String, plant_size: String, mode_of_contact: String)
    {
        guard let uid = UserManager.shared.auth.currentUser?.uid else{
            print("Error in getting the Uid for trade page")
            return
        }
        
        UserManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error{
                print("Error getting user document: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot, snapshot.exists,
                  let username = snapshot.data()?["Username"] as? String else{
                print("Error getting the username from user document")
                return
            }
            
            let ref = UserManager.shared.storage.reference(withPath: uid)
            guard let imageData = self.image?.jpegData(compressionQuality: 0.5)
            else{
                print("image could not be compressed")
                return
            }
            ref.putData(imageData,metadata: nil){
                metaData, error in
                if let error = error {
                    print("Error to push the immage to store \(error)")
                    return
                }
                
                ref.downloadURL{url, error in
                    if let error = error{
                        print("Error to download the url \(error)")
                        return
                    }
                    print("Successfully stored\(String(describing: url?.absoluteString))")
                    
                    guard let url = url else{return
                    }
                    UserManager.shared.firestore.collection("UserTrade").addDocument(data: ["plant_name": self.plant_name, "plant_age" : self.plant_age, "plant_grown": self.plant_grown, "plant_size": self.plant_size, "user_location": self.user_location, "uid" : uid, "image" : url.absoluteString, "username" : username, "mode_of_contact": self.mode_of_contact]){
                        error in
                        if let error = error{
                            print("Error adding document : \(error.localizedDescription)")
                        }
                        else{
                            print("Document added")
                        }
                    }
                }
            }
        }
    }
}


struct CreateNewTrade_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewTrade()
    }
}
