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
        eventTableCell.locationTitle.text = eventData[indexPath].datumDescription
       // eventTableCell.dateTitle.text = eventData[indexPath].date
        eventTableCell.lblLikeCount.text = "\(eventData[indexPath].like_counts ?? 0)"
        eventTableCell.configCell(eventData[indexPath])
        eventTableCell.btnInterested.tag = indexPath
       
        if eventData[indexPath].is_event_liked?.count == 0{
            eventTableCell.btnInterestedWidth.constant = 180
            eventTableCell.btnInterested.backgroundColor = UIColor.init(hexString: "37A282")
            eventTableCell.btnInterested.setTitle("Are you Interested?", for: .normal)
        }else{
            eventTableCell.btnInterested.backgroundColor = UIColor.red
            eventTableCell.btnInterested.setTitle("Uninterested", for: .normal)
        }
        eventTableCell.callInterestedCallback = { index in
           
            let reloadIndexPath = IndexPath(row: index, section: 0)
            self.postRequest(self.indexOfPageToRequest)
            self.eventsTableView.reloadRows(at: [reloadIndexPath], with: .automatic)
        }

        
        
       
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        let date: Date? = dateFormatterGet.date(from: eventData[indexPath].createdAt ?? "")
        let datep = dateFormatterPrint.string(from: date ?? Date())
        eventTableCell.dateTitle.text = datep
       // }
        let baseUrl = eventData[indexPath].user?.avatarid?.baseUrl ?? ""
        let imageUrl = (baseUrl + (eventData[indexPath].user?.avatarid?.attachmenturl ?? ""))
        eventTableCell.userImage.setImage(withString: imageUrl)
        
        
        eventTableCell.userImage.layer.cornerRadius =  eventTableCell.userImage.frame.height / 2
        eventTableCell.userImage.layer.masksToBounds = true
        
        eventTableCell.eventImage.layer.masksToBounds = false
        eventTableCell.eventImage.clipsToBounds = true
        eventTableCell.eventImage.layer.cornerRadius = 5
        
        let baseUrlImg = eventData[indexPath].attachment?.baseUrl ?? ""
        eventTableCell.eventImage.setImage(withString: String.getString(baseUrlImg + (eventData[indexPath].attachment?.attachmenturl ?? "")), placeholder: UIImage(named: "image_placeholder"))
        
        
        eventTableCell.moreButton.tag = indexPath
        
        
        eventTableCell.btnMoreCallback = { tag in
                
            let baseUrlImg = self.eventData[indexPath].attachment?.baseUrl ?? ""

            let vc = self.pushViewController(withName: CreateEventViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! CreateEventViewController
            vc.hostname = self.eventData[indexPath].hostName
            vc.eventname = self.eventData[indexPath].eventName
            vc.location = self.eventData[indexPath].location
            vc.date = self.eventData[indexPath].date
            vc.time = self.eventData[indexPath].time
            vc.fulldescription = self.eventData[indexPath].datumDescription
            vc.website = self.eventData[indexPath].website
            vc.eventYype = self.eventData[indexPath].eventType
            vc.registrationType = self.eventData[indexPath].registrationType
            vc.imgurl = String.getString(baseUrlImg + (self.self.eventData[indexPath].attachment?.attachmenturl ?? ""))
            vc.bookingUrl = self.eventData[indexPath].url
            vc.typeofpage = "read"
                    
        }
    
    eventTableCell.callVisitCallback = { index in
        
        let vc = self.pushViewController(withName: CreateEventViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! CreateEventViewController
        vc.hostname = self.eventData[indexPath].hostName
        vc.eventname = self.eventData[indexPath].eventName
        vc.location = self.eventData[indexPath].location
        vc.date = self.eventData[indexPath].date
        vc.time = self.eventData[indexPath].time
        vc.fulldescription = self.eventData[indexPath].datumDescription
        vc.website = self.eventData[indexPath].website
        vc.eventYype = self.eventData[indexPath].eventType
        vc.registrationType = self.eventData[indexPath].registrationType
        vc.imgurl = String.getString(baseUrlImg + (self.eventData[indexPath].attachment?.attachmenturl ?? ""))
        vc.bookingUrl = self.eventData[indexPath].url
        vc.typeofpage = "read"
        
    }
        
        return eventTableCell
        
    }
 
//
//    func getcurrentdateWithTime(timeStamp :String?) -> String {
//       // let time = Double.getDouble(timeStamp) / 1000
//       // let date = Date(timeIntervalSince1970: time)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .short
//        dateFormatter.timeZone = .current
//        dateFormatter.dateFormat = "yyyy-MMM-dd"
//        dateFormatter.locale =  Locale(identifier:  "en")
//        let localDate = dateFormatter.date(from: timeStamp ?? "")
//
//        return "\(localDate ?? Date())"
//
//    }
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

        let indexPath = indexPath.row
        
        

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
extension Date {
    static func getFormattedDate(string: String , formatter:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        let date: Date? = dateFormatterGet.date(from: "2018-02-01T19:10:04+00:00")
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }
}
