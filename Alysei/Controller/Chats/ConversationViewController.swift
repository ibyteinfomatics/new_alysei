//
//  ConversationViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 11/08/21.
//

import UIKit
import Photos
import YPImagePicker
import IQKeyboardManagerSwift

enum FromVC {
    case UserTab
    case Notification
    case Login
    case Forget
    case Language
}

class ConversationViewController: AlysieBaseViewC {
    
    //MARK: Outlets
    @IBOutlet weak var viewNavigation: UIView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var chatTblView: UITableView!
    @IBOutlet weak var chatTextView: IQTextView!
    @IBOutlet weak var txtMsgHeightConstraint: NSLayoutConstraint!
    @IBOutlet var bottomViewBottmConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var btnBlock: UIButton!
    @IBOutlet weak var viewDots: UIView!
    @IBOutlet weak var viewList: UIView!
    @IBOutlet weak var viewDelete: UIView!
    @IBOutlet weak var sendView: UIView!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnGift: UIButton!
    
    @IBOutlet weak var btnDelete: UIButton!
    
    let textViewMaxHeight:CGFloat = 100.0
    let textViewMinHeight:CGFloat = 34.0
    
    var receiverid  =  String()
    var receivername = String()
    var fromvc: FromVC?
    var selectedChat = [String]()
    /*var receiverselectedChat = [String]()
    var senderselectedImageChat = [String]()
    var receiverselectedImgaeChat = [String]()*/
    
    var messages:[ReceivedMessageClass]?
    //var receiverDetails:RecentUser?
    var resentUserDetails = [RecentUser]()
    
    
    var name : String?
    var userId : String?
    var sendImage : UIImage?
    //var userName : String?
    var profileImageUrl : String?
    
    // camera image
    var ypImages = [YPMediaItem]()
    var imagesFromSource = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendView.layer.cornerRadius = 20
        sendView.layer.borderWidth = 1
        sendView.layer.borderColor = UIColor.lightGray.cgColor
        
