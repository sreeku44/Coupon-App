//
//  MapViewController.swift
//  Coupon App
//
//  Created by Sreekala Santhakumari on 4/13/17.
//  Copyright © 2017 Klas. All rights reserved.
//

import UIKit
import MapKit


protocol mapViewDelegate  {
    
    func mapView( mV : Shop)
    
}
class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    var delegate : mapViewDelegate?
    var nameOfTheShop :String!
    var locationManager = CLLocationManager()
    var annotations = [MKPointAnnotation]()
    @IBOutlet weak var mapView: MKMapView!
    
    var selectedAnnotation :MKPointAnnotation!
    
    
    @IBAction func doneBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    //AnnotationView
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let couponAnnotaion =  annotation as! MKPointAnnotation
        let annotationView = MKPinAnnotationView(annotation: couponAnnotaion, reuseIdentifier: "MyAnnotation")
        annotationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        annotationView.canShowCallout = true
        
        //adding  button for deatails & map
        let button = UIButton(type: .detailDisclosure) as UIButton
        button.addTarget(self, action: #selector(infoButtonPressed), for: .touchUpInside)
        
        annotationView.rightCalloutAccessoryView = button
        return annotationView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.showsUserLocation = true
        
        self.title = self.nameOfTheShop
        
        // set up locationmanager , location update with CLLocationManager
        self.locationManager = CLLocationManager ()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLHeadingFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        
        
        //Set up map view
        self.mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        self.mapView.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()

                }
        
        //Zoom to user location
//        let noLocation = CLLocationCoordinate2D()
//        let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 500, 500)
//        mapView.setRegion(viewRegion, animated: false)
        
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
        
        //To findount what is near me
        let couponRequest = MKLocalSearchRequest()
        couponRequest.naturalLanguageQuery = nameOfTheShop
        let couponregion = MKCoordinateRegionMakeWithDistance(self.locationManager.location!.coordinate, 500, 500)
        couponRequest.region = couponregion
        let couponSearch = MKLocalSearch(request: couponRequest)
        couponSearch.start { (response : MKLocalSearchResponse?, error :Error?) in
            
            for mapItem in (response?.mapItems)! {
                
                //Assigning annotaion / location/
                let annotation = MKPointAnnotation()
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = mapItem.placemark.name
                if let city = mapItem.placemark.locality,
                    let state = mapItem.placemark.administrativeArea,
                    let postalcode = mapItem.placemark.postalCode
                {
                    
                    annotation.subtitle = "  \(city) , \(state) \(postalcode) "
                    
                    self.mapView.addAnnotation(annotation)
                    let span = MKCoordinateSpanMake(0.05, 0.05)
                    let region = MKCoordinateRegionMake(mapItem.placemark.coordinate, span)
                    print (mapItem.placemark.addressDictionary)
                    
                }
                
            }
            
        }
        
    }
//    override func viewDidAppear(_ animated: Bool) {
//        
//        if CLLocationManager.authorizationStatus() == .notDetermined {
//            
//        locationManager.requestAlwaysAuthorization()
//        }
//        
//        else if CLLocationManager.authorizationStatus() == .denied {
//            
//            showAlert (" Location service were previously denied. Please enable location services for this app in Settings")
//        }
//        else if CLLocationManager.authorizationStatus() == .authorizedAlways{
//            
//            locationManager.startUpdatingLocation()
//        
//        }
//        
//        }
    //}
    // optional - setting location manager delegate for self.locationManager.delegate = self
    
    
    func locationManager(_manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    // optional - setting location manager delegate for self.locationManager.delegate = self
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.4, 0.4)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            self.mapView.setRegion(region, animated: true)
            self.mapView.showsUserLocation = true
            
        }
    }
    
    
    // optional - setting location manager delegate for self.locationManager.delegate = self
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
        
    }
    
    //user location
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if view.annotation is MKUserLocation {
            return
        }
        
        self.selectedAnnotation = view.annotation as! MKPointAnnotation
    }
    
    func infoButtonPressed() {
        
        let directionsURL: String = "http://maps.apple.com/?saddr=\(mapView.userLocation.coordinate.latitude),\(mapView.userLocation.coordinate.longitude)&daddr=\( self.selectedAnnotation.coordinate.latitude),\(self.selectedAnnotation.coordinate.longitude)"
        
        UIApplication.shared.open(URL(string: directionsURL)!, options: [:], completionHandler: nil)
        
    }
    
    
}
