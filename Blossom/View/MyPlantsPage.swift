//
//  MyPlantsPage.swift
//  Blossom


import SwiftUI
import SDWebImageSwiftUI
import SwipeCellKit

struct MyPlantsPage: View {
    @AppStorage("uid") var userID : String = ""
    @State var myPlants: [MyPlants] = []
    @ObservedObject var vm = SpeciesViewModel()
    @State private var selectedPlantName: String = ""
    @State private var showSettings : Bool = false
    var body: some View {
        NavigationView{
            ScrollView{
                ZStack{
                    VStack{
                        Spacer()
                        if myPlants.isEmpty{
                            Text("No Favorites!")
                                .font(.custom("Lato-Regular", size: 20))
                                .foregroundColor(.greenColor)
                        }
                        else{
                            ForEach(myPlants, id:  \.id) { myplant in
                                HStack{
                                    WebImage(url:URL(string: myplant.plant_img))
                                        .resizable()
                                        .aspectRatio(contentMode:.fill)
                                        .frame(width: 70, height: 100)
                                        .cornerRadius(10)
                                        .padding(10)
                                        .padding(.leading,15)
                                    
                                    
                                    Text(myplant.plant_name)
                                        .font(.custom("Lato-Regular", size: 18))
                                    Spacer()
                                    Button(action:{
                                        deleteMyPlant(id: myplant.id)
                                    }){
                                        Image(systemName: "trash.fill")
                                            .font(.custom("Lato-Regular", size: 16))
                                            .foregroundColor(.pinkColor)
                                    }.padding(.trailing,30)
                                }.border(Color.gray.opacity(0.3), width: 2)
                                    .cornerRadius(20)
                            }
                        }
                        
                    }// end of vstack
                    .frame(width: 400)
                    .padding(.top,20)
                    
                    // to open the settings view
                    GeometryReader { _ in
                        HStack{
                            
                            SettingsView()
                                .offset(x: showSettings ? 0 : UIScreen.main.bounds.width, y: showSettings ? 0 : UIScreen.main.bounds.height - 25)
                        }
                    }
                    .background(Color.white.opacity(showSettings ? 0.2 : 0))
                    
                }
                .navigationTitle(showSettings ? "" : "MY PLANTS")
                .navigationBarTitleDisplayMode(.inline)
                .font(.custom("Lato-Bold", size: 20))
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading)
                    {
                        Button{
                            self.showSettings.toggle()
                        }label:{
                            Image("ic-settings")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                        
                    }
                }
                
            }.onAppear{
                showMyPlants()
                
            }
            
        }
        
        
    }
    
    
    func deleteMyPlant(id: String){
        let alert = UIAlertController(title: "Delete Plant", message: "Are you sure you want to delete this plant?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
            UserManager.shared.firestore.collection("MyFavorites").document(id).delete(){
                error in
                if let error = error{
                    print("Error removing the plant id:\(error)")
                }
                else{
                    print("Document deleted successfully")
                    showMyPlants()
                }
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        if let window = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).first?.windows.first {
            window.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    // function to fetch plants from the MyFavorite firestore Collection
    func showMyPlants(){
        UserManager.shared.firestore.collection("MyFavorites").getDocuments{snapshot, error in
            if let error = error{
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents
            else{
                print("No data Found")
                return
            }
            myPlants = documents.compactMap{
                document -> MyPlants? in
                let data = document.data()
                let id = document.documentID
                let uid = data["uid"] as? String ?? ""
                
                guard uid == UserManager.shared.auth.currentUser?.uid else{
                    print("this user has not added any favorite plant yet")
                    return nil
                }
                
                let plant_name = data["plant_name"] as? String ?? ""
                let plant_img = data["plant_img"] as? String ?? ""
                return MyPlants(id:id, plant_name: plant_name, plant_img: plant_img)
            }
            
            
        }
    }
}

struct MyPlantsPage_Previews: PreviewProvider {
    static var previews: some View {
        MyPlantsPage()
    }
}
