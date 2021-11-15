//
//  InquiryChatVC.swift
//  Alysei
//
//  Created by Gitesh Dang on 11/8/21.
//

import UIKit
import Firebase
import FirebaseDatabase

class InquiryChatVC: AlysieBaseViewC {
    @IBOutlet weak var vwNew: UIView!
    @IBOutlet weak var vwOpened: UIView!
    @IBOutlet weak var vwClosed: UIView!
    @IBOutlet weak var vwBottomNew: UIView!
    @IBOutlet weak var vwBottomOpened: UIView!
    @IBOutlet weak var vwBottomClosed: UIView!
    @IBOutlet weak var lblNew: UILabel!
    @IBOutlet weak var lblOpened: UILabel!
    @IBOutlet weak var lblClosed: UILabel!
    @IBOutlet weak var tblViewNotification: UITableView!
    var type : String?
    
    var ResentUser:[InquiryRecentUser]?
    var resentReference     = Database.database().reference().child("Inquiry").child(Parameters.ResentMessage)

    override func viewDidLoad() {
        super.viewDidLoad()

        let newTap = UITapGestureRecognizer.init(target: self, action: #selector(openNewChatList))
        self.vwNew.addGestureRecognizer(newTap)
        
        let openTap = UITapGestureRecognizer.init(target: self, action: #selector(openOpenedList))
        self.vwOpened.addGestureRecognizer(openTap)
        
        let closeTap = UITapGestureRecognizer.init(target: self, action: #selector(openClosedList))
        self.vwClosed.addGestureRecognizer(closeTap)
        // Do any additional setup after loading the view.
        
        tblViewNotification.dataSource = self
        tblViewNotification.delegate = self
        receiveUsers(child: "New")
        type = "New"
    }
    
    @objc func openNewChatList(){
        lblNew.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        lblOpened.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
        lblClosed.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
      
        vwBottomNew.layer.backgroundColor = UIColor.init(hexString: "009A9E").cgColor
        vwBottomOpened.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        vwBottomClosed.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        self.ResentUser?.removeAll()
        self.tblViewNotification.reloadData()
        receiveUsers(child: "New")
        type = "New"
    }
    @objc func openOpenedList(){
        lblNew.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
        lblOpened.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        lblClosed.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
        vwBottomNew.layer.backgroundColor =  UIColor.lightGray.withAlphaComponent(0.5).cgColor
        vwBottomOpened.layer.backgroundColor = UIColor.init(hexString: "009A9E").cgColor
        vwBottomClosed.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        self.ResentUser?.removeAll()
        self.tblViewNotification.reloadData()
        receiveUsers(child: "Opened")
        type = "Opened"
    }
    @objc func openClosedList(){
        lblNew.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
        lblOpened.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
        lblClosed.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        vwBottomNew.layer.backgroundColor =  UIColor.lightGray.withAlphaComponent(0.5).cgColor
        vwBottomOpened.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        vwBottomClosed.layer.backgroundColor = UIColor.init(hexString: "009A9E").cgColor
        self.ResentUser?.removeAll()
        self.tblViewNotification.reloadData()
        receiveUsers(child: "Closed")
        type = "Closed"
    }
    
    @IBAction func btnBackAction(_ sender: UIButton){
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func receiveUsers(child: String) {
        
        kChatharedInstance.inquiry_receiveResentUsers(userid:String.getString(kSharedUserDefaults.loggedInUserModal.userId), child: child) { (users) in
            self.ResentUser?.removeAll()
            self.ResentUser = users
            self.tblViewNotification.reloadData()
        }
        
    }
    
    private func getNotificationTableCell(index: Int) -> UITableViewCell{
    
        let notificationTableCell = tblViewNotification.dequeueReusableCell(withIdentifier: "NotificationTableCell") as! NotificationTableCell
        //notificationTableCell.configure()
        
        let timeInterval  = ResentUser![index].timestamp
        
        let dateString = getcurrentdateWithTime(timeStamp: String.getString(timeInterval))
        print("formatted date is =  \(dateString)")
                
        notificationTableCell.name.text = ResentUser![index].otherName
        notificationTableCell.time.text = dateString
        
        if ResentUser![index].mediaType == "photos" {
            notificationTableCell.photo.constant = 20
            notificationTableCell.message.text = "  Photo"
        } else {
            notificationTableCell.photo.constant = 0
            notificationTableCell.message.text = ResentUser![index].lastmessage
        }
        
        notificationTableCell.count.layer.cornerRadius = 15
        
        if ResentUser![index].readCount != 0 {
            notificationTableCell.count.isHidden = false
            notificationTableCell.count.setTitle(String.getString(ResentUser![index].readCount), for: .normal)
            notificationTableCell.message.textColor = UIColor.init(red: 51/255.0, green: 163/255.0, blue: 134/255.0, alpha: 1.0)
        } else {
            notificationTableCell.count.isHidden = true
            notificationTableCell.message.textColor = UIColor.gray
        }
        
        notificationTableCell.imgViewNotification.layer.masksToBounds = false
        notificationTableCell.imgViewNotification.clipsToBounds = true
        notificationTableCell.imgViewNotification.layer.cornerRadius = notificationTableCell.imgViewNotification.frame.width/2

        
        
        if String.getString(self.ResentUser?[index].otherImage ?? "").contains(imageDomain) {
            notificationTableCell.imgViewNotification.setImage(withString: String.getString(self.ResentUser?[index].otherImage ?? ""), placeholder: UIImage(named: "image_placeholder"))
        } else {
            let img = (imageDomain+"/"+String.getString(self.ResentUser?[index].otherImage ?? ""))
            notificationTableCell.imgViewNotification.setImage(withString: img.replacingOccurrences(of: "//", with: "/"), placeholder: UIImage(named: "image_placeholder"))
        }
        
       // notificationTableCell.imgViewNotification.setImage(withString: String.getString(self.ResentUser?[index].otherImage ?? ""), placeholder: UIImage(named: "image_placeholder"))
        
        return notificationTableCell
        
    }
    
    func getcurrentdateWithTime(timeStamp :String?) -> String {
        let time = Double.getDouble(timeStamp) / 1000
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "dd MMM YYYY"
        dateFormatter.locale =  Locale(identifier:  "en")
        let localDate = dateFormatter.string(from: date)
        
        let units = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second, .weekOfYear])
            let components = Calendar.current.dateComponents(units, from: date, to: Date())

            if components.year! > 0 {
                return "\(components.year!) " + (components.year! > 1 ? "years ago" : "year ago")

            } else if components.month! > 0 {
                return "\(components.month!) " + (components.month! > 1 ? "months ago" : "month ago")

            } else if components.weekOfYear! > 0 {
                return "\(components.weekOfYear!) " + (components.weekOfYear! > 1 ? "weeks ago" : "week ago")

            } else if (components.day! > 0) {
                return (components.day! > 1 ? "\(String.getString(localDate))" : "Yesterday")

            } else if components.hour! > 0 {
                return "\(components.hour!) " + (components.hour! > 1 ? "hours ago" : "hour ago")

            } else if components.minute! > 0 {
                return "\(components.minute!) " + (components.minute! > 1 ? "minutes ago" : "minute ago")

            } else {
                return "\(components.second!) " + (components.second! > 1 ? "seconds ago" : "second ago")
            }
        
    }

}

extension InquiryChatVC: UITableViewDataSource, UITableViewDelegate{
        
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.ResentUser?.count ?? 0
  }
        
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return self.getNotificationTableCell(index: indexPath.row)
  }
        
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80.0
  }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // if type == "New" {
            let receiverDetails = [ Parameters.uid : String.getString(self.ResentUser?[indexPath.row].uid),
                                    Parameters.otherId : String.getString(self.ResentUser?[indexPath.row].otherId),
                                    Parameters.lastmessage : String.getString(self.ResentUser?[indexPath.row].lastmessage),
                                    Parameters.mediaType    : String.getString(self.ResentUser?[indexPath.row].mediaType) ,
                                    Parameters.timeStamp : String.getString(self.ResentUser?[indexPath.row].timestamp),
                                    Parameters.otherImage : String.getString(self.ResentUser?[indexPath.row].otherImage) ,
                                    Parameters.otherName : String.getString(self.ResentUser?[indexPath.row].otherName),
                                    Parameters.readCount : 0,
                                    Parameters.userTyping : false] as [String : Any]
            
            resentReference.child("New").child("user_\(String.getString(kSharedUserDefaults.loggedInUserModal.userId))").child("user_\(String.getString(self.ResentUser?[indexPath.row].otherId))").updateChildValues(receiverDetails)
            
            
            
       // }
        
        
        
        let vc = pushViewController(withName: InquiryConversation.id(), fromStoryboard: StoryBoardConstants.kChat) as! InquiryConversation
       // let vc = storyboard?.instantiateViewController(withIdentifier: "ConversationViewController") as!  ConversationViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        //vc.receiverDetails = self.ResentUser?[indexPath.row]
        vc.userId = self.ResentUser?[indexPath.row].otherId
        vc.name = self.ResentUser?[indexPath.row].otherName
        vc.profileImageUrl = imageDomain+"/"+String.getString(self.ResentUser?[indexPath.row].otherImage ?? "")
        
        if String.getString(self.ResentUser?[indexPath.row].otherImage ?? "").contains(imageDomain) {
            vc.profileImageUrl = String.getString(self.ResentUser?[indexPath.row].otherImage ?? "")
            
        } else {
            var img = ("/"+String.getString(self.ResentUser?[indexPath.row].otherImage ?? ""))
            img = img.replacingOccurrences(of: "//", with: "/")
            
            vc.profileImageUrl = imageDomain+img
        }
        
        vc.storeId = self.ResentUser?[indexPath.row].storeId ?? ""
        vc.storeName = self.ResentUser?[indexPath.row].storeName ?? ""
        vc.productName = self.ResentUser?[indexPath.row].productName ?? ""
        vc.productId = self.ResentUser?[indexPath.row].productId ?? ""
        vc.productImage = self.ResentUser?[indexPath.row].productImage ?? ""
        //self.present(vc , animated: true)
    }
        
}
