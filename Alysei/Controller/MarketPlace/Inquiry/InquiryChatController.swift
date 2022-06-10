//
//  InquiryChatController.swift
//  Alysei
//
//  Created by Gitesh Dang on 25/05/22.
//

import UIKit
import CoreMIDI

class InquiryChatController: AlysieBaseViewC {
    @IBOutlet weak var vwNew: UIView!
    @IBOutlet weak var vwOpened: UIView!
    @IBOutlet weak var vwClosed: UIView!
    @IBOutlet weak var vwBottomNew: UIView!
    @IBOutlet weak var vwBottomOpened: UIView!
    @IBOutlet weak var vwBottomClosed: UIView!
    @IBOutlet weak var lblNew: UILabel!
    @IBOutlet weak var lblOpened: UILabel!
    @IBOutlet weak var lblClosed: UILabel!
    @IBOutlet weak var newCount: UILabel!
    @IBOutlet weak var openedCount: UILabel!
    @IBOutlet weak var tblViewNotification: UITableView!
    @IBOutlet weak var lblHeading: UILabel!
    
    var inquiryNewOpenModel : InquiryNewOpenModel?
    var userType: UserRoles!
    var type: String?
    
    var passProductId: String?
    var passSenderId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.producer.rawValue)"{
            type = "new"
        }else{
            type = "open"
        }
        callTabApi()
        lblHeading.text  = "Inbox"
        lblOpened.text = MarketPlaceConstant.kOpened
        lblClosed.text = MarketPlaceConstant.kClosed
        lblNew.text = MarketPlaceConstant.kNew
        
        let newTap = UITapGestureRecognizer.init(target: self, action: #selector(openNewChatList))
        self.vwNew.addGestureRecognizer(newTap)
        
        let openTap = UITapGestureRecognizer.init(target: self, action: #selector(openOpenedList))
        self.vwOpened.addGestureRecognizer(openTap)
        
        let closeTap = UITapGestureRecognizer.init(target: self, action: #selector(openClosedList))
        self.vwClosed.addGestureRecognizer(closeTap)
        
      
    }
    override func viewWillAppear(_ animated: Bool) {
        openedCount.layer.cornerRadius = 13
        openedCount.layer.masksToBounds = true
        openedCount.textColor = UIColor.white
        newCount.layer.cornerRadius = 13
        newCount.layer.masksToBounds = true
        newCount.textColor = UIColor.white
        openedCount.isHidden = true
        newCount.isHidden = true
        if let selfUserTypeString = kSharedUserDefaults.loggedInUserModal.memberRoleId {
            if let selfUserType: UserRoles = UserRoles(rawValue: (Int(selfUserTypeString) ?? 10))  {
                self.userType = selfUserType
            }
        }
        
        if self.userType != .producer {
            self.vwNew.isHidden = true
           // openOpenedList()
        }
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.producer.rawValue)" {
            openNewChatList()
        }else{
            openOpenedList()
        }
        if type == "New" {
            
        } else if type == "Opened" {
            
        } else if type == "Closed" {
            
        }
        //usercount = 0
//        print("usercount111 ",usercount)
//        self.ResentUser?.removeAll()
//        self.tblViewNotification.reloadData()
//        receiveUsers(child: String.getString(type))
//
//        self.newCount.isHidden = true
//        self.openedCount.isHidden = true
//        newInquiryCount(child: "New")
//        openedInquiryCount(child: "Opened")
    }
    
    @objc func openNewChatList(){
        lblNew.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        lblOpened.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
        lblClosed.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
      
        vwBottomNew.layer.backgroundColor = UIColor.init(hexString: "37A282").cgColor
        vwBottomOpened.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        vwBottomClosed.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
       
        type = "new"
        callTabApi()
    }
    @objc func openOpenedList(){
        lblNew.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
        lblOpened.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        lblClosed.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
        vwBottomNew.layer.backgroundColor =  UIColor.lightGray.withAlphaComponent(0.5).cgColor
        vwBottomOpened.layer.backgroundColor = UIColor.init(hexString: "37A282").cgColor
        vwBottomClosed.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
      
        type = "open"
        callTabApi()
    }
    @objc func openClosedList(){
        lblNew.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
        lblOpened.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
        lblClosed.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        vwBottomNew.layer.backgroundColor =  UIColor.lightGray.withAlphaComponent(0.5).cgColor
        vwBottomOpened.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        vwBottomClosed.layer.backgroundColor = UIColor.init(hexString: "37A282").cgColor
        
        type = "close"
        callTabApi()
    }
    
    private func getNotificationTableCell(index: Int) -> UITableViewCell{
    
        if type == "new"{
            return UITableViewCell()
        }else{
            guard let notificationTableCell = tblViewNotification.dequeueReusableCell(withIdentifier: "NotificationTableCell") as? NotificationTableCell else{return UITableViewCell()}
   //      notificationTableCell.name.text = inquiryNewOpenModel?.dataOpen?[index].receiver?.companyName
            notificationTableCell.name.text = inquiryNewOpenModel?.dataOpen?[index].receiver?.companyName
            notificationTableCell.message.text = inquiryNewOpenModel?.dataOpen?[index].message
            if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.producer.rawValue)"{
                let imageUrl = (inquiryNewOpenModel?.dataOpen?[index].sender?.profile_img?.baseUrl ?? "") + (inquiryNewOpenModel?.dataOpen?[index].sender?.profile_img?.attachmentUrl ?? "")
                notificationTableCell.imgViewNotification.setImage(withString: imageUrl, placeholder: UIImage(named: "image_placeholder"), nil)
                notificationTableCell.name.text = inquiryNewOpenModel?.dataOpen?[index].sender?.companyName
            }else{
                let imageUrl = (inquiryNewOpenModel?.dataOpen?[index].receiver?.profile_img?.baseUrl ?? "") + (inquiryNewOpenModel?.dataOpen?[index].receiver?.profile_img?.attachmentUrl ?? "")
                notificationTableCell.imgViewNotification.setImage(withString: imageUrl, placeholder: UIImage(named: "image_placeholder"), nil)
                notificationTableCell.name.text = inquiryNewOpenModel?.dataOpen?[index].receiver?.companyName
            }
          
            if inquiryNewOpenModel?.dataOpen?[index].unread_count == 0{
            notificationTableCell.count.isHidden = true
            }else{
                notificationTableCell.count.setTitle("\(inquiryNewOpenModel?.dataOpen?[index].unread_count ?? 0)", for: .normal)
                notificationTableCell.count.layer.cornerRadius = notificationTableCell.count.frame.height / 2
            }
            
            let timeInterval  = inquiryNewOpenModel?.dataOpen?[index].created_at ?? ""
            print("timeInterval----------------------",timeInterval)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "en")
            let date = dateFormatter.date(from: timeInterval)
            let newDateFormatter = DateFormatter()
            newDateFormatter.dateFormat = "HH:mm a"
            let dateString = newDateFormatter.string(from: date ?? Date())
            print("formatted date is =  \(dateString)")
            notificationTableCell.time.text = dateString
            
