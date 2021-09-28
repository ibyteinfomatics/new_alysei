//
//  ForgotPasswordViewC.swift
//  Alysie
//
//  Created by CodeAegis on 13/01/21.
//

import UIKit

class ForgotPasswordViewC: AlysieBaseViewC {

  //MARK: - IBOutlet -
  
  @IBOutlet weak var txtFieldEmail: UITextFieldExtended!
  @IBOutlet weak var btnResetPassword: UIButton!
  @IBOutlet weak var viewBottom: UIView!
  
  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidLayoutSubviews() {
    
    super.viewDidLayoutSubviews()
    self.txtFieldEmail.makeCornerRadius(radius: 5.0)
    self.btnResetPassword.makeCornerRadius(radius: 5.0)
    self.viewBottom.makeCornerRadius(radius: 15.0)
    self.viewBottom.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    self.txtFieldEmail.attributedPlaceholder = NSAttributedString(string: AppConstants.Email.capitalized,
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapBack(_ sender: UIButton) {
    
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func tapResetPassword(_ sender: UIButton) {
    
    if self.txtFieldEmail.text?.isEmpty == true{
      showAlert(withMessage: AlertMessage.kEmailAddress)
    }
    else if self.txtFieldEmail.text?.isEmail() == false{
      showAlert(withMessage: AlertMessage.kValidEmailAddress)
    }
    else{
      self.btnResetPassword.isUserInteractionEnabled = false
      self.postRequestToSendOTP()
    }
  }
  
  //MARK: - WebService Methods -
  
  private func postRequestToSendOTP() -> Void{
    
    let param: [String:Any] = [APIConstants.kEmail:String.getString(self.txtFieldEmail.text)]
    
    disableWindowInteraction()
    CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kResendOtp, method: .POST, controller: self, type: 0, param: param,btnTapped: self.btnResetPassword)
  }
}

extension ForgotPasswordViewC{
  
  override func didUserGetData(from result: Any, type: Int) {
    
    let controller = self.pushViewController(withName: OTPVerificationViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? OTPVerificationViewC
    controller?.email = String.getString(self.txtFieldEmail.text)
    controller?.pushedFrom = .forgotPassword
  }
}
