//
//  TripsViewController.swift
//  Profile Screen
//
//  Created by mac on 30/08/21.
//

import UIKit

class TripsViewController: AlysieBaseViewC {
    @IBOutlet weak var myTripLabel: UILabel!
    @IBOutlet weak var createTripsButton: UIButton!
    @IBOutlet weak var tripsTableView: UITableView!
    @IBOutlet weak var vwBlank: UIView!
    
    var tripModel:TripModel?
    var userId: String?
    
    var agencyname,website:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tripsTableView.delegate = self
        tripsTableView.dataSource = self
        createTripsButton.layer.cornerRadius = 18
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if userId != ""{
            createTripsButton.isHidden = true
        } else {
            createTripsButton.isHidden = false
        }
        postRequestToGetTrip()
    }
    func setUI(){
        if self.tripModel?.data?.count ?? 0 == 0{
            self.vwBlank.isHidden = false
        }else{
            self.vwBlank.isHidden = true
        }
    }
    @IBAction func create(_ sender: UIButton) {
        check = "show"
        let vc  = pushViewController(withName: CreateTripsViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! CreateTripsViewController
        vc.agency = agencyname
        vc.website = website
    }
    
    
    private func getEventTableCell(_ indexPath: Int) -> UITableViewCell{
        
        let tripTableCell = tripsTableView.dequeueReusableCell(withIdentifier: TripsTableViewCell.identifier()) as! TripsTableViewCell
        
        tripTableCell.tripTitle.text = tripModel?.data?[indexPath].tripName
        tripTableCell.travelTitle.text = tripModel?.data?[indexPath].travelAgency
        
     //   tripTableCell.activitiesTitle.text = tripModel?.data?[indexPath].adventure?.adventureType
        tripTableCell.locationTitle.text = tripModel?.data?[indexPath].region?.name
        tripTableCell.tripTitle.text = tripModel?.data?[indexPath].tripName
        tripTableCell.moreInfoButton.layer.cornerRadius = 10
        tripTableCell.interestedButton.layer.cornerRadius = 10
        if tripModel?.data?[indexPath].currency == "USD" {
            tripTableCell.priceTitle.text =  "$" + (tripModel?.data?[indexPath].price ?? "0")
        } else if tripModel?.data?[indexPath].currency == "Euro" {
            tripTableCell.priceTitle.text =  "€" + (tripModel?.data?[indexPath].price ?? "0")
        } else {
            tripTableCell.priceTitle.text =  "$" + (tripModel?.data?[indexPath].price ?? "0")
        }
        
        let imageUrl = kImageBaseUrl + (tripModel?.data?[indexPath].user?.avatarID?.attachmentURL ?? "")
        tripTableCell.userImage.setImage(withString: imageUrl)
        tripTableCell.configCell(tripModel?.data?[indexPath] ?? TripDatum(with: [:]))
        tripTableCell.editButton.tag = indexPath
        tripTableCell.deleteButton.tag = indexPath
        tripTableCell.moreInfoButton.tag = indexPath
        
        if tripModel?.data?[indexPath].intensity?.intensity == "Level 1" {

                    tripTableCell.view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.view2.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    tripTableCell.view3.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    tripTableCell.view4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    tripTableCell.view5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

                } else if tripModel?.data?[indexPath].intensity?.intensity == "Level 2" {

                    tripTableCell.view2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.view3.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    tripTableCell.view4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    tripTableCell.view5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

                } else if tripModel?.data?[indexPath].intensity?.intensity == "Level 3" {

                    tripTableCell.view3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.view2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.view4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    tripTableCell.view5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

                } else if tripModel?.data?[indexPath].intensity?.intensity == "Level 4" {

                    tripTableCell.view4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.view2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.view3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.view5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

                } else if tripModel?.data?[indexPath].intensity?.intensity == "Level 5" {

                    tripTableCell.view5.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.view2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.view3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.view4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor

                }
        
        
        if tripModel?.data?[indexPath].duration == "1 Day" {

                    tripTableCell.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview2.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    tripTableCell.duview3.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    tripTableCell.duview4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    tripTableCell.duview5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            
                    tripTableCell.duview6.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    tripTableCell.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

                } else if tripModel?.data?[indexPath].duration == "2 Days" {

                    tripTableCell.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview3.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    tripTableCell.duview4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    tripTableCell.duview5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    tripTableCell.duview6.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    tripTableCell.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

                } else if tripModel?.data?[indexPath].duration == "3 Days" {

                    tripTableCell.duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    tripTableCell.duview5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    tripTableCell.duview6.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    tripTableCell.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

                } else if tripModel?.data?[indexPath].duration == "4 Days" {

                    tripTableCell.duview4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    tripTableCell.duview6.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    tripTableCell.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

                } else if tripModel?.data?[indexPath].duration == "5 Days" {

                    tripTableCell.duview5.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview6.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    tripTableCell.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

                } else if tripModel?.data?[indexPath].duration == "6 Days" {
                    
                    tripTableCell.duview5.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview6.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

                } else if tripModel?.data?[indexPath].duration == "7 Days" {
                    
                    tripTableCell.duview5.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview6.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    tripTableCell.duview7.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor

                }
        
    
        if userId != ""{
            tripTableCell.deleteButton.isHidden = true
            tripTableCell.editButton.isHidden = true
            tripTableCell.interestedButton.isHidden = false
        } else {
            tripTableCell.deleteButton.isHidden = false
            tripTableCell.editButton.isHidden = false
            tripTableCell.interestedButton.isHidden = true
        }
        
        tripTableCell.btnDeleteCallback = { tag,tripId in
          
            
            //MARK:show Alert Message
            let refreshAlert = UIAlertController(title: "", message: "Are you sure you want to delete this trip?", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
               
                self.disableWindowInteraction()
              
                TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kDeleteTrip+"\(tripId)", requestMethod: .POST, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
                    
                    self.postRequestToGetTrip()
                }
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                  
                self.parent?.dismiss(animated: true, completion: nil)
            }))
            //let parent = self.parentViewController?.presentedViewController as? HubsListVC
            self.parent?.present(refreshAlert, animated: true, completion: nil)
            
        }
        
        tripTableCell.btnEditCallback = { tag in
            check = "show"
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
            vc.trip_id = self.tripModel?.data?[indexPath].tripID
            
            vc.countryId = self.tripModel?.data?[indexPath].country?.id
            vc.regionId = self.tripModel?.data?[indexPath].region?.id
            vc.adventureId = self.tripModel?.data?[indexPath].adventure?.adventureTypeID
            vc.intensityId = self.tripModel?.data?[indexPath].intensity?.intensityID
            vc.currency = self.tripModel?.data?[indexPath].currency
            vc.typeofpage = "edit"
                    
        }
        
        tripTableCell.btnMoreCallback = { tag in
            check = "show"
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
        
        tripTableCell.tripImage.layer.masksToBounds = false
        tripTableCell.tripImage.clipsToBounds = true
        tripTableCell.tripImage.layer.cornerRadius = 5
        
        tripTableCell.tripImage.setImage(withString: String.getString(kImageBaseUrl+(tripModel?.data?[indexPath].attachment?.attachmentURL)! ?? ""), placeholder: UIImage(named: "image_placeholder"))
        
        return tripTableCell
        
    }
    
    private func postRequestToGetTrip() -> Void{
      
      disableWindowInteraction()
    
      TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetTripListing+"\(userId!)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
          let dictResponse = dictResponse as? [String:Any]
          
          self.tripModel = TripModel.init(with: dictResponse)
        
        self.myTripLabel.text = "My Trips (\(self.tripModel?.data?.count ?? 0))"
        self.setUI()
        self.tripsTableView.reloadData()
      }
      
    }
    
}
extension TripsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        return self.getEventTableCell(indexPath.row)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
