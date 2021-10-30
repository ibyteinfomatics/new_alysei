//
//  AddAward.swift
//  Alysei
//
//  Created by Gitesh Dang on 27/10/21.
//

import UIKit
import Photos
import YPImagePicker
import DropDown

class AddAward: AlysieBaseViewC,UITextFieldDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var urlView: UIView!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var placeView: UIView!
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var eventView1: UIView!
    @IBOutlet weak var eventNameTxf: UITextField!
    
    @IBOutlet weak var productView1: UIView!
    @IBOutlet weak var productNameTxf: UITextField!
    
    @IBOutlet weak var urlView1: UIView!
    @IBOutlet weak var urlNameTxf: UITextField!
    
    @IBOutlet weak var placeView1: UIView!
    @IBOutlet weak var placeNameTxf: UITextField!
    @IBOutlet weak var placeBtton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBOutlet weak var cameraText: UILabel!
    @IBOutlet weak var cameraIcon: UIImageView!
    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var imageView: UIView!
    
    var eventName,productName,url,placeName,imgurl: String?
    var award_id: Int?
    var typeofpage,medal_id: String?
    
    var picker = UIImagePickerController()
    var eventPhoto: UIImage?
    var ypImages = [YPMediaItem]()
    var imagesFromSource = [UIImage]()
    var uploadImageArray = [UIImage]()
    
    var medalarrData = [String]()
    var medalIdarrData = [String]()
    var dataDropDown = DropDown()
    var medaModel:AwardMedalModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        property()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddAward.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        if eventName != nil {
            
            uploadImage.setImage(withString: String.getString(kImageBaseUrl+imgurl!), placeholder: UIImage(named: "image_placeholder"))
            
            
            eventNameTxf.text = eventName
            productNameTxf.text = productName
            urlNameTxf.text = url
            placeNameTxf.text = placeName
            
            
            eventLabel.isHidden = false
            eventNameTxf.placeholder = ""
            eventView1.isHidden = false
            eventLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            
            productLabel.isHidden = false
            productNameTxf.placeholder = ""
            productView1.isHidden = false
            productLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            
            urlLabel.isHidden = false
            urlNameTxf.placeholder = ""
            urlView1.isHidden = false
            urlLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            
            placeLabel.isHidden = false
            placeNameTxf.placeholder = ""
            placeView1.isHidden = false
            placeLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            
        }
        
        
        if typeofpage == "read" {
            
            self.cameraIcon.isHidden = true
            self.cameraText.isHidden = true
            saveButton.isHidden = true
            eventNameTxf.isUserInteractionEnabled = false
            productNameTxf.isUserInteractionEnabled = false
            urlNameTxf.isUserInteractionEnabled = false
            
        } else {
            getModelList()
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func placeBtn(_ sender: UIButton){
        
        if typeofpage != "read" {
            openDropDown()
        }
        
        
    }
    
    @IBAction func saveButton(_ sender: UIButton){
        
        if eventName != nil {
            
            if eventNameTxf.text == "" {
                alert(msg: "Please enter competition name!")
            } else if productNameTxf.text == "" {
                alert(msg: "Please enter winning product name!")
            } else if placeNameTxf.text == "" {
                alert(msg: "Please enter medal name!")
            } else if urlNameTxf.text == "" {
                alert(msg: "Please enter competition URL!")
            } /*else if String.getString(self.urlNameTxf.text).isURL() == false{
                alert(msg: "Please enter valid competition URL!")
            }*/ else {
                updateRewardApi()
            }
            
        } else {
            
            if self.uploadImageArray.count == 0 {
                alert(msg: "Please upload competition image!")
            } else if eventNameTxf.text == "" {
                alert(msg: "Please enter competition name!")
            } else if productNameTxf.text == "" {
                alert(msg: "Please enter winning product name!")
            } else if placeNameTxf.text == "" {
                alert(msg: "Please enter medal name!")
            } else if urlNameTxf.text == "" {
                alert(msg: "Please enter competition URL!")
            } /*else if String.getString(self.urlNameTxf.text).isURL() == false{
                alert(msg: "Please enter valid competition URL!")
            }*/ else {
                createRewardApi()
            }
            
            
        }
        
    }
    
    @IBAction func btnMediaTapped(_ sender: Any) {
        
        if typeofpage != "read" {
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
    
    @objc func openDropDown(){
        dataDropDown.dataSource = self.medalarrData
        dataDropDown.show()
        dataDropDown.anchorView = self.placeBtton
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            //self.btnReport.setTitle(item, for: .normal)
            placeNameTxf.text = item
            medal_id = self.medalIdarrData[index]
            
        }
        dataDropDown.cellHeight = 40
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .top
    }
    
    
    func property(){
        
        eventView.isHidden =  true
        eventLabel.isHidden =  true
        
        productView.isHidden =  true
        productLabel.isHidden =  true
        
        urlView.isHidden =  true
        urlLabel.isHidden =  true
        
        placeView.isHidden =  true
        placeLabel.isHidden =  true
        
        eventNameTxf.autocorrectionType = .no
        productNameTxf.autocorrectionType = .no
        urlNameTxf.autocorrectionType = .no
        
        eventView1.layer.cornerRadius = 4
        eventView1.layer.borderWidth = 2
        eventView1.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        productView1.layer.cornerRadius = 4
        productView1.layer.borderWidth = 2
        productView1.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        urlView1.layer.cornerRadius = 4
        urlView1.layer.borderWidth = 2
        urlView1.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        placeView1.layer.cornerRadius = 4
        placeView1.layer.borderWidth = 2
        placeView1.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        imageView.layer.cornerRadius = 4
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.eventNameTxf{
            
            self.eventLabel.isHidden = false
            self.eventNameTxf.placeholder = ""
            self.eventView.isHidden = false
            self.eventView1.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            eventLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)

        }
        
        
        if textField == self.productNameTxf{
            
            self.productLabel.isHidden = false
            self.productNameTxf.placeholder = ""
            self.productView.isHidden = false
            self.productView1.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            productLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)

        }
        
        
        if textField == self.urlNameTxf{
            
            self.urlLabel.isHidden = false
            self.urlNameTxf.placeholder = ""
            self.urlView.isHidden = false
            self.urlView1.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            urlLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)

        }
        
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.eventNameTxf {
            
            self.eventLabel.isHidden = false
            self.eventLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.eventNameTxf.placeholder = "Name of Competition / Event"
            self.eventView.isHidden = false
            eventView1.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
           
        }
        
        if textField == self.productNameTxf {
            
            self.productLabel.isHidden = false
            self.productLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.productNameTxf.placeholder = "Name of Winning Product"
            self.productView.isHidden = false
            productView1.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
           
        }
        
        if textField == self.urlNameTxf {
            
            self.urlLabel.isHidden = false
            self.urlLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.urlNameTxf.placeholder = "Competition URL"
            self.urlView.isHidden = false
            urlView1.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
           
        }
        
    }
    
    private func getModelList() -> Void{
      
      disableWindowInteraction()
    
      TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kAwardMedal, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
          let dictResponse = dictResponse as? [String:Any]
          
          self.medaModel = AwardMedalModel.init(with: dictResponse)
            
          for i in 0..<(self.medaModel?.data?.count)! {
                self.medalarrData.append(self.medaModel?.data?[i].name ?? "")
                self.medalIdarrData.append(String.getString(self.medaModel?.data?[i].medal_id))
          }
        
      }
      
    }
    
    
    func createRewardApi(){
        
        let params: [String:Any] = [
            "award_name": eventNameTxf.text ?? "",
            "winning_product": productNameTxf.text ?? "",
            "medal_id": String.getString(medal_id),
            "competition_url": urlNameTxf.text ?? "",]
        
        let imageParam : [String:Any] = [APIConstants.kImage: self.uploadImageArray[0],
                                         APIConstants.kImageName: "image_id"]
        
        CommonUtil.sharedInstance.postRequestToImageUpload(withParameter: params, url: APIUrl.kAwardCreate, image: imageParam, controller: self, type: 0)
        
    }
    
    
    func updateRewardApi(){
        
        let params: [String:Any] = [
            "award_name": eventNameTxf.text ?? "",
            "winning_product": productNameTxf.text ?? "",
            "medal_id": String.getString(medal_id),
            "competition_url": urlNameTxf.text ?? "",
            "award_id": String.getString(award_id),]
        
        let imageParam : [String:Any] = self.uploadImageArray.count > 0 ? [APIConstants.kImage: self.uploadImageArray[0],
                                                                           APIConstants.kImageName: "image_id"] : [:]
       
        CommonUtil.sharedInstance.postRequestToImageUpload(withParameter: params, url: APIUrl.kAwardUpdate, image: imageParam, controller: self, type: 0)
        
    }
    
    
    func alert(msg:String){
        let refreshAlert = UIAlertController(title: "Alert!!", message: msg, preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
           
            self.parent?.dismiss(animated: true, completion: nil)
        }))
        
        //let parent = self.parentViewController?.presentedViewController as? HubsListVC
        self.parent?.present(refreshAlert, animated: true, completion: nil)
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
extension AddAward{
    
    override func didUserGetData(from result: Any, type: Int) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
