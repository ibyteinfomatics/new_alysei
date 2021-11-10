//
//  InquiryFormViewC.swift
//  Alysei
//
//  Created by Gitesh Dang on 11/8/21.
//

import UIKit

class InquiryFormViewC: AlysieBaseViewC {
    
    @IBOutlet weak var lblProductDesc: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtMessage: UITextView!

    var passproductId: String?
    var passproductName: String?
    var passProductPrice: String?
    
    var storeId : String?
    var storeName : String?
    var productImage : String?
    
    var name : String?
    var userId : String?
    var profileImageUrl : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtMessage.delegate = self
       
        setData()
       
        // Do any additional setup after loading the view.
    }
    
    func setData(){
        lblProductDesc.text = passproductName?.capitalized
        lblProductPrice.text = "$" + "\(passProductPrice ?? "")"
        txtMessage.text = "Message"
        txtMessage.textColor = UIColor.lightGray
        txtMessage.layer.borderWidth = 0.5
        txtMessage.layer.borderColor = UIColor.lightGray.cgColor
        let userData = kSharedUserDefaults.loggedInUserModal
        
        var name = ""
        if userData.memberRoleId == "\(UserRoles.restaurant.rawValue)"{
            name = userData.restaurantName ?? ""
        }else if userData.memberRoleId == "\(UserRoles.voyagers.rawValue)" || userData.memberRoleId == "\(UserRoles.voiceExperts.rawValue)" {
            name = "\(userData.firstName ?? "")" + "\(userData.lastName ?? "")"
        }else{
            name = "\(userData.companyName ?? "")"
        }
        txtFullName.text = name
        txtEmail.text = userData.email
        txtPhoneNumber.text = userData.phone
    }

    @IBAction func btnDismissAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSendEnquiryAction(_ sender: UIButton){
        if txtMessage.text == "Message"{
            self.showAlert(withMessage: "Please enter some message")
        }else{
            self.callSaveInquiryApi()
            
            

        }
    }

}

extension InquiryFormViewC: UITextViewDelegate{
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == AppConstants.leaveComment && txtMessage.textColor == UIColor.lightGray{
            textView.text = ""
        }
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = AppConstants.leaveComment
            textView.textColor = UIColor.lightGray
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
        
        // Else if the text view's placeholder is showing and the
        // length of the replacement string is greater than 0, set
        // the text color to black then set its text to the
        // replacement string
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }
        
        // For every other case, the text should change with the usual
        // behavior...
        else {
            return true
        }
        
        // ...otherwise return false since the updates have already
        // been made
        return false
    }
}

extension InquiryFormViewC{
    func callSaveInquiryApi(){
        
        let params: [String:Any] = [
            
            APIConstants.kProductId: passproductId ?? "",    
            APIConstants.kName: txtFullName.text ?? "",
            APIConstants.kEmail: txtEmail.text ?? "",
            APIConstants.kPhone: txtPhoneNumber.text ?? "",
            APIConstants.kMessage: txtMessage.text ?? ""
        ]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kSaveInquiry, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { dictResponse, error, errortype, statusCode in
            
            switch statusCode {
            case 200:
                //_ = self.pushViewController(withName: InquiryConversation.id(), fromStoryboard: StoryBoardConstants.kChat) as? InquiryConversation
                
                
                let vc = self.pushViewController(withName: InquiryConversation.id(), fromStoryboard: StoryBoardConstants.kChat) as? InquiryConversation
                vc?.name = self.name ?? ""
                vc?.userId = self.userId ?? ""
                vc?.profileImageUrl = self.profileImageUrl ?? ""
                vc?.storeId = self.storeId ?? ""
                vc?.storeName = self.storeName ?? ""
                vc?.productId = self.passproductId ?? ""
                vc?.productName = self.passproductName ?? ""
                vc?.productImage = self.productImage ?? ""
                
            default:
                self.showAlert(withMessage: "Network Error")
            }
        }
    }
}
