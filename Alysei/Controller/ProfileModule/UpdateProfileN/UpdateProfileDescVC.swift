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
    @IBOutlet weak var lblTextCount: UILabel!

    var passUserFieldId: Int?
    var passheaderTitle: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        vwHeader.drawBottomShadow()
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
        
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        let finalText = updatedText.removeWhitespace()
        if finalText.count <= 300{
         //   let finalText = updatedText.removeWhitespace()
            self.lblTextCount.text = "\(finalText.count)"
            return true
        }else{
            if text == "" && range.length > 0  {
                print("Backspace was pressed")
              //  let finalText = textView.text.removeWhitespace()
                self.lblTextCount.text = "\(finalText.count)"
                return true
            }
            else{
                return false
                
            }
            
        }
        
    }

}
extension String {
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }

    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
  }
