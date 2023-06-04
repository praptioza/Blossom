//
//  LocationManager.swift
//  Blossom


import Foundation
import MapKit
import CoreLocation
//used to manage location services of our application
class LocationManager : NSObject, ObservableObject{
    
    //private property that is an instance of CLLocationManager class used to request location from user, monitor changes in location status etc
    private let locationmanager = CLLocationManager()
    
    @Published var userlocation : CLLocation?
    static let shared = LocationManager()
    private var locationAuthorized = false
    
    //LocationManager has an initializer that sets up the CLLocationManager object by setting its delegate to self
    override init(){
        super.init()
        locationmanager.delegate = self
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        locationmanager.distanceFilter = kCLDistanceFilterNone
        locationmanager.startUpdatingLocation()
    }
    
    //access user's location when the app is in use
    func requestLocation(){
        locationmanager.requestWhenInUseAuthorization()
    }
}


//LocationManager class also conforms to CLLocationManagerDelegate protocol which gives methods for handling location events
extension LocationManager : CLLocationManagerDelegate {
    
    //didChangeAuthorization method is called when the user gants or revokes authorization to use location services,
    //function that monitors changes on the user's location status so, it starts off as undetermined. If user grants permission then status changes and at that time this function will get called
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status : CLAuthorizationStatus)
    {
        switch status{
            
        case .notDetermined:
            print("DEBUG: Not determined")
            
        case .restricted:
            print("DEBUG: Restricted")
            
        case .denied:
            print("DEBUG : Denied")
            let alert = UIAlertController(title: "Location Access Denied", message: "Please enable location access in Settings to use Map feature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let window = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).first?.windows.first {
                window.rootViewController?.present(alert, animated: true, completion: nil)
            }
            
        case .authorizedAlways:
            print("Auth always")
            locationAuthorized = true
            
        case .authorizedWhenInUse:
            print("auth when in use")
            locationAuthorized = true
            
        @unknown default:
            break
        }
    }
    
    //didUpdateLocations method is called when the location manager actually recieves user location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //location property is updated with the latest location data
        guard let location = locations.last else{
            return
        }
        
        self.userlocation = location
    }
}

