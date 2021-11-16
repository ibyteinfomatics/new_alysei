//
//  ShowMapMarker.swift
//  Alysei
//
//  Created by Gitesh Dang on 16/11/21.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class ShowMapMarker: AlysieBaseViewC, GMSMapViewDelegate {
    
    @IBOutlet weak var mapView: UIView!
   // @IBOutlet weak var imgViewMarker: UIImageView!
    var lat = [Double]()
    var long = [Double]()
    var name = [String]()
    
    var mapViews: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*lat.append(28.621271)
        long.append(77.061325)
        name.append("Me")
        
        lat.append(28.6210)
        long.append(77.3812)
        name.append("iByte")
        
        lat.append(28.6386)
        long.append(77.0721)
        name.append("Vikas")*/
        

        //mapView.delegate = self
        
       /* var position = CLLocationCoordinate2DMake(28.621271,77.061325)
            var marker = GMSMarker(position: position)
            marker.title = "Hello World"
            marker.map = mapView
        self.mapView.animate(toZoom: 9.0)*/
        // Do any additional setup after loading the view.
        
        let camera = GMSCameraPosition.camera(withLatitude: lat[0], longitude: long[0], zoom: 15.0)
        mapViews = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: mapView.frame.size.width, height: mapView.frame.size.height), camera: camera)
            //mapViews.delegate = self
            
        mapView.addSubview(mapViews)
        
        for (index, name) in name.enumerated()
        {
                
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2DMake(lat[index], long[index])
                marker.title = name
                marker.map = mapViews
                mapViews.selectedMarker = marker
        }
        
        
        
        
       
    }
    
    @IBAction func btnBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
   
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
         print("Marker tapped")
         return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