        chatTblView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 10, right: 0)
        
       // print("image",kSharedUserDefaults.loggedInUserModal.avatar?.imageURL)
        
        initialSetup()
        registerNib()
        receiveMessage()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.navigationBar.isHidden = false
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        self.tabBarController?.tabBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.btnDelete.isHidden = true
        
        chatTblView.reloadData()
        self.chatTextView.returnKeyType = .next
    }
    
    
    //MARK:- Private Functions
    private func initialSetup() {
        chatTblView.rowHeight = UITableView.automaticDimension
        lblUserName.text = name
    }
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      self.viewNavigation.drawBottomShadow()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
        
        
    }
  
   /* @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.txtMsgHeightConstraint.constant = keyboardSize.height
            self.view.layoutIfNeeded()
            scrollToLastRow()
            
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
               chatTblView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height+chatTextView.frame.height, right: 0)
            }
            
        }
    }*/
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        chatTextView.resignFirstResponder()
        return true
    }
    
    /*@objc func keyboardWillHide(notification: NSNotification){
        self.txtMsgHeightConstraint.constant = 0
        
        chatTextView.inputView = nil
       
        self.view.layoutIfNeeded()
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            chatTblView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:0, right: 0)
            }
    }*/
    
    @objc func keyboardWillShow(notification: NSNotification) {
        var keyboardSize: CGSize = CGSize.zero
        if let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            keyboardSize = value.cgRectValue.size
            if MobileDeviceType.IS_IPHONE_X || MobileDeviceType.IS_IPHONE_X_MAX {
                bottomViewBottmConstraint.constant = keyboardSize.height-34
            }else {
                bottomViewBottmConstraint.constant = keyboardSize.height
            }
            self.view.layoutIfNeeded()
            scrollToLastRow()
            
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        bottomViewBottmConstraint.constant = 0
        self.view.layoutIfNeeded()
    }
    
    //Function for Register  Nib in for Table View
    private func registerNib() {
        self.chatTblView.register(UINib(nibName: cellidentifiers.SendertextCell, bundle: nil),   forCellReuseIdentifier: cellidentifiers.SendertextCell)
        self.chatTblView.register(UINib(nibName: cellidentifiers.Receivertextcell, bundle: nil),  forCellReuseIdentifier: cellidentifiers.Receivertextcell)
        self.chatTblView.register(UINib(nibName: cellidentifiers.SenderImageCell, bundle: nil), forCellReuseIdentifier: cellidentifiers.SenderImageCell)
        self.chatTblView.register(UINib(nibName: cellidentifiers.ReceiverImageCell, bundle: nil),forCellReuseIdentifier: cellidentifiers.ReceiverImageCell)
        self.chatTblView.register(UINib(nibName: cellidentifiers.SenderTextImageCell, bundle: nil), forCellReuseIdentifier: cellidentifiers.SenderTextImageCell)
        self.chatTblView.register(UINib(nibName: cellidentifiers.ReceiverTextImageCell, bundle: nil), forCellReuseIdentifier: cellidentifiers.ReceiverTextImageCell)
    }
  
    
    func scrollToLastRow() {
        DispatchQueue.main.async {
            if Int.getInt(self.messages?.count) != 0 {
                let indexPath = IndexPath(row: Int.getInt(self.messages?.count) - 1, section: 0)
                self.chatTblView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    
    //MARK:- func for receiveMessgae
    func receiveMessage() {
        kChatharedInstance.receivce_message(senderId: String.getString(kSharedUserDefaults.loggedInUserModal.userId), receiverId: String.getString(userId)) { (message, deletedMessage) in
            //chatInstanse.updateRecentChatMessageCount(receiverId: String.getString(self.receiverDetails?.receiverId), senderId: String.getString(self.receiverDetails?.senderId))
            self.messages?.removeAll()
            self.messages =  message
            self.chatTblView.reloadData()
            self.chatTextView.text = ""
            self.scrollToLastRow()
        }
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
        if fromvc == .Notification {
            kSharedAppDelegate.pushToTabBarViewC()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    
    @IBAction func btnDeleteTapped(_ sender: Any) {
        kChatharedInstance.deletePerticularMessage(msgId: self.selectedChat, user_id: (String.getString(kSharedUserDefaults.loggedInUserModal.userId))+"_"+(String.getString(userId)))
        
        kChatharedInstance.deletePerticularMessage(msgId: self.selectedChat, user_id: (String.getString(kSharedUserDefaults.loggedInUserModal.userId))+"_"+(String.getString(userId)))
        
       // self.senderselectedChat.removeAll()
        btnDelete.isHidden = true
        
    }
    
    @IBAction func btnMediaTapped(_ sender: Any) {
       
        chatTblView.reloadData()
//        ImagePickerHelper.shared.showCameraPickerController(reference: self) { (image) -> (Void) in
//            self.sendImage(image : image, check: true)
//        }
        
        var config = YPImagePickerConfiguration()
        config.screens = [.library, .photo]
        config.library.maxNumberOfItems = 1
        config.showsPhotoFilters = false

        config.library.preselectedItems = ypImages
        let picker = YPImagePicker(configuration: config)

        picker.didFinishPicking { [self, unowned picker] items, cancelled in
            self.ypImages = items
            for item in items {
                switch item {
                case .photo(let photo):
                    //self.imagesFromSource.append(photo.modifiedImage ?? photo.image)
                    //sendImage(image: photo.modifiedImage)
                    print(photo)
                    
                    let vc = pushViewController(withName: ImageWithText.id(), fromStoryboard: StoryBoardConstants.kChat) as! ImageWithText
                    vc.modalPresentationStyle = .overFullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    vc.image = photo.originalImage
                    vc.userId = userId
                    vc.name = name
                    vc.msg = chatTextView.text
                    vc.profileImageUrl = profileImageUrl
                    
                case .video(v: let v):
                    print("not used")
                }
            }
            picker.dismiss(animated: true, completion: nil)
        }

        self.present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func sendTextMessage(_ sender: Any) {
        if chatTextView.text != "" {
            self.sendMessage()
            chatTextView.text = ""
        }
    }
    
    func getcurrentdateWithTime(timeStamp :String?) -> String {
        let time = Double.getDouble(timeStamp) /// 1000
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "dd MMM YYYY"
        dateFormatter.locale =  Locale(identifier:  "en_US")
        let localDate = dateFormatter.string(from: date)
       
        let units = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second, .weekOfYear])
            let components = Calendar.current.dateComponents(units, from: date, to: Date())

            if components.year! > 0 {
                return "\(components.year!) " + (components.year! > 1 ? MarketPlaceConstant.kYearsAgo : MarketPlaceConstant.kYearAgo)

            } else if components.month! > 0 {
                return "\(components.month!) " + (components.month! > 1 ? MarketPlaceConstant.kMonthsAgo : MarketPlaceConstant.kMonthAgo)

            } else if components.weekOfYear! > 0 {
                return "\(components.weekOfYear!) " + (components.weekOfYear! > 1 ? MarketPlaceConstant.kWeeksAgo : MarketPlaceConstant.kWeekAgo)

            } else if (components.day! > 0) {
                return (components.day! > 1 ? "\(String.getString(localDate))" : MarketPlaceConstant.kYesterday)

            } else if components.hour! > 0 {
                return "\(components.hour!) " + (components.hour! > 1 ? MarketPlaceConstant.kHoursAgo :  MarketPlaceConstant.kHourAgo)

            } else if components.minute! > 0 {
                return "\(components.minute!) " + (components.minute! > 1 ? MarketPlaceConstant.kMinuteAgo : MarketPlaceConstant.kMinuteAgo)

            } else {
                return "\(components.second!) " + (components.second! > 1 ? MarketPlaceConstant.kSecondsAgo : MarketPlaceConstant.kSecondAgo)
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

//MARK:- UITextViewDelegate Methods
extension ConversationViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.contentSize.height >= self.textViewMaxHeight {
            txtMsgHeightConstraint.constant = self.textViewMaxHeight
        }
        else {
            txtMsgHeightConstraint.constant = max(textViewMinHeight, textView.contentSize.height)
        }
        
    }
    
    // hides text views
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.text = textView.text + "\n"
    //        textView.resignFirstResponder()
            return false
        }
        return true
    }
    // hides text fields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            textField.text = textField.text ?? "" + "\n"
    //        textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    /*func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            chatTextView.resignFirstResponder()
        }
        return true
    }*/
    
}

