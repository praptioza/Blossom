//
//  RootView.swift
//  Blossom
//


import SwiftUI
struct RootView: View{
    @AppStorage("uid") var userID : String = ""
    var body: some View {
        if userID == ""{
            AuthView()
        } else
        {
            ContentView()
              
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
