//
//  PlaceListView.swift
//  Blossom


import SwiftUI
import MapKit

struct PlaceListView: View {
    
    let landmarks : [Landmark]
    
    var body: some View {
        VStack(alignment: .leading){
            List{
                ForEach(self.landmarks, id : \.id){ landmark in
                    VStack(alignment: .leading){
                        Text(landmark.name).fontWeight(.bold)
                        Text(landmark.title)
                    }
                }
            }.navigationTitle("Nurseries Near You")
        }.cornerRadius(30)
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView(landmarks : [Landmark(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D()))])
    }
}