extension ConversationViewController : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages?.count ?? 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let objects = self.messages?[indexPath.row]
        if  objects?.messageFrom  == .sender {
            
            switch objects?.mediaType {
            
            case .text? :
                
                guard let textCell = tableView.dequeueReusableCell(withIdentifier: "SendertextCell") as? SendertextCell else {return UITableViewCell()}
                
                textCell.lblMessage.text = objects?.message
                textCell.likeImgView.isHidden = true
                let time = self.getcurrentdateWithTime(timeStamp: String.getString(objects?.timestamp))
                
                print("senderChatMessage--------",(objects?.message ?? "") ,"and its time",(time))
                textCell.bgView.layer.cornerRadius = 15
                textCell.bgView.layer.masksToBounds = true
                textCell.bgView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMinYCorner,.layerMinXMaxYCorner]
                
                textCell.lbltime.text = time
                
                textCell.LongDeleteCallBack = {
                    //textCell.bgView.backgroundColor = UIColor.darkGray
                    
                    if self.selectedChat.contains(obj: String.getString(objects?.uid)) {
                        textCell.bgView.backgroundColor = UIColor.init(red: 75.0/255.0, green: 179.0/255.0, blue: 253.0/255.0, alpha: 1.0)
                        
                        let index = self.selectedChat.firstIndex(of: String.getString(objects?.uid))
                        self.selectedChat.remove(at: index!)
                        
                    } else {
                        textCell.bgView.backgroundColor = UIColor.darkGray
                        self.selectedChat.append(String.getString(objects?.uid))
                    }
                    
                    if self.selectedChat.count > 0{
                        self.btnDelete.isHidden = false
                    } else {
                        self.btnDelete.isHidden = true
                    }
                    
                }
                
                return textCell
                
            case .photos? :
                
                guard let photoCell = tableView.dequeueReusableCell(withIdentifier: "SenderImageCell") as? SenderImageCell else {return UITableViewCell()}
                photoCell.sendimageView.setImage(withString: String.getString(objects?.mediaImage), placeholder: UIImage(named: "gallery_image"))
                photoCell.btnLike.isHidden = true
                
                let time = self.getcurrentdateWithTime(timeStamp: String.getString(objects?.timestamp))
                photoCell.time.text = time
                
                //OPEN IMAGE
                photoCell.openImageCallBack = {
                    
                    let story = UIStoryboard(name:"Chat", bundle: nil)
                    let controller = story.instantiateViewController(withIdentifier: "SeemImageVC") as! SeemImageVC
                    controller.url = String.getString(objects?.mediaImage)
                    
                    self.present(controller, animated: true)
                }
                
                photoCell.LongDeleteCallBack = {
                    //textCell.bgView.backgroundColor = UIColor.darkGray
                    
                    if self.selectedChat.contains(obj: String.getString(objects?.uid)) {
                        //textCell.bgView.backgroundColor = UIColor.init(red: 75.0/255.0, green: 179.0/255.0, blue: 253.0/255.0, alpha: 1.0)
                        
                        let index = self.selectedChat.firstIndex(of: String.getString(objects?.uid))
                        self.selectedChat.remove(at: index!)
                        
                    } else {
                        //textCell.bgView.backgroundColor = UIColor.darkGray
                        self.selectedChat.append(String.getString(objects?.uid))
                    }
                    
                    if self.selectedChat.count > 0 {
                        self.btnDelete.isHidden = false
                    } else {
                        self.btnDelete.isHidden = true
                    }
                    
                }
                
                return photoCell
                
            case .textphotos? :
                
                guard let photoCell = tableView.dequeueReusableCell(withIdentifier: "SenderTextImageCell") as? SenderTextImageCell else {return UITableViewCell()}
                photoCell.sendimageView.setImage(withString: String.getString(objects?.mediaImage), placeholder: UIImage(named: "gallery_image"))
                photoCell.btnLike.isHidden = true
                
                let time = self.getcurrentdateWithTime(timeStamp: String.getString(objects?.timestamp))
                photoCell.time.text = time
                photoCell.lblMessage.text = String.getString(objects?.message)
                
                photoCell.bgView.layer.cornerRadius = 10
                photoCell.bgView.layer.masksToBounds = true
                photoCell.bgView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMinYCorner,.layerMinXMaxYCorner,.layerMaxXMinYCorner]
                
                
                
                //OPEN IMAGE
                photoCell.openImageCallBack = {
                    
                    let story = UIStoryboard(name:"Chat", bundle: nil)
                    let controller = story.instantiateViewController(withIdentifier: "SeemImageVC") as! SeemImageVC
                    controller.url = String.getString(objects?.mediaImage)
                    
                    self.present(controller, animated: true)
                }
                
                photoCell.LongDeleteCallBack = {
                    //textCell.bgView.backgroundColor = UIColor.darkGray
                    
                    if self.selectedChat.contains(obj: String.getString(objects?.uid)) {
                        photoCell.bgView.backgroundColor = UIColor.init(red: 75.0/255.0, green: 179.0/255.0, blue: 253.0/255.0, alpha: 1.0)
                        let index = self.selectedChat.firstIndex(of: String.getString(objects?.uid))
                        self.selectedChat.remove(at: index!)
                        
                    } else {
                        photoCell.bgView.backgroundColor = UIColor.darkGray
                        self.selectedChat.append(String.getString(objects?.uid))
                    }
                    
                    if self.selectedChat.count > 0 {
                        self.btnDelete.isHidden = false
                    } else {
                        self.btnDelete.isHidden = true
                    }
                    
                }
                
                return photoCell
                
            default :
                return UITableViewCell()
            }
            
        }else  {
            
            switch objects?.mediaType {
            case .text? :
                guard let textCell = tableView.dequeueReusableCell(withIdentifier: "Receivertextcell") as? Receivertextcell else {return UITableViewCell()}
                
                textCell.lblMessage.text = objects?.message
                textCell.likeImgView.isHidden = true
                textCell.chatBoxView.layer.cornerRadius = 15
                textCell.chatBoxView.layer.masksToBounds = true
                textCell.chatBoxView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner]
                
                let time = self.getcurrentdateWithTime(timeStamp: String.getString(objects?.timestamp))
                print("receiverChatMessage--------",(objects?.message ?? "") ,"and its time",(time),"with time stamp",objects?.timestamp)
                textCell.lbltime.text = time
                
                textCell.LongDeleteCallBack = {
                    //textCell.bgView.backgroundColor = UIColor.darkGray
                    
                    if self.selectedChat.contains(obj: String.getString(objects?.uid)) {
                        textCell.chatBoxView.backgroundColor = UIColor.init(red: 229/255.0, green: 229/255.0, blue: 234/255.0, alpha: 1.0)
                        
                        let index = self.selectedChat.firstIndex(of: String.getString(objects?.uid))
                        self.selectedChat.remove(at: index!)
                        
                    } else {
                        textCell.chatBoxView.backgroundColor = UIColor.darkGray
                        self.selectedChat.append(String.getString(objects?.uid))
                    }
                    
                    if self.selectedChat.count > 0 {
                        self.btnDelete.isHidden = false
                    } else {
                        self.btnDelete.isHidden = true
                    }
                    
                }
                
                if String.getString(objects?.senderImage).contains(kImageBaseUrl) {
                    textCell.profile_image.setImage(withString: String.getString(objects?.senderImage), placeholder: UIImage(named: "image_placeholder"))
                } else {
                    let imgUrl = (objects?.base_url ?? "") + (objects?.senderImage ?? "")
                    textCell.profile_image.setImage(withString:String.getString(imgUrl), placeholder: UIImage(named: "image_placeholder"))
                }
                
                //textCell.profile_image.setImage(withString: String.getString(objects?.receiverImage), placeholder: UIImage(named: "image_placeholder"))
                textCell.profile_image.layer.cornerRadius = textCell.profile_image.frame.width/2
                
                return textCell
            case .photos? :
                
                guard let photoCell = tableView.dequeueReusableCell(withIdentifier: "ReceiverImageCell") as? ReceiverImageCell else {return UITableViewCell()}
                
                photoCell.receiveimageView.setImage(withString: String.getString(objects?.mediaImage), placeholder: UIImage(named: "gallery_image"))
                photoCell.btnLike.isHidden = true
                
                let time = self.getcurrentdateWithTime(timeStamp: String.getString(objects?.timestamp))
                
                photoCell.time.text = time
                
                photoCell.LongDeleteCallBack = {
                    //textCell.bgView.backgroundColor = UIColor.darkGray
                    
                    if self.selectedChat.contains(obj: String.getString(objects?.uid)) {
                        //textCell.bgView.backgroundColor = UIColor.init(red: 75.0/255.0, green: 179.0/255.0, blue: 253.0/255.0, alpha: 1.0)
                        
                        let index = self.selectedChat.firstIndex(of: String.getString(objects?.uid))
                        self.selectedChat.remove(at: index!)
                        
                    } else {
                        //textCell.bgView.backgroundColor = UIColor.darkGray
                        self.selectedChat.append(String.getString(objects?.uid))
                    }
                    
                    if self.selectedChat.count > 0 {
                        self.btnDelete.isHidden = false
                    } else {
                        self.btnDelete.isHidden = true
                    }
                    
                }
                
                //OPEN IMAGE
                photoCell.openImageCallBack = {
                    
                    let story = UIStoryboard(name:"Chat", bundle: nil)
                    let controller = story.instantiateViewController(withIdentifier: "SeemImageVC") as! SeemImageVC
                    controller.url = String.getString(objects?.mediaImage)
                    
                    self.present(controller, animated: true)
                }
                
                return photoCell
                
            case .textphotos? :
                
                guard let photoCell = tableView.dequeueReusableCell(withIdentifier: "ReceiverTextImageCell") as? ReceiverTextImageCell else {return UITableViewCell()}
                
                photoCell.receiveimageView.setImage(withString: String.getString(objects?.mediaImage), placeholder: UIImage(named: "gallery_image"))
                photoCell.btnLike.isHidden = true
                photoCell.lblMessage.text = String.getString(objects?.message)

                photoCell.bgView.layer.cornerRadius = 10
                photoCell.bgView.layer.masksToBounds = true
                photoCell.bgView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMinYCorner,.layerMinXMaxYCorner,.layerMaxXMinYCorner]
                
                
                let time = self.getcurrentdateWithTime(timeStamp: String.getString(objects?.timestamp))
                
                photoCell.time.text = time
                
                photoCell.LongDeleteCallBack = {
                    //textCell.bgView.backgroundColor = UIColor.darkGray
                    
                    if self.selectedChat.contains(obj: String.getString(objects?.uid)) {
                        photoCell.bgView.backgroundColor = UIColor.init(red: 75.0/255.0, green: 179.0/255.0, blue: 253.0/255.0, alpha: 1.0)
                        let index = self.selectedChat.firstIndex(of: String.getString(objects?.uid))
                        self.selectedChat.remove(at: index!)
                        
                    } else {
                        photoCell.bgView.backgroundColor = UIColor.darkGray
                        self.selectedChat.append(String.getString(objects?.uid))
                    }
                    
                   
                    if self.selectedChat.count > 0 {
                        self.btnDelete.isHidden = false
                    } else {
                        self.btnDelete.isHidden = true
                    }
                    
                }
                
                //OPEN IMAGE
                photoCell.openImageCallBack = {
                    
                    let story = UIStoryboard(name:"Chat", bundle: nil)
                    let controller = story.instantiateViewController(withIdentifier: "SeemImageVC") as! SeemImageVC
                    controller.url = String.getString(objects?.mediaImage)
                    
                    self.present(controller, animated: true)
                }
                
                return photoCell
            default :
                return UITableViewCell()
            }
            
        }
        
    }
    
}

