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
    
    var tripModel:TripModel?
    var tripId: String?
    
    var agencyname,website:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        tripsTableView.delegate = self
        tripsTableView.dataSource = self
        // Do any additional setup after loading the view.
        postRequestToGetTrip()
    }
    
    @IBAction func filterBtn(_ sender: UIButton) {
        _ = pushViewController(withName: TripsFilterVC.id(), fromStoryboard: StoryBoardConstants.kHome) as? TripsFilterVC
        
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    private func postRequestToGetTrip() -> Void{
      
      disableWindowInteraction()
    
      TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetDiscoverListing+"\(tripId!)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
        let dictResponse = dictResponse as? [String:Any]
      if let data = dictResponse?["data"] as? [String:Any]{
        self.tripModel = TripModel.init(with: data)
      }
      
        self.tripsTableView.reloadData()
      }
      
    }
    
    private func getEventTableCell(_ indexPath: Int) -> UITableViewCell{
        
        let tripTableCell = tripsTableView.dequeueReusableCell(withIdentifier: TripsTableViewCell.identifier()) as! TripsTableViewCell
        
        tripTableCell.tripTitle.text = tripModel?.data?[indexPath].tripName
        tripTableCell.travelTitle.text = tripModel?.data?[indexPath].travelAgency
        
        tripTableCell.activitiesTitle.text = tripModel?.data?[indexPath].adventure?.adventureType
        tripTableCell.locationTitle.text = tripModel?.data?[indexPath].region?.name
        tripTableCell.tripTitle.text = tripModel?.data?[indexPath].tripName
        
        if tripModel?.data?[indexPath].currency == "USD" {
            tripTableCell.priceTitle.text =  "$" + (tripModel?.data?[indexPath].price ?? "0")
        } else if tripModel?.data?[indexPath].currency == "Euro" {
            tripTableCell.priceTitle.text =  "€" + (tripModel?.data?[indexPath].price ?? "0")
        } else {
            tripTableCell.priceTitle.text =  "$" + (tripModel?.data?[indexPath].price ?? "0")
        }
        
        
        tripTableCell.configCell(tripModel?.data?[indexPath] ?? TripDatum(with: [:]))
        
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
        
        tripTableCell.tripImage.layer.masksToBounds = false
        tripTableCell.tripImage.clipsToBounds = true
        tripTableCell.tripImage.layer.cornerRadius = 5
        
        tripTableCell.tripImage.setImage(withString: String.getString(kImageBaseUrl+(tripModel?.data?[indexPath].attachment?.attachmentURL)! ?? ""), placeholder: UIImage(named: "image_placeholder"))
        
        return tripTableCell
        
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
        return tripModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        return self.getEventTableCell(indexPath.row)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}
