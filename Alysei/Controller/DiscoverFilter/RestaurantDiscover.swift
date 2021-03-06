//
//  RestaurantDiscover.swift
//  Alysei
//
//  Created by Gitesh Dang on 09/11/21.
//

import UIKit
import CoreLocation

class RestaurantDiscover: AlysieBaseViewC {
    
    @IBOutlet weak var filter: UIButton!
    @IBOutlet weak var btnMap: UIButton!
    @IBOutlet weak var tripsTableView: UITableView!
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var lblTitle: UILabel!
 //   @IBOutlet weak var userImage: UIImageView!
    
    var restModel:RestaurantModel?
    var restauUser = [RestaurantUser]()
    var restId: String?
    var locationManager: CLLocationManager!
    var passHubs: String?
    var passRestType: String?
    
    var lat = [Double]()
    var long = [Double]()
    var name = [String]()
    var address = [String]()
    var userid = [Int]()
   // var latitude: String?
   // var longitude: String?
    var indexOfPageToRequest = 1
    var latitude : Double?
    var longitude: Double?
    var country: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vwHeader.drawBottomShadow()
        tripsTableView.delegate = self
        tripsTableView.dataSource = self
        restId = "restaurants"
        getCurrentLocation()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblTitle.text = AppConstants.kRestaurants
        btnMap.setTitle(AppConstants.kMap, for: .normal)
        btnMap.setTitle(AppConstants.kMap, for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func mapBtn(_ sender: UIButton) {
        
        let count  = restauUser.count
        
        for index in 0..<count {
            
            if restauUser[index].lattitude != ""{
                name.append(String.getString(restauUser[index].restaurantName))
                address.append(String.getString(restauUser[index].address))
                lat.append(Double.getDouble(restauUser[index].lattitude))
                long.append(Double.getDouble(restauUser[index].longitude))
                userid.append(Int.getInt(restauUser[index].userid))
            }
            
        }
        
        let controller = pushViewController(withName: ShowMapMarker.id(), fromStoryboard: StoryBoardConstants.kHome) as? ShowMapMarker
        controller?.lat = lat
        controller?.long = long
        controller?.name = name
        controller?.address = address
        controller?.userid = userid
        controller?.restId = restId
    }
    
    @IBAction func filterBtn(_ sender: UIButton) {
        
        let controller = pushViewController(withName: RestaurantFilterVC.id(), fromStoryboard: StoryBoardConstants.kHome) as? RestaurantFilterVC
        controller?.passHubs = self.passHubs
        controller?.passRestType = self.passRestType
        controller?.passSelectedDataCallback = {  passHubs, passRestType in
            self.passHubs = String.getString(passHubs)
            self.passRestType = String.getString(passRestType)
            self.callFilterApi(1)
        }
        
        controller?.clearFiltercCallBack = {
            self.passHubs = ""
            self.passRestType = ""
            self.callFilterApi(1)
        }
        
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getBlogTableCell(_ indexPath: Int) -> UITableViewCell{
        
        let restTableCell = tripsTableView.dequeueReusableCell(withIdentifier: BlogsTableViewCell.identifier()) as! BlogsTableViewCell
        
        restTableCell.blogTitle.text = restauUser[indexPath].restaurantName
        restTableCell.blogDescription.text = AppConstants.RestaurantType + " : " +  "\(restauUser[indexPath].restaurant_type ?? "")"
        
        restTableCell.imgUser.layer.cornerRadius =  restTableCell.imgUser.frame.height / 2
        
        let baseurl = restauUser[indexPath].avatarid?.baseUrl ?? ""
        let imageUrl = baseurl + (restauUser[indexPath].avatarid?.attachmenturl ?? "")
        restTableCell.imgUser.setImage(withString: imageUrl, placeholder: UIImage(named: "profile_icon"))
        
        //        restTableCell.blogImage.layer.masksToBounds = false
        //        restTableCell.blogImage.clipsToBounds = true
        //        restTableCell.blogImage.layer.cornerRadius = 5
        
        if restauUser[indexPath].avatarid?.attachmenturl != nil {
            let baseurlImg = restauUser[indexPath].avatarid?.baseUrl ?? ""
            //restTableCell.blogImage.setImage(withString: String.getString(baseurlImg+(restauUser[indexPath].coverid?.attachmenturl ?? "") ), placeholder: UIImage(named: "image_placeholder"))
            let imageRest = String.getString(baseurlImg+(restauUser[indexPath].coverid?.attachmenturl ?? "")).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? ""
            let imageRestUrl = URL(string: imageRest)
            if imageRestUrl != URL(string: ""){
                restTableCell.blogImage.loadImageWithUrl((imageRestUrl ?? URL(string: ""))!)
            }
        } else {
            restTableCell.blogImage.image = UIImage(named: "image_placeholder")
        }
        
        
        
        return restTableCell
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height - (self.view.frame.height * 2) {
            if indexOfPageToRequest > restModel?.lastPage ?? 0{
                print("No Data")
            }else{
                // increments the number of the page to request
                indexOfPageToRequest += 1
                
                // call your API for more data
                postRequestToGetRestaurant(indexOfPageToRequest)
                
                // tell the table view to reload with the new data
                self.tripsTableView.reloadData()
            }
        }
    }
    
    
    
}

extension RestaurantDiscover: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restauUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.getBlogTableCell(indexPath.row)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = pushViewController(withName: ProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? ProfileViewC
        
        if kSharedUserDefaults.loggedInUserModal.userId == "\(self.restauUser[indexPath.row].userid)" {
            controller?.userLevel = .own
        }else{
            controller?.userLevel = .other
        }
        controller?.userID = self.restauUser[indexPath.row].userid
        if controller?.userLevel == .own{
        self.navigationController?.popViewController(animated: true)
        }
    }
    
}
extension RestaurantDiscover: CLLocationManagerDelegate{
 
