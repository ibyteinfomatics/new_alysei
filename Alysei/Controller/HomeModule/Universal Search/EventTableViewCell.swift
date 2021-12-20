//
//  EventsTableViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 18/11/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var hostTitle: UILabel!
    @IBOutlet weak var locationTitle: UILabel!
    @IBOutlet weak var dateTitle: UILabel!
    @IBOutlet weak var timeTitle: UILabel!
    @IBOutlet weak var noItemLabel: UILabel!
    @IBOutlet weak var btnVisit: UIButton!
    
    @IBOutlet weak var mainVw: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var btnInterested: UIButton!
    @IBOutlet weak var btnInterestedWidth: NSLayoutConstraint!
    
    var isInterested: Int?
    var callInterestedCallback: ((Int) -> Void)? = nil
    var callVisitCallback: ((Int) -> Void)? = nil
    var data : EventDatum?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImage.layer.cornerRadius = self.userImage.frame.height / 2
        btnVisit.layer.cornerRadius = self.btnVisit.frame.height / 2
        btnVisit.layer.masksToBounds = true
        // Initialization code
        
    }
    func configCell(_ data: EventDatum){
      
        self.data = data
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnInterestedAction(_ sender: UIButton){
        if data?.is_event_liked?.count == 0 {
            isInterested = 1
        }else {
            isInterested = 0
        }
        callInterestesApi(sender.tag, isInterested)
    }
    
    @IBAction func btnVisit(_ sender: UIButton){
        callVisitCallback?(data?.eventid ?? 0)
    }
}
extension EventTableViewCell {
    
    func callInterestesApi(_ index: Int?,_ isInterested: Int?){
        
        let params: [String:Any] = [
            "like_or_unlike": isInterested ?? 0,
            "event_id": data?.eventid ?? ""
            ]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Discover.kInterestedEvent, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { dictResponse, error, errorType, statusCode in
            switch statusCode{
            case 200:
                
                self.callInterestedCallback?(index ?? -1)
            default:
                print("Error")
            }
           
        }
    }
}