//            if inquiryNewOpenModel![index].mediaType == "photos" {
//                notificationTableCell.photo.constant = 20
//                notificationTableCell.message.text = "  Photo"
//            } else {
                notificationTableCell.photo.constant = 0
              //  notificationTableCell.message.text = inquiryNewOpenModel?.dataOpen?[0].me
//            }
            return notificationTableCell
        }
        //notificationTableCell.configure()
     
    }
    
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    func getcurrentdateWithTime(timeStamp :String?) -> String {
        let time = Double.getDouble(timeStamp) /// 1000
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
                return "\(components.year!) " + (components.year! > 1 ? MarketPlaceConstant.kYearsAgo : MarketPlaceConstant.kYearAgo )

            } else if components.month! > 0 {
                return "\(components.month!) " + (components.month! > 1 ? MarketPlaceConstant.kMonthsAgo : MarketPlaceConstant.kMonthAgo)

            } else if components.weekOfYear! > 0 {
                return "\(components.weekOfYear!) " + (components.weekOfYear! > 1 ? MarketPlaceConstant.kWeeksAgo : MarketPlaceConstant.kWeekAgo)

            } else if (components.day! > 0) {
                return (components.day! > 1 ? "\(String.getString(localDate))" : MarketPlaceConstant.kYesterday)

            } else if components.hour! > 0 {
                return "\(components.hour!) " + (components.hour! > 1 ? MarketPlaceConstant.kHoursAgo : MarketPlaceConstant.kHourAgo)

            } else if components.minute! > 0 {
                return "\(components.minute!) " + (components.minute! > 1 ? MarketPlaceConstant.kMinutesAgo : MarketPlaceConstant.kMinuteAgo)

            } else {
                return "\(components.second!) " + (components.second! > 1 ? MarketPlaceConstant.kSecondsAgo : MarketPlaceConstant.kSecondAgo)
            }
        
    }

}
extension InquiryChatController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == "new"{
            return 2
        }else{
        return inquiryNewOpenModel?.dataOpen?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        getNotificationTableCell(index: indexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let vc = pushViewController(withName: InquiryConverstionController.id(), fromStoryboard: StoryBoardConstants.kChat) as! InquiryConverstionController
        vc.passProductId = self.inquiryNewOpenModel?.dataOpen?[indexPath.row].product_id
        vc.passProductImageUrl = (self.inquiryNewOpenModel?.dataOpen?[indexPath.row].product?.galleries?.baseUrl ?? "") + (self.inquiryNewOpenModel?.dataOpen?[indexPath.row].product?.galleries?.attachment_url ?? "")
        vc.passProductName = self.inquiryNewOpenModel?.dataOpen?[indexPath.row].product?.title ?? ""
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.producer.rawValue)" {
            vc.passReceiverId =  "\(self.inquiryNewOpenModel?.dataOpen?[indexPath.row].sender?.userId ?? 0)"
        }else{
            vc.passReceiverId =  "\(self.inquiryNewOpenModel?.dataOpen?[indexPath.row].receiver?.userId ?? 0)"
        }
        
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
    }
}
extension InquiryChatController {
    func callTabApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.getEnquiry + "\(self.type ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { result, error, errorType, statusCode in
            
            if let result = result as? [String:Any] {
            
                if let data = result["data"] as? [String:Any]{
                self.inquiryNewOpenModel = InquiryNewOpenModel.init(with: data)
            }
              
                self.tblViewNotification.reloadData()
            }
            if self.inquiryNewOpenModel?.dataOpen?.count == 0 {
                if self.type == "open"{
                    self.openedCount.isHidden = true
                }else{
                    self.newCount.isHidden = true
                }
            }
            
            
        }
    }
}