 func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
    
   NotificationCenter.default.removeObserver(self)
   manager.stopUpdatingLocation()
   let location = locations.last! as CLLocation
     
     self.latitude = location.coordinate.latitude
     self.longitude = location.coordinate.longitude
   //_ = pushViewController(withName: MapViewC.id(), fromStoryboard: StoryBoardConstants.kLogin)
     self.intialGoogleSetup(withLatitude: self.latitude ?? 0.0, withLongitude: self.longitude ?? 0.0)
 }
    
    private func intialGoogleSetup(withLatitude latitude: Double, withLongitude longitude: Double) {
      
      self.getAddressFromGeoCodeAPI(latitude: latitude, longitude: longitude, handler: { (response: String?) in
        print("location-------------------------",response)
          let component = response?.components(separatedBy: ",")
          print("Compponent--------------------------------",component?.last?.removeWhitespace())
          let userCountry = component?.last?.removeWhitespace()
          self.country = userCountry
          self.postRequestToGetRestaurant(1)
      })
     }
    private func getCurrentLocation() {
    
    if (CLLocationManager.locationServicesEnabled()) {
      print(AlertMessage.kLocationEnabled)
      locationManager = CLLocationManager()
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.requestAlwaysAuthorization()
      locationManager.requestWhenInUseAuthorization()
      locationManager.startUpdatingLocation()
       
    } else {
      print(AlertMessage.kLocationNotEnabled)
     }
    }
}
extension RestaurantDiscover {
    
    private func postRequestToGetRestaurant(_ pageNo: Int?) -> Void{
        
        disableWindowInteraction()
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetDiscoverListing + "\(restId!)" + "&country=" + "\(self.country ?? "")" + "&page=\(pageNo ?? 1)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            if let data = dictResponse?["data"] as? [String:Any]{
                self.restModel = RestaurantModel.init(with: data)
                
                if self.indexOfPageToRequest == 1 { self.restauUser.removeAll() }
                
                self.restauUser.append(contentsOf: self.restModel?.data ?? [RestaurantUser(with: [:])])
                
            }
            
            self.tripsTableView.reloadData()
        }
        
    }
    
    func callFilterApi (_ pageNo: Int?) {
        // self.restModel = RestaurantModel(with: [:])
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Discover.kDiscoverRestaurantSearch + "&hubs=" + String.getString(self.passHubs)+"&restaurant_type="+String.getString(self.passRestType) + "&country=" + "\(self.country ?? "")" + "&page=\(pageNo ?? 1)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            switch statusCode{
            case 200:
            let dictResponse = dictResponse as? [String:Any]
            if let data = dictResponse?["data"] as? [String:Any]{
                self.restModel = RestaurantModel.init(with: data)
                
                if self.indexOfPageToRequest == 1 { self.restauUser.removeAll() }
                
                self.restauUser.append(contentsOf: self.restModel?.data ?? [RestaurantUser(with: [:])])
                
            }
            case 409:
                if pageNo == 1{
                    self.restauUser.removeAll()
                }
            default:
                print("Error")
          }
            self.tripsTableView.reloadData()
            
        }
        
    }
}
