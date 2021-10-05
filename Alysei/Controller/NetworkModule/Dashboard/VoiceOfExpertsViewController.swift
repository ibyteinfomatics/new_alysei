//
//  VoiceOfExpertsViewController.swift
//  Dashboard
//
//  Created by mac on 23/09/21.
//

import UIKit

class VoiceOfExpertsViewController: UIViewController {
    @IBOutlet weak var btnDecline: UIButton!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var reason: UILabel!
    @IBOutlet weak var specialization: UILabel!
    @IBOutlet weak var voice_title: UILabel!
    @IBOutlet weak var country: UILabel!
    
    @IBOutlet weak var userimg: UIImageView!
    
    var connectionId = ""
    var dashboardModel:DashboardModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnDecline.layer.borderWidth = 1
        btnDecline.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        // Do any additional setup after loading the view.
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
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kDashboard+id, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
           
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.dashboardModel = DashboardModel.init(with: dictResponse)
                
            }
            
            self.name.text = self.dashboardModel?.data?.userData?.companyName
            self.reason.text = self.dashboardModel?.data?.userData?.reasonToConnect
            
            self.userimg.layer.masksToBounds = false
            self.userimg.clipsToBounds = true
            self.userimg.layer.borderWidth = 2
            self.userimg.layer.borderColor = UIColor.white.cgColor
            self.userimg.layer.cornerRadius = self.userimg.frame.width/2
            
            if self.dashboardModel?.data?.userData?.avatarid?.attachmenturl != nil {
                self.userimg.setImage(withString: String.getString(kImageBaseUrl+(self.dashboardModel?.data?.userData?.avatarid?.attachmenturl)! ?? ""), placeholder: UIImage(named: "image_placeholder"))
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
        
        self.inviteApi(id: Int.getInt(self.connectionId), type: 2)
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
