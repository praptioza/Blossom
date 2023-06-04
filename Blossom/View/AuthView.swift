//
//  AuthView.swift
//  Blossom
//


import SwiftUI

struct AuthView: View {
    @State private var currentViewShowing: String = "login"
   
    var body: some View {
        if (currentViewShowing == "login"){
            LogInPage(currentShowingView: $currentViewShowing)
        }
            else{
            SignUpPage(currentViewShowing: $currentViewShowing)
                    .transition(.move(edge: .bottom))
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
