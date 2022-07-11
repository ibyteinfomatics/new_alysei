//
//  EventsViewController.swift
//  Profile Screen
//
//  Created by mac on 30/08/21.
//

import UIKit


class EventsView: AlysieBaseViewC {
    @IBOutlet weak var myEventsLabel: UILabel!
    @IBOutlet weak var createEventButton: UIButton!
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var vwBlank: UIView!
    @IBOutlet weak var lblBlank: UILabel!
    
    var eventModel:EventModel?
    var userId: String?
    var hostname,location,website:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblBlank.text = AppConstants.kThereAreNoEventsAtThisMoment
        myEventsLabel.text = AppConstants.kMyEvents
        createEventButton.setTitle(AppConstants.kCreateEvents, for: .normal)
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        createEventButton.layer.cornerRadius = 18
       
    }
    
    func setUI(){
        if self.eventModel?.data?.count ?? 0 == 0{
            self.vwBlank.isHidden = false
        }else{
            self.vwBlank.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if userId != ""{
            createEventButton.isHidden = true
        } else {
            createEventButton.isHidden = false
        }
        postRequest()
    }
    
    @IBAction func create(_ sender: UIButton) {
        check = "create"
        let vc = self.pushViewController(withName: CreateEventViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! CreateEventViewController
        vc.hostname = hostname
        vc.location = location
        vc.website = website
      
    }
    
    private func getEventTableCell(_ indexPath: Int) -> UITableViewCell{
        
        let eventTableCell = eventsTableView.dequeueReusableCell(withIdentifier: EventsTableViewCell.identifier()) as! EventsTableViewCell
        if (self.userId ?? "") == kSharedUserDefaults.loggedInUserModal.userId {
            eventTableCell.btnInterested.isHidden = true
        }else{
            eventTableCell.btnInterested.isHidden = false
        }
        eventTableCell.moreButton.setTitle(AppConstants.kMoreInfo, for: .normal)
        if eventModel?.data?[indexPath].is_event_liked?.count == 0{
            eventTableCell.btnInterestedWidth.constant = 180
            eventTableCell.btnInterested.backgroundColor = UIColor.init(hexString: "37A282")
            eventTableCell.btnInterested.setTitle(AppConstants.kAreyouInterested, for: .normal)
        }else{
            eventTableCell.btnInterested.backgroundColor = UIColor.red
            eventTableCell.btnInterested.setTitle(AppConstants.kUninterested, for: .normal)
        }
        eventTableCell.eventTitle.text = eventModel?.data?[indexPath].eventName
        eventTableCell.hostTitle.text = eventModel?.data?[indexPath].hostName
        eventTableCell.locationTitle.text = eventModel?.data?[indexPath].datumDescription
      //  eventTableCell.dateTitle.text = eventModel?.data?[indexPath].date
        
        let imageUrl = (eventModel?.data?[indexPath].user?.avatarid?.baseUrl ?? "") + (eventModel?.data?[indexPath].user?.avatarid?.attachmenturl ?? "")
        eventTableCell.userImage.setImage(withString: imageUrl)
        
        eventTableCell.userImage.layer.cornerRadius =  eventTableCell.userImage.frame.height / 2
        eventTableCell.userImage.layer.masksToBounds = true
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        let date: Date? = dateFormatterGet.date(from: eventModel?.data?[indexPath].createdAt ?? "")
        print("Date",dateFormatterPrint.string(from: date ?? Date())) // Feb 01,2018
        let datep = dateFormatterPrint.string(from: date ?? Date())
        eventTableCell.dateTitle.text = datep
        eventTableCell.data = eventModel?.data?[indexPath]
        
        eventTableCell.moreButton.layer.cornerRadius =  eventTableCell.moreButton.frame.height / 2
        
        eventTableCell.editButton.tag = indexPath
        eventTableCell.deleteButton.tag = indexPath
        eventTableCell.moreButton.tag = indexPath
        eventTableCell.callInterestedCallback = { index in
            let reloadIndexPath = IndexPath(row: index, section: 0)
            self.postRequest()
            self.eventsTableView.reloadRows(at: [reloadIndexPath], with: .automatic)
        }
        if userId != ""{
            eventTableCell.deleteButton.isHidden = true
            eventTableCell.editButton.isHidden = true
            eventTableCell.btnInterested.isHidden = false
        } else {
            eventTableCell.deleteButton.isHidden = false
            eventTableCell.editButton.isHidden = false
            eventTableCell.btnInterested.isHidden = true
        }
        
        eventTableCell.btnDeleteCallback = { tag in
          
            
            //MARK:show Alert Message
            let refreshAlert = UIAlertController(title: "", message: AppConstants.kAreYouSureYouWantToDeleteThisEvent, preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: MarketPlaceConstant.kYes, style: .default, handler: { (action: UIAlertAction!) in
               
                self.disableWindowInteraction()
              
                TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kDeleteEvent+"\(self.eventModel?.data?[indexPath].eventid ?? 0)", requestMethod: .POST, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
                    
                    self.postRequest()
                }
            }))
            refreshAlert.addAction(UIAlertAction(title: MarketPlaceConstant.kNo, style: .cancel, handler: { (action: UIAlertAction!) in
                  
                self.parent?.dismiss(animated: true, completion: nil)
            }))
            //let parent = self.parentViewController?.presentedViewController as? HubsListVC
            self.parent?.present(refreshAlert, animated: true, completion: nil)
            
        }
        
        eventTableCell.btnMoreCallback = { tag in
            check = "show"
            let vc = self.pushViewController(withName: CreateEventViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! CreateEventViewController
            vc.hostname = self.eventModel?.data?[indexPath].hostName
            vc.eventname = self.eventModel?.data?[indexPath].eventName
            vc.location = self.eventModel?.data?[indexPath].datumDescription
            vc.date = self.eventModel?.data?[indexPath].date
            vc.time = self.eventModel?.data?[indexPath].time
            vc.fulldescription = self.eventModel?.data?[indexPath].datumDescription
            vc.website = self.eventModel?.data?[indexPath].website
            vc.eventYype = self.eventModel?.data?[indexPath].eventType
            vc.registrationType = self.eventModel?.data?[indexPath].registrationType
            vc.imgurl = String.getString((self.eventModel?.data?[indexPath].attachment?.baseUrl ?? "")+(self.eventModel?.data?[indexPath].attachment?.attachmenThumbnailUrl ?? ""))
            vc.bookingUrl = self.eventModel?.data?[indexPath].url
            vc.typeofpage = "read"
            
        }
        
        eventTableCell.btnEditCallback = { tag in
            check = "show"
            let vc = self.pushViewController(withName: CreateEventViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! CreateEventViewController
            vc.hostname = self.eventModel?.data?[indexPath].hostName
            vc.eventname = self.eventModel?.data?[indexPath].eventName
            vc.location = self.eventModel?.data?[indexPath].location
            vc.date = self.eventModel?.data?[indexPath].date
            vc.time = self.eventModel?.data?[indexPath].time
            vc.fulldescription = self.eventModel?.data?[indexPath].datumDescription
            vc.website = self.eventModel?.data?[indexPath].website
            vc.eventYype = self.eventModel?.data?[indexPath].eventType
            vc.registrationType = self.eventModel?.data?[indexPath].registrationType
            vc.imgurl = String.getString((self.eventModel?.data?[indexPath].attachment?.baseUrl ?? "")+(self.eventModel?.data?[indexPath].attachment?.attachmenturl ?? ""))
            vc.event_id = self.eventModel?.data?[indexPath].eventid
            vc.typeofpage = "edit"
            
        }
        
//        eventTableCell.eventImage.layer.masksToBounds = false
//        eventTableCell.eventImage.clipsToBounds = true
//        eventTableCell.eventImage.layer.cornerRadius = 5
        
        eventTableCell.eventImage.setImage(withString: String.getString((eventModel?.data?[indexPath].attachment?.baseUrl ?? "")+(eventModel?.data?[indexPath].attachment?.attachmenturl ?? "")), placeholder: UIImage(named: "image_placeholder"))
        
        return eventTableCell
        
    }
    
    private func postRequest() -> Void{
      
      disableWindowInteraction()
    
      TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetEventListing+"\(userId!)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
          let dictResponse = dictResponse as? [String:Any]
          
          self.eventModel = EventModel.init(with: dictResponse)
        
          self.myEventsLabel.text = AppConstants.kMyEvents + " " + "(\(self.eventModel?.data?.count ?? 0))"
        self.setUI()
        self.eventsTableView.reloadData()
      }
      
    }
    func getcurrentdateWithTime(timeStamp :String?) -> String {
            let time = Double.getDouble(timeStamp) /// 1000
            let date = Date(timeIntervalSince1970: time)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeZone = .current
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.locale =  Locale(identifier:  "en")
            let localDate = dateFormatter.string(from: date)
            
            return localDate
            
        }
    
}

extension EventsView: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        return self.getEventTableCell(indexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("index--- ",indexPath.row)
    }
    
}
