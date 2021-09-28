//
//  UpdatePasswordViewC.swift
//  Alysie
//
//  Created by Alendra Kumar on 18/01/21.
//

import UIKit

class UpdatePasswordViewC: AlysieBaseViewC {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var viewNavigation: UIView!
  @IBOutlet weak var txtCurrentPassword: UITextField!
  @IBOutlet weak var txtNewPassword: UITextField!
    

  //MARK: - ViewLifeCycle Methods -

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidLayoutSubviews(){
    super.viewDidLayoutSubviews()
    self.viewNavigation.drawBottomShadow()
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapClose(_ sender: UIButton) {
    
    self.navigationController?.popViewController(animated: true)
  }
  
    @IBAction func updatePassword(_ sender: UIButton){
        changePassword()
    }
}

extension UpdatePasswordViewC {
    func changePassword(){
        
        let params: [String:Any] = [
            APIConstants.koldPassword: txtCurrentPassword.text ?? "",
            APIConstants.knewPassword: txtNewPassword.text ?? ""
        ]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kChangePassword, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errtyoe, statuscode) in
            self.showAlert(withMessage: "Password Updated Successfully")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                kSharedUserDefaults.clearAllData()
            }
        }
    }
}
