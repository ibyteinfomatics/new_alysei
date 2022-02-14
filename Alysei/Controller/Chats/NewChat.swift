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
    var connection:ConnectionTabModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.blankview.isHidden = true
        callConnectionApi()
        // Do any additional setup after loading the view.
    }
       
    
      
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      self.viewNavigation.drawBottomShadow()
    }
    
    @IBAction func tapBack(_ sender: UIButton) {
      
      self.navigationController?.popViewController(animated: true)
    }

    private func getTableCell(index: Int) -> UITableViewCell{
    
        let notificationTableCell = tblView.dequeueReusableCell(withIdentifier: "NotificationTableCell") as! NotificationTableCell
        
        let baseUrlImg = self.connection?.data?[index].user?.avatarID?.baseUrl ?? ""
        
        if connection?.data?[index].user?.companyName != "" {
            notificationTableCell.name.text = connection?.data?[index].user?.companyName
        } else if connection?.data?[index].user?.firstname != ""{
            notificationTableCell.name.text = (connection?.data?[index].user!.firstname)!+" "+(connection?.data?[index].user!.lastname)!
        } else {
            notificationTableCell.name.text = connection?.data?[index].user?.restaurantName
        }
        
        if connection?.data?[index].user?.roleID == UserRoles.producer.rawValue{
            notificationTableCell.userNickName.text = "Producer,"//modelData.subjectId?.email?.lowercased()
            notificationTableCell.message.isHidden = false
        }else if connection?.data?[index].user?.roleID == UserRoles.restaurant.rawValue{
            notificationTableCell.message.isHidden = false
            notificationTableCell.userNickName.text = "Restaurant,"//modelData.subjectId?.email?.lowercased()
        }else if connection?.data?[index].user?.roleID == UserRoles.voyagers.rawValue {
            
            notificationTableCell.userNickName.text = "Voyager"//modelData.subjectId?.email?.lowercased()
            notificationTableCell.message.isHidden = true
        }else if connection?.data?[index].user?.roleID == UserRoles.voiceExperts.rawValue{
            notificationTableCell.message.isHidden = false
            notificationTableCell.userNickName.text = "Voice Of Experts,"//modelData.subjectId?.email?.lowercased()
        }else if connection?.data?[index].user?.roleID == UserRoles.distributer1.rawValue {
            notificationTableCell.message.isHidden = false
            notificationTableCell.userNickName.text = "Importer,"//modelData.subjectId?.email?.lowercased()
        }else if connection?.data?[index].user?.roleID == UserRoles.distributer2.rawValue{
            notificationTableCell.message.isHidden = false
            notificationTableCell.userNickName.text = "Distributer,"//modelData.subjectId?.email?.lowercased()
        }else if connection?.data?[index].user?.roleID == UserRoles.distributer3.rawValue{
            notificationTableCell.message.isHidden = false
            notificationTableCell.userNickName.text = "Importer & Distributer,"//modelData.subjectId?.email?.lowercased()
        }else if connection?.data?[index].user?.roleID == UserRoles.travelAgencies.rawValue{
            notificationTableCell.message.isHidden = false
            notificationTableCell.userNickName.text = "Travel Agencies,"//modelData.subjectId?.email?.lowercased()
        }
        
        
        notificationTableCell.message.text = String.getString(connection?.data?[index].user?.followers_count)+" Followers"
        
        notificationTableCell.imgViewNotification.layer.masksToBounds = false
        notificationTableCell.imgViewNotification.clipsToBounds = true
        notificationTableCell.imgViewNotification.layer.cornerRadius = notificationTableCell.imgViewNotification.frame.width/2
        
        if self.connection?.data?[index].user?.avatarID?.attachmentURL != nil {
            notificationTableCell.imgViewNotification.setImage(withString: String.getString(baseUrlImg+(self.connection?.data?[index].user?.avatarID?.attachmentURL)! ?? ""), placeholder: UIImage(named: "image_placeholder"))
        }
        
        
        
        return notificationTableCell
        
    }
    
    func callConnectionApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kConnectionTabApi, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
           
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [[String:Any]]{
                self.connection = ConnectionTabModel.init(with: dictResponse)
                
            }
            
            if self.connection?.data?.count ?? 0 <= 0 {
                self.blankview.isHidden = false
            }
            
            self.tblView.reloadData()
        }
    }
   

}

extension NewChat: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.connection?.data?.count ?? 0
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
        vc.userId  = String.getString(self.connection?.data?[indexPath.row].user?.userID)
        
        
        let baseUrlImg = self.connection?.data?[indexPath.row].user?.avatarID?.baseUrl ?? ""
        
        if connection?.data?[indexPath.row].user?.companyName != "" {
            vc.name = connection?.data?[indexPath.row].user?.companyName
        } else if connection?.data?[indexPath.row].user?.firstname != ""{
            vc.name = (connection?.data?[indexPath.row].user!.firstname)!+" "+(connection?.data?[indexPath.row].user!.lastname)!
        } else {
            vc.name = connection?.data?[indexPath.row].user?.restaurantName
        }
        if self.connection?.data?[indexPath.row].user?.avatarID?.attachmentURL != nil {
            vc.profileImageUrl = baseUrlImg+(self.connection?.data?[indexPath.row].user?.avatarID?.attachmentURL)! ?? ""
        }
        
   
    }
    
}
