//
//  New Chat.swift
//  Alysei
//
//  Created by Gitesh Dang on 24/08/21.
//

import UIKit
 
class NewChat: AlysieBaseViewC {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewNavigation: UIView!
    @IBOutlet weak var blankview: UIView!
    @IBOutlet weak var lblheading: UILabel!
    @IBOutlet weak var lblBlankView: UILabel!
    
    var connection:ConnectionTabModel?
    var arrConnection =  [Datum]()
    var indexOfPageToRequest = 1
    var lastPage: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.blankview.isHidden = true
        
        callConnectionApi()
        // Do any additional setup after loading the view.
    }
       
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblheading.text = AppConstants.kNewChat
        lblBlankView.text = AppConstants.kThereIsNoNewChat
    }
      
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      self.viewNavigation.drawBottomShadow()
    }
    
    @IBAction func tapBack(_ sender: UIButton) {
      
      self.navigationController?.popViewController(animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height - (self.view.frame.height * 2) {
            if indexOfPageToRequest > lastPage ?? 0{
                print("No Data")
            }else{
            // increments the number of the page to request
                self.indexOfPageToRequest += 1

                callConnectionApi()

            // tell the table view to reload with the new data
            self.tblView.reloadData()
            }
        }
    }

    private func getTableCell(index: Int) -> UITableViewCell{
    
        let notificationTableCell = tblView.dequeueReusableCell(withIdentifier: "NotificationTableCell") as! NotificationTableCell
        
        let baseUrlImg = self.arrConnection[index].user?.avatarID?.baseUrl ?? ""
        
        if arrConnection[index].user?.companyName != "" {
            notificationTableCell.name.text = arrConnection[index].user?.companyName
        } else if arrConnection[index].user?.firstname != ""{
            notificationTableCell.name.text = (arrConnection[index].user!.firstname) + " " + (arrConnection[index].user!.lastname)
        } else {
            notificationTableCell.name.text = arrConnection[index].user?.restaurantName
        }
        
        if arrConnection[index].user?.roleID == UserRoles.producer.rawValue{
            notificationTableCell.userNickName.text = "Producer,"
            notificationTableCell.message.isHidden = false
        }else if arrConnection[index].user?.roleID == UserRoles.restaurant.rawValue{
            notificationTableCell.message.isHidden = false
            notificationTableCell.userNickName.text = "Restaurant,"
        }else if arrConnection[index].user?.roleID == UserRoles.voyagers.rawValue {
            
            notificationTableCell.userNickName.text = "Voyager"
            notificationTableCell.message.isHidden = true
        }else if arrConnection[index].user?.roleID == UserRoles.voiceExperts.rawValue{
            notificationTableCell.message.isHidden = false
            notificationTableCell.userNickName.text = "Voice Of Experts,"
        }else if arrConnection[index].user?.roleID == UserRoles.distributer1.rawValue {
            notificationTableCell.message.isHidden = false
            notificationTableCell.userNickName.text = "Importer,"
        }else if arrConnection[index].user?.roleID == UserRoles.distributer2.rawValue{
            notificationTableCell.message.isHidden = false
            notificationTableCell.userNickName.text = "Distributer,"
        }else if arrConnection[index].user?.roleID == UserRoles.distributer3.rawValue{
            notificationTableCell.message.isHidden = false
            notificationTableCell.userNickName.text = "Importer & Distributer,"
        }else if arrConnection[index].user?.roleID == UserRoles.travelAgencies.rawValue{
            notificationTableCell.message.isHidden = false
            notificationTableCell.userNickName.text = "Travel Agencies,"
        }
        
        
        notificationTableCell.message.text = String.getString(arrConnection[index].user?.followers_count)+" Followers"
        
        notificationTableCell.imgViewNotification.layer.masksToBounds = false
        notificationTableCell.imgViewNotification.clipsToBounds = true
        notificationTableCell.imgViewNotification.layer.cornerRadius = notificationTableCell.imgViewNotification.frame.width/2
        
        if self.arrConnection[index].user?.avatarID?.attachmentURL != nil {
            notificationTableCell.imgViewNotification.setImage(withString: String.getString(baseUrlImg+(self.arrConnection[index].user?.avatarID?.attachmentURL)! ?? ""), placeholder: UIImage(named: "image_placeholder"))
        }
        
        
        
        return notificationTableCell
        
    }
    
    func callConnectionApi(){
        
        self.arrConnection.removeAll()
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kConnectionTabApi, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
           
            let dictResponse = dictResponse as? [String:Any]
            // let response = dictResponse["data"] as? [String:Any]
            
             if let data = dictResponse?["data"] as? [String:Any]{
                 self.lastPage = data["last_page"] as? Int
                 self.connection = ConnectionTabModel.init(with: data)
                 if self.indexOfPageToRequest == 1 {self.arrConnection.removeAll()}
                 self.arrConnection.append(contentsOf: self.connection?.data ?? [Datum(with: [:])])
             }
            
             if self.arrConnection.count > 0 {
                 self.blankview.isHidden = true
             } else {
                 self.blankview.isHidden = false
             }
            
            self.tblView.reloadData()
        }
    }
   

}

extension NewChat: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrConnection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.getTableCell(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = pushViewController(withName: ConversationViewController.id(), fromStoryboard: StoryBoardConstants.kChat) as! ConversationViewController
        
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        //vc.receiverDetails = self.ResentUser?[indexPath.row]
        vc.userId  = String.getString(self.arrConnection[indexPath.row].user?.userID)
        
        
        let baseUrlImg = self.arrConnection[indexPath.row].user?.avatarID?.baseUrl ?? ""
        
        if arrConnection[indexPath.row].user?.companyName != "" {
            vc.name = arrConnection[indexPath.row].user?.companyName
        } else if arrConnection[indexPath.row].user?.firstname != ""{
            vc.name = (arrConnection[indexPath.row].user!.firstname)+" "+(arrConnection[indexPath.row].user!.lastname)
        } else {
            vc.name = arrConnection[indexPath.row].user?.restaurantName
        }
        if self.arrConnection[indexPath.row].user?.avatarID?.attachmentURL != nil {
            vc.profileImageUrl = baseUrlImg+(self.arrConnection[indexPath.row].user?.avatarID?.attachmentURL)! ?? ""
        }
        
   
    }
    
}
