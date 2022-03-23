//
//  OverLayLoginViewController.swift
//  Alysie
//
//  Created by Gitesh Dang on 16/03/21.
//

import UIKit

class OverLayLoginViewController: AlysieBaseViewC {

    //MARK: VARIABLE
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    var btnCallback: ((Int,GetRoleViewModel,String,String) -> Void)? = nil
   // var btnSignUpCallBack : ((GetRoleViewModel) -> Void)? = nil
    
    //MARK: IBOutlets
    
    @IBOutlet weak var slideView: UIView!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var lblLoginWithAccount: UILabel!
    @IBOutlet weak var lblDontHaveAccount: UILabel!
    @IBOutlet weak var btnForgetPassword: UIButton!
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        lblLoginWithAccount.text = LogInSignUp.kLoginToyourAccount
        lblDontHaveAccount.text = LogInSignUp.kDontHaveAccount
        txtFieldEmail.placeholder = AppConstants.Email
        txtFieldPassword.placeholder = AppConstants.Password
        btnLogin.setTitle(LogInSignUp.kLOGIN, for: .normal)
        btnForgetPassword.setTitle(LogInSignUp.kForgetPassword, for: .normal)
        btnSignUp.setTitle(LogInSignUp.kSignUp, for: .normal)
        
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
        //slideIdicator.roundCorners(.allCorners, radius: 10)
        //subscribeButton.roundCorners(.allCorners, radius: 10)
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
        self.txtFieldEmail.makeCornerRadius(radius: 5.0)
        self.txtFieldPassword.makeCornerRadius(radius: 5.0)
        self.btnLogin.makeCornerRadius(radius: 5.0)
        self.btnSignUp.underlined()
        self.txtFieldEmail.attributedPlaceholder = NSAttributedString(string: AppConstants.Email.capitalized,
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.txtFieldPassword.attributedPlaceholder = NSAttributedString(string: AppConstants.Password.capitalized,
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    //MARK: IBACTIONS
    @IBAction func btnLogin(_ sender: UIButton){

//        self.txtFieldEmail.text = "sweety@gmail.com"
//        self.txtFieldPassword.text = "deepanshu@123"

        validateFields(sender.tag)
    }
    @IBAction func btnForgetAction(_ sender: UIButton){
       self.dismiss(animated: false, completion: {
            self.btnCallback?(sender.tag, GetRoleViewModel([:]), "","")
        })
    }
    
    @IBAction func btnBack(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
   
    @IBAction func btnSignUp(_ sender: UIButton){
        self.dismiss(animated: true, completion: {
            self.postRequestToGetRoles(sender.tag)
        
        })
 }
    
    @IBAction func tapEye(_ sender: UIButton) {
      
      self.btnEye.isSelected = (self.btnEye.isSelected == false) ? true : false
      self.txtFieldPassword.isSecureTextEntry = (self.btnEye.isSelected == false) ? true : false
    }
    
    //MARK: - Private Methods -
    
    private func validateFields(_ tag: Int) -> Void{
        
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
            //self.btnLogin.isUserInteractionEnabled = false
            self.postRequestToLogin(tag)
        }
    }
}
//MARK: WEB SERVICES METHODS
extension OverLayLoginViewController{
    
    private func postRequestToLogin(_ tag: Int) -> Void{

        let parameters: [String:Any] = [
            "device_type": "2",
            "device_token": kSharedUserDefaults.getDeviceToken()]
      
        disableWindowInteraction()
        CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kLogin, method: .POST, controller: self, userName: String.getString(self.txtFieldEmail.text), passsword: String.getString(self.txtFieldPassword.text), type: tag, param: parameters, btnTapped: self.btnLogin)
        
    }
    
    private func postRequestToGetRoles(_ tag: Int) -> Void{
       // kSharedAppDelegate.get
        disableWindowInteraction()
        CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kGetRoles, method: .GET, controller: self, type: tag, param: [:], btnTapped: self.btnSignUp)
    }
}
extension OverLayLoginViewController{
    
    override func didUserGetData(from result: Any, type: Int) {
        
        switch type {
        case 1:
            let dicResult = kSharedInstance.getDictionary(result)
            let dictData = kSharedInstance.getDictionary(dicResult[APIConstants.kData])
            
            if String.getString(dictData[APIConstants.kAccountEnabled]) == AppConstants.Incomplete{
                let firstName = String.getString(dictData[APIConstants.kFirstName])
                self.dismiss(animated: true, completion: {
                    self.btnCallback?(type,GetRoleViewModel([:]),self.txtFieldEmail.text ?? "",firstName)
                })
                 
            }
            else{
                
                kSharedUserDefaults.setLoggedInUserDetails(loggedInUserDetails: dicResult)
                kSharedUserDefaults.alyseiReview =  Int.getInt(dictData["alysei_review"])
                kSharedUserDefaults.setAppLanguage(language: (dictData["locale"] as? String ?? ""))
                kSharedAppDelegate.pushToTabBarViewC()
            }
        case 3:
            self.btnSignUp.isUserInteractionEnabled = true
            //let controller = pushViewController(withName: RoleViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? RoleViewC
            let dicResponse = kSharedInstance.getDictionary(result)
            let dicData = kSharedInstance.getDictionary(dicResponse[APIConstants.kData])
            self.btnCallback?(type, GetRoleViewModel(dicData),"","")
            //controller?.getRoleViewModel = GetRoleViewModel(dicData)
        default:
            break
        }
    }
}
