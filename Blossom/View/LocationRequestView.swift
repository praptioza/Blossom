//
//  LocationRequestView.swift
//  Blossom


import SwiftUI
import MapKit

struct LocationRequestView: View {
    @ObservedObject var locationmanager = LocationManager()
    var body: some View {
        ZStack {
            Color.clear
                .onAppear {
                    LocationManager.shared.requestLocation()
                }
            if locationmanager.userlocation != nil {
                HomeView()
            }
            else {
                VStack{
                    Text("Turn on location servies").font(.custom("Lato-Regular",size:18)).foregroundColor(.greenColor)
                }
            }
        }
    }
}

struct LocationRequestView_Previews: PreviewProvider {
    static var previews: some View {
        LocationRequestView()
    }
}
