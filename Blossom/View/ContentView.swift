//
//  ContentView.swift
//  Blossom
//
//  Created by user232715 on 4/30/23.
//

import SwiftUI


class TabBarVisibility: ObservableObject {
    @Published var isVisible = true
}

struct ContentView: View {
    @State private var selectedTab = 0
    @AppStorage("uid") var userID : String = ""
    @ObservedObject var vm = SpeciesViewModel()
    @ObservedObject var locationManager = LocationManager.shared
    @State private var locationAuthorized = false
    init(){
        let appearance = UINavigationBarAppearance()
        UITabBar.appearance().unselectedItemTintColor = .gray
        UITabBar.appearance().tintColor = UIColor(Color.black)
        appearance.backgroundColor = UIColor(Color.pinkColor.opacity(0.5))
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        
        TabView{
            // my plants page
            
            MyPlantsPage(userID: userID)
                .tabItem{
                    Image("ic-myplants")
                        .renderingMode(.template)
                }
            //end of my plants tab
            
            
            //search plants tab
            SearchPlantsView()
                .tabItem {
                    Image("ic-searchplants")
                        .renderingMode(.template)
                }
            //end of search plants tab

            
            //plant trade tab
           PlantTradePage(userID: userID)
                .tabItem{
                    Image("ic-planttrade")
                        .renderingMode(.template)
                }
            //end of plant trade tab
            

            
            if locationAuthorized{
                HomeView()
                   .tabItem {
                       Image("ic-nurseries")
                       .renderingMode(.template)
                    }
           }
           if locationAuthorized == false{
               LocationRequestView()
                   .tabItem {
                       Image("ic-nurseries")
                       .renderingMode(.template)
                   }
           }
            //end of nurseries tab
            

            
        }//end of tab view
        .accentColor(.black)
    }
}//end of main view




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}
