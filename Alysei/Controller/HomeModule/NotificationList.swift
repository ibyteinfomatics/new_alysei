//
//  NotificationList.swift
//  Alysei
//
//  Created by Gitesh Dang on 27/08/21.
//

import UIKit


class NotificationList: AlysieBaseViewC {
    
    @IBOutlet weak var tblViewNotification: UITableView!
    @IBOutlet weak var viewNavigation: UIView!
    @IBOutlet weak var blankview: UIView!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblBlankView: UILabel!
    @IBOutlet weak var btnClearAll: UIButton!
   
    
    
    var notimodel:NotificationListModel?
    var notifiacationArray = [NotiDatum]()
    var indexOfPageToRequest = 1

   
    override func viewDidLoad() {
        super.viewDidLoad()
      
        lblHeading.text = MarketPlaceConstant.kNotifications
        btnClearAll.setTitle(RecipeConstants.kClearAll, for: .normal)
        lblBlankView.text = AppConstants.kThereIsNoNotification
        blankview.isHidden = true
        postRequestToGetNotification(indexOfPageToRequest)
       
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      self.viewNavigation.drawBottomShadow()
    }
    
    @IBAction func tapBack(_ sender: UIButton) {
      self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnClearAllNotification(_ sender: UIButton){
        postRequestClearNotification()
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height - (self.view.frame.height * 2) {
            if indexOfPageToRequest > notimodel?.data?.lastPage ?? 0{
                print("No Data")
            }else{
            // increments the number of the page to request
            indexOfPageToRequest += 1

            // call your API for more data
                postRequestToGetNotification(indexOfPageToRequest)

            // tell the table view to reload with the new data
            self.tblViewNotification.reloadData()
            }
        }
    }
    private func getTableCell(index: Int) -> UITableViewCell{
    
        let notificationTableCell = tblViewNotification.dequeueReusableCell(withIdentifier: "NotificationTableCell") as! NotificationTableCell
        
        //notificationTableCell.configure()
        
        //let dfmatter = DateFormatter()
        //dfmatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
       // let date = dfmatter.date(from: String.getString(notifiacationArray[index].postedAt))
       // let dateStamp:TimeInterval = date!.timeIntervalSince1970
      //  let dateSt:Int = Int(dateStamp)
        
        let postedAt = String.getString(notifiacationArray[index].postedAt)
        
        //let timeInterval  = notimodel?.data?.data?[index].createdAt
        notificationTableCell.imgViewNotification.layer.cornerRadius = notificationTableCell.imgViewNotification.layer.frame.height / 2
        notificationTableCell.layer.masksToBounds = true
        
        let baseUrl = notifiacationArray[index].user?.base_url ?? ""
        notificationTableCell.imgViewNotification.setImage(withString: String.getString(baseUrl + (notifiacationArray[index].user?.avatar_image ?? "")), placeholder: UIImage(named: "NotiLogo"))
        
        //let dateString = getcurrentdateWithTime(timeStamp: String.getString(dateSt))
       // print("formatted date is =  \(dateString)")
        
        notificationTableCell.message.text = postedAt
        notificationTableCell.name.text = (notifiacationArray[index].sender_name ?? "") + " " + (notifiacationArray[index].title ?? "")
       
        return notificationTableCell
        
    }
    
    func getcurrentdateWithTime(timeStamp :String?) -> String {
        let time = Double.getDouble(timeStamp)
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
            return "\(components.year!) " + (components.year! > 1 ? MarketPlaceConstant.kYearsAgo :  MarketPlaceConstant.kYearAgo)

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
    private func postRequestClearNotification(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.clearAllNotification, requestMethod: .POST, requestParameters: [:], withProgressHUD: true) { result, error, errorType, statusCode in
            switch statusCode {
            case 200:
                self.notifiacationArray.removeAll()
                self.tblViewNotification.reloadData()
                    self.blankview.isHidden = false
            default:
                print("Invalid")
            }
        }
    }
    
    private func postRequestToGetNotification(_ pageNo: Int) -> Void{
      
      disableWindowInteraction()
    
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetNotificationList + "?page=\(pageNo)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
//            TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetNotificationList, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            kChatharedInstance.notificationUpdate(userID: String.getString(kSharedUserDefaults.loggedInUserModal.userId))
            
            if self.indexOfPageToRequest == 1{
                self.notifiacationArray.removeAll()
            }
          let dictResponse = dictResponse as? [String:Any]
          
          self.notimodel = NotificationListModel.init(with: dictResponse)
            for i in (0..<(self.notimodel?.data?.data?.count ?? 0)){
                self.notifiacationArray.append(self.notimodel?.data?.data?[i] ?? NotiDatum(with: [:]))
            }
        
            if self.notifiacationArray.count <= 0 {
                self.blankview.isHidden = false
            }else{
                self.tblViewNotification.isHidden = false
            }
            
          self.tblViewNotification.reloadData()
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

extension NotificationList: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifiacationArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.getTableCell(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension //+ 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // let type = notimodel?.data?.data?[indexPath.row].notificationType
        let type = notifiacationArray[indexPath.row].notificationType
        
        switch Int.getInt(type) {
        case 1:
            kSharedAppDelegate.moveChat(receiverid: String.getString(notifiacationArray[indexPath.row].redirectToid), username: String.getString(notifiacationArray[indexPath.row].sender_name))
            
        case 2,6,7,8:
            kSharedAppDelegate.moveToPost(postid: String.getString(notifiacationArray[indexPath.row].redirectToid))
            
        case 3:
            //kSharedAppDelegate.moveToNetwork(index: 0)
            
            tabBarController!.selectedIndex = 3
             networkcurrentIndex = 0
        case 4:
            //networkcurrentIndex = 1
           // tabBarController!.selectedIndex = 3
            //self.showAlert(withMessage: notifiacationArray[indexPath.row].reason ?? "", nil)
            self.showAlertWithTitle(withMessage: notifiacationArray[indexPath.row].reason ?? "", appTitle: notifiacationArray[indexPath.row].sender_name ?? "", nil)
        case 5:
            // kSharedAppDelegate.moveToNetwork(index: 3)
            tabBarController!.selectedIndex = 3
            networkcurrentIndex = 3
//            let controller = pushViewController(withName: ProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? ProfileViewC
//            controller?.userLevel = .other
//            controller?.userID = Int.getInt(notifiacationArray[indexPath.row].user?.userid)
        case 9:
            kSharedAppDelegate.moveToMemberShip()
        case 10:
            let storyboard = UIStoryboard(name: StoryBoardConstants.kChat, bundle: nil)
            guard let nextvc = storyboard.instantiateViewController(withIdentifier: "InquiryConverstionController") as? InquiryConverstionController else { return }
            
                let data = notifiacationArray[indexPath.row]
            nextvc.passProductId = "\(data.redirectToid ?? 0)"
                //nextvc?.passProductEnquiryId = "\(response?["marketplace_product_enquery_id"]  as? Int ?? 0)"
            nextvc.passProductImageUrl = data.enquiry_product_image
            nextvc.passProductName = data.enquiry_product_name
                if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.producer.rawValue)" {

                    nextvc.passReceiverId =  kSharedUserDefaults.loggedInUserModal.userId
                }else{
                    let reciverdata = data.sender_id as? Int
                    nextvc.passReceiverId =  "\(reciverdata ?? 0)"
                }
                
            self.navigationController?.pushViewController(nextvc, animated: true)
          // kSharedAppDelegate.moveInqueryChat(receiverid: String.getString(notifiacationArray[indexPath.row].redirectToid), username: String.getString(notifiacationArray[indexPath.row].sender_name))
       
        default:
            kSharedAppDelegate.pushToTabBarViewC()
    
        }
        
    }
    
}
