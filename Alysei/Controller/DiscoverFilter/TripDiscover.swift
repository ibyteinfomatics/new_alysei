//
//  TripDiscover.swift
//  Alysei
//
//  Created by Gitesh Dang on 09/11/21.
//

import UIKit

class TripDiscover: AlysieBaseViewC {
    
    @IBOutlet weak var filter: UIButton!
    @IBOutlet weak var tripsTableView: UITableView!
    @IBOutlet weak var vwHeader: UIView!
    var tripModel:TripModel?
    var tripData = [TripDatum]()
    var tripId: String?
    
    var agencyname,website:String?
    
    var indexOfPageToRequest = 1

    
    var passSelectedCountry: String?
    var passRegions: String?
    var passAdventure:String?
    var passDuration:String?
    var passIntensity:String?
    var passprice:String?
    var regionId,adventureId,intensityId: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        vwHeader.drawBottomShadow()
        tripsTableView.delegate = self
        tripsTableView.dataSource = self
        // Do any additional setup after loading the view.
        self.tripId = "trips"
        postRequestToGetTrip(indexOfPageToRequest)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func filterBtn(_ sender: UIButton) {
        let controller = pushViewController(withName: TripsFilterVC.id(), fromStoryboard: StoryBoardConstants.kHome) as? TripsFilterVC
        
        controller?.passSelectedCountry = self.passSelectedCountry
        controller?.passRegions = self.passRegions
        controller?.passAdventure = self.passAdventure
        controller?.passDuration = self.passDuration
        controller?.passIntensity = self.passIntensity
        controller?.passprice = self.passprice
        controller?.regionId = regionId
        controller?.adventureId = adventureId
        controller?.intensityId = intensityId
        
        
        controller?.passSelectedDataCallback = {(passSelectedCountry,passRegions,passAdventure,passDuration,passIntensity, passprice,regionId,adventureId ,intensityId) in
            
            self.passSelectedCountry = passSelectedCountry
            self.passRegions = passRegions
            self.passAdventure = passAdventure
            self.passDuration = passDuration
            self.passIntensity = passIntensity
            self.passprice = passprice
            self.regionId = regionId
            self.adventureId = adventureId
            self.intensityId = intensityId
            self.callFilterApi(1)
        }
        controller?.clearfilterCallback = {
            self.passSelectedCountry = ""
            self.passRegions = ""
            self.passAdventure = ""
            self.passDuration = ""
            self.passIntensity = ""
            self.passprice = ""
            self.regionId = ""
            self.adventureId = ""
            self.intensityId = ""
            self.tripId = "trips"
            self.postRequestToGetTrip(1)
        }
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func getEventTableCell(_ indexPath: Int) -> UITableViewCell{
        
        let tripTableCell = tripsTableView.dequeueReusableCell(withIdentifier: TripsTableViewCell.identifier()) as! TripsTableViewCell
        
        tripTableCell.tripTitle.text = tripData[indexPath].tripName
        tripTableCell.travelTitle.text = tripData[indexPath].travelAgency
        
    //    tripTableCell.activitiesTitle.text = tripData[indexPath].adventure?.adventureType
        tripTableCell.locationTitle.text = tripData[indexPath].region?.name
        tripTableCell.tripTitle.text = tripData[indexPath].tripName
        
        if tripData[indexPath].currency == "USD" {
            tripTableCell.priceTitle.text =  "$" + (tripData[indexPath].price ?? "0")
        } else if tripData[indexPath].currency == "Euro" {
            tripTableCell.priceTitle.text =  "€" + (tripData[indexPath].price ?? "0")
        } else {
            tripTableCell.priceTitle.text =  "$" + (tripData[indexPath].price ?? "0")
        }
        
        let imageUrl = kImageBaseUrl + (tripData[indexPath].user?.avatarID?.attachmentURL ?? "")
        tripTableCell.userImage.setImage(withString: imageUrl)
        tripTableCell.userImage.layer.cornerRadius =  tripTableCell.userImage.frame.height / 2
        
        tripTableCell.configCell(tripData[indexPath])
        
        if tripData[indexPath].intensity?.intensity == "Level 1" {

            tripTableCell.view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.view2.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            tripTableCell.view3.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            tripTableCell.view4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            tripTableCell.view5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

        } else if tripData[indexPath].intensity?.intensity == "Level 2" {

            tripTableCell.view2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.view3.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            tripTableCell.view4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            tripTableCell.view5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

        } else if tripData[indexPath].intensity?.intensity == "Level 3" {

            tripTableCell.view3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.view2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.view4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            tripTableCell.view5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

        } else if tripData[indexPath].intensity?.intensity == "Level 4" {

            tripTableCell.view4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.view2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.view3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.view5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

        } else if tripData[indexPath].intensity?.intensity == "Level 5" {

            tripTableCell.view5.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.view2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.view3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.view4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor

        }


        if tripData[indexPath].duration == "1 Day" {

            tripTableCell.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview2.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            tripTableCell.duview3.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            tripTableCell.duview4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            tripTableCell.duview5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
    
            tripTableCell.duview6.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            tripTableCell.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

        } else if tripData[indexPath].duration == "2 Days" {

            tripTableCell.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview3.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            tripTableCell.duview4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            tripTableCell.duview5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            tripTableCell.duview6.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            tripTableCell.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

        } else if tripData[indexPath].duration == "3 Days" {

            tripTableCell.duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            tripTableCell.duview5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            tripTableCell.duview6.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            tripTableCell.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

        } else if tripData[indexPath].duration == "4 Days" {

            tripTableCell.duview4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            tripTableCell.duview6.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            tripTableCell.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

        } else if tripData[indexPath].duration == "5 Days" {

            tripTableCell.duview5.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview6.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            tripTableCell.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

        } else if tripData[indexPath].duration == "6 Days" {
            
            tripTableCell.duview5.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview6.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

        } else if tripData[indexPath].duration == "7 Days" {
            
            tripTableCell.duview5.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview6.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            tripTableCell.duview7.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor

        }
        
        tripTableCell.tripImage.layer.masksToBounds = false
        tripTableCell.tripImage.clipsToBounds = true
        tripTableCell.tripImage.layer.cornerRadius = 5
        
        tripTableCell.tripImage.setImage(withString: String.getString(kImageBaseUrl+(tripData[indexPath].attachment?.attachmentURL)! ), placeholder: UIImage(named: "image_placeholder"))
        
        return tripTableCell
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height - (self.view.frame.height * 2) {
            if indexOfPageToRequest > tripModel?.lastPage ?? 0{
                print("No Data")
            }else{
            // increments the number of the page to request
            indexOfPageToRequest += 1

            // call your API for more data
                postRequestToGetTrip(indexOfPageToRequest)

            // tell the table view to reload with the new data
            self.tripsTableView.reloadData()
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
extension TripDiscover: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        return self.getEventTableCell(indexPath.row)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = indexPath.row
        let vc = self.pushViewController(withName: CreateTripsViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! CreateTripsViewController
        vc.tripname = self.tripModel?.data?[indexPath].tripName
        vc.agency = self.tripModel?.data?[indexPath].travelAgency
        vc.duration = self.tripModel?.data?[indexPath].duration
        vc.adventure = self.tripModel?.data?[indexPath].adventure?.adventureType
        vc.trip_id = self.tripModel?.data?[indexPath].tripID
        vc.intensity = self.tripModel?.data?[indexPath].intensity?.intensity
        vc.country = self.tripModel?.data?[indexPath].country?.name
        vc.region = self.tripModel?.data?[indexPath].region?.name
        vc.website = self.tripModel?.data?[indexPath].website
        vc.price = self.tripModel?.data?[indexPath].price
        vc.fulldescription = self.tripModel?.data?[indexPath].datumDescription
        vc.imgurl = self.tripModel?.data?[indexPath].attachment?.attachmentURL
        vc.currency = self.tripModel?.data?[indexPath].currency
        vc.typeofpage = "read"
    }
    
}
extension TripDiscover {
    
    private func postRequestToGetTrip(_ pageNo: Int?) -> Void{
      
      disableWindowInteraction()
    
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetDiscoverListing+"\(self.tripId ?? "")"+"&page=\(pageNo ?? 1)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
        let dictResponse = dictResponse as? [String:Any]
      if let data = dictResponse?["data"] as? [String:Any]{
        self.tripModel = TripModel.init(with: data)
        
        if self.indexOfPageToRequest == 1 { self.tripData.removeAll() }
        
        self.tripData.append(contentsOf: self.tripModel?.data ?? [TripDatum(with: [:])])
        
      }
      
        self.tripsTableView.reloadData()
      }
      
    }
   
    func callFilterApi (_ pageNo: Int?) {
        //self.tripModel = TripModel(with: [:])
        let str = passDuration
        let trimmedDurationStr = str?.trimmingCharacters(in: .whitespaces)
       
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Discover.kDiscoverTripsSearch + "&region=" + "\(regionId ?? "" )" + "&adventure_type=" + "\(adventureId ?? "" )" + "&duration=" + "\(trimmedDurationStr ?? "")" + "&intensity=" + "\(intensityId ?? "")"  + "&price=" + "\(passprice ?? "")"+"&page=\(pageNo ?? 1)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
          if let data = dictResponse?["data"] as? [String:Any]{
            self.tripModel = TripModel.init(with: data)
            
            if self.indexOfPageToRequest == 1 { self.tripData.removeAll() }
            
            self.tripData.append(contentsOf: self.tripModel?.data ?? [TripDatum(with: [:])])
          }
          
          self.tripsTableView.reloadData()
        }
        
    }
}
