//
//  ContentView.swift
//  Blossom
//
//  Created by user232715 on 4/30/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = SpeciesViewModel()
    @State private var selectedTab = 0
    
    init(){
        let appearance = UINavigationBarAppearance()
//        UITabBar.appearance().backgroundColor = UIColor(Color.pinkColor.opacity(0.5))
        UITabBar.appearance().barTintColor = UIColor(Color.pinkColor.opacity(0.5))
        UITabBar.appearance().unselectedItemTintColor = .gray
        UITabBar.appearance().tintColor = UIColor(Color.black)
        appearance.backgroundColor = UIColor(Color.pinkColor.opacity(0.5))
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    
    var body: some View {
        TabView{
            
            Text("Hello")
                .tabItem{
                    Image("ic-myplants")
                    .renderingMode(.template)
                }
            //end of my plants tab
        
//----------------------------------------------------------------------------------------------
            
            //search plants tab
           SearchPlantsView()
            .tabItem {
                Image("ic-searchplants")
                .renderingMode(.template)
            }
            //end of search plants tab

//----------------------------------------------------------------------------------------------
            
            //plant trade tab
            Text("Hello")
                .tabItem{
                    Image("ic-planttrade")
                    .renderingMode(.template)
                }
            //end of plant trade tab
            
//----------------------------------------------------------------------------------------------
            
            //nurseries tab
            Text("Hello")
                .tabItem{
                    Image("ic-nurseries")
                    .renderingMode(.template)
                }
            //end of nurseries tab
            
//----------------------------------------------------------------------------------------------
            
        }//end of tab view
        .accentColor(.black)
        .onAppear{
            UITabBar.appearance().barTintColor = UIColor(Color.pinkColor.opacity(0.5))
        }
    }//end of main view
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
