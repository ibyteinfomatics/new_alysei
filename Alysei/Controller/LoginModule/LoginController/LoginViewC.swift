//
//  LoginViewC.swift
//  Alysie
//
//  Created by CodeAegis on 13/01/21.
//

import UIKit

class LoginViewC: AlysieBaseViewC {

  //MARK: - IBOutlet -
  
  @IBOutlet weak var txtFieldEmail: UITextField!
  @IBOutlet weak var txtFieldPassword: UITextField!
  @IBOutlet weak var btnLogin: UIButton!
  @IBOutlet weak var btnSignUp: UIButton!
  @IBOutlet weak var viewBottom: UIView!
  @IBOutlet weak var btnEye: UIButton!
  
  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.btnEye.isSelected = false
    self.txtFieldPassword.isSecureTextEntry = (self.btnEye.isSelected == false) ? true : false
  }
  
  override func viewDidLayoutSubviews() {
    
    super.viewDidLayoutSubviews()
    self.txtFieldEmail.makeCornerRadius(radius: 5.0)
    self.txtFieldPassword.makeCornerRadius(radius: 5.0)
    self.btnLogin.makeCornerRadius(radius: 5.0)
    self.btnSignUp.underlined()
    self.viewBottom.makeCornerRadius(radius: 15.0)
    self.viewBottom.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    self.txtFieldEmail.attributedPlaceholder = NSAttributedString(string: AppConstants.Email.capitalized,
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    self.txtFieldPassword.attributedPlaceholder = NSAttributedString(string: AppConstants.Password.capitalized,
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapBack(_ sender: UIButton) {
    
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func tapEye(_ sender: UIButton) {
    
    self.btnEye.isSelected = (self.btnEye.isSelected == false) ? true : false
    self.txtFieldPassword.isSecureTextEntry = (self.btnEye.isSelected == false) ? true : false
  }
  
  @IBAction func tapLogin(_ sender: UIButton) {
    
    self.validateFields()
  }
  
  @IBAction func tapForgotPassword(_ sender: UIButton) {
    
    _ = pushViewController(withName: ForgotPasswordViewC.id(), fromStoryboard: StoryBoardConstants.kLogin)
  }
  
  @IBAction func tapSignUp(_ sender: UIButton) {
   
    self.btnSignUp.isUserInteractionEnabled = false
    self.postRequestToGetRoles()
  }
  
  //MARK: - Private Methods -
  
  private func validateFields() -> Void{
    
    if String.getString(self.txtFieldEmail.text).isEmpty == true{
      showAlert(withMessage: AlertMessage.kEmailAddress)
    }
    else if String.getString(self.txtFieldPassword.text).isEmpty == true{
      showAlert(withMessage: AlertMessage.kPassword)
    }
    else if String.getString(self.txtFieldEmail.text).isEmail() == false{
      showAlert(withMessage: AlertMessage.kValidEmailAddress)
    }
    else{
      self.btnLogin.isUserInteractionEnabled = false
      self.postRequestToLogin()
    }
  }
  
  //MARK: - WebService Methods -
  
  private func postRequestToLogin() -> Void{
    
    disableWindowInteraction()
    CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kLogin, method: .POST, controller: self, userName: String.getString(self.txtFieldEmail.text), passsword: String.getString(self.txtFieldPassword.text), type: 0, param: [:], btnTapped: self.btnLogin)
  }
  
  private func postRequestToGetRoles() -> Void{
    
    disableWindowInteraction()
    CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kGetRoles, method: .GET, controller: self, type: 1, param: [:], btnTapped: self.btnSignUp)
  }
  
}

extension LoginViewC{
  
  override func didUserGetData(from result: Any, type: Int) {
    
    switch type {
    case 0:
      let dicResult = kSharedInstance.getDictionary(result)
      let dictData = kSharedInstance.getDictionary(dicResult[APIConstants.kData])
      
      if String.getString(dictData[APIConstants.kAccountEnabled]) == AppConstants.Incomplete{
        let controller = pushViewController(withName: OTPVerificationViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? OTPVerificationViewC
        controller?.email = String.getString(self.txtFieldEmail.text)
        controller?.userName = String.getString(dictData[APIConstants.kFirstName])
        controller?.pushedFrom = .login
      }
      else{
        kSharedUserDefaults.setLoggedInUserDetails(loggedInUserDetails: dicResult)
        kSharedAppDelegate.pushToTabBarViewC()
      }
    case 1:
      self.btnSignUp.isUserInteractionEnabled = true
      //let controller = pushViewController(withName: RoleViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? RoleViewC
        let controller = pushViewController(withName: SelectRoleViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? SelectRoleViewC
      let dicResponse = kSharedInstance.getDictionary(result)
      let dicData = kSharedInstance.getDictionary(dicResponse[APIConstants.kData])
      controller?.getRoleViewModel = GetRoleViewModel(dicData)
    
       
    default:
      break
    }
  }
}
