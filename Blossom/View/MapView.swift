//
//  MapView.swift
//  Blossom


import Foundation
import SwiftUI
import MapKit
import CoreLocation

// this class acts as an intermediary between MKMapView object and MapView struct and is used to handle events and interactions that occur on 'MKMapView' object that is created in the MaoView struct
class Coordinator : NSObject, MKMapViewDelegate {
    
    var control : MapView
    
    init(_ control : MapView){
        self.control = control
    }
    
    //is called when an annotation view is added to the map view
    func mapView(_ mapView : MKMapView, didAdd views : [MKAnnotationView]){
        
        if let annotationView = views.first{
            if let annotation = annotationView.annotation{
                if annotation is MKUserLocation{
                    let region = MKCoordinateRegion(center : annotation.coordinate, latitudinalMeters:  10000, longitudinalMeters: 10000)
                    mapView.setRegion(region, animated:true)
                }
            }
        }
    }
}


struct MapView : UIViewRepresentable {
    
    let landmarks : [Landmark]
    
    //creates and returns a new instance of MKMapView(used to display a map)
    func makeUIView(context: Context) -> MKMapView{
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        
        //adding user location annotation
        if let userlocation = map.userLocation.location{
            let annotation = MKPointAnnotation()
            annotation.coordinate = userlocation.coordinate
            map.addAnnotation(annotation)
        }
        
        //add landmarks annotations
        let annotations = landmarks.map(LandmarkAnnotation.init)
        map.addAnnotations(annotations)
        return map
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    //called when the view needs to be updated like when user interacts with the map or the state of the view changes
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        uiView.annotations.forEach{
            annotation in
            if let annotation = annotation as? LandmarkAnnotation {
                uiView.removeAnnotation(annotation)
            }
        }
        // Add new landmarks annotations
        let annotations = landmarks.map(LandmarkAnnotation.init)
        uiView.addAnnotations(annotations)
    }
    
    
    private func updateAnnotations(from mapView: MKMapView){
        //removes all the annotations from the map view and adds new annotations based on the landmarks array that is passed to the 'MapView' struct.
        mapView.removeAnnotations(mapView.annotations)
        //map  function creates a new LandmakAnnotation instance for each landmark in the array
        let annotations = self.landmarks.map(LandmarkAnnotation.init)
        //addAnnotations function adds the annotations to the map view
        mapView.addAnnotations(annotations)
    }
}

