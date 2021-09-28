//
//  MapViewC.swift
//  Alysei
//
//  Created by CodeAegis on 01/03/21.
//  Copyright © 2020 CodeAegis. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation


struct MapAddressModel {
    let address1: String
    let address2: String
    let mapAddress: String
}

class MapViewC: AlysieBaseViewC {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var lblUpdateLocation: UILabel!
  @IBOutlet weak var btnBack: UIButton!
  @IBOutlet weak var viewBottom: UIView!
  @IBOutlet weak var mapView: GMSMapView!
  @IBOutlet weak var imgViewMarker: UIImageView!
  @IBOutlet weak var btnSearchLocation: UIButton!
  @IBOutlet weak var viewSearchLocation: UIViewExtended!
  @IBOutlet weak var viewBottomHeight: NSLayoutConstraint!
  
  //MARK: - Properties -

    var fromVC: isCameFrom?
    var hubLatCordinate: Double?
    var hubLongCordinate:Double?
    var hubRadius: Int?
    var locationManager = CLLocationManager()
  var centerMapCoordinate:CLLocationCoordinate2D!
  var marker = GMSMarker()
    var circle = GMSCircle()
  var signUpStepTwoDataModel: SignUpStepTwoDataModel!
  var delegate: SaveAddressCallback?
    var latitude: Double?
    var longitude: Double?

    var dismiss: ((_ mapAddress: MapAddressModel, _ latitude: Double?, _ longitude: Double?) -> Void)?

  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
    
    super.viewDidLoad()

//    let circleLocation = CLLocationCoordinate2DMake(30.889316, 75.8576758)
//    circle.position = circleLocation
//    circle.fillColor = UIColor.red.withAlphaComponent(0.3)
//    circle.strokeColor = .red
//    circle.strokeWidth = 2.0
////    circle.map = self.mapView
//
//    let path = GMSMutablePath()
//    path.add(CLLocationCoordinate2D(latitude: 30.889316, longitude: 75.8576758))
//    path.add(CLLocationCoordinate2D(latitude: 28.9921136, longitude: 76.3331312))
//    path.add(CLLocationCoordinate2D(latitude: 30.0584217, longitude: 77.971143))
//    path.add(CLLocationCoordinate2D(latitude: 30.889316, longitude: 75.8576758))
//    let polyline = GMSPolyline(path: path)
//    polyline.map = self.mapView
//
//    let label1 = GMSMarker(position: CLLocationCoordinate2D(latitude: 30.889316, longitude: 75.8576758))
//    label1.title = "Ludhiana"
//    label1.map = self.mapView
//
//    let label2 = GMSMarker(position: CLLocationCoordinate2D(latitude: 28.9921136, longitude: 76.3331312))
//    label2.title = "Delhi"
//    label2.map = self.mapView
//
//    let label3 = GMSMarker(position: CLLocationCoordinate2D(latitude: 30.0584217, longitude: 77.971143))
//    label3.title = "Haridwar"
//    label3.map = self.mapView
//
//    var bounds = GMSCoordinateBounds()
//
//    for index in 1...path.count() {
//        bounds = bounds.includingCoordinate(path.coordinate(at: index))
//    }
//
//    mapView.animate(with: GMSCameraUpdate.fit(bounds))

   

