//
//  TravelAgencyViewController.swift
//  Dashboard
//
//  Created by mac on 23/09/21.
//

import UIKit

class TravelAgencyViewController: AlysieBaseViewC {

    @IBOutlet weak var btnDecline: UIButton!
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var reason: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var ourptrip: UILabel!
    @IBOutlet weak var speciality: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTitle1: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var btnAccept: UIButton!
   
    
    var connectionId = ""
    var visitordId = ""
    var dashboardModel:DashboardModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAccept.setTitle(AppConstants.kAccept, for: .normal)
        lblTitle.text = AppConstants.kViewRequest
        lblTitle1.text = AppConstants.kAboutTravelAgency
        lblTitle2.text = AppConstants.kOurTrips
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
            self.name.text = self.dashboardModel?.data?.userData?.companyName
            self.reason.text = self.dashboardModel?.data?.userData?.reasonToConnect
            
            self.userimg.layer.masksToBounds = false
            self.userimg.clipsToBounds = true
            self.userimg.layer.borderWidth = 2
            self.userimg.layer.borderColor = UIColor.white.cgColor
            self.userimg.layer.cornerRadius = self.userimg.frame.width/2
            
            if self.dashboardModel?.data?.userData?.avatarid?.attachmenturl != nil {
                self.userimg.setImage(withString: String.getString((self.dashboardModel?.data?.userData?.avatarid?.baseUrl ?? "")+(self.dashboardModel?.data?.userData?.avatarid?.attachmenturl ?? "") ), placeholder: UIImage(named: "image_placeholder"))
            }
            
            for i in 0..<(self.dashboardModel?.data?.aboutMember?.count ?? 0){
            if self.dashboardModel?.data?.aboutMember?[i].title == "About" {
            self.about.text = self.dashboardModel?.data?.aboutMember?[i].value
            }
            if self.dashboardModel?.data?.aboutMember?[i].title == "Our Tours" {
            self.ourptrip.text = self.dashboardModel?.data?.aboutMember?[i].value
            }
            if self.dashboardModel?.data?.aboutMember?[i].title == "Speciality Trips" {
            self.speciality.text = self.dashboardModel?.data?.aboutMember?[i].value
            }
                if self.dashboardModel?.data?.aboutMember?[i].title == "State/Region" {
            self.country.text = self.dashboardModel?.data?.aboutMember?[i].value
                }
            }
        }
        
    }
    
    @IBAction func backAccept(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapAccept(_ sender: UIButton) {
        self.inviteApi(id: Int.getInt(self.connectionId), type: 1)
        
    }
    
    @IBAction func tapDecline(_ sender: UIButton) {
        
       // self.inviteApi(id: Int.getInt(self.connectionId), type: 2)
        let vc = self.pushViewController(withName: DeclineRequest.id(), fromStoryboard: StoryBoardConstants.kHome) as! DeclineRequest
        vc.visitordId = Int.getInt(self.visitordId)
    }
    


}
