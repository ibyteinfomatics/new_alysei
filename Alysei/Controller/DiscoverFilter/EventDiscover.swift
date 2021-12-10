//
//  EventDiscover.swift
//  Alysei
//
//  Created by Gitesh Dang on 09/11/21.
//

import UIKit

class EventDiscover: AlysieBaseViewC {
  
    @IBOutlet weak var filter: UIButton!
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var vwHeader: UIView!
    var eventModel:EventModel?
    var eventId: String?
    var hostname,location,website:String?
    
    var indexOfPageToRequest = 1
    var eventData = [EventDatum]()
    
    //Mark: FilterData
    
    var selectedDate: String?
    var selectedEventType: String?
    var selectedRegistrationType: String?
    var selectedRestType: String?
    var passRestId: String?
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventId = "events"
        vwHeader.drawBottomShadow()
        eventsTableView.delegate = self
        eventsTableView.dataSource = self

        postRequest(indexOfPageToRequest)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
   
    
    
    @IBAction func filterBtn(_ sender: UIButton) {
        
        let controller = pushViewController(withName: EventFilterVC.id(), fromStoryboard: StoryBoardConstants.kHome) as? EventFilterVC
        controller?.passSelectedDate = self.selectedDate
        controller?.passSelectedEventType = self.selectedEventType
        controller?.passSelectedRegistrationType = self.selectedRegistrationType
        controller?.passSelectedRestType = self.selectedRestType
        controller?.passRestId =  passRestId
        controller?.passSelectedDataCallback = { passSelectedDate,passEventType,passRegistrationType,passRestType,passRestId in
            self.selectedDate = passSelectedDate
            self.selectedEventType = passEventType
            self.selectedRegistrationType? = passRegistrationType
            self.selectedRestType = passRestType
            self.passRestId = passRestId
            self.callFilterApi(1)
        }
        controller?.clearFiltercCallBack = {
            self.selectedDate = ""
            self.selectedEventType = ""
            self.selectedRegistrationType? = ""
            self.selectedRestType = ""
            self.passRestId = ""
            self.eventId = "events"
            self.postRequest(1)
        }
    }
    
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    private func getEventTableCell(_ indexPath: Int) -> UITableViewCell{
        
        let eventTableCell = eventsTableView.dequeueReusableCell(withIdentifier: EventsTableViewCell.identifier()) as! EventsTableViewCell
        
        eventTableCell.eventTitle.text = eventData[indexPath].eventName
        eventTableCell.hostTitle.text = eventData[indexPath].hostName
        eventTableCell.locationTitle.text = eventData[indexPath].location
        eventTableCell.dateTitle.text = eventData[indexPath].date
        eventTableCell.lblLikeCount.text = "\(eventData[indexPath].like_counts ?? 0)"
        eventTableCell.configCell(eventData[indexPath])
        eventTableCell.btnInterested.tag = indexPath
        eventTableCell.btnInterestedWidth.constant = 180
        eventTableCell.btnInterested.backgroundColor = UIColor.init(hexString: "37A282")
        eventTableCell.callInterestedCallback = { index in
            let reloadIndexPath = IndexPath(row: index, section: 0)
            self.postRequest(1)
            self.eventsTableView.reloadRows(at: [reloadIndexPath], with: .automatic)
        }
        if ((eventData[indexPath].time?.contains(":")) == true) {
            eventTableCell.timeTitle.text = eventData[indexPath].time
        } else {
            eventTableCell.timeTitle.text = getcurrentdateWithTime(timeStamp: eventData[indexPath].time)
        }
        let imageUrl = (kImageBaseUrl + (eventData[indexPath].user?.avatarid?.attachmenturl ?? ""))
        eventTableCell.userImage.setImage(withString: imageUrl)
        
        
        eventTableCell.userImage.layer.cornerRadius =  eventTableCell.userImage.frame.height / 2
        eventTableCell.userImage.layer.masksToBounds = true
        
        eventTableCell.eventImage.layer.masksToBounds = false
        eventTableCell.eventImage.clipsToBounds = true
        eventTableCell.eventImage.layer.cornerRadius = 5
        
        eventTableCell.eventImage.setImage(withString: String.getString(kImageBaseUrl+(eventData[indexPath].attachment?.attachmenturl ?? "")), placeholder: UIImage(named: "image_placeholder"))
        
        return eventTableCell
        
    }
    
    func getcurrentdateWithTime(timeStamp :String?) -> String {
        let time = Double.getDouble(timeStamp) / 1000
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale =  Locale(identifier:  "en")
        let localDate = dateFormatter.string(from: date)
        
        return localDate
            
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height - (self.view.frame.height * 2) {
            if indexOfPageToRequest > eventModel?.lastPage ?? 0{
                print("No Data")
            }else{
            // increments the number of the page to request
            indexOfPageToRequest += 1

            // call your API for more data
                postRequest(indexOfPageToRequest)

            // tell the table view to reload with the new data
            self.eventsTableView.reloadData()
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

extension EventDiscover: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        return self.getEventTableCell(indexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("index--- ",indexPath.row)
        
        let indexPath = indexPath.row
        
        let vc = self.pushViewController(withName: CreateEventViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! CreateEventViewController
        vc.hostname = eventData[indexPath].hostName
        vc.eventname = eventData[indexPath].eventName
        vc.location = eventData[indexPath].location
        vc.date = eventData[indexPath].date
        vc.time = eventData[indexPath].time
        vc.fulldescription = eventData[indexPath].datumDescription
        vc.website = eventData[indexPath].website
        vc.eventYype = eventData[indexPath].eventType
        vc.registrationType = eventData[indexPath].registrationType
        vc.imgurl = eventData[indexPath].attachment?.attachmenturl
        vc.bookingUrl = eventData[indexPath].url
        vc.typeofpage = "read"
        
    }
    
    
    
}
extension EventDiscover {
    
    func callFilterApi (_ pageNo: Int?) {
      //  self.eventModel = EventModel(with: [:])
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Discover.kDiscoverEventSearch + "&date=" + "\(selectedDate ?? "")" + "&event_type=" + "\(selectedEventType ?? "")" + "&registration_type=" + "\(selectedRegistrationType ?? "")" + "&restaurant_type=" + "\(passRestId ?? "")"+"&page=\(pageNo ?? 1)" , requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
          if let data = dictResponse?["data"] as? [String:Any]{
            self.eventModel = EventModel.init(with: data)
            
            if self.indexOfPageToRequest == 1 { self.eventData.removeAll() }
            
            self.eventData.append(contentsOf: self.eventModel?.data ?? [EventDatum(with: [:])])
          }
          
          self.eventsTableView.reloadData()
        }
        
    }
    
    
    private func postRequest(_ pageNo: Int?) -> Void{
      
      disableWindowInteraction()
    
      TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetDiscoverListing+"\(eventId ?? "" )"+"&page=\(pageNo ?? 1)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
          let dictResponse = dictResponse as? [String:Any]
        if let data = dictResponse?["data"] as? [String:Any]{
          self.eventModel = EventModel.init(with: data)
            
            if self.indexOfPageToRequest == 1 { self.eventData.removeAll() }
            
            self.eventData.append(contentsOf: self.eventModel?.data ?? [EventDatum(with: [:])])
            
        }
        
        self.eventsTableView.reloadData()
      }
      
    }
  
    
}
