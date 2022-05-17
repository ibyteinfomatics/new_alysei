//
//  ImageWithText.swift
//  Alysei
//
//  Created by Gitesh Dang on 24/02/22.
//

import UIKit
import IQKeyboardManagerSwift

class ImageWithText: AlysieBaseViewC {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var chatTextView: IQTextView!
    @IBOutlet weak var sendView: UIView!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var textViewHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var viewBottomConstraint     : NSLayoutConstraint!

    var image : UIImage?
    var shouldUpdateFocus = true
    var imagesFromSource = [UIImage]()
    
    var name : String?
    var userId : String?
    var msg : String?
    //var sendImage : UIImage?
    //var userName : String?
    var profileImageUrl : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        sendView.layer.cornerRadius = 20
        sendView.layer.borderWidth = 1
        sendView.layer.borderColor = UIColor.lightGray.cgColor
        
        img.image = image
        chatTextView.text = msg
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapBack(_ sender: UIButton) {
      
      self.navigationController?.popViewController(animated: true)
    }
    
    override func dismissKeyboard() {
            view.endEditing(true)
        self.viewBottomConstraint.constant = 20
        }
    
    override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            IQKeyboardManager.shared.enableAutoToolbar = true
            IQKeyboardManager.shared.enable = true
        }
    
    @IBAction func sendTextMessage(_ sender: Any) {
        
        self.imagesFromSource.append(image!)
        sendImage(image: image)
        
    }

    @objc func keyboardWillShow(_ notification: Notification) {
            if let keyboardFrame : NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                var keyboardHeight: CGFloat?
                shouldUpdateFocus = true
                if #available(iOS 11.0, *) {
                    keyboardHeight = keyboardRectangle.height - view.safeAreaInsets.bottom
                } else {
                    keyboardHeight = keyboardRectangle.height
                }
                UIView.animate(withDuration: 0.1, animations: {
                    self.viewBottomConstraint.constant = (keyboardHeight ?? 0)
                    self.view.layoutIfNeeded()
                }) { (succeed) in
//                    DispatchQueue.main.async {
//                      //  self.scrollToLastCell()
//                    }
                }
                
            }
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ImageWithText {
    
    
    
    func sendImage(image :UIImage?){
        self.sendButton.isUserInteractionEnabled = false
        let imageParam : [String:Any] = [APIConstants.kImage: self.imagesFromSource,
                                         APIConstants.kImageName: "media"]
        
        CommonUtil.showHudWithNoInteraction(show: true)
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName:APIUrl.kUploadMediaApi, requestMethod: .post, requestImages: [imageParam], requestVideos: [:], requestData: [:]) {[weak self] (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            CommonUtil.showHudWithNoInteraction(show: false)
            guard self != nil else { return }
            if errorType == ErrorType.requestSuccess {
                let dicResponse     = kSharedInstance.getDictionary(result)
                switch Int.getInt(statusCode) {
                case 200:
                 
                    //let data = kSharedInstance.getDictionary(dicResponse[kData])
                   
                    let mediaUrl = String.getString(dicResponse["media_url"])
                    print("media   "+mediaUrl)
                    
                    let sendMessageDetails = ReceivedMessageClass()
                    sendMessageDetails.receiverid = String.getString(self?.userId)
                    sendMessageDetails.senderid = String.getString(kSharedUserDefaults.loggedInUserModal.userId)
                    
                    if self?.chatTextView.text != "" {
                        sendMessageDetails.mediaType = .textphotos
                    } else {
                        sendMessageDetails.mediaType = .photos
                    }
                    
                    
                    sendMessageDetails.mediaImage = mediaUrl
                    sendMessageDetails.message = String.getString(self?.chatTextView.text)
                    
                    sendMessageDetails.deleted = ""
                    sendMessageDetails.like = false
                    sendMessageDetails.chat_id = String.getString(kSharedUserDefaults.loggedInUserModal.userId)+"_"+String.getString( self?.userId)
                    
                    if kSharedUserDefaults.loggedInUserModal.companyName != ""{
                        sendMessageDetails.senderName = kSharedUserDefaults.loggedInUserModal.companyName
                    } else if kSharedUserDefaults.loggedInUserModal.restaurantName != ""{
                        sendMessageDetails.senderName = kSharedUserDefaults.loggedInUserModal.restaurantName
                    } else if kSharedUserDefaults.loggedInUserModal.firstName != ""{
                        sendMessageDetails.senderName = String.getString(kSharedUserDefaults.loggedInUserModal.firstName)+String.getString(kSharedUserDefaults.loggedInUserModal.lastName)
                    }
                    
                    sendMessageDetails.senderImage =  kSharedUserDefaults.loggedInUserModal.avatar?.imageURL?.replacingOccurrences(of: imageDomain, with: "")
                    
                    sendMessageDetails.receiverImage = self?.profileImageUrl
                    sendMessageDetails.receiverName = self?.name
                    sendMessageDetails.timestamp = String.getString(Int(Date().timeIntervalSince1970)) // * 1000))
                    //sendMessageDetails.uid = String.getString(self!.chatTextView.text)
                    
                    kChatharedInstance.send_message(messageDic: sendMessageDetails, senderId:  String.getString(kSharedUserDefaults.loggedInUserModal.userId), receiverId:String.getString( self?.userId))
                    
                    self?.notificationApi(fromid: String.getString(kSharedUserDefaults.loggedInUserModal.userId), toid: String.getString(self?.userId))

                case 400:
                    self?.sendButton.isUserInteractionEnabled = true
                    self?.showAlert(withMessage: String.getString(dicResponse["message"]))
                    
                default:
                    self?.sendButton.isUserInteractionEnabled = true
                    CommonUtil.showHudWithNoInteraction(show: false)
                    self?.showAlert(withMessage: String.getString(dicResponse["message"]))
                    
                }
            } else if errorType == ErrorType.noNetwork {
                CommonUtil.showHudWithNoInteraction(show: false)
                self?.showAlert(withMessage: String.getString("no network"))
            } else {
                CommonUtil.showHudWithNoInteraction(show: false)
                self?.showAlert(withMessage: String.getString("no network"))
            }
        }
    }
    
    func notificationApi(fromid: String, toid: String){
        
       let parameters: [String:Any] = [
            "from_id": fromid,
            "to_id": toid,
            "type": "chat"]
        
        /*let parameters: [String:Any] = [
            "from_id": toid,
            "to_id": fromid]*/
      
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kSendNotification, requestMethod: .POST, requestParameters: parameters, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}
