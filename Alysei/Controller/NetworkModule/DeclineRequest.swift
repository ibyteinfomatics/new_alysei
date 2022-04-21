//
//  DeclineRequest.swift
//  Alysei
//
//  Created by Jai on 07/03/22.
//

import UIKit

class DeclineRequest: AlysieBaseViewC {
    
    @IBOutlet weak var reasonToDecline: UITextView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDecline: UIButton!
    @IBOutlet weak var lblReasonDecline: UILabel!
    
    var visitordId : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = AppConstants.kDeclineRequest
        btnDecline.setTitle(AppConstants.kDecline, for: .normal)
        lblReasonDecline.text = AppConstants.kReasonToDecline
        headerView.drawBottomShadow()
        reasonToDecline.layer.borderWidth = 1
        reasonToDecline.layer.borderColor = UIColor.lightGray.cgColor
        reasonToDecline.textContainer.heightTracksTextView = true
        reasonToDecline.isScrollEnabled = false
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backbuttonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }


    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        self.reasonToDecline.resignFirstResponder()
       
        if reasonToDecline.text == "" {
            showAlert(withMessage: AlertMessage.kDeclineMsg)
        } else {
            declineApi(id: visitordId ?? 0, type: 2, resaon: String.getString(reasonToDecline.text))
            //inviteApi(id: visitordId ?? 0, type: 2, resaon: String.getString(reasonToDecline.text))
        }
        
    }
    
    /*func inviteApi(id: Int, type: Int, resaon: String){
        
        let params: [String:Any] = [
            "connection_id": id,
            "accept_or_reject": type,
            "reason": resaon]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kinvitationAcceptReject, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            if statusCode == 200 {
                self.navigationController?.popViewController(animated: false)
                self.navigationController?.popViewController(animated: false)
            }
           

        }
        
    }*/
    
    func declineApi(id: Int, type: Int, resaon: String){
        
        let params: [String:Any] = [:]
        
        let declineReason = String(resaon.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kotherAcceptReject+"visitor_profile_id="+String.getString(id)+"&accept_or_reject="+String.getString(type)+"&reason="+declineReason, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            //self.fetchVisiterProfileDetails(self.userID)
            
            if statusCode == 200 {
                networkcurrentIndex = 1
                let controller = self.pushViewController(withName: NetworkViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? NetworkViewC
                
            }
            
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
