//
//  InquiryConverstionController.swift
//  Alysei
//
//  Created by Gitesh Dang on 31/05/22.
//

import UIKit
import Photos
import YPImagePicker
import IQKeyboardManagerSwift
import DropDown

class InquiryConverstionController: AlysieBaseViewC {

    //
    //  InquiryConversation.swift
    //  Alysei
    //
    //  Created by Gitesh Dang on 09/11/21.
    //
        
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
        @IBOutlet weak var morebtn: UIButton!
        
        @IBOutlet weak var itemImg: UIImageView!
        @IBOutlet weak var itemName: UILabel!
        @IBOutlet weak var productView: UIView!
        
        @IBOutlet weak var deleteView: UIView!
        
        @IBOutlet weak var btnDelete: UIButton!
        
        let textViewMaxHeight:CGFloat = 100.0
        let textViewMinHeight:CGFloat = 34.0
        
        var new_opend = true
        
        var storeId = ""
        var storeName = ""
        var productId = ""
        var productName = ""
        var productImage = ""
        
        var receiverid  =  String()
        var receivername = String()
        var fromvc: FromVC?
        var selectedChat = [String]()
        /*var receiverselectedChat = [String]()
        var senderselectedImageChat = [String]()
        var receiverselectedImgaeChat = [String]()*/
        
        var messages: [OpenModel]?
        //var receiverDetails:RecentUser?
        var resentUserDetails = [InquiryRecentUser]()
        
        
        var name : String?
        var userId : String?
        var type: String?
        var sendImage : UIImage?
        //var userName : String?
        var profileImageUrl : String?
        
        // camera image
        var ypImages = [YPMediaItem]()
        var imagesFromSource = [UIImage]()
        
        var arrMoreType = ["Close Inquiry"]
        var dataDropDown = DropDown()
        var passProductImageUrl: String?
        var passProductName: String?
        var ResentUser:[InquiryRecentUser]?
        var position = 0
        var passProductId: String?
        var passReceiverId: String?
        var passProductEnquiryId: String?
    
       var sendChatImage: UIImage?
        override func viewDidLoad() {
            super.viewDidLoad()
            getMessage()
            sendView.layer.cornerRadius = 20
            sendView.layer.borderWidth = 1
            sendView.layer.borderColor = UIColor.lightGray.cgColor
            
            chatTblView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 10, right: 0)
            
           // print("image",kSharedUserDefaults.loggedInUserModal.avatar?.imageURL)
            
            initialSetup()
            registerNib()
           // receiveMessage()
            
            if type == "Closed" && ResentUser?[position].producerUserId == String.getString(kSharedUserDefaults.loggedInUserModal.userId){
                viewBottom.isHidden = true
            }
           
            if ((kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.producer.rawValue)") && (type == "open" || type == "new")) {
                morebtn.isHidden = true
            }else{
                morebtn.isHidden = false
            }
           
            // Do any additional setup after loading the view.
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            //self.navigationController?.navigationBar.isHidden = false
            IQKeyboardManager.shared.enable = false
            self.tabBarController?.tabBar.isHidden = true
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
            self.btnDelete.isHidden = true
            itemImg.setImage(withString: passProductImageUrl ?? "", placeholder: UIImage(named: "profile_icon"))
            
