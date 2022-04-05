//
//  RestaurantViewController.swift
//  Dashboard
//
//  Created by mac on 22/09/21.
//

import UIKit

class RestaurantViewController: AlysieBaseViewC {
    @IBOutlet weak var btnDecline: UIButton!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var reason: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var pickup: UILabel!
    @IBOutlet weak var pickupDiscount: UILabel!
    @IBOutlet weak var deliveryDiscount: UILabel!
    @IBOutlet weak var ourmenu: UILabel!
    @IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var restType: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTitle1: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var lblTitle3: UILabel!
    
    var connectionId = ""
    var visitordId = ""
    var dashboardModel:DashboardModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = AppConstants.kViewRequest
        lblTitle1.text = AppConstants.kAbout
        lblTitle2.text = AppConstants.kAboutRestaurant
        lblTitle3.text = AppConstants.kOurMenu
        btnDecline.setTitle(AppConstants.kDecline, for: .normal)
        btnAccept.setTitle(AppConstants.kAccept, for: .normal)
        vwHeader.drawBottomShadow()
        btnDecline.layer.borderWidth = 1
        btnDecline.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        callDashboardApi(id: connectionId)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        userimg.isUserInteractionEnabled = true
        userimg.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        let controller = pushViewController(withName: ProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? ProfileViewC
        controller?.userLevel = .other
        controller?.userID = dashboardModel?.data?.userData?.userid
        // Your action
    }
    
    
    func inviteApi(id: Int, type: Int){
        
        let params: [String:Any] = [
            "connection_id": id,
            "accept_or_reject": type]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kinvitationAcceptReject, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            self.navigationController?.popViewController(animated: true)

        }
        
    }
    
    func callDashboardApi(id: String){
        self.scrollview.isHidden = true
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kDashboard+id, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
           
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.dashboardModel = DashboardModel.init(with: dictResponse)
                
            }
            self.scrollview.isHidden = false
            self.name.text = self.dashboardModel?.data?.userData?.restaurantName
            self.reason.text = self.dashboardModel?.data?.userData?.reasonToConnect
            //self.restType.text = self.dashboardModel?.data?.userData?.ty
            self.userimg.layer.masksToBounds = false
            self.userimg.clipsToBounds = true
            self.userimg.layer.borderWidth = 2
            self.userimg.layer.borderColor = UIColor.white.cgColor
            self.userimg.contentMode = .scaleToFill
            self.userimg.layer.cornerRadius = self.userimg.frame.width/2
            
            if self.dashboardModel?.data?.userData?.avatarid?.attachmenturl != nil {
                self.userimg.setImage(withString: String.getString((self.dashboardModel?.data?.userData?.avatarid?.baseUrl ?? "")+(self.dashboardModel?.data?.userData?.avatarid?.attachmenturl)! ?? ""), placeholder: UIImage(named: "image_placeholder"))
            }
            
            
            
            if self.dashboardModel?.data?.aboutMember?.count == 5 {
                self.about.text = self.dashboardModel?.data?.aboutMember?[3].value
                self.ourmenu.text = self.dashboardModel?.data?.aboutMember?[4].value
                self.restType.text = self.dashboardModel?.data?.aboutMember?[2].value
            } else{
                self.about.text = self.dashboardModel?.data?.aboutMember?[2].value
                self.ourmenu.text = self.dashboardModel?.data?.aboutMember?[3].value
                self.restType.text = self.dashboardModel?.data?.aboutMember?[1].value
            }
            
            //self.pickup.text = self.dashboardModel?.data?.aboutMember?[2].value
            //self.pickupDiscount.text = self.dashboardModel?.data?.aboutMember?[2].value
            //self.deliveryDiscount.text = self.dashboardModel?.data?.aboutMember?[2].value
            
        }
    }

    @IBAction func backAccept(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapAccept(_ sender: UIButton) {
        self.inviteApi(id: Int.getInt(self.connectionId), type: 1)
        
    }
    
    @IBAction func tapDecline(_ sender: UIButton) {
        
        //self.inviteApi(id: Int.getInt(self.connectionId), type: 2)
        
        let vc = self.pushViewController(withName: DeclineRequest.id(), fromStoryboard: StoryBoardConstants.kHome) as! DeclineRequest
        vc.visitordId = Int.getInt(self.visitordId)
    }

}
