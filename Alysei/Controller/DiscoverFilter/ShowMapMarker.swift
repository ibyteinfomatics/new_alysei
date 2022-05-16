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

class ShowMapMarker: AlysieBaseViewC {
    
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var nextbtn: UIButton!
    @IBOutlet weak var previous: UIButton!
    @IBOutlet weak var headerView: UIView!
    
   // @IBOutlet weak var imgViewMarker: UIImageView!
    var lat = [Double]()
    var long = [Double]()
    var name = [String]()
    var address = [String]()
    var userid = [Int]()
    
    var mapViews: GMSMapView!
    
    var restModel:RestaurantModel?
    var restauUser = [RestaurantUser]()
    var indexOfPageToRequest = 1
    var restId: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.drawBottomShadow()
        /*lat.append(28.621271)
        long.append(77.061325)
        name.append("Me")
        
        lat.append(28.6210)
        long.append(77.3812)
        name.append("iByte")
        
        lat.append(28.6386)
        long.append(77.0721)
        name.append("Vikas")*/
        

        //mapViews.delegate = self
        
        nextbtn.layer.borderWidth = 2
        nextbtn.backgroundColor = UIColor.white
        nextbtn.layer.cornerRadius = 10
        nextbtn.layer.borderColor = UIColor.gray.cgColor
        
        previous.layer.borderWidth = 2
        previous.layer.cornerRadius = 10
        previous.backgroundColor = UIColor.white
        previous.layer.borderColor = UIColor.gray.cgColor
        
        previous.isHidden = true
        nextbtn.isHidden = true
        
        if lat.count > 0 {
            nextbtn.isHidden = false
        }
        
        
        
