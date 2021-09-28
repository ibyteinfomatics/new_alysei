//
//  OTPVerificationViewC.swift
//  Alysie
//
//  Created by CodeAegis on 13/02/21.
//

import UIKit

class OTPVerificationViewC: AlysieBaseViewC {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var lblHeading: UILabel!
  @IBOutlet weak var btnVerifyOTP: UIButtonExtended!
  @IBOutlet weak var btnResendOTP: UIButton!
  @IBOutlet var txtFieldOTP: [UITextField]!
  @IBOutlet weak var viewNavigation: UIView!
  @IBOutlet weak var lblUsername: UILabel!
  
  //MARK: - Properties -
  
  var email: String?
  var userName: String?
  var pushedFrom: PushedFrom = PushedFrom.login
  
  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    self.initialSetupTextFields()
  }
  
  override func viewDidLayoutSubviews() {
    
    super.viewDidLayoutSubviews()
    self.viewNavigation.drawBottomShadow()
  }
  
  //MARK: - Private Methods -
  
  private func initialSetupTextFields(){
    
    let text = NSMutableAttributedString()
    text.append(NSAttributedString(string: AppConstants.OTPHeading, attributes: [NSAttributedString.Key.font: AppFonts.regular(18.0).font]));
    text.append(NSAttributedString(string: String.getString(email), attributes: [NSAttributedString.Key.font: AppFonts.bold(20.0).font]))
    lblHeading.attributedText = text
    lblUsername.text = (self.userName?.isEmpty == false) ? (AppConstants.Hi + String.getString(self.userName) + ",") : (AppConstants.Hi + "User" + ",")
    self.txtFieldOTP.first?.becomeFirstResponder()
    self.txtFieldOTP.forEach{
      $0.delegate = self
      $0.makeCornerRadius(radius: 4.0)
      $0.addTarget(self, action: #selector(OTPVerificationViewC.textFieldEditingChanged(_:)),for: UIControl.Event.editingChanged)
    }
  }
  
  @objc private func textFieldEditingChanged(_ sender: UITextFieldExtended){
    
    print("textFieldEditingChanged")
    let currentIndex = self.txtFieldOTP.firstIndex(of:sender)
    
    if sender.text?.isEmpty == true{
      if sender.text?.isBackSpace == true && currentIndex != 0{
        if let index = currentIndex,self.txtFieldOTP.count - 1 > (index - 1){
          self.txtFieldOTP[index - 1].becomeFirstResponder()
        }
      }
    }
    else{
      if let index = currentIndex,self.txtFieldOTP.count > (index + 1){
        self.txtFieldOTP[index + 1].becomeFirstResponder()
      }
    }
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapBack(_ sender: UIButton) {
    
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func tapVerifyOTP(_ sender: UIButton) {
    
    self.txtFieldOTP.forEach{
     if $0.text?.isEmpty == true{
      showAlert(withMessage: AlertMessage.kEnter6DigitOTP)
     }
   }
   self.postRequestToVerifyOTP()
  }
  
  @IBAction func tapResendOTP(_ sender: UIButton) {
    
    self.postRequestToResendOTP()
  }
  
  //MARK: - WebService Methods -
  
  private func postRequestToVerifyOTP() -> Void{
    
    let param: [String:Any] = [APIConstants.kEmail:String.getString(self.email),
                               APIConstants.kOtp: self.txtFieldOTP.map {String.getString($0.text)}.joined()]
    disableWindowInteraction()
    CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kVerifyOtp, method: .POST, controller: self, type: 0, param: param, btnTapped: self.btnVerifyOTP)
  }
  
  private func postRequestToResendOTP() -> Void{
    
    let param: [String:Any] = [APIConstants.kEmail:String.getString(self.email)]
    disableWindowInteraction()
    CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kResendOtp, method: .POST, controller: self, type: 1, param: param, btnTapped: self.btnResendOTP)
  }
}

//MARK: - TextViewDelegateMethods -

extension OTPVerificationViewC: UITextFieldDelegate{
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
      
      let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
      let compSepByCharInSet = string.components(separatedBy: aSet)
      let numberFiltered = compSepByCharInSet.joined(separator: "")
      return (string == numberFiltered && textField.text?.isEmpty == true || String.getString(string).isBackSpace == true)
  }

}

extension OTPVerificationViewC{
  
  override func didUserGetData(from result: Any, type: Int) {
    switch type {
    case 0:
      if self.pushedFrom == PushedFrom.forgotPassword{
        let controller = pushViewController(withName: ResetPasswordViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? ResetPasswordViewC
        controller?.email = self.email
      }
      else{
        let dicResult = kSharedInstance.getDictionary(result)
        kSharedUserDefaults.setLoggedInUserDetails(loggedInUserDetails: dicResult)
        kSharedAppDelegate.pushToTabBarViewC()
      }
    case 1:
      showAlert(withMessage: AlertMessage.kOTPSent)
    default:
      break
    }
  }
}
