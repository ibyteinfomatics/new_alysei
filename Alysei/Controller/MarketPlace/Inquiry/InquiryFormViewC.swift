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
    @IBOutlet weak var vwInquiry: UIView!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnSendInquiry: UIButton!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblStoreContact: UILabel!

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
        vwInquiry.drawBottomShadow()
        lblHeading.text = MarketPlaceConstant.kSendInquiry
        lblFullName.text = MarketPlaceConstant.kFullName + "*"
        lblEmail.text = MarketPlaceConstant.kEmail + "*"
        lblMessage.text = MarketPlaceConstant.kMessage + "*"
        lblPhoneNumber.text = MarketPlaceConstant.kPhoneNumber + "*"
        //lblStoreContact.text = MarketPlaceConstant.
        btnSendInquiry.setTitle(MarketPlaceConstant.kSendInquiry, for: .normal)
        setData()
       
        // Do any additional setup after loading the view.
    }
    
    func setData(){
        lblProductDesc.text = passproductName?.capitalized
        lblProductPrice.text = "$" + "\(passProductPrice ?? "")"
        txtMessage.text = MarketPlaceConstant.kIsProductAvailable
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
        if txtMessage.text == MarketPlaceConstant.kMarkMessage{
            self.showAlert(withMessage: MarketPlaceConstant.KEnterSomeMessage)
        }else{
        self.callSaveInquiryApi()
            
            /*self.sendMessage()
            let vc = self.pushViewController(withName: InquiryConversation.id(), fromStoryboard: StoryBoardConstants.kChat) as? InquiryConversation
            vc?.name = self.name ?? ""
            vc?.userId = self.userId ?? ""
            vc?.profileImageUrl = self.profileImageUrl ?? ""
            vc?.storeId = self.storeId ?? ""
            vc?.type = "New"
            vc?.storeName = self.storeName ?? ""
            vc?.productId = self.passproductId ?? ""
            vc?.productName = self.passproductName ?? ""
            vc?.productImage = self.productImage ?? ""*/

        }
    }
    
    func sendMessage() {
        //sender data
        var name = ""
        
        let sendMessageDetails = InquiryReceivedMessageClass()
        sendMessageDetails.receiverid = String.getString( userId)
        sendMessageDetails.senderid = String.getString(kSharedUserDefaults.loggedInUserModal.userId)
        sendMessageDetails.mediaType = .text
       
        
        sendMessageDetails.deleted = ""
        sendMessageDetails.like = false
        sendMessageDetails.chat_id = String.getString(kSharedUserDefaults.loggedInUserModal.userId)+"_"+String.getString( userId)+"_"+String.getString(self.passproductId)
        
        sendMessageDetails.storeId = storeId
        sendMessageDetails.storeName = storeName
        sendMessageDetails.productId = self.passproductId
        sendMessageDetails.productName = self.passproductName
        sendMessageDetails.productImage = productImage
        sendMessageDetails.producerUserId = String.getString(userId)
        
        if kSharedUserDefaults.loggedInUserModal.companyName != ""{
            sendMessageDetails.senderName = kSharedUserDefaults.loggedInUserModal.companyName
            name = kSharedUserDefaults.loggedInUserModal.companyName ?? ""
        } else if kSharedUserDefaults.loggedInUserModal.restaurantName != ""{
            sendMessageDetails.senderName = kSharedUserDefaults.loggedInUserModal.restaurantName
            name = kSharedUserDefaults.loggedInUserModal.restaurantName ?? ""
        } else if kSharedUserDefaults.loggedInUserModal.firstName != ""{
            sendMessageDetails.senderName = String.getString(kSharedUserDefaults.loggedInUserModal.firstName)+String.getString(kSharedUserDefaults.loggedInUserModal.lastName)
            name = String.getString(kSharedUserDefaults.loggedInUserModal.firstName)+String.getString(kSharedUserDefaults.loggedInUserModal.lastName)
        }
        
        sendMessageDetails.message = name+"\n"+String.getString(kSharedUserDefaults.loggedInUserModal.email)+"\n"+String.getString(kSharedUserDefaults.loggedInUserModal.phone)+"\n"+txtMessage.text
        
        sendMessageDetails.senderImage = kSharedUserDefaults.loggedInUserModal.avatar?.imageURL?.replacingOccurrences(of: imageDomain, with: "")
        
        //"public/uploads/2021/08/2327781571627986351.jpg"//kImageBaseUrl+UserDetailBasedElements().profilePhoto
        
        sendMessageDetails.receiverImage = profileImageUrl
        sendMessageDetails.receiverName = name
        sendMessageDetails.timestamp = String.getString(Int(Date().timeIntervalSince1970 * 1000))
        //sendMessageDetails.uid = String.getString(self.chatTextView.text)
        
        kChatharedInstance.inquirysend_message(child: "New", messageDic: sendMessageDetails, senderId:  String.getString(kSharedUserDefaults.loggedInUserModal.userId), receiverId:String.getString(userId), storeId: self.passproductId ?? "")
        //sendChatNotification(userId: self.receiverDetails?.receiverId ?? "")
        
        //notificationApi(fromid: String.getString(kSharedUserDefaults.loggedInUserModal.userId), toid: String.getString(userId))
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
                self.sendMessage()
                let vc = self.pushViewController(withName: InquiryConversation.id(), fromStoryboard: StoryBoardConstants.kChat) as? InquiryConversation
                vc?.name = self.name ?? ""
                vc?.userId = self.userId ?? ""
                vc?.profileImageUrl = self.profileImageUrl ?? ""
                vc?.storeId = self.storeId ?? ""
                vc?.type = "New"
                vc?.storeName = self.storeName ?? ""
                vc?.productId = self.passproductId ?? ""
                vc?.productName = self.passproductName ?? ""
                vc?.productImage = self.productImage ?? ""
            case 409:
                self.showAlert(withMessage: MarketPlaceConstant.kSubmitQuery)
            default:
                self.showAlert(withMessage: MarketPlaceConstant.kNetworkError)
            }
        }
    }
}
