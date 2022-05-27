//
//  InquiryChatController.swift
//  Alysei
//
//  Created by Gitesh Dang on 25/05/22.
//

import UIKit

class InquiryChatController: UIViewController {
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
    override func viewDidLoad() {
        super.viewDidLoad()
        type = "new"
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
        
        if let selfUserTypeString = kSharedUserDefaults.loggedInUserModal.memberRoleId {
            if let selfUserType: UserRoles = UserRoles(rawValue: (Int(selfUserTypeString) ?? 10))  {
                self.userType = selfUserType
            }
        }
        
        if self.userType != .producer {
            self.vwNew.isHidden = true
           // openOpenedList()
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
        let notificationTableCell = tblViewNotification.dequeueReusableCell(withIdentifier: "NotificationTableCell") as! NotificationTableCell
        notificationTableCell.name.text = inquiryNewOpenModel?.dataOpen?[index].sender?.name
            return notificationTableCell
        }
        //notificationTableCell.configure()
        
       
        
       
        
    }
    
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
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
            
            
        }
    }
}
