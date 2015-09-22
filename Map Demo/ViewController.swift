//
//  ViewController.swift
//  Map Demo
//
//  Created by TangWeichang on 8/11/15.
//  Copyright © 2015 TangWeichang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // when app is running
        locationManager.startUpdatingLocation()
        
        // Do any additional setup after loading the view, typically from a nib.
        var latitude:CLLocationDegrees = 43.095181
        var longitude:CLLocationDegrees = -79.006424
        var latDelta:CLLocationDegrees = 0.05 // Difference
        var lonDelta:CLLocationDegrees = 0.05
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        map.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Niagra Falls"
        annotation.subtitle = "One day I'll go there"
        map.addAnnotation(annotation)
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        uilpgr.minimumPressDuration = 1
        map.addGestureRecognizer(uilpgr)
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        var userLocation: CLLocation = locations[0] as! CLLocation
        var latitude = userLocation.coordinate.latitude
        var longitude = userLocation.coordinate.longitude
        var latDelta:CLLocationDegrees = 0.05 // Difference
        var lonDelta:CLLocationDegrees = 0.05
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        self.map.setRegion(region, animated: false)
    }
    
    func action(gestureRecognizer:UIGestureRecognizer) {
        //print("Gesture Recognized")
        var touchPoint = gestureRecognizer.locationInView(self.map)
        var newCoordinate: CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
        var annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinate
        annotation.title = "New Place"
        annotation.subtitle = "One day I'll go there"
        map.addAnnotation(annotation)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

