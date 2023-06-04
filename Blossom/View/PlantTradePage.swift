//
//  PlantTradePage.swift
//  Blossom


import SDWebImageSwiftUI
import SwiftUI

struct PlantTradePage: View {
    @AppStorage("uid") var userID : String = ""
    @ObservedObject private var vm = UserProfileDetailViewModel()
    @State private var showSettings : Bool = false
    @State var isSelected = false
    @State var trades: [Trade] = []
    @State var Mytrades: [Trade] = []
    
    
    var body: some View {
        NavigationView{
            ZStack{
                
                VStack{
                    Picker(selection: $isSelected, label: Text("Picker")){
                        Text("All Trades").font(.custom("Lato-Bold", size: 18))
                            .tag(false)
                        Text("My Trades").font(.custom("Lato-Bold", size: 18))
                            .tag(true)
                    }.pickerStyle(SegmentedPickerStyle()).padding()
                    
                    ScrollView{
                        if isSelected == false{
                            if trades.isEmpty{
                                Text("No Plants posted to trade!")
                                    .font(.custom("Lato-Regular", size: 20))
                                    .foregroundColor(.greenColor)
                            }
                            else{
                                ForEach(trades, id: \.id) { trade in
                                    
                                    AllTradeCardView(trade: trade)
                                }
                            }
                        }
                        else{
                            if Mytrades.isEmpty{
                                Text("You have no plants to trade!")
                                    .font(.custom("Lato-Regular", size: 20))
                                    .foregroundColor(.greenColor)
                            }
                            else{
                                ForEach(Mytrades, id: \.id) { trade in
                                    
                                    MyTradeCardView(trade: trade)
                                }
                            }
                            
                        }
                    }//end of scrollview
                }// End of VStack
                
            }//end of z stack
            
            .navigationTitle("PLANT TRADE")
            .navigationBarTitleDisplayMode(.inline)
            .font(.custom("Lato-Bold", size: 20))
            .toolbar{
                
                ToolbarItem(placement: .navigationBarTrailing)
                {
                    NavigationLink(destination: CreateNewTrade()){
                        Image("ic-newpost").font(.title).foregroundColor(.black)
                    }
                }
            }
            
        }//end of navigation view
        .onAppear {
            fetchAllTrades()
            fetchMyTrades()
                    UITabBar.appearance().barTintColor = UIColor(Color.white)
        }
    }
    func fetchAllTrades() {
        UserManager.shared.firestore.collection("UserTrade").getDocuments{ snapshot, error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            guard let documents = snapshot?.documents else{
                print("No data found")
                return
            }
            
            trades = documents.compactMap{ document -> Trade? in
                let data  = document.data()
                let id = document.documentID
                let uid = data["uid"] as? String ?? ""
                guard uid != UserManager.shared.auth.currentUser?.uid else {
                    return nil
                }
                
                let plant_name = data["plant_name"] as? String ?? ""
                let plant_age = data["plant_age"] as? String ?? ""
                let plant_size = data["plant_size"] as? String ?? ""
                let plant_grown = data["plant_grown"] as? String ?? ""
                let user_location = data["user_location"] as? String ?? ""
                let username = data["username"] as? String ?? ""
                let plant_img = data["image"] as? String ?? ""
                let mode_of_contact = data["mode_of_contact"] as? String ?? ""
                return Trade(id: id, uid: uid, plant_name: plant_name, plant_age: plant_age, plant_size: plant_size, user_location: user_location, plant_grown: plant_grown, username: username, plant_img: plant_img, mode_of_contact: mode_of_contact)
            }
        }
    }
    // to fetch Current Users Trades
    func fetchMyTrades() {
        UserManager.shared.firestore.collection("UserTrade").getDocuments{ snapshot, error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            guard let documents = snapshot?.documents else{
                print("No data found")
                return
            }
            
            Mytrades = documents.compactMap{ document -> Trade? in
                let data  = document.data()
                let id = document.documentID
                let uid = data["uid"] as? String ?? ""
                guard uid == UserManager.shared.auth.currentUser?.uid else {
                    return nil
                }
                
                let plant_name = data["plant_name"] as? String ?? ""
                let plant_age = data["plant_age"] as? String ?? ""
                let plant_size = data["plant_size"] as? String ?? ""
                let plant_grown = data["plant_grown"] as? String ?? ""
                let user_location = data["user_location"] as? String ?? ""
                let username = data["username"] as? String ?? ""
                let plant_img = data["image"] as? String ?? ""
                let mode_of_contact = data["mode_of_contact"] as? String ?? ""
                return Trade(id: id, uid: uid, plant_name: plant_name, plant_age: plant_age, plant_size: plant_size, user_location: user_location, plant_grown: plant_grown, username: username, plant_img: plant_img, mode_of_contact: mode_of_contact)
            }
        }
    }
}

