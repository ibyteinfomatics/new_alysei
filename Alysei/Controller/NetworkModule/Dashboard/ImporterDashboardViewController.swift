//
//  ImporterDashboardViewController.swift
//  Dashboard
//
//  Created by mac on 20/09/21.
//

import UIKit

class ImporterDashboardViewController: AlysieBaseViewC {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var btnDecline: UIButton!
    @IBOutlet weak var btnAccept: UIButton!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var reason: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var horeca: UILabel!
    @IBOutlet weak var fda: UILabel!
    @IBOutlet weak var privatelabel: UILabel!
    @IBOutlet weak var brandlabel: UILabel!
    @IBOutlet weak var ourproduct: UILabel!
    @IBOutlet weak var countryText: UILabel!
    @IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var fdaHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var fdaLine: UIView!
    @IBOutlet weak var fdaLabel: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTitle1: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var lblTitle3: UILabel!
    @IBOutlet weak var lblTitle4: UILabel!
    @IBOutlet weak var lblTitle5: UILabel!
    @IBOutlet weak var lblTitle6: UILabel!
    
    
    var connectionId = ""
    var visitordId = ""
    var dashboardModel:DashboardModel?
    var role = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.drawBottomShadow()
        lblTitle.text = AppConstants.kViewRequest
        btnAccept.setTitle(AppConstants.kAccept, for: .normal)
        btnDecline.setTitle(AppConstants.kDecline, for: .normal)
        lblTitle1.text = AppConstants.kAbout
        lblTitle2.text = AppConstants.kHORECA
        lblTitle3.text = MarketPlaceConstant.kFDACertified
        lblTitle4.text = AppConstants.PrivateLabel
        lblTitle5.text = AppConstants.AlyseiBrand
        lblTitle6.text = AppConstants.kOurProducts
//        headerView.layer.masksToBounds = false
//        headerView.layer.shadowRadius = 2
//        headerView.layer.shadowOpacity = 0.2
//        headerView.layer.shadowColor = UIColor.lightGray.cgColor
//        headerView.layer.shadowOffset = CGSize(width: 0 , height:2)
        
        //let role = Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId)
        
        switch role {
        case 4,5,6:
            countryText.text = "USA State"
        default:
            countryText.text = "Italian Region"
        }
        
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
            
            //self.navigationController?.popViewController(animated: true)
            if statusCode == 200 {
                networkcurrentIndex = 1
                let controller = self.pushViewController(withName: NetworkViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? NetworkViewC
                
            }

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
                self.userimg.setImage(withString: String.getString((self.dashboardModel?.data?.userData?.avatarid?.baseUrl ?? "")+(self.dashboardModel?.data?.userData?.avatarid?.attachmenturl)! ?? ""), placeholder: UIImage(named: "image_placeholder"))
            }
            
            
            
            if (self.dashboardModel?.data?.aboutMember?.count ?? 0) > 6{
                
                self.fdaHeight.constant = 70
                self.fda.isHidden = false
                self.fdaLine.isHidden = false
                self.fdaLabel.isHidden = false
                
                self.about.text = self.dashboardModel?.data?.aboutMember?[2].value
                self.region.text = self.dashboardModel?.data?.aboutMember?[0].value
                self.horeca.text = self.dashboardModel?.data?.aboutMember?[4].value
                self.privatelabel.text = self.dashboardModel?.data?.aboutMember?[5].value
                
                self.fda.text = self.dashboardModel?.data?.aboutMember?[1].value
                
                self.ourproduct.text = self.dashboardModel?.data?.aboutMember?[3].value
                
                if self.dashboardModel?.data?.aboutMember?[6].value == "" ||  self.dashboardModel?.data?.aboutMember?[6].value == nil{
                    self.brandlabel.isHidden = true
                }else{
                    self.brandlabel.isHidden = false
                    self.brandlabel.text = self.dashboardModel?.data?.aboutMember?[6].value
                }
            } else {
                self.about.text = self.dashboardModel?.data?.aboutMember?[1].value
                self.region.text = self.dashboardModel?.data?.aboutMember?[0].value
                self.horeca.text = self.dashboardModel?.data?.aboutMember?[3].value
                self.privatelabel.text = self.dashboardModel?.data?.aboutMember?[4].value
                
                self.fdaHeight.constant = 0
                self.fda.isHidden = true
                self.fdaLine.isHidden = true
                self.fdaLabel.isHidden = true
                
                self.ourproduct.text = self.dashboardModel?.data?.aboutMember?[2].value
                
                if self.dashboardModel?.data?.aboutMember?[5].value == "" ||  self.dashboardModel?.data?.aboutMember?[5].value == nil{
                    self.brandlabel.isHidden = true
                }else{
                    self.brandlabel.isHidden = false
                    self.brandlabel.text = self.dashboardModel?.data?.aboutMember?[5].value
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
        
        //self.inviteApi(id: Int.getInt(self.connectionId), type: 2)
        let vc = self.pushViewController(withName: DeclineRequest.id(), fromStoryboard: StoryBoardConstants.kHome) as! DeclineRequest
        vc.visitordId = Int.getInt(self.connectionId)
    }
    

}
