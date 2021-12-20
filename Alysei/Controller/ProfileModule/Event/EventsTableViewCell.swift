//
//  EventsTableViewCell.swift
//  Profile Screen
//
//  Created by mac on 30/08/21.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var hostTitle: UILabel!
    @IBOutlet weak var locationTitle: UILabel!
    @IBOutlet weak var dateTitle: UILabel!
    @IBOutlet weak var timeTitle: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var btnInterested: UIButton!
    @IBOutlet weak var btnInterestedWidth: NSLayoutConstraint!
    
    var isInterested = 0
    var data : EventDatum?
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        // Initialization code
        
    }

    var btnDeleteCallback:((Int) -> Void)? = nil
    var btnEditCallback:((Int) -> Void)? = nil
    var btnMoreCallback:((Int) -> Void)? = nil
    var callInterestedCallback: ((Int) -> Void)? = nil
    var index: Int?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(_ data: EventDatum){
      
        self.data = data
        
    }
    @IBAction func btnDeleteAction(_ sender: UIButton){
        btnDeleteCallback?(sender.tag)
    }
    
    @IBAction func btnMoreAction(_ sender: UIButton){
        btnMoreCallback?(sender.tag)
    }
    
    @IBAction func btnEditAction(_ sender: UIButton){
        btnEditCallback?(sender.tag)
    }
    @IBAction func btnInterestedAction(_ sender: UIButton){
        self.index = sender.tag
        if isInterested == 0 {
            isInterested = 1
        }else {
            isInterested = 0
        }
        callInterestesApi(sender.tag, isInterested)
    }

}
extension EventsTableViewCell {
    
    func callInterestesApi(_ index: Int?,_ isInterested: Int?){
        
        let params: [String:Any] = [
            "like_or_unlike": isInterested ?? 0,
            "event_id": data?.eventid ?? ""
            ]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Discover.kInterestedEvent, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { dictResponse, error, errorType, statusCode in
            switch statusCode{
            case 200:
                self.btnInterested.backgroundColor = UIColor.red
                self.btnInterested.setTitle("UnInterested", for: .normal)
                self.callInterestedCallback?(index ?? -1)
            default:
                print("Error")
            }
           
        }
    }
}