struct PlantTradePage_Previews: PreviewProvider {
    static var previews: some View {
        PlantTradePage()
    }
}

// Card View for All trade segment
struct AllTradeCardView: View {
    @State private var cardSize: CGSize = CGSize.zero
    @State  var trade : Trade
    var body: some View {
        
        ZStack{
            Color.gray.opacity(0.3)
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .scaledToFill()
                        .cornerRadius(64)
                    
                    
                    
                    VStack(alignment: .leading) {
                        Text(trade.username)
                            .font(.custom("Lato-Regular", size: 16))
                            .bold()
                    }
                    
                    Spacer()
                }
                .padding() // end of user profile hstack
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Plant to trade: ")
                        .font(.custom("Lato-Bold", size: 18))
                        .bold()
                    
                    Text("Name: \(trade.plant_name)")
                        .font(.custom("Lato-Thin", size: 16))
                    
                    Text("Age: \(trade.plant_age)")
                        .font(.custom("Lato-Regular", size: 16))
                    
                    Text("Grown: \(trade.plant_grown)")
                        .font(.custom("Lato-Regular", size: 16))
                    
                    Text("Plant Size: \(trade.plant_size)")
                        .font(.custom("Lato-Regular", size: 16))
                    
                    Text("Location: \(trade.user_location)")
                        .font(.custom("Lato-Regular", size: 16))
                    
                    Text("Mode of Contact: \(trade.mode_of_contact)")
                        .font(.custom("Lato-Regular", size: 16))
                    
                    
                    WebImage(url: URL(string: trade.plant_img))
                        .resizable()
                        .cornerRadius(10)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150 , height: 150)
                        .cornerRadius(10)
                        .padding(.top,10)
                }
                .padding()
            } // end of vstack
            
            Spacer()
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .preference(key: SizePreferenceKey.self, value: geo.size)
                    }
                ).cornerRadius(20)
                .onPreferenceChange(SizePreferenceKey.self) { size in
                    self.cardSize = size
                }
        }.frame(width: 370, height: cardSize.height).padding(.bottom,8)
            .cornerRadius(20)
    }
    
}


struct MyTradeCardView: View {
    @State private var cardSize: CGSize = CGSize.zero
    let trade : Trade
    var body: some View {
        ZStack{
            
            Color.gray.opacity(0.3)
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .scaledToFill()
                        .cornerRadius(64)
                    
                    VStack(alignment: .leading) {
                        Text(trade.username)
                            .font(.custom("Lato-Regular", size: 16))
                            .bold()
                        
                    }
                    
                    Spacer()
                }
                .padding() // end of user profile hstack
                
                
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    
                    
                    Text("Plant to trade: ")
                        .font(.custom("Lato-Bold", size: 18))
                        .bold()
                    
                    Text("Name: \(trade.plant_name)")
                        .font(.custom("Lato-Thin", size: 16))
                    
                    Text("Age: \(trade.plant_age)")
                        .font(.custom("Lato-Regular", size: 16))
                    
                    Text("Grown: \(trade.plant_grown)")
                        .font(.custom("Lato-Regular", size: 16))
                    
                    Text("Plant Size: \(trade.plant_size)")
                        .font(.custom("Lato-Regular", size: 16))
                    
                    Text("Location: \(trade.user_location)")
                        .font(.custom("Lato-Regular", size: 16))
                    
                    Text("Mode of Contact: \(trade.mode_of_contact)")
                        .font(.custom("Lato-Regular", size: 16))
                    
                    WebImage(url: URL(string: trade.plant_img))
                        .resizable()
                        .cornerRadius(10)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150 , height: 150)
                        .cornerRadius(10)
                        .padding(.top,10)
                    
                    
                }
                .padding()
            } // end of vstack
            
            
            Spacer()
            
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .preference(key: SizePreferenceKey.self, value: geo.size)
                    }
                )
            
                .cornerRadius(20)
                .onPreferenceChange(SizePreferenceKey.self) { size in
                    self.cardSize = size
                }
        }.frame(width: 370, height: cardSize.height).padding(.bottom,8)
            .cornerRadius(20)
    }
    
}


struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}



struct TradeImages : View{
    let trade : [Trade]
    
    var body : some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(trade){ trade in
                    WebImage(url: URL(string: trade.plant_img))
                        .resizable()
                        .frame(width:100, height:50)
                        .cornerRadius(10)
                        .aspectRatio(contentMode: .fill)
                    
                }
            }
        }
    }
}

