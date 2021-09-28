//
//  OverLayForgetVC.swift
//  Alysie
//
//  Created by Gitesh Dang on 16/03/21.
//

import UIKit

class OverLayForgetVC: AlysieBaseViewC {
    
    //MARK: @IBOutlets
    @IBOutlet weak var txtFieldEmail: UITextFieldExtended!
    @IBOutlet weak var btnResetPassword: UIButton!
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    var btnCallBack: ((String) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
        self.txtFieldEmail.makeCornerRadius(radius: 5.0)
        self.btnResetPassword.makeCornerRadius(radius: 5.0)
        self.txtFieldEmail.attributedPlaceholder = NSAttributedString(string: AppConstants.Email.capitalized,
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
                UIView.animate(withDuration: 0.5) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    //MARK: IBActions
    //MARK: - IBAction -
    
    @IBAction func tapBack(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
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
}

extension OverLayForgetVC {
    //MARK: - WebService Methods -
    
    private func postRequestToSendOTP() -> Void{
        
        let param: [String:Any] = [APIConstants.kEmail:String.getString(self.txtFieldEmail.text)]
        
        disableWindowInteraction()
        CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kResendOtp, method: .POST, controller: self, type: 0, param: param,btnTapped: self.btnResetPassword)
    }
}

extension OverLayForgetVC{
    
    override func didUserGetData(from result: Any, type: Int) {
        self.dismiss(animated: true) {
            self.btnCallBack?(self.txtFieldEmail.text ?? "")
        }
        
    }
}
