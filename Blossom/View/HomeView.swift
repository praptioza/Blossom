//
//  HomeView.swift
//  Blossom



import SwiftUI
import MapKit
struct HomeView: View {
    @ObservedObject var locationManager = LocationManager()
    @State private var landmarks : [Landmark] = [Landmark]()
    @State private var search : String = "Plant Nursery"
    @State private var isShowingNurseriesList : Bool = false
    
    //uses MKLocalSearch class to retrieve a list of landmarks matching the query
    private func getNearByLandmarks(){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        request.region = MKCoordinateRegion(center: locationManager.userlocation?.coordinate ?? CLLocationCoordinate2D(), latitudinalMeters: 10000, longitudinalMeters: 10000)
        let search = MKLocalSearch(request: request)
        search.start{ (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                //map function is used to map these items to an array of Landmark objects using the placemark property of each MKMapItem and aassigns the resulting array to the landmarks state variable
                self.landmarks = mapItems.map{
                    Landmark(placemark : $0.placemark)
                }
            }
            
        }
    }
    
    var body: some View {
        
        ZStack(alignment : .bottomTrailing){
            MapView(landmarks: landmarks)
                .ignoresSafeArea()
                .onAppear(){
                    getNearByLandmarks()
                }
            
            Button(action: {
                self.isShowingNurseriesList.toggle()
            }) {
                Image("ic-nurseries")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(20)
                    .foregroundColor(.white)
                    .background(Color.greenColor)
                    .cornerRadius(60)
                    .padding()
            }
            .sheet(isPresented: $isShowingNurseriesList) {
                PlaceListView(landmarks: self.landmarks)
                    .presentationDetents([.medium,.large])
                    .presentationDragIndicator(.visible)
                    .onAppear(){
                        getNearByLandmarks()
                    }
            }
        }.navigationTitle("Nurseries Near You")
            .onAppear{
                UITabBar.appearance().barTintColor = UIColor(Color.white)
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