        let camera = GMSCameraPosition.camera(withLatitude: lat[0], longitude: long[0], zoom: 15.0)
        mapViews = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: mapView.frame.size.width, height: mapView.frame.size.height), camera: camera)
        mapViews.delegate = self
            
        mapView.addSubview(mapViews)
        
        for (index, name) in name.enumerated() {
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(lat[index], long[index])
            marker.title = name
            marker.userData = userid[index]
            //marker.setValue(userid[index], forKey: "userid")
            marker.snippet = address[index]
           // marker.icon = UIImage.init(named: "icons8_location-2")
            marker.icon = drawImageWithProfilePic(pp: UIImage(named: "OnlyMe")!, image: UIImage(named: "icons8_location-2")!)
            //marker.icon = GMSMarker.markerImage(with: UIColor.gr)
            marker.map = mapViews
            mapViews.selectedMarker = marker
            
        }
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func drawImageWithProfilePic(pp: UIImage, image: UIImage) -> UIImage {

        let imgView = UIImageView(image: image)
        let picImgView = UIImageView(image: pp)
        picImgView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)

        imgView.addSubview(picImgView)
        picImgView.center.x = imgView.center.x
        picImgView.center.y = imgView.center.y - 7
        picImgView.layer.cornerRadius = picImgView.frame.width/2
        picImgView.clipsToBounds = true
        imgView.setNeedsLayout()
        picImgView.setNeedsLayout()

        let newImage = imageWithView(view: imgView)
        return newImage
    }

    func imageWithView(view: UIView) -> UIImage {
        var image: UIImage?
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return image ?? UIImage()
    }
    
    @IBAction func btnBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: UIButton){
        
        previous.isHidden = false
        nextBtnUi()
        indexOfPageToRequest += 1
        postRequestToGetRestaurant(indexOfPageToRequest)
        
    }
    
    @IBAction func btnPrevious(_ sender: UIButton){
        
        preBtnUi()
        
        indexOfPageToRequest -= 1
        postRequestToGetRestaurant(indexOfPageToRequest)
    }
    
    @IBAction func btnList(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    func preBtnUi(){
        previous.layer.borderWidth = 2
        previous.backgroundColor = UIColor.init(hexString: "#33A386")
        previous.tintColor = UIColor.white
        previous.setTitleColor(UIColor.white, for: .normal)
        previous.layer.cornerRadius = 20
        previous.layer.borderColor = UIColor.gray.cgColor
        
        nextbtn.layer.borderWidth = 2
        nextbtn.layer.cornerRadius = 20
        nextbtn.backgroundColor = UIColor.white
        nextbtn.tintColor = UIColor.black
        nextbtn.setTitleColor(UIColor.black, for: .normal)
        nextbtn.layer.borderColor = UIColor.gray.cgColor
    }
    
    func nextBtnUi(){
        
        nextbtn.layer.borderWidth = 2
        nextbtn.backgroundColor = UIColor.init(hexString: "#33A386")
        nextbtn.tintColor = UIColor.white
        nextbtn.setTitleColor(UIColor.white, for: .normal)
        nextbtn.layer.cornerRadius = 20
        nextbtn.layer.borderColor = UIColor.gray.cgColor
        
        previous.layer.borderWidth = 2
        previous.layer.cornerRadius = 20
        previous.backgroundColor = UIColor.white
        previous.tintColor = UIColor.black
        previous.setTitleColor(UIColor.black, for: .normal)
        previous.layer.borderColor = UIColor.gray.cgColor
    }
    
    private func postRequestToGetRestaurant(_ pageNo: Int?) -> Void{
      
      disableWindowInteraction()
        self.restauUser.removeAll()
        if pageNo == 1 {
            previous.isHidden = true
            
        }
    
      TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetDiscoverListing+"\(restId!)"+"&page=\(pageNo ?? 1)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
        let dictResponse = dictResponse as? [String:Any]
        if let data = dictResponse?["data"] as? [String:Any]{
          self.restModel = RestaurantModel.init(with: data)
            
          if self.indexOfPageToRequest == 1 { self.restauUser.removeAll() }
          
          self.restauUser.append(contentsOf: self.restModel?.data ?? [RestaurantUser(with: [:])])
            
            if self.restauUser.count > 0 {
                
                
                if self.restauUser.count < 10 {
                    self.nextbtn.isHidden = true
                    self.preBtnUi()
                } else {
                    self.nextBtnUi()
                    self.nextbtn.isHidden = false
                }
                
                self.lat.removeAll()
                self.long.removeAll()
                self.name.removeAll()
                self.address.removeAll()
                self.userid.removeAll()
                
                for index in 0..<self.restauUser.count {
                    
                    if self.restauUser[index].lattitude != ""{
                        self.name.append(String.getString(self.restauUser[index].restaurantName))
                        self.address.append(String.getString(self.restauUser[index].address))
                        self.lat.append(Double.getDouble(self.restauUser[index].lattitude))
                        self.long.append(Double.getDouble(self.restauUser[index].longitude))
                        self.userid.append(Int.getInt(self.restauUser[index].userid))
                    }
                    
                }
                
                
                let camera = GMSCameraPosition.camera(withLatitude: self.lat[0], longitude: self.long[0], zoom: 15.0)
                self.mapViews = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: self.mapView.frame.size.width, height: self.mapView.frame.size.height), camera: camera)
                //self.mapViews.animate(to: camera)
                self.mapViews.delegate = self
                
                self.mapView.addSubview(self.mapViews)
                
                for (index, name) in self.name.enumerated() {
                    
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2DMake(self.lat[index], self.long[index])
                    marker.title = name
                
                    marker.userData = self.userid[index]
                    //marker.setValue(userid[index], forKey: "userid")
                    marker.snippet = self.address[index]
                   // marker.icon = UIImage.init(named: "icons8_location-2")
                    marker.icon = self.drawImageWithProfilePic(pp: UIImage(named: "OnlyMe")!, image: UIImage(named: "icons8_location-2")!)
                    //marker.icon = GMSMarker.markerImage(with: UIColor.gr)
                    marker.map = self.mapViews
                    self.mapViews.selectedMarker = marker
                    
                }
                
                
            } else {
                self.nextbtn.isHidden = true
            }
          
        }
      
        
      }
      
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

extension ShowMapMarker: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("Marker tapped")
        return false // return false to display info window
    }

    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        //marker.icon = UIImage(named: "map_marker_unselected")
        print("Marker unselected")
    }
    
    /* handles Info Window tap */
     func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("didTapInfoWindowOf ",marker.userData)
        
        let controller = pushViewController(withName: ProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? ProfileViewC
        controller?.userLevel = .other
        controller?.userID = Int.getInt(marker.userData)
        
        
        
     }
     
     /* handles Info Window long press */
     func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
     print("didLongPressInfoWindowOf")
     }
    
}
