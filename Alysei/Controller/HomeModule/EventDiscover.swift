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
    
    var eventModel:EventModel?
    var eventId: String?
    var hostname,location,website:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsTableView.delegate = self
        eventsTableView.dataSource = self

        postRequest()
        // Do any additional setup after loading the view.
    }
    
   
    private func postRequest() -> Void{
      
      disableWindowInteraction()
    
      TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetDiscoverListing+"\(eventId!)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
          let dictResponse = dictResponse as? [String:Any]
          
          self.eventModel = EventModel.init(with: dictResponse)
        
        self.eventsTableView.reloadData()
      }
      
    }
    
    @IBAction func filterBtn(_ sender: UIButton) {
        
        
    }
    

    private func getEventTableCell(_ indexPath: Int) -> UITableViewCell{
        
        let eventTableCell = eventsTableView.dequeueReusableCell(withIdentifier: EventsTableViewCell.identifier()) as! EventsTableViewCell
        
        eventTableCell.eventTitle.text = eventModel?.data?[indexPath].eventName
        eventTableCell.hostTitle.text = eventModel?.data?[indexPath].hostName
        eventTableCell.locationTitle.text = eventModel?.data?[indexPath].location
        eventTableCell.dateTitle.text = eventModel?.data?[indexPath].date
        
        
        if ((eventModel?.data?[indexPath].time?.contains(":")) == true) {
            eventTableCell.timeTitle.text = eventModel?.data?[indexPath].time
        } else {
            eventTableCell.timeTitle.text = getcurrentdateWithTime(timeStamp: eventModel?.data?[indexPath].time)
        }
        
        eventTableCell.eventImage.layer.masksToBounds = false
        eventTableCell.eventImage.clipsToBounds = true
        eventTableCell.eventImage.layer.cornerRadius = 5
        
        eventTableCell.eventImage.setImage(withString: String.getString(kImageBaseUrl+(eventModel?.data?[indexPath].attachment?.attachmenturl)! ?? ""), placeholder: UIImage(named: "image_placeholder"))
        
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
        return eventModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        return self.getEventTableCell(indexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 189
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("index--- ",indexPath.row)
    }
    
    
    
}
