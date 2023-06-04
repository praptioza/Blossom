//
//  Landmark.swift
//  Blossom


import Foundation
import MapKit

//Landmark represents a point of interest on a map and is associated with a MKPlacemark
//MKPlacemark class gives geographic information about a location, such as its name, address and geographic coordinates

struct Landmark{
    
    //placemark is an object of MKPlacemark that provides the geographic info about a landmark
    let placemark : MKPlacemark
    
    var id : UUID{
        return UUID()
    }
    
    var name : String{
        self.placemark.name ?? ""
    }
    
    var title : String{
        self.placemark.title ?? ""
    }
    
    //CLLocationCoordinate2D struct the represents the geographic coordinates of a landmark
    var coordinate : CLLocationCoordinate2D{
        self.placemark.coordinate
    }
}