extension ConversationViewController {
    
    func sendMessage() {
        //sender data
        let sendMessageDetails = ReceivedMessageClass()
        sendMessageDetails.receiverid = String.getString( userId)
        sendMessageDetails.senderid = String.getString(kSharedUserDefaults.loggedInUserModal.userId)
        sendMessageDetails.mediaType = .text
        sendMessageDetails.message = String.getString(self.chatTextView.text)
        
        sendMessageDetails.deleted = ""
        sendMessageDetails.like = false
        sendMessageDetails.chat_id = String.getString(kSharedUserDefaults.loggedInUserModal.userId)+"_"+String.getString( userId)
        
        if kSharedUserDefaults.loggedInUserModal.companyName != ""{
            sendMessageDetails.senderName = kSharedUserDefaults.loggedInUserModal.companyName
        } else if kSharedUserDefaults.loggedInUserModal.restaurantName != ""{
            sendMessageDetails.senderName = kSharedUserDefaults.loggedInUserModal.restaurantName
        } else if kSharedUserDefaults.loggedInUserModal.firstName != ""{
            sendMessageDetails.senderName = String.getString(kSharedUserDefaults.loggedInUserModal.firstName) + " " +  String.getString(kSharedUserDefaults.loggedInUserModal.lastName)
        }
        
        
        //sendMessageDetails.senderImage = kSharedUserDefaults.loggedInUserModal.avatar?.imageURL?.replacingOccurrences(of: imageDomain, with: "")
        
        sendMessageDetails.senderImage = kSharedUserDefaults.getProfilePic()
        
        //"public/uploads/2021/08/2327781571627986351.jpg"//kImageBaseUrl+UserDetailBasedElements().profilePhoto
        
        sendMessageDetails.receiverImage = profileImageUrl
        sendMessageDetails.receiverName = name
        sendMessageDetails.timestamp = String.getString(Int(Date().timeIntervalSince1970)) // * 1000))
        //sendMessageDetails.uid = String.getString(self.chatTextView.text)
        
        kChatharedInstance.send_message(messageDic: sendMessageDetails, senderId:  String.getString(kSharedUserDefaults.loggedInUserModal.userId), receiverId:String.getString(userId))
        //sendChatNotification(userId: self.receiverDetails?.receiverId ?? "")
        
        notificationApi(fromid: String.getString(kSharedUserDefaults.loggedInUserModal.userId), toid: String.getString(userId))
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
            
        }
        
    }
    
    
    
    //MARK:- Func for Send Image To server and save Data on Firebase
    
    
    
    
   /* func sendImage(image:UIImage) {
        
        
        let parameters: [String : Any] = [: ]
        
        let image: [String: Any] = [
            "image"                    : image ,
            "imageName"                : "file"
        ]
        
       // CommonUtils.showHudWithNoInteraction(show: true)
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName  :ServiceName.upload_get_file,
                                                         requestMethod  : .post,
                                                         requestImages  : [image],
                                                         requestVideos  : [:],
                                                         requestData    : parameters)
        {[weak self] (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            CommonUtils.showHudWithNoInteraction(show: false)
            guard self != nil else { return }
            if errorType == ErrorType.requestSuccess {
                let dicResponse     = kSharedInstance.getDictionary(result)
                
                
                switch Int.getInt(statusCode) {
                case 200:
                    
                    let data   = kSharedInstance.getDictionary(dicResponse[APIKeys.kData])
                    let imageUrl = (String.getString(data["file"]))
                    
                    let sendMessageDetails = MessageClass()
                    sendMessageDetails.senderId = String.getString(self?.userDetails["id"])
                    sendMessageDetails.receiverId = self?.receiverDetails?.receiverId
                    sendMessageDetails.receiverName = self?.receiverDetails?.receiverName
                    sendMessageDetails.mediaType = .image
                    sendMessageDetails.thumnilImageurl = String.getString(imageUrl)
                    chatInstanse.send_message(messageDic: sendMessageDetails, senderId:  String.getString(self?.userDetails["id"]), receiverId:String.getString( self?.receiverDetails?.receiverId))
                //    http://13.127.14.7/media/chat/chat339/3391582982513.jpeg
                case 400:
                    CommonUtils.showToast(message: String.getString(dicResponse[APIKeys.kMessgae]))
                case 403:
                    CommonUtils.showToast(message: String.getString(dicResponse[APIKeys.kMessgae]))
                default:
                    CommonUtils.showToast(message: String.getString(dicResponse[APIKeys.kMessgae]))
                }
            } else if errorType == ErrorType.noNetwork {
                CommonUtils.showToast(message: String.getString("No Netwrok"))
            } else {
                CommonUtils.showToast(message: String.getString("Server not Connect"))
            }
        }
    }*/


}
