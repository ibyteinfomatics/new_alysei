//
//  UpdateProfileDescVC.swift
//  Alysei
//
//  Created by Gitesh Dang on 11/11/21.
//

import UIKit

class UpdateProfileDescVC: AlysieBaseViewC {
    
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var headerTitle: UILabel!

    var passUserFieldId: Int?
    var passheaderTitle: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        vwHeader.addShadow()
        txtDesc.addBorder()
        txtDesc.delegate = self
        headerTitle.text = passheaderTitle
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSaveAction(_ sender: UIButton){
        if txtDesc.text == ""{
            self.showAlert(withMessage: "Please enter some description")
        }else{
            callSaVeApi()
        }
    }
    
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}

extension UpdateProfileDescVC{
    func callSaVeApi(){
        
        let params: [String:Any] = [
            APIConstants.userFieldId: passUserFieldId ?? 0,
            "value": String.getString(txtDesc.text),
        ]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kSaveUpdateProfileField, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { dictResponse, error, errType, statusCode in
            
            switch statusCode {
            case 200:
            self.navigationController?.popViewController(animated: true)
            default:
                print("Error")
        }
    }
}
}

extension UpdateProfileDescVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let spaceCount = textView.text.count
        if spaceCount <= 200{
            return true
        }else{
            if text == "" && range.length > 0  {
                print("Backspace was pressed")
                return true
            }
            else{
                return false
                
            }
            
        }    }

}