    self.mapView.isMyLocationEnabled = true
    if fromVC == .locateHub {
        print("add Circle")
        viewBottom.isHidden = true
        viewSearchLocation.isHidden = true
        viewBottomHeight.constant = 0
        self.intialGoogleSetup(withLatitude:hubLatCordinate ?? 0.0, withLongitude: hubLongCordinate ?? 0.0)
       
    }else{
    self.mapView.addSubview(self.viewSearchLocation)
        self.mapView.addSubview(self.imgViewMarker)
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        viewBottom.isHidden = false
        viewSearchLocation.isHidden = false
        viewBottomHeight.constant = 180
        self.intialGoogleSetup(withLatitude: kSharedUserDefaults.latitude, withLongitude: kSharedUserDefaults.longitude)
    }

    
   
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
    func addCircle(){
        
        print("HubRadius,-----------------------------",self.hubRadius)
        let circleCenter : CLLocationCoordinate2D  = CLLocationCoordinate2DMake(hubLatCordinate ?? 0.0 , hubLongCordinate ?? 0.0)
       // let circ = GMSCircle(position: circleCenter, radius: Double(CGFloat(hubRadius ?? 0).getMiles()))
        
        let floatRadius = CGFloat(hubRadius ?? 0).getMiles()
        let doubleRadius = Double(floatRadius) * 1000000
        
        print("HubRadius,-----------------------------",doubleRadius)
       // let circ = GMSCircle(position: circleCenter, radius: 300000)
         let circ = GMSCircle(position: circleCenter, radius: doubleRadius)
        print("circ,-----------------------------",circ)
        circ.fillColor = UIColor(red: 0.0, green: 0.7, blue: 0, alpha: 0.1)
        circ.strokeColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 0.5)
        circ.strokeWidth = 2.5;
        circ.map = self.mapView
        self.mapView.animate(toZoom: 9.0)
    }
  //MARK: - IBAction -
  
  @IBAction func tapBack(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func tapConfirmLocation(_ sender: UIButton) {
    
    let storyboard = UIStoryboard.init(name: StoryBoardConstants.kLogin, bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: SaveAddressViewC.id()) as! SaveAddressViewC
    viewController.signUpStepTwoDataModel = self.signUpStepTwoDataModel
    viewController.mapAddress = lblUpdateLocation.text
    viewController.delegate = self
    viewController.modalPresentationStyle = .overCurrentContext

    viewController.dismiss = { [weak self] (mapAddressModel) in
        self?.latitude = Double.getDouble(self?.centerMapCoordinate.latitude)
        self?.longitude = Double.getDouble(self?.centerMapCoordinate.longitude)
        self?.dismiss?(mapAddressModel , self?.latitude , self?.longitude)
        self?.navigationController?.popViewController(animated: true)
    }

    self.navigationController?.present(viewController, animated: true, completion: nil)
  }
  
  @IBAction func tapSearchLocation(_ sender: UIButton) {
    
    let autocompleteController = GMSAutocompleteViewController()
    autocompleteController.delegate = self
    self.present(autocompleteController, animated: true, completion: nil)
  }
  
  //MARK: - Private Methods -
 
  private func intialGoogleSetup(withLatitude latitude: Double, withLongitude longitude: Double) {
    
    self.getAddressFromGeoCodeAPI(latitude: latitude, longitude: longitude, handler: { (response: String?) in
      self.lblUpdateLocation.text = response
//      kSharedUserDefaults.latitude = latitude
//      kSharedUserDefaults.longitude = longitude
//      let latitudeDegree = CLLocationDegrees(exactly: latitude)
//      let longitudeDegree = CLLocationDegrees(exactly: longitude)
//      self.centerMapCoordinate = CLLocationCoordinate2D(latitude: latitudeDegree ?? 0.0, longitude: longitudeDegree ?? 0.0 )
        if self.fromVC == .locateHub{
            let latitudeDegree = CLLocationDegrees(exactly: self.hubLatCordinate ?? 0.0)
            let longitudeDegree = CLLocationDegrees(exactly: self.hubLongCordinate ?? 0.0)
            print("hubLatCordinate----------------------------------------\(self.hubLatCordinate ?? 0.0)")
            print("hubLongCordinate----------------------------------------\(self.hubLongCordinate ?? 0.0)")
            print("hubLatDegreeCordinate----------------------------------------\(latitudeDegree ?? 0.0)")
            print("hubLongDegreeCordinate----------------------------------------\(longitudeDegree ?? 0.0)")
            let camera = GMSCameraPosition.camera(withLatitude: latitudeDegree ?? 0.0 , longitude: longitudeDegree ?? 0.0, zoom: 6.0)
            self.mapView.camera = camera
            self.addCircle()
        }else{
            kSharedUserDefaults.latitude = latitude
            kSharedUserDefaults.longitude = longitude
            let latitudeDegree = CLLocationDegrees(exactly: latitude)
            let longitudeDegree = CLLocationDegrees(exactly: longitude)
      let camera = GMSCameraPosition.camera(withLatitude: latitudeDegree ?? 0.0 , longitude: longitudeDegree ?? 0.0, zoom: 18.0)
            self.mapView.camera = camera
        }
     
      self.mapView.delegate = self
    })
  }
}


//MARK: - Core Location

extension MapViewC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let userLocation = locations.last else {
            return
        }

        kSharedUserDefaults.latitude = userLocation.coordinate.latitude
        kSharedUserDefaults.longitude = userLocation.coordinate.longitude

        self.intialGoogleSetup(withLatitude: kSharedUserDefaults.latitude, withLongitude: kSharedUserDefaults.longitude)

//        let camera = GMSCameraPosition.camera(withLatitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.latitude, zoom: 10.0)
//        self.mapView.camera = camera

        locationManager.stopUpdatingLocation()
    }

}

//MARK: - GMSMapView Methods -

extension MapViewC: GMSMapViewDelegate{

  func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
  
    self.lblUpdateLocation.text = ""
  }
  
  func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
    
    let latitude = mapView.camera.target.latitude
    let longitude = mapView.camera.target.longitude
    self.centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    self.getAddressFromGeoCodeAPI(latitude: latitude, longitude: longitude, handler: { (response: String?) in
      self.lblUpdateLocation.text = response
      kSharedUserDefaults.latitude = latitude
      kSharedUserDefaults.longitude = longitude
    })
  }
}

//MARK: - GMSDelegate Methods -

extension MapViewC: GMSAutocompleteViewControllerDelegate {


  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    
    kSharedUserDefaults.latitude = place.coordinate.latitude
    kSharedUserDefaults.longitude = place.coordinate.longitude
    self.intialGoogleSetup(withLatitude: kSharedUserDefaults.latitude, withLongitude: kSharedUserDefaults.longitude)
    dismiss(animated: true, completion: nil)

  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    print("Error: ", error.localizedDescription)
  }

  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }
}

extension MapViewC: SaveAddressCallback{
    func addressSaved(_ model: SignUpStepTwoDataModel, addressLineOne: String, addressLineTwo: String, mapAddress: String?) {
        self.dismiss(animated: true){
            self.delegate?.addressSaved(model, addressLineOne: addressLineOne, addressLineTwo: addressLineTwo, mapAddress: mapAddress)
        }
    }
    
  
//    func addressSaved(_ model: SignUpStepTwoDataModel, addressLineOne: String, addressLineTwo: String, mapAddress:String) {
//
//
//  }
}
extension CGFloat {
  func getMiles() -> CGFloat{
       return self * 0.000621371192
  }
  func getMeters() -> CGFloat {
       return self * 1609.344
  }
}