            itemName.text = passProductName
            print("profileImageUrl ",String.getString(profileImageUrl))
            self.chatTextView.returnKeyType = .next
            chatTblView.reloadData()
           
        }
        
        func openMoredropDown(){
            dataDropDown.dataSource = arrMoreType
            dataDropDown.show()
            getMessage()
            dataDropDown.anchorView = deleteView

            dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
            dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in

                updateEnquiryStatus()
                
//                let sendMessageDetails = InquiryReceivedMessageClass()
//                sendMessageDetails.receiverid = String.getString( userId)
//                sendMessageDetails.senderid = String.getString(kSharedUserDefaults.loggedInUserModal.userId)
//                sendMessageDetails.mediaType = .text
//                sendMessageDetails.message = self.ResentUser?[position].lastmessage
//
//                sendMessageDetails.deleted = ""
//                sendMessageDetails.like = false
//                sendMessageDetails.chat_id = String.getString(kSharedUserDefaults.loggedInUserModal.userId)+"_"+String.getString( userId)+"_"+productId
//
//                sendMessageDetails.storeId = self.ResentUser?[position].storeId
//                sendMessageDetails.storeName = self.ResentUser?[position].storeName
//                sendMessageDetails.productId = self.ResentUser?[position].productId
//                sendMessageDetails.productName = self.ResentUser?[position].productName
//                sendMessageDetails.productImage = self.ResentUser?[position].productImage
//                sendMessageDetails.producerUserId = String.getString( userId)
//
//                if kSharedUserDefaults.loggedInUserModal.companyName != ""{
//                    sendMessageDetails.senderName = kSharedUserDefaults.loggedInUserModal.companyName
//                } else if kSharedUserDefaults.loggedInUserModal.restaurantName != ""{
//                    sendMessageDetails.senderName = kSharedUserDefaults.loggedInUserModal.restaurantName
//                } else if kSharedUserDefaults.loggedInUserModal.firstName != ""{
//                    sendMessageDetails.senderName = String.getString(kSharedUserDefaults.loggedInUserModal.firstName)+String.getString(kSharedUserDefaults.loggedInUserModal.lastName)
//                }
//
//                sendMessageDetails.senderImage = kSharedUserDefaults.loggedInUserModal.avatar?.imageURL?.replacingOccurrences(of: imageDomain, with: "")
//
//                //"public/uploads/2021/08/2327781571627986351.jpg"//kImageBaseUrl+UserDetailBasedElements().profilePhoto
//
//                sendMessageDetails.receiverImage = self.ResentUser?[position].otherImage
//                sendMessageDetails.receiverName = self.ResentUser?[position].otherName
//                sendMessageDetails.timestamp = String.getString(self.ResentUser?[position].timestamp)
//
//                kChatharedInstance.inquiry_resentUser(messageDetails: sendMessageDetails, child: "Blocked")
//                self.navigationController?.popViewController(animated: true)
                
            }
            dataDropDown.cellHeight = 40
            dataDropDown.backgroundColor = UIColor.white
            dataDropDown.selectionBackgroundColor = UIColor.clear
            dataDropDown.direction = .bottom
        }
        
        
        //MARK:- Private Functions
        private func initialSetup() {
            chatTblView.rowHeight = UITableView.automaticDimension
            lblUserName.text = name
         
          //  self.itemName.text = productName
            
//            if productImage.contains(kImageBaseUrl) {
//                itemImg.setImage(withString: productImage, placeholder: UIImage(named: "image_placeholder"))
//            } else {
//                itemImg.setImage(withString: "https://alysei.s3.us-west-1.amazonaws.com/"+productImage, placeholder: UIImage(named: "image_placeholder"))
//            }
         //   itemImg.setImage(withString: productImage, placeholder: UIImage(named: "image_placeholder"))
        }
        
        override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
          self.productView.drawBottomShadow()
           // self.viewNavigation.layer.backgroundColor = UIColor.init(hexString: "#33A386").cgColor
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            IQKeyboardManager.shared.enable = true
            IQKeyboardManager.shared.enableAutoToolbar = true
            NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
            NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
            
            
        }
      
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            chatTextView.resignFirstResponder()
            return true
        }
        
        
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
//        func receiveMessage() {
//            kChatharedInstance.inquiryreceivce_message(senderId: String.getString(kSharedUserDefaults.loggedInUserModal.userId), receiverId: String.getString(userId), storeId: productId ) { (message, deletedMessage) in
//                //chatInstanse.updateRecentChatMessageCount(receiverId: String.getString(self.receiverDetails?.receiverId), senderId: String.getString(self.receiverDetails?.senderId))
//                self.messages?.removeAll()
//                self.messages =  message
//                self.chatTblView.reloadData()
//                self.scrollToLastRow()
//            }
//        }
        
        @IBAction func moreTapped(_ sender: UIButton) {
            openMoredropDown()
        }
        
        @IBAction func btnBackTapped(_ sender: UIButton) {
            
            if fromvc == .Notification {
                kSharedAppDelegate.pushToTabBarViewC()
            } else {
                self.navigationController?.popViewController(animated: true)
            }
            
            
        }
        
        
        @IBAction func btnDeleteTapped(_ sender: Any) {
            kChatharedInstance.deleteEnquiryPerticularMessage(msgId: self.selectedChat, user_id: (String.getString(kSharedUserDefaults.loggedInUserModal.userId))+"_"+(String.getString(userId))+"_"+productId)
            
            //kChatharedInstance.deleteEnquiryPerticularMessage(msgId: self.selectedChat, user_id: (String.getString(kSharedUserDefaults.loggedInUserModal.userId))+"_"+(String.getString(userId))+"_"+productId)
            
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
            config.showsPhotoFilters = true

            config.library.preselectedItems = ypImages
            let picker = YPImagePicker(configuration: config)

            picker.didFinishPicking { [self, unowned picker] items, cancelled in
                self.ypImages = items
                for item in items {
                    switch item {
                    case .photo(let photo):
                        //self.imagesFromSource.append(photo.modifiedImage ?? photo.image)
                      //  sendImage(image: photo.modifiedImage)
                        self.sendChatImage = photo.modifiedImage ?? photo.originalImage
                        self.apiSendMessage()
                        print(photo)
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
                //type = "Opened"
                
//                if new_opend == true {
//                    type = "New"
//                }
//
//                if type == "Closed"{
//                    morebtn.isHidden = false
//                }
                
               
                apiSendMessage()
            }
        }
        
        func getcurrentdateWithTime(timeStamp :String?) -> String {
            let time = Double.getDouble(timeStamp) /// 1000
            let date = Date(timeIntervalSince1970: time)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeZone = .current
            dateFormatter.dateFormat = "dd MMM YYYY"
            dateFormatter.locale =  Locale(identifier:  "en")
            let localDate = dateFormatter.string(from: date)
            
            let units = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second, .weekOfYear])
                let components = Calendar.current.dateComponents(units, from: date, to: Date())

            if components.year! > 0 {
                return "\(components.year!) " + (components.year! > 1 ? MarketPlaceConstant.kYearsAgo : MarketPlaceConstant.kYearAgo )

            } else if components.month! > 0 {
                return "\(components.month!) " + (components.month! > 1 ? MarketPlaceConstant.kMonthsAgo : MarketPlaceConstant.kMonthAgo)

            } else if components.weekOfYear! > 0 {
                return "\(components.weekOfYear!) " + (components.weekOfYear! > 1 ? MarketPlaceConstant.kWeeksAgo : MarketPlaceConstant.kWeekAgo)

            } else if (components.day! > 0) {
                return (components.day! > 1 ? "\(String.getString(localDate))" : MarketPlaceConstant.kYesterday)

            } else if components.hour! > 0 {
                return "\(components.hour!) " + (components.hour! > 1 ? MarketPlaceConstant.kHoursAgo : MarketPlaceConstant.kHourAgo)

            } else if components.minute! > 0 {
                return "\(components.minute!) " + (components.minute! > 1 ? MarketPlaceConstant.kMinutesAgo : MarketPlaceConstant.kMinuteAgo)

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
    extension InquiryConverstionController: UITextViewDelegate {
        
        func textViewDidChange(_ textView: UITextView) {
            
            if textView.contentSize.height >= self.textViewMaxHeight {
                txtMsgHeightConstraint.constant = self.textViewMaxHeight
            }
            else {
                txtMsgHeightConstraint.constant = max(textViewMinHeight, textView.contentSize.height)
            }
            
        }
        
        /*func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" {
                chatTextView.resignFirstResponder()
            }
            return true
        }*/
        
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
        
    }

    extension InquiryConverstionController : UITableViewDataSource , UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.messages?.count ?? 0
        }
        
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.producer.rawValue)"{
                if indexPath.row == 0 {
                    guard let textCell = tableView.dequeueReusableCell(withIdentifier: "Receivertextcell") as? Receivertextcell else {return UITableViewCell()}
                    textCell.configCell(self.messages?[indexPath.row] ?? OpenModel(with: [:]))
                        return textCell
                }else{
                    if kSharedUserDefaults.loggedInUserModal.userId  != "\(self.messages?[indexPath.row].receiver?.userId ?? 0)" && (self.messages?[indexPath.row].image_id == nil){
                        guard let textCell = tableView.dequeueReusableCell(withIdentifier: "SendertextCell") as? SendertextCell else {return UITableViewCell()}
                        textCell.likeImgView.isHidden = true
                        textCell.lblMessage.text = self.messages?[indexPath.row].message
                        let timeInterval  = self.messages?[indexPath.row].created_at ?? ""
                        print("timeInterval----------------------",timeInterval)
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        dateFormatter.locale = Locale(identifier: "en")
                        let date = dateFormatter.date(from: timeInterval)
                        let newDateFormatter = DateFormatter()
                        newDateFormatter.dateFormat = "HH:mm a"
                        let dateString = newDateFormatter.string(from: date ?? Date())
                        print("formatted date is =  \(dateString)")
                        textCell.lbltime.text = dateString
                        return textCell
                    }else if kSharedUserDefaults.loggedInUserModal.userId  != "\(self.messages?[indexPath.row].receiver?.userId ?? 0)" && (self.messages?[indexPath.row].image_id != nil){
                        guard let senderImageCell = tableView.dequeueReusableCell(withIdentifier: "SenderImageCell") as? SenderImageCell else {return UITableViewCell()}
                        let imageUrl = (self.messages?[indexPath.row].image_id?.baseUrl ?? "") + (self.messages?[indexPath.row].image_id?.attachmentURL ?? "")
                        senderImageCell.sendimageView.setImage(withString: imageUrl)
                        let timeInterval  = self.messages?[indexPath.row].created_at ?? ""
                        print("timeInterval----------------------",timeInterval)
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        dateFormatter.locale = Locale(identifier: "en")
                        let date = dateFormatter.date(from: timeInterval)
                        let newDateFormatter = DateFormatter()
                        newDateFormatter.dateFormat = "HH:mm a"
                        let dateString = newDateFormatter.string(from: date ?? Date())
                        print("formatted date is =  \(dateString)")
                        senderImageCell.time.text = dateString
                        senderImageCell.btnLike.isHidden = true
                        return senderImageCell
                    }else{
                        if self.messages?[indexPath.row].image_id == nil{
                        guard let textCell = tableView.dequeueReusableCell(withIdentifier: "Receivertextcell") as? Receivertextcell else {return UITableViewCell()}
                        textCell.likeImgView.isHidden = true
                        textCell.lblMessage.text = self.messages?[indexPath.row].message
                        let timeInterval  = self.messages?[indexPath.row].created_at ?? ""
                        print("timeInterval----------------------",timeInterval)
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        dateFormatter.locale = Locale(identifier: "en")
                        let date = dateFormatter.date(from: timeInterval)
                        let newDateFormatter = DateFormatter()
                        newDateFormatter.dateFormat = "HH:mm a"
                        let dateString = newDateFormatter.string(from: date ?? Date())
                        print("formatted date is =  \(dateString)")
                        textCell.lbltime.text = dateString
                        let image =  (self.messages?[indexPath.row].sender?.profile_img?.baseUrl ?? "") + (self.messages?[indexPath.row].sender?.profile_img?.attachmentUrl ?? "")
                        textCell.profile_image.setImage(withString: image,placeholder: UIImage(named: "image-placeholder"))
                        return textCell
                        }else{
                            guard let receiverImageCell = tableView.dequeueReusableCell(withIdentifier: "ReceiverImageCell") as? ReceiverImageCell else {return UITableViewCell()}
                            let imageUrl = (self.messages?[indexPath.row].image_id?.baseUrl ?? "") + (self.messages?[indexPath.row].image_id?.attachmentURL ?? "")
                            receiverImageCell.receiveimageView.setImage(withString: imageUrl)
                            
                            let timeInterval  = self.messages?[indexPath.row].created_at ?? ""
                            print("timeInterval----------------------",timeInterval)
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            dateFormatter.locale = Locale(identifier: "en")
                            let date = dateFormatter.date(from: timeInterval)
                            let newDateFormatter = DateFormatter()
                            newDateFormatter.dateFormat = "HH:mm a"
                            let dateString = newDateFormatter.string(from: date ?? Date())
                            print("formatted date is =  \(dateString)")
                            receiverImageCell.time.text = dateString
                            receiverImageCell.btnLike.isHidden = true
                            return receiverImageCell
                        }
                    }
                }
            }else{
            if indexPath.row == 0{
                   guard let textCell = tableView.dequeueReusableCell(withIdentifier: "SendertextCell") as? SendertextCell else {return UITableViewCell()}
                textCell.configCell(self.messages?[indexPath.row] ?? OpenModel(with: [:]))
                    return textCell
            }else{
                if kSharedUserDefaults.loggedInUserModal.userId  != "\(self.messages?[indexPath.row].receiver?.userId ?? 0)" && (self.messages?[indexPath.row].image_id == nil){
                    guard let textCell = tableView.dequeueReusableCell(withIdentifier: "SendertextCell") as? SendertextCell else {return UITableViewCell()}
                    textCell.likeImgView.isHidden = true
                    textCell.lblMessage.text = self.messages?[indexPath.row].message
                    let timeInterval  = self.messages?[indexPath.row].created_at ?? ""
                    print("timeInterval----------------------",timeInterval)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    dateFormatter.locale = Locale(identifier: "en")
                    let date = dateFormatter.date(from: timeInterval)
                    let newDateFormatter = DateFormatter()
                    newDateFormatter.dateFormat = "HH:mm a"
                    let dateString = newDateFormatter.string(from: date ?? Date())
                    print("formatted date is =  \(dateString)")
                    textCell.lbltime.text = dateString
                    return textCell
                }else if kSharedUserDefaults.loggedInUserModal.userId  != "\(self.messages?[indexPath.row].receiver?.userId ?? 0)" && (self.messages?[indexPath.row].image_id != nil){
                    guard let senderImageCell = tableView.dequeueReusableCell(withIdentifier: "SenderImageCell") as? SenderImageCell else {return UITableViewCell()}
                    let imageUrl = (self.messages?[indexPath.row].image_id?.baseUrl ?? "") + (self.messages?[indexPath.row].image_id?.attachmentURL ?? "")
                    senderImageCell.sendimageView.setImage(withString: imageUrl)
                    let timeInterval  = self.messages?[indexPath.row].created_at ?? ""
                    print("timeInterval----------------------",timeInterval)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    dateFormatter.locale = Locale(identifier: "en")
                    let date = dateFormatter.date(from: timeInterval)
                    let newDateFormatter = DateFormatter()
                    newDateFormatter.dateFormat = "HH:mm a"
                    let dateString = newDateFormatter.string(from: date ?? Date())
                    print("formatted date is =  \(dateString)")
                    senderImageCell.time.text = dateString
                    senderImageCell.btnLike.isHidden = true
                    return senderImageCell
                }else{
                    if self.messages?[indexPath.row].image_id == nil{
                    guard let textCell = tableView.dequeueReusableCell(withIdentifier: "Receivertextcell") as? Receivertextcell else {return UITableViewCell()}
                    textCell.likeImgView.isHidden = true
                    textCell.lblMessage.text = self.messages?[indexPath.row].message
                    let timeInterval  = self.messages?[indexPath.row].created_at ?? ""
                    print("timeInterval----------------------",timeInterval)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    dateFormatter.locale = Locale(identifier: "en")
                    let date = dateFormatter.date(from: timeInterval)
                    let newDateFormatter = DateFormatter()
                    newDateFormatter.dateFormat = "HH:mm a"
                    let dateString = newDateFormatter.string(from: date ?? Date())
                    print("formatted date is =  \(dateString)")
                    textCell.lbltime.text = dateString
                    let image =  (self.messages?[indexPath.row].sender?.profile_img?.baseUrl ?? "") + (self.messages?[indexPath.row].sender?.profile_img?.attachmentUrl ?? "")
                    textCell.profile_image.setImage(withString: image,placeholder: UIImage(named: "image-placeholder"))
                    return textCell
                    }else{
                        guard let receiverImageCell = tableView.dequeueReusableCell(withIdentifier: "ReceiverImageCell") as? ReceiverImageCell else {return UITableViewCell()}
                        let imageUrl = (self.messages?[indexPath.row].image_id?.baseUrl ?? "") + (self.messages?[indexPath.row].image_id?.attachmentURL ?? "")
                        receiverImageCell.receiveimageView.setImage(withString: imageUrl)
                        
                        let timeInterval  = self.messages?[indexPath.row].created_at ?? ""
                        print("timeInterval----------------------",timeInterval)
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        dateFormatter.locale = Locale(identifier: "en")
                        let date = dateFormatter.date(from: timeInterval)
                        let newDateFormatter = DateFormatter()
                        newDateFormatter.dateFormat = "HH:mm a"
                        let dateString = newDateFormatter.string(from: date ?? Date())
                        print("formatted date is =  \(dateString)")
                        receiverImageCell.time.text = dateString
                        receiverImageCell.btnLike.isHidden = true
                        return receiverImageCell
                    }
                }
            }
            }
           // return UITableViewCell()
            }
        
    }

    extension InquiryConverstionController {
        func getMessage(){

                let params: [String:Any] = [
                    APIConstants.kProductId: passProductId ?? "",
                    APIConstants.kSenderId: passReceiverId ?? ""
                ]
                TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.getInquiryMessage, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { result, error, errorType, statusCode in
                    
                    print(result)
                    if let result = result as? [String:Any] {

                        if let data = result["data"] as? [[String:Any]]{
                            self.messages = data.map({OpenModel.init(with: $0)})
                    }

                        self.chatTblView.reloadData()
                        self.scrollToLastRow()
                    }
                }
            }
        
        func apiSendMessage(){
            let params: [String:Any] = [
                APIConstants.kProductId : String.getString(passProductId ?? ""),
                APIConstants.kMessage: String.getString(chatTextView.text ?? ""),
                APIConstants.kReceiver_id : String.getString(passReceiverId)
             
            ]
            
            let imageParam : [String:Any] = [APIConstants.kImage: self.sendChatImage,
                                             APIConstants.kImageName: "image"]
            
            
            TANetworkManager.sharedInstance.requestMultiPart(withServiceName: APIUrl.kSendMessage, requestMethod: .post, requestImages: [imageParam], requestVideos: [:], requestData: params) {[weak self] result, error, errorType, statusCode in
                switch statusCode {
                case 200:
                    self?.chatTextView.text = ""
                    self?.sendChatImage = UIImage()
                    self?.getMessage()
                    self?.scrollToLastRow()
                    break
                default:
                    self?.showAlert(withMessage: "Error Occured")
                    break
                    
                }
                
            }
        }
        
        func updateEnquiryStatus(){
            
           let parameters: [String:Any] = [
            "marketplace_product_enquery_id": self.passProductEnquiryId ?? "",
            "status": "close",
            ]
            
            TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kEnquiryStatus, requestMethod: .POST, requestParameters: parameters, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
                switch statusCode {
                case 200:
                    self.morebtn.isHidden = true
                default:
                    print("Error")
                }
               
                
            }
        }
       func notificationApi(fromid: String, toid: String){
            
           let parameters: [String:Any] = [
                "from_id": fromid,
            "to_id": toid,
            "type": "enquery"]
            
            /*let parameters: [String:Any] = [
                "from_id": toid,
                "to_id": fromid]*/
          
            TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kSendNotification, requestMethod: .POST, requestParameters: parameters, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
                
            }
            
        }
        
    }

