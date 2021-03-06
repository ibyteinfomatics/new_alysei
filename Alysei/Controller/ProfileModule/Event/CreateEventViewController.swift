//
//  CreateEventViewController.swift
//  Profile Screen
//
//  Created by mac on 28/08/21.
//

import UIKit
import Photos
import YPImagePicker
import DropDown

class CreateEventViewController: UIViewController,UITextFieldDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var eventNameTxf: UITextField!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventNameView: UIView!
    @IBOutlet weak var hostNameView: UIView!
    @IBOutlet weak var hostNameView1: UIView!
    @IBOutlet weak var hostNameTxf: UITextField!
    @IBOutlet weak var hostNameLabel: UILabel!
    @IBOutlet weak var locationNameView: UIView!
    @IBOutlet weak var locationNameView1: UIView!
    @IBOutlet weak var locationNameTxf: UITextField!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateView1: UIView!
    @IBOutlet weak var dateTxf: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var timeView1: UIView!
    @IBOutlet weak var timeTxf: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionView1: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var websiteView: UIView!
    @IBOutlet weak var websiteTxf: UITextField!
    @IBOutlet weak var websiteView1: UIView!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var eventView1: UIView!
    @IBOutlet weak var eventTxf: UITextField!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var registrationView: UIView!
    @IBOutlet weak var registrationView1: UIView!
    @IBOutlet weak var registrationTxf: UITextField!
    @IBOutlet weak var registrationLabel: UILabel!
    
    @IBOutlet weak var cameraText: UILabel!
    @IBOutlet weak var cameraIcon: UIImageView!
    @IBOutlet weak var uploadImage: UIImageView!
    
    @IBOutlet weak var btnEvent: UIButton!
    @IBOutlet weak var btnResgstration: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var headerText: UILabel!
    @IBOutlet weak var drop1: UIButton!
    @IBOutlet weak var drop2: UIButton!
    @IBOutlet weak var bookingUrlView: UIView!
    @IBOutlet weak var bookingUrlView1: UIView!
    @IBOutlet weak var bookingTxf: UITextField!
    @IBOutlet weak var heightbookingUrl: NSLayoutConstraint!
    @IBOutlet weak var vwHeadBooking: UILabel!
    @IBOutlet weak var lblCountTxt: UILabel!
    @IBOutlet weak var lblMaximumText: UILabel!
    
    var hostname,location,date,time,eventname,fulldescription,website,eventYype,registrationType,imgurl,baseUrl,bookingUrl: String?
    var event_id: Int?
    var typeofpage: String?
    
    var picker = UIImagePickerController()
    
    var eventPhoto: UIImage?
    
    var dataDropDown = DropDown()
    var arrData = [AppConstants.kPublic,AppConstants.kPrivate]
    var arrDataResgistration = [AppConstants.kFree,AppConstants.kPaid,AppConstants.kBuyInvitation]
    
    // camera image
    var ypImages = [YPMediaItem]()
    var imagesFromSource = [UIImage]()
    
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    
    var uploadImageArray = [UIImage]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerText.text = AppConstants.kCreateEvent
        saveButton.setTitle(RecipeConstants.kSave, for: .normal)
        eventNameLabel.text = AppConstants.kEventName
        hostNameLabel.text = AppConstants.kHostName
        locationNameLabel.text = MarketPlaceConstant.kLocation
        dateLabel.text = AppConstants.kDate
        timeLabel.text = AppConstants.kTime
        descriptionLabel.text = MarketPlaceConstant.kDescription
        websiteLabel.text = MarketPlaceConstant.kCWebsite
        eventLabel.text = AppConstants.kEventCapType
        registrationLabel.text = AppConstants.kRegistrationCapType
        vwHeadBooking.text = AppConstants.kBookingUrl
        lblMaximumText.isHidden = false
        lblCountTxt.isHidden = false
        
        let websiteTap = UITapGestureRecognizer(target: self, action: #selector(openWebsite))
        self.websiteView.addGestureRecognizer(websiteTap)
        
        let bookingUrlTap = UITapGestureRecognizer(target: self, action: #selector(openBookingUrl))
        self.bookingUrlView.addGestureRecognizer(bookingUrlTap)
        
        self.property()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateEventViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        showDatePicker()
        
        showTimePicker()
        
        hostNameTxf.text = hostname
        locationNameTxf.text = location
        websiteTxf.text = website
        
        hostNameTxf.isUserInteractionEnabled = false
        locationNameTxf.isUserInteractionEnabled = false
        websiteTxf.isUserInteractionEnabled = false
        
        hostNameLabel.isHidden = false
        hostNameTxf.placeholder = ""
        hostNameView1.isHidden = false
     //   hostNameLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        hostNameLabel.textColor = UIColor.darkGray.withAlphaComponent(0.7)
        locationNameLabel.isHidden = false
        locationNameTxf.placeholder = ""
        locationNameView1.isHidden = false
        locationNameLabel.textColor =  UIColor.darkGray.withAlphaComponent(0.7)
        
        websiteLabel.isHidden = false
        websiteTxf.placeholder = ""
        websiteView1.isHidden = false
        websiteLabel.textColor =  UIColor.darkGray.withAlphaComponent(0.7)
        
        descriptionTextView.textContainer.heightTracksTextView = true
        descriptionTextView.isScrollEnabled = false
        bookingUrlView.isHidden = true
     //   bookingUrlView1.isHidden = true
        heightbookingUrl.constant = 0
        if eventname != nil {
            hostNameTxf.text = hostname
            eventNameTxf.text = eventname
            locationNameTxf.text = location
            bookingTxf.text = bookingUrl
            dateTxf.text = date
            timeTxf.text = time
            descriptionTextView.text = fulldescription
            descriptionTextView.textColor = .black
            websiteTxf.text = website
            eventTxf.text = eventYype
            registrationTxf.text = registrationType
            uploadImage.setImage(withString: String.getString(imgurl!), placeholder: UIImage(named: "image_placeholder"))
            self.cameraIcon.isHidden = true
            self.cameraText.isHidden = true
            
            eventNameLabel.isHidden = false
            eventNameTxf.placeholder = ""
            eventNameView.isHidden = false
            eventNameLabel.textColor = UIColor.darkGray.withAlphaComponent(0.7)
            bookingUrlView.isUserInteractionEnabled = true
            dateLabel.isHidden = false
            dateTxf.placeholder = ""
            dateView1.isHidden = false
            dateLabel.textColor =  UIColor.darkGray.withAlphaComponent(0.7)
            
            timeLabel.isHidden = false
            timeTxf.placeholder = ""
            timeView1.isHidden = false
            timeLabel.textColor =  UIColor.darkGray.withAlphaComponent(0.7)
            
            descriptionLabel.isHidden = false
            descriptionView1.isHidden = false
            //descriptionLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            descriptionLabel.textColor = UIColor.darkGray.withAlphaComponent(0.7)
            
            eventLabel.isHidden = false
            eventTxf.placeholder = ""
            eventView1.isHidden = false
            eventLabel.textColor =  UIColor.darkGray.withAlphaComponent(0.7)
            
            registrationLabel.isHidden = false
            registrationTxf.placeholder = ""
            registrationView1.isHidden = false
            registrationLabel.textColor =  UIColor.darkGray.withAlphaComponent(0.7)
            
           // bookingTxf.textColor = UIColor.black
            
            descriptionView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            nameView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            hostNameView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            locationNameView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            dateView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            timeView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            websiteView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            eventView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            registrationView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            
        }
        
        if typeofpage == "read" {
            
            headerText.text = "Event"
            drop1.isHidden = true
            drop2.isHidden = true
            saveButton.isHidden = true
            websiteTxf.textColor = UIColor.link
            bookingTxf.textColor = UIColor.link
            eventNameTxf.isUserInteractionEnabled = false
            dateTxf.isUserInteractionEnabled = false
            timeTxf.isUserInteractionEnabled = false
            descriptionTextView.isUserInteractionEnabled = false
            eventTxf.isUserInteractionEnabled = false
            registrationTxf.isUserInteractionEnabled = false
            lblMaximumText.isHidden = true
            lblCountTxt.isHidden = true
            if bookingUrl != "" || bookingUrl == nil {
                heightbookingUrl.constant = 60
                bookingUrlView.isHidden = false
                bookingUrlView1.isHidden = false
            
                vwHeadBooking.textColor = UIColor.darkGray.withAlphaComponent(0.7)
                bookingTxf.isHidden = false
                bookingTxf.isUserInteractionEnabled = false
            }else{
                bookingUrlView.isHidden = true
                bookingUrlView1.isHidden = true
                heightbookingUrl.constant = 0
                bookingTxf.isHidden = true
                bookingTxf.isUserInteractionEnabled = true
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func btnRegistrationDropDown(_ sender: UIButton){
        
        if typeofpage != "read" {
            openDropDownRegis()
        }
        
    }
    
    @IBAction func btnEventDropDown(_ sender: UIButton){
        
        if typeofpage != "read" {
            openDropDown()
        }
        
    }
    
    @IBAction func saveButton(_ sender: UIButton){
        
        if eventname != nil {
           
            if eventNameTxf.text == "" {
                alert(msg: AlertMessage.kPleaseEnterEvent)
            } else if dateTxf.text == "" {
                alert(msg: AlertMessage.kPleaseEnterDate)
            } else if timeTxf.text == "" {
                alert(msg: AlertMessage.kPleaseEnterTime)
            } else if descriptionTextView.text == "" {
                alert(msg: AlertMessage.kPleaseEnterDescription)
            } else if eventTxf.text == "" {
                alert(msg: AlertMessage.kPleaseSelectEventType)
            } else if registrationTxf.text == "" {
                alert(msg: AlertMessage.kPleaseSelectRegistrationType)
            } else if ((bookingUrlView.isHidden == false && bookingTxf.text == "") && (registrationTxf.text == AppConstants.kPaid)) {
                alert(msg: AlertMessage.kPleaseEnterBookingUrl)
            } else if ((bookingUrlView.isHidden == false && bookingTxf.text?.isURL() == false) && (registrationTxf.text == AppConstants.kPaid)) {
                alert(msg:AlertMessage.kPleaseEnterValidBookingUrl)
            } else {
                updateEventApi()
            }
            
        } else {
            
            
            if self.uploadImageArray.count == 0 {
                alert(msg: AlertMessage.kPleaseUploadEventImage)
            } else if eventNameTxf.text == "" {
                alert(msg: AlertMessage.kPleaseEnterEvent)
            } else if dateTxf.text == "" {
                alert(msg: AlertMessage.kPleaseEnterDate)
            } else if timeTxf.text == "" {
                alert(msg: AlertMessage.kPleaseEnterTime)
            } else if descriptionTextView.text == "" {
                alert(msg: AlertMessage.kPleaseEnterDescription)
            } else if eventTxf.text == "" {
                alert(msg:AlertMessage.kPleaseSelectEventType)
            } else if registrationTxf.text == "" {
                alert(msg: AlertMessage.kPleaseSelectRegistrationType)
            } else if ((bookingUrlView.isHidden == false && bookingTxf.text == "") && (registrationTxf.text == AppConstants.kPaid)) {
                alert(msg: AlertMessage.kPleaseEnterBookingUrl)
            }else if ((bookingUrlView.isHidden == false && bookingTxf.text?.isURL() == false) && (registrationTxf.text == AppConstants.kPaid)) {
                alert(msg:AlertMessage.kPleaseEnterValidBookingUrl)
            } else {
                createEventApi()
            }
        }
        
    }
   @objc func openWebsite(){
       guard let url = URL(string: websiteTxf.text ?? "") else {
         return //be safe
       }

       if #available(iOS 10.0, *) {
           UIApplication.shared.open(url, options: [:], completionHandler: nil)
       } else {
           UIApplication.shared.openURL(url)
       }
    }
    
    @objc func openBookingUrl(){
        guard let url = URL(string: bookingTxf.text ?? "") else {
          return //be safe
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
     }
    @objc func openDropDown(){
        dataDropDown.dataSource = self.arrData
        dataDropDown.show()
        dataDropDown.anchorView = self.btnEvent
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            //self.btnReport.setTitle(item, for: .normal)
            eventTxf.text = item
            
        }
        dataDropDown.cellHeight = 40
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .top
    }
    
    @objc func openDropDownRegis(){
        dataDropDown.dataSource = self.arrDataResgistration
        dataDropDown.show()
        dataDropDown.anchorView = self.btnResgstration
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            //self.btnReport.setTitle(item, for: .normal)
            registrationTxf.text = item
            if item == AppConstants.kPaid || item == AppConstants.kBuyInvitation{
                bookingUrlView.isHidden = false
                bookingUrlView1.isHidden = true
                vwHeadBooking.isHidden = true
                vwHeadBooking.textColor =  UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
                heightbookingUrl.constant = 60
            }else{
                bookingUrlView.isHidden = true
                bookingUrlView1.isHidden = true
                vwHeadBooking.isHidden = true
                heightbookingUrl.constant = 0
            }
            
        }
        dataDropDown.cellHeight = 40
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .top
    }
    
    @IBAction func btnMediaTapped(_ sender: Any) {
        
        if typeofpage != "read" {
            var config = YPImagePickerConfiguration()
            config.screens = [.library, .photo]
            config.library.maxNumberOfItems = 1
            config.showsPhotoFilters = true
            //config.showsCrop = .rectangle(ratio: 1.5)
            config.library.onlySquare = true
            config.library.preselectedItems = ypImages
            let picker = YPImagePicker(configuration: config)
            
            picker.didFinishPicking { [self, unowned picker] items, cancelled in
                self.ypImages = items
                for item in items {
                    switch item {
                    case .photo(let photo):
                        self.imagesFromSource.removeAll()
                        self.imagesFromSource.append(photo.modifiedImage ?? photo.image)
                        
                        uploadImageArray = [UIImage]()
                        uploadImageArray.append(self.imagesFromSource[0])
                        
                        self.uploadImage.image = photo.modifiedImage ?? photo.image
                        self.uploadImage.layer.cornerRadius = 4
                        
                        self.cameraIcon.isHidden = true
                        self.cameraText.isHidden = true
                        
                        print(photo)
                    case .video(v: let v):
                        print("not used")
                    }
                }
                picker.dismiss(animated: true, completion: nil)
            }
            
            self.present(picker, animated: true, completion: nil)
        }
        
    }
    
    private func alertToAddImage() -> Void {
        
        let alert:UIAlertController = UIAlertController(title: AlertMessage.kSourceType, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let cameraAction = UIAlertAction(title: AlertMessage.kTakePhoto,
                                         style: UIAlertAction.Style.default) { (action) in
            self.showImagePicker(withSourceType: .camera, mediaType: .image)
        }
        
        let galleryAction = UIAlertAction(title: AlertMessage.kChooseLibrary,
                                          style: UIAlertAction.Style.default) { (action) in
            self.showImagePicker(withSourceType: .photoLibrary, mediaType: .image)
        }
        
        let cancelAction = UIAlertAction(title: AlertMessage.kCancel,
                                         style: UIAlertAction.Style.cancel) { (action) in
            print("\(AlertMessage.kCancel) tapped")
        }
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showImagePicker(withSourceType type: UIImagePickerController.SourceType,mediaType: MediaType) -> Void {
        
        if UIImagePickerController.isSourceTypeAvailable(type) {
            
            self.picker.mediaTypes = mediaType.CameraMediaType
            self.picker.allowsEditing = true
            self.picker.sourceType = type
            self.present(self.picker,animated: true,completion: {
                self.picker.delegate = self
            })
            self.picker.delegate = self }
        else{
            self.showAlert(withMessage: "This feature is not available.")
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.eventNameTxf
        {
            self.eventNameLabel.isHidden = false
            self.eventNameTxf.placeholder = ""
            self.eventNameView.isHidden = false
            self.nameView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            
            eventNameLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
            
        }
        if textField == self.bookingTxf
        {
            self.vwHeadBooking.isHidden = false
            self.bookingTxf.placeholder = ""
            self.bookingUrlView.isHidden = false
            bookingUrlView1.isHidden = false
            vwHeadBooking.isHidden = false
            self.bookingUrlView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            
            vwHeadBooking.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
            
        }
        else if textField == self.hostNameTxf{
            
            self.hostNameLabel.isHidden = false
            self.hostNameTxf.placeholder = ""
            self.hostNameView1.isHidden = false
            self.hostNameView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            
            hostNameLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
            
        }
        else if textField == self.locationNameTxf{
            
            self.locationNameLabel.isHidden = false
            self.locationNameTxf.placeholder = ""
            self.locationNameView1.isHidden = false
            self.locationNameView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            
            locationNameLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
            
        }
        else if textField == self.dateTxf{
            
            self.dateLabel.isHidden = false
            self.dateTxf.placeholder = ""
            self.dateView1.isHidden = false
            self.dateView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            
            dateLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
            
        }
        
        else if textField == self.timeTxf{
            
            self.timeLabel.isHidden = false
            self.timeTxf.placeholder = ""
            self.timeView1.isHidden = false
            self.timeView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            
            timeLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
            
            
        }
        else if textField == self.websiteTxf{
            
            self.websiteLabel.isHidden = false
            self.websiteTxf.placeholder = ""
            self.websiteView1.isHidden = false
            self.websiteView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            
            websiteLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
            
            
        }
        
        else if textField == self.eventTxf{
            
            self.eventLabel.isHidden = false
            self.eventTxf.placeholder = ""
            self.eventView1.isHidden = false
            self.eventView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            
            eventLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
            
            
        }
        
        else if textField == self.registrationTxf{
            
            self.registrationLabel.isHidden = false
            self.registrationTxf.placeholder = ""
            self.registrationView1.isHidden = false
            self.registrationView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            
            registrationLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
            
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == self.descriptionTextView{
            
            if self.descriptionTextView.text == "Description" {
                self.descriptionTextView.text = nil
            }
           
            self.descriptionTextView.textColor = .black
            self.descriptionLabel.isHidden = false
            // self.timeTxf.placeholder = ""
            self.descriptionView1.isHidden = false
            self.descriptionView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            
            descriptionLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
            
            
            
            
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if textView == descriptionTextView{
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        let finalText = updatedText//.removeWhitespace()
        if finalText.count <= 300 {
            self.lblCountTxt.text = "\(finalText.count)"

            return true
        }else{
            if text == "" && range.length > 0  {
                print("Backspace was pressed")
                return true
            }
            else{
                return false
                
            }
            
        }
        }else{
            return true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == bookingTxf {
        if (registrationTxf.text == AppConstants.kPaid || registrationTxf.text == AppConstants.kBuyInvitation){
            if textField.text == "" {
                bookingTxf.text = "https://"
            }
        }
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == bookingTxf {
            if bookingTxf.text == "https://"{
                textField.text = ""
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        //Checkes if textfield is empty or not after after user ends editing.
        if textField == self.eventNameTxf
        {
            //if self.eventNameTxf.text == ""
           // {
                self.eventNameLabel.isHidden = false
             //   self.eventNameLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.eventNameLabel.textColor = UIColor.darkGray.withAlphaComponent(0.7)
            self.eventNameTxf.placeholder = AppConstants.kEventName
                self.eventNameView.isHidden = false
                nameView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            //}
            
            
        }
        if textField == self.bookingTxf
        {
            //if self.eventNameTxf.text == ""
           // {
                self.vwHeadBooking.isHidden = false
              //  self.vwHeadBooking.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.vwHeadBooking.textColor = UIColor.darkGray.withAlphaComponent(0.7)
            self.bookingTxf.placeholder = AppConstants.kBookingUrl
                self.bookingUrlView.isHidden = false
            bookingUrlView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            //}
            
            
        }
        else if textField == self.hostNameTxf
        {
           // if self.hostNameTxf.text == ""
            //{
                self.hostNameLabel.isHidden = false
               // self.hostNameLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.hostNameLabel.textColor = UIColor.darkGray.withAlphaComponent(0.7)
            self.hostNameTxf.placeholder = AppConstants.kHostName
                self.hostNameView1.isHidden = false
                hostNameView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
           // }
        }
        else if textField == self.locationNameTxf
        {
            //if self.locationNameTxf.text == ""
            //{
                self.locationNameLabel.isHidden = false
              //  self.locationNameLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.locationNameLabel.textColor = UIColor.darkGray.withAlphaComponent(0.7)
            self.locationNameTxf.placeholder = MarketPlaceConstant.kLocation
                self.locationNameView1.isHidden = false
                locationNameView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            //}
            
        }
        
        else if textField == self.dateTxf
        {
            //if self.dateTxf.text == ""
            //{
                self.dateLabel.isHidden = false
               // self.dateLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.dateLabel.textColor = UIColor.darkGray.withAlphaComponent(0.7)
            self.dateTxf.placeholder = AppConstants.kDate
                self.dateView1.isHidden = false
                dateView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            //}
            
            
        }
        else if textField == self.timeTxf
        {
            //if self.timeTxf.text == ""
           // {
                self.timeLabel.isHidden = false
              //  self.timeLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.timeLabel.textColor = UIColor.darkGray.withAlphaComponent(0.7)
            self.timeTxf.placeholder = AppConstants.kTime
                self.timeView1.isHidden = false
                timeView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                
                
           // }
        }
        
        else if textField == self.websiteTxf
        {
            //if self.websiteTxf.text == ""
            //{
                self.websiteLabel.isHidden = false
              //  self.websiteLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.websiteLabel.textColor = UIColor.darkGray.withAlphaComponent(0.7)
            self.websiteTxf.placeholder = MarketPlaceConstant.kCWebsite
                self.websiteView1.isHidden = false
                websiteView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                
                
            //}
        }
        
        else if textField == self.eventTxf
        {
           // if self.eventTxf.text == ""
           // {
                self.eventLabel.isHidden = false
           // self.eventLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.eventLabel.textColor = UIColor.darkGray.withAlphaComponent(0.7)
            self.eventTxf.placeholder = AppConstants.kEventCapType
                self.eventView1.isHidden = false
                eventView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                
                
           // }
        }
        else if textField == self.registrationTxf
        {
            //if self.registrationTxf.text == ""
           // {
                self.registrationLabel.isHidden = false
              //  self.registrationLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.registrationLabel.textColor = UIColor.darkGray.withAlphaComponent(0.7)
                self.registrationTxf.placeholder = AppConstants.kRegistrationCapType
                self.registrationView1.isHidden = false
                registrationView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                
                
            //}
        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == self.descriptionTextView
        {
            //if self.descriptionTextView.text == ""
           // {
                self.descriptionLabel.isHidden = false
              //  self.descriptionLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.descriptionLabel.textColor = UIColor.darkGray.withAlphaComponent(0.7)
               // self.descriptionTextView.text = "Description"
                self.descriptionView1.isHidden = false
                self.descriptionTextView.textColor = .black
                descriptionView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                
                
           // }
            
            
        }
        
        
    }
    
    func property(){
        
        eventNameLabel.isHidden =  true
        hostNameLabel.isHidden = true
        locationNameLabel.isHidden = true
        dateLabel.isHidden = true
        timeLabel.isHidden = true
        descriptionLabel.isHidden = true
        websiteLabel.isHidden = true
        eventLabel.isHidden = true
        registrationLabel.isHidden = true
        vwHeadBooking.isHidden = true
        
        descriptionTextView.text = AppConstants.kDescription
        descriptionTextView.textColor = .lightGray
      //  descriptionTextView.font = UIFont(name: "Helvetica-Neue", size: 18)
        
        eventNameView.isHidden = true
        hostNameView1.isHidden = true
        locationNameView1.isHidden = true
        dateView1.isHidden = true
        timeView1.isHidden = true
        descriptionView1.isHidden = true
        websiteView1.isHidden = true
        eventView1.isHidden = true
        registrationView1.isHidden = true
        if bookingUrl ==  nil || bookingUrl == "" {
        bookingUrlView1.isHidden = true
        vwHeadBooking.isHidden = true
        }else{
            bookingUrlView1.isHidden = false
            vwHeadBooking.isHidden = false
            vwHeadBooking.textColor =  UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        }
        
        
        eventNameTxf.autocorrectionType = .no
        hostNameTxf.autocorrectionType = .no
        locationNameTxf.autocorrectionType = .no
        dateTxf.autocorrectionType = .no
        timeTxf.autocorrectionType = .no
        descriptionTextView.autocorrectionType = .no
        websiteTxf.autocorrectionType = .no
        eventTxf.autocorrectionType = .no
        bookingTxf.autocorrectionType = .no
        
        
        
        eventNameTxf.delegate = self
        descriptionTextView.delegate = self
        headerView.layer.masksToBounds = false
        headerView.layer.shadowRadius = 2
        headerView.layer.shadowOpacity = 0.2
        headerView.layer.shadowColor = UIColor.lightGray.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0 , height:2)
        
        imageView.layer.cornerRadius = 4
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        nameView.layer.cornerRadius = 4
        nameView.layer.borderWidth = 2
        nameView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        hostNameView.layer.cornerRadius = 4
        hostNameView.layer.borderWidth = 2
        hostNameView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        locationNameView.layer.cornerRadius = 4
        locationNameView.layer.borderWidth = 2
        locationNameView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        bookingUrlView.layer.cornerRadius = 4
        bookingUrlView.layer.borderWidth = 2
        bookingUrlView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        dateView.layer.cornerRadius = 4
        dateView.layer.borderWidth = 2
        dateView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        timeView.layer.cornerRadius = 4
        timeView.layer.borderWidth = 2
        timeView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        descriptionView.layer.cornerRadius = 4
        descriptionView.layer.borderWidth = 2
        descriptionView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        websiteView.layer.cornerRadius = 4
        websiteView.layer.borderWidth = 2
        websiteView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        eventView.layer.cornerRadius = 4
        eventView.layer.borderWidth = 2
        eventView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        registrationView.layer.cornerRadius = 4
        registrationView.layer.borderWidth = 2
        registrationView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
    }
    @IBAction func dateTxf(_ sender: UITextField) {
        
    }
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        dateTxf.inputAccessoryView = toolbar
        dateTxf.inputView = datePicker
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateTxf.text = formatter.string(from: datePicker.date)
        
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    func showTimePicker(){
        //Formate Date
        
        // let formatter = DateFormatter.self
        timePicker.datePickerMode = .time
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(timePickerValueChanged));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker1));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        timeTxf.inputAccessoryView = toolbar
        timeTxf.inputView = timePicker
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = .wheels
        } else {
            
            // Fallback on earlier versions
        }
        
    }
    
    @objc func timePickerValueChanged(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss a"
        timeTxf.text = formatter.string(from: timePicker.date)
        
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker1(){
        self.view.endEditing(true)
    }
    
    
    func createEventApi(){
        
        let params: [String:Any] = [
            
            "event_name": eventNameTxf.text ?? "",
            "host_name": hostNameTxf.text ?? "",
            "location": locationNameTxf.text ?? "",
            "date": dateTxf.text ?? "",
            "time": timeTxf.text ?? "",
            "description": descriptionTextView.text ?? "",
            "website": websiteTxf.text ?? "",
            "event_type": eventTxf.text ?? "",
            "registration_type": registrationTxf.text ?? "",
            "url": bookingTxf.text ?? ""
            
        ]
        
        let imageParam : [String:Any] = [APIConstants.kImage: self.uploadImageArray[0],
                                         APIConstants.kImageName: "image_id"]
        
        CommonUtil.sharedInstance.postRequestToImageUpload(withParameter: params, url: APIUrl.kCreateEvent, image: imageParam, controller: self, type: 0)
        
    }
    
    
    func updateEventApi(){
        
        let params: [String:Any] = [
            
            "event_name": eventNameTxf.text ?? "",
            "host_name": hostNameTxf.text ?? "",
            "location": locationNameTxf.text ?? "",
            "date": dateTxf.text ?? "",
            "time": timeTxf.text ?? "",
            "description": descriptionTextView.text ?? "",
            "website": websiteTxf.text ?? "",
            "event_type": eventTxf.text ?? "",
            "registration_type": registrationTxf.text ?? "",
            "event_id": String.getString(event_id),
            "url": bookingTxf.text ?? ""
            
        ]
        
        
        
        let imageParam : [String:Any] = self.uploadImageArray.count > 0 ? [APIConstants.kImage: self.uploadImageArray[0],
                                                                           APIConstants.kImageName: "image_id"] : [:]
       
        CommonUtil.sharedInstance.postRequestToImageUpload(withParameter: params, url: APIUrl.kUpdateEvent, image: imageParam, controller: self, type: 0)
        
    }
    
    
    func alert(msg:String){
        let refreshAlert = UIAlertController(title: "Alert!!", message: msg, preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
           
            self.parent?.dismiss(animated: true, completion: nil)
        }))
        
        //let parent = self.parentViewController?.presentedViewController as? HubsListVC
        self.parent?.present(refreshAlert, animated: true, completion: nil)
    }
    
    
}

extension CreateEventViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        uploadImage.image  = tempImage
        self.dismiss(animated: true, completion: nil)
        
        /*guard let selectedImage = info[.editedImage] as? UIImage else { return }
         self.dismiss(animated: true) {
         
         self.eventPhoto = selectedImage
         self.uploadImage.image = selectedImage
         }*/
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}


extension CreateEventViewController{
    
    override func didUserGetData(from result: Any, type: Int) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
