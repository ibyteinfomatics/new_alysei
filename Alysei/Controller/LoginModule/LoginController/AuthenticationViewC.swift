//
//  AuthenticationViewC.swift
//  Alysei
//
//  Created by Mobcoder Technologies Private Limited on 12/07/22.
//

import UIKit

class AuthenticationViewC: UIViewController {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!

    @IBOutlet weak var textFieldFirst: UITextField!
    @IBOutlet weak var textFieldSecond: UITextField!
    @IBOutlet weak var textFieldThird: UITextField!
    @IBOutlet weak var textFieldFourth: UITextField!
    @IBOutlet weak var textFieldFive: UITextField!
    
   
    var userOtp: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        view1.layer.cornerRadius = self.view1.frame.height / 2
        view2.layer.cornerRadius = self.view1.frame.height / 2
        view3.layer.cornerRadius = self.view1.frame.height / 2
        view4.layer.cornerRadius = self.view1.frame.height / 2
        view5.layer.cornerRadius = self.view1.frame.height / 2
        
        view1.layer.masksToBounds = true
        view2.layer.masksToBounds = true
        view3.layer.masksToBounds = true
        view4.layer.masksToBounds = true
        view5.layer.masksToBounds = true
        
        textFieldFirst.layer.cornerRadius = self.view1.frame.height / 2
        textFieldSecond.layer.cornerRadius = self.view1.frame.height / 2
        textFieldThird.layer.cornerRadius = self.view1.frame.height / 2
        textFieldFourth.layer.cornerRadius = self.view1.frame.height / 2
        textFieldFive.layer.cornerRadius = self.view1.frame.height / 2
        textFieldFirst.delegate = self
        textFieldSecond.delegate = self
        textFieldThird.delegate = self
        textFieldFourth.delegate = self
        textFieldFive.delegate = self
    }
   
    
    @IBAction func tapVerifyPass(_ sender: UIButton) {
        
        if validateFields(){
            if self.userOtp == "12202"{
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: LoginAccountViewC.id()) as? LoginAccountViewC else{return}
        self.navigationController?.pushViewController(nextVC, animated: true)
            }else{
                self.showAlert(withMessage: "Please enter correct code", nil)
            }
        }
    }
    
    
    
    private func validateFields() -> Bool  {
        if (String(textFieldFirst.text ?? "").count > 0 &&
            String(textFieldSecond.text ?? "").count > 0 &&
            String(textFieldThird.text ?? "").count > 0 &&
            String(textFieldFourth.text ?? "").count > 0 &&
            String(textFieldFive.text ?? "").count > 0) {

            let CodeOTP = String(textFieldFirst.text ?? "") +
                String(textFieldSecond.text ?? "") +
                String(textFieldThird.text ?? "") +
                String(textFieldFourth.text ?? "")
            
            let fullCodeOTP = CodeOTP +  String(textFieldFive.text ?? "")
            self.userOtp = String(fullCodeOTP)

            self.view.endEditing(true)
            return true

        } else {
            showAlert(withMessage: AlertMessage.kEnterOTP)
            return false
        }
    }
}

extension AuthenticationViewC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
        // Range.length == 1 means,clicking backspace
        if (range.length == 0){
            if textField == textFieldFirst {
                textFieldSecond?.becomeFirstResponder()
            }
            if textField == textFieldSecond {
                textFieldThird?.becomeFirstResponder()
            }
            if textField == textFieldThird {
                textFieldFourth?.becomeFirstResponder()
            }
            if textField == textFieldFourth {
                textFieldFive?.becomeFirstResponder()
                
            }
            if textField == textFieldFive{
                textFieldFive?.resignFirstResponder()
                
            }
            textField.text? = string
            return false
        }else if (range.length == 1) {
            if textField == textFieldFive{
                textFieldFourth?.becomeFirstResponder()
            }
            if textField == textFieldFourth {
                textFieldThird?.becomeFirstResponder()
            }
            if textField == textFieldThird {
                textFieldSecond?.becomeFirstResponder()
            }
            if textField == textFieldSecond {
                textFieldFirst?.becomeFirstResponder()
            }
            if textField == textFieldFirst {
                textFieldFirst?.resignFirstResponder()
            }
            textField.text? = ""
            return false
        }
        return true
    }
}
