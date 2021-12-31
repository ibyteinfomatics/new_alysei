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
    
    var notimodel:NotificationListModel?
    var indexOfPageToRequest = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        let date = dfmatter.date(from: String.getString(notimodel?.data?.data?[index].createdAt))
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        let dateSt:Int = Int(dateStamp)
        
        //let timeInterval  = notimodel?.data?.data?[index].createdAt
        notificationTableCell.imgViewNotification.layer.cornerRadius = notificationTableCell.imgViewNotification.layer.frame.height / 2
        notificationTableCell.layer.masksToBounds = true
        
        let baseUrl = notimodel?.data?.data?[index].user?.base_url ?? ""
        notificationTableCell.imgViewNotification.setImage(withString: String.getString(baseUrl + (notimodel?.data?.data?[index].user?.avatar_image ?? "")), placeholder: UIImage(named: "image_placeholder"))
        
        let dateString = getcurrentdateWithTime(timeStamp: String.getString(dateSt))
        print("formatted date is =  \(dateString)")
        
        notificationTableCell.message.text = dateString
        notificationTableCell.name.text = notimodel?.data?.data?[index].title
       
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
    
    private func postRequestToGetNotification(_ pageNo: Int) -> Void{
      
      disableWindowInteraction()
    
        //TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetNotificationList + "&page=\(pageNo)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetNotificationList, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
          let dictResponse = dictResponse as? [String:Any]
          
          self.notimodel = NotificationListModel.init(with: dictResponse)
          
          self.tblViewNotification.isHidden = false
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
        return notimodel?.data?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.getTableCell(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension //+ 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let type = notimodel?.data?.data?[indexPath.row].notificationType
        
        switch Int.getInt(type) {
        case 1:
            kSharedAppDelegate.moveChat(receiverid: String.getString(notimodel?.data?.data?[indexPath.row].redirectToid), username: String.getString(notimodel?.data?.data?[indexPath.row].sender_name))
            
        case 2,6,7,8:
            kSharedAppDelegate.moveToPost(postid: String.getString(notimodel?.data?.data?[indexPath.row].redirectToid))
            
        case 3:
            kSharedAppDelegate.moveToNetwork(index: 0)
            
        case 4:
            kSharedAppDelegate.moveToNetwork(index: 1)
            
        case 5:
            kSharedAppDelegate.moveToNetwork(index: 3)
            
        case 9:
            kSharedAppDelegate.moveToMemberShip()
        case 10:
            kSharedAppDelegate.moveInqueryChat(receiverid: String.getString(notimodel?.data?.data?[indexPath.row].redirectToid), username: String.getString(notimodel?.data?.data?[indexPath.row].sender_name))
       
        default:
            kSharedAppDelegate.pushToTabBarViewC()
    
        }
        
    }
    
}
