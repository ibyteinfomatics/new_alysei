//
//  ResetPasswordViewC.swift
//  Alysie
//
//  Created by CodeAegis on 22/02/21.
//

import UIKit

class ResetPasswordViewC: AlysieBaseViewC {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var txtFieldNewPassword: UITextFieldExtended!
  @IBOutlet weak var txtFieldConfirmPassword: UITextFieldExtended!
  @IBOutlet weak var btnSubmit: UIButtonExtended!
  @IBOutlet weak var viewNavigation: UIView!
  @IBOutlet weak var btnNewEye: UIButton!
  @IBOutlet weak var btnConfirmEye: UIButton!
  
  //MARK: - Properties -

  var email: String?
  
  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidLayoutSubviews() {
    
    super.viewDidLayoutSubviews()
    self.viewNavigation.drawBottomShadow()
  }
  
  //MARK: - Private Methods -
  
  private func validateFields() -> Void{
    
    if String.getString(txtFieldNewPassword.text).isEmpty == true{
      showAlert(withMessage: AlertMessage.kNewPassword)
    }
    else if String.getString(txtFieldConfirmPassword.text).isEmpty == true{
      showAlert(withMessage: AlertMessage.kConfirmPassword)
    }
    else if String.getString(txtFieldNewPassword.text) != String.getString(txtFieldConfirmPassword.text){
      showAlert(withMessage: AlertMessage.kPasswordNotEqual)
    }
    else if String.getString(txtFieldNewPassword.text).isPassword() == false{
      showAlert(withMessage: AlertMessage.kValidPassword)
    }
    else{
      self.btnSubmit.isUserInteractionEnabled = false
      self.postRequestToResetPassword()
    }
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapSubmit(_ sender: UIButton) {
    self.validateFields()
  }
  
  @IBAction func tapNewEye(_ sender: UIButton) {
    
    self.btnNewEye.isSelected = (self.btnNewEye.isSelected == false) ? true : false
    self.txtFieldNewPassword.isSecureTextEntry = (self.btnNewEye.isSelected == false) ? true : false
    
  }
  
  @IBAction func tapConfirmEye(_ sender: UIButton) {
    
    self.btnConfirmEye.isSelected = (self.btnConfirmEye.isSelected == false) ? true : false
    self.txtFieldConfirmPassword.isSecureTextEntry = (self.btnConfirmEye.isSelected == false) ? true : false
  }
  
  //MARK: - WebService Methods -

  private func postRequestToResetPassword() -> Void{
    
    let param: [String:Any] = [APIConstants.kEmail: String.getString(self.email),
                               APIConstants.kPassword: String.getString(self.txtFieldNewPassword.text),
                               APIConstants.kConfirmPassword: String.getString(self.txtFieldConfirmPassword.text)
    ]
    disableWindowInteraction()
    CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kResetPassword, method: .POST, controller: self, type: 0, param: param , btnTapped: self.btnSubmit)
  }
}

extension ResetPasswordViewC{
  
  override func didUserGetData(from result: Any, type: Int) {
    
    showAlert(withMessage: AlertMessage.kPasswordChanged){
      
      for controller in self.navigationController!.viewControllers as Array {
          if controller.isKind(of: LoginViewC.self) {
              self.navigationController!.popToViewController(controller, animated: true)
              break
        }
      }
    }
  }
}
