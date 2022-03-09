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
    var connectionid : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.drawBottomShadow()
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
            inviteApi(id: connectionid ?? 0, type: 2, resaon: String.getString(reasonToDecline.text))
        }
        
    }
    
    func inviteApi(id: Int, type: Int, resaon: String){
        
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