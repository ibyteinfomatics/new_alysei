//
//  DemoMapViewViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 23/03/21.
//

import UIKit
import GoogleMaps
import GoogleMaps

class DemoMapViewViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
   
    @IBOutlet weak var mapView: GMSMapView!
   
    @IBOutlet weak var viewHeader: UIView!
    var centerLattitude: Double?
    var centerLongitude: Double?
    var radius: Int?
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHeader.drawBottomShadow()
        //self.addCircle()
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        // Do any additional setup after loading the view.
    }
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    print("locations = \(locValue.latitude) \(locValue.longitude)")
}
    func addCircle(){
        let circleCenter : CLLocationCoordinate2D  = CLLocationCoordinate2DMake(centerLattitude ?? 0.0, centerLongitude ?? 0.0)
        let circ = GMSCircle(position: circleCenter, radius: 100)
        circ.fillColor = UIColor(red: 0.0, green: 0.7, blue: 0, alpha: 0.1)
        circ.strokeColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 0.5)
        circ.strokeWidth = 2.5;
        circ.map = self.mapView
    }
     
}
