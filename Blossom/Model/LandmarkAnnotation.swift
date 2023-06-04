//
//  LandmarkAnnotation.swift
//  Blossom


import Foundation
import MapKit
import UIKit

//conforms to MKAnnotation protocol to create annotations for a map view
final class LandmarkAnnotation :NSObject, MKAnnotation{
    
    //2 properties required by the protocol
    let title : String?
    let coordinate: CLLocationCoordinate2D
    
    //takes a 'Landmark' object as a paramter and uses its name and coordinate properties to initialize title and coordinate properties of the annotation object
    init(landmark : Landmark){
        self.title = landmark.name
        self.coordinate = landmark.coordinate
    }
}
