//
//  CreateTripsViewController.swift
//  Profile Screen
//
//  Created by mac on 02/09/21.
//

import UIKit
import Photos
import YPImagePicker
import DropDown

class CreateTripsViewController: AlysieBaseViewC,UITextFieldDelegate,UITextViewDelegate {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var tripNameView: UIView!
    @IBOutlet weak var tripNameTxf: UITextField!
    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var tripNameView1: UIView!
    @IBOutlet weak var travelAgencyView: UIView!
    @IBOutlet weak var travelAgencyView1: UIView!
    @IBOutlet weak var travelAgencyTxf: UITextField!
    @IBOutlet weak var travelAgencyLabel: UILabel!
    @IBOutlet weak var regionView: UIView!
    @IBOutlet weak var regionView1: UIView!
    @IBOutlet weak var regionTxf: UITextField!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var adventuresView: UIView!
    @IBOutlet weak var adventuresView1: UIView!
    @IBOutlet weak var adventuresTxf: UITextField!
    @IBOutlet weak var adventuresLabel: UILabel!
    @IBOutlet weak var durationView: UIView!
    @IBOutlet weak var durationView1: UIView!
    @IBOutlet weak var durationTxf: UITextField!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var intensityView: UIView!
    @IBOutlet weak var intensityView1: UIView!
    @IBOutlet weak var intensityTxf: UITextField!
    @IBOutlet weak var intensityLabel: UILabel!
    @IBOutlet weak var websiteView: UIView!
    @IBOutlet weak var websiteTxf: UITextField!
    @IBOutlet weak var websiteView1: UIView!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var priceTxf: UITextField!
    @IBOutlet weak var priceView1: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionView1: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var cameraText: UILabel!
    @IBOutlet weak var cameraIcon: UIImageView!
    @IBOutlet weak var uploadImage: UIImageView!
    
    @IBOutlet weak var intensityEvent: UIButton!
    @IBOutlet weak var durationEvent: UIButton!
    @IBOutlet weak var currencyEvent: UIButton!
    @IBOutlet weak var regionEvent: UIButton!
    @IBOutlet weak var adventureEvent: UIButton!
    @IBOutlet weak var countryEvent: UIButton!
    
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryTxf: UITextField!
    @IBOutlet weak var countryView1: UIView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var headerText: UILabel!
    @IBOutlet weak var drop1: UIButton!
    @IBOutlet weak var drop2: UIButton!
    @IBOutlet weak var drop3: UIButton!
    @IBOutlet weak var drop4: UIButton!
    @IBOutlet weak var drop5: UIButton!
    @IBOutlet weak var drop6: UIImageView!
    
    var countryId,regionId,adventureId,intensityId: Int!
    
    var dataDropDown = DropDown()
    var currencyArray = ["USD","Euro"]
    
    var DayarrData = ["1 Day","2 Days","3 Days","4 Days","5 Days","6 Days","7 Days"]
    
    var tripname,agency,website,price,country,region,adventure,intensity,duration,fulldescription,imgurl,baseURL,currency: String?
    var trip_id: Int?
    var typeofpage: String?
    
    // camera image
    var ypImages = [YPMediaItem]()
    var imagesFromSource = [UIImage]()
    var uploadImageArray = [UIImage]()
    
    var intensityModel:IntensityModel?
    var intensityarrData = [String]()
    
    var adventureModel:AdventureModel?
    var adventurearrData = [String]()
    
    var arrOptions: [SignUpOptionsDataModel] = []
    var arrCountryStateName = [String]()
    
    var regionarrOptions: [SignUpOptionsDataModel] = []
    var regionarrCountryStateName = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.property()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateEventViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)
        
        travelAgencyTxf.text = agency
        websiteTxf.text = website
        
        travelAgencyTxf.isUserInteractionEnabled = false
        websiteTxf.isUserInteractionEnabled = false
        
        travelAgencyLabel.isHidden = false
        travelAgencyTxf.placeholder = ""
        travelAgencyView1.isHidden = false
        travelAgencyLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        
        websiteLabel.isHidden = false
        websiteTxf.placeholder = ""
        websiteView1.isHidden = false
        websiteLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        
        descriptionTextView.textContainer.heightTracksTextView = true
        descriptionTextView.isScrollEnabled = false
        
        if tripname != nil {
            tripNameTxf.text = tripname
            
            currencyLabel.text = currency
            countryTxf.text = country
            regionTxf.text = region
            adventuresTxf.text = adventure
            durationTxf.text = duration
            intensityTxf.text = intensity
            priceTxf.text = price
            descriptionTextView.text = fulldescription
            uploadImage.setImage(withString: String.getString((baseURL ?? "") + imgurl!), placeholder: UIImage(named: "image_placeholder"))
            self.cameraIcon.isHidden = true
            self.cameraText.isHidden = true
            
            
            tripNameLabel.isHidden = false
            tripNameTxf.placeholder = ""
            tripNameView1.isHidden = false
            tripNameLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            
            
            
            regionLabel.isHidden = false
            regionTxf.placeholder = ""
            regionView1.isHidden = false
            regionLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            
            adventuresLabel.isHidden = false
            adventuresTxf.placeholder = ""
            adventuresView1.isHidden = false
            adventuresLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            
            durationLabel.isHidden = false
            durationTxf.placeholder = ""
            durationView1.isHidden = false
            durationLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            
            intensityLabel.isHidden = false
            intensityTxf.placeholder = ""
            intensityView1.isHidden = false
            intensityLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            
            
            
            priceLabel.isHidden = false
            priceTxf.placeholder = ""
            priceView1.isHidden = false
            priceLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            
            descriptionLabel.isHidden = false
            descriptionView1.isHidden = false
            descriptionLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            
            countryLabel.isHidden = false
            countryTxf.placeholder = ""
            countryView1.isHidden = false
            countryLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            
        }
        
        if typeofpage == "read" {
            
            headerText.text = "Trips/Packages"
            drop1.isHidden = true
            drop2.isHidden = true
            drop3.isHidden = true
            drop4.isHidden = true
            drop5.isHidden = true
            drop6.isHidden = true
            saveButton.isHidden = true
            tripNameTxf.isUserInteractionEnabled = true
           
            descriptionTextView.isUserInteractionEnabled = false
            priceTxf.isUserInteractionEnabled = false
            
            descriptionTextView.textColor = .black
            
        } else {
            getInensity()
            getAdventure()
            postRequestToGetCountries()
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()

    }
    
    @IBAction func AdventureDropDown(_ sender: UIButton){
        if typeofpage != "read" {
            adventureDropDown()
        }
        
    }
    
    @IBAction func IntensityDropDown(_ sender: UIButton){
        if typeofpage != "read" {
            intensityDropDown()
        }
        
    }
    
    @IBAction func DurationDropDown(_ sender: UIButton){
        if typeofpage != "read" {
            dayDropDown()
        }
       
    }
    
    @IBAction func RegionDropDown(_ sender: UIButton){
        if typeofpage != "read" {
            regiondropDown()
        }
        
    }
    
    @IBAction func CountryDropDown(_ sender: UIButton){
        if typeofpage != "read" {
            countrydropDown()
        }
        
    }
    
    
    @IBAction func CouurencyDropDown(_ sender: UIButton){
        if typeofpage != "read" {
            currencyDropDown()
        }
        
    }
    
    @IBAction func savebUtoon(_ sender: UIButton){
        
        if tripname != nil {
            
            if self.tripNameTxf.text == "" {
                alert(msg: "Please enter trip name!")
            } else if self.countryTxf.text == "" {
                alert(msg: "Please select country!")
            } else if self.regionTxf.text == "" {
                alert(msg: "Please select region!")
            } else if self.adventuresTxf.text == "" {
                alert(msg: "Please select adventures!")
            }else if self.durationTxf.text == "" {
                alert(msg: "Please select duration!")
            }else if self.intensityTxf.text == "" {
                alert(msg: "Please select intensity!")
            }else if self.priceTxf.text == "" {
                alert(msg: "Please enter price!")
            } else if self.descriptionTextView.text == "" {
                alert(msg: "Please enter descriotion!")
            } else {
                updateTripApi()
            }
            
        } else {
            
            if self.uploadImageArray.count == 0 {
                alert(msg: "Please upload travel image!")
            } else if self.tripNameTxf.text == "" {
                alert(msg: "Please enter trip name!")
            } else if self.countryTxf.text == "" {
                alert(msg: "Please select country!")
            } else if self.regionTxf.text == "" {
                alert(msg: "Please select region!")
            } else if self.adventuresTxf.text == "" {
                alert(msg: "Please select adventures!")
            }else if self.durationTxf.text == "" {
                alert(msg: "Please select duration!")
            }else if self.intensityTxf.text == "" {
                alert(msg: "Please select intensity!")
            }else if self.priceTxf.text == "" {
                alert(msg: "Please enter price!")
            } else if self.descriptionTextView.text == "" {
                alert(msg: "Please enter descriotion!")
            } else {
                createTripApi()
            }
            
        }
        
    }
    
    @IBAction func btnMediaTapped(_ sender: Any) {
        
        if typeofpage != "read" {
            
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
    
    @objc func currencyDropDown(){
        
        self.dataDropDown.dataSource = self.currencyArray
        dataDropDown.show()
        dataDropDown.anchorView = self.currencyEvent
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            //self.btnReport.setTitle(item, for: .normal)
            currencyLabel.text = item
          
        }
        dataDropDown.cellHeight = 50
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .top
        
    }
    
    
    @objc func dayDropDown(){
        self.adventuresLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.intensityLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.countryLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.regionLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.adventuresView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.countryView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.regionView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.intensityView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.priceView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.priceTxf.endEditing(true)
        self.descriptionView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.descriptionTextView.endEditing(true)
        self.dataDropDown.dataSource = self.DayarrData
        dataDropDown.show()
        dataDropDown.anchorView = self.durationEvent
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            //self.btnReport.setTitle(item, for: .normal)
            durationTxf.text = item
            
            self.durationLabel.isHidden = false
           self.durationTxf.placeholder = ""
          self.durationView1.isHidden = false
          self.durationView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            self.durationLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
           
        }
        dataDropDown.cellHeight = 50
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .top
    }
    
    
    func countrydropDown(){
        self.adventuresLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.intensityLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.durationLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.regionLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.adventuresView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.durationView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.regionView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.intensityView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.dataDropDown.dataSource = self.arrCountryStateName
        dataDropDown.show()
        dataDropDown.anchorView = countryEvent
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            //self.btnReport.setTitle(item, for: .normal)
            countryTxf.text = item
            self.countryLabel.isHidden = false
            self.countryTxf.placeholder = ""
          self.countryView1.isHidden = false
          self.countryLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
            print(self.arrOptions[index].id)
            self.countryView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            countryId = Int.getInt(arrOptions[index].id)
            
            regionTxf.text = ""
            self.regionLabel.isHidden = true
            self.regionTxf.placeholder = "Region"
            self.regionView1.isHidden = true
            regionView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            self.regionLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
            
            
            callGetStatesWithCountryIdApi(String.getString(self.arrOptions[index].id))
           
        }
        dataDropDown.cellHeight = 50
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .top
    }
    
    func regiondropDown(){
        self.adventuresLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.intensityLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.durationLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.countryLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.adventuresView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.durationView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.countryView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.intensityView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.dataDropDown.dataSource = self.regionarrCountryStateName
        dataDropDown.show()
        dataDropDown.anchorView = regionEvent
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            //self.btnReport.setTitle(item, for: .normal)
            regionTxf.text = item
            regionId = Int.getInt(regionarrOptions[index].id)
            
            self.regionLabel.isHidden = false
           self.regionTxf.placeholder = ""
          self.regionView1.isHidden = false
          self.regionView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            self.regionLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
        }
        dataDropDown.cellHeight = 50
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .top
    }
    
    @objc func intensityDropDown(){
        self.adventuresLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.countryLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.durationLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.regionLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.adventuresView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.durationView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.countryView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.intensityView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.dataDropDown.dataSource = self.intensityarrData
        dataDropDown.show()
        dataDropDown.anchorView = self.intensityEvent
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            //self.btnReport.setTitle(item, for: .normal)
            intensityTxf.text = item
            intensityId = self.intensityModel?.data?[index].intensity_id
            
            self.intensityLabel.isHidden = false
           self.intensityTxf.placeholder = ""
          self.intensityView1.isHidden = false
          self.intensityView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            self.intensityLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
           
        }
        dataDropDown.cellHeight = 50
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .top
    }
    
    @objc func adventureDropDown(){
        self.countryLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.intensityLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.durationLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.regionLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.countryView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.durationView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.regionView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.intensityView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.dataDropDown.dataSource = self.adventurearrData
        dataDropDown.show()
        dataDropDown.anchorView = self.adventureEvent
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            //self.btnReport.setTitle(item, for: .normal)
            adventuresTxf.text = item
            adventureId = self.adventureModel?.data?[index].adventure_type_id
            
            self.adventuresLabel.isHidden = false
           self.adventuresTxf.placeholder = ""
          self.adventuresView1.isHidden = false
          self.adventuresView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            self.adventuresLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
        }
        dataDropDown.cellHeight = 50
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .top
    }
    
    private func getInensity() -> Void{
      
      disableWindowInteraction()
    
      TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetIntensity, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
          let dictResponse = dictResponse as? [String:Any]
          
          self.intensityModel = IntensityModel.init(with: dictResponse)
            
          for i in 0..<(self.intensityModel?.data?.count)! {
                self.intensityarrData.append(self.intensityModel?.data?[i].intensity ?? "")
          }
        
      }
      
    }
    
    func callGetStatesWithCountryIdApi(_ expertCountryId: String){
        regionarrOptions.removeAll()
        regionarrCountryStateName.removeAll()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetStatesByCountryId + "\(expertCountryId)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dicResponse, error, errorType, statusCode) in
            let response = dicResponse as? [String:Any]
            //let filterCountry = kSharedInstance.signUpViewModel.arrSignUpStepOne.filter({$0.name == APIConstants.kCountry})
            if let array = response?[APIConstants.kData] as? ArrayOfDictionary{
              self.regionarrOptions = array.map({SignUpOptionsDataModel(withDictionary: $0)})
           }
            for i in 0..<self.regionarrOptions.count {
                self.regionarrCountryStateName.append(self.regionarrOptions[i].name ?? "")
            }
            //self.pushVCCallback?([HubCityArray](),GetRoleViewModel([:]),ProductType(with: [:]),[StateModel](),self.arrOptions,AppConstants.SelectState)
            //self.dataDropDown.dataSource = self.arrCountryStateName
            //self.opendropDown()
        }
    }
    
    private func postRequestToGetCountries() -> Void{
      
      disableWindowInteraction()
       
        arrOptions.removeAll()
        arrCountryStateName.removeAll()
        TANetworkManager.sharedInstance.requestApi(withServiceName: "https://alyseiapi.ibyteworkshop.com/public/api/get/countries?param=trips", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dicResponse, error, errorType, statusCode) in
            let response = dicResponse as? [String:Any]
            //let filterCountry = kSharedInstance.signUpViewModel.arrSignUpStepOne.filter({$0.name == APIConstants.kCountry})
            if let array = response?[APIConstants.kData] as? ArrayOfDictionary{
              self.arrOptions = array.map({SignUpOptionsDataModel(withDictionary: $0)})
           }
            for i in 0..<self.arrOptions.count {
                self.arrCountryStateName.append(self.arrOptions[i].name ?? "")
            }
           
            
        }
        
    }
    
    private func getAdventure() -> Void{
      
      disableWindowInteraction()
    
      TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetAdventure, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
          let dictResponse = dictResponse as? [String:Any]
          
          self.adventureModel = AdventureModel.init(with: dictResponse)
            
          for i in 0..<(self.adventureModel?.data?.count)! {
                self.adventurearrData.append(self.adventureModel?.data?[i].adventure_type ?? "")
          }
        
      }
      
    }
    
    func updateTripApi(){
            
        let params: [String:Any] = [
            
            "trip_name": tripNameTxf.text ?? "",
            "travel_agency": travelAgencyTxf.text ?? "",
            "country": String.getString(countryId!),
            "region": String.getString(regionId!),
            "adventure_type": String.getString(adventureId!),
            "duration": durationTxf.text ?? "",
            "intensity": String.getString(intensityId!),
            "website": websiteTxf.text ?? "",
            "price": priceTxf.text ?? "",
            "description": descriptionTextView.text ?? "",
            "trip_id": String.getString(trip_id),
            "currency": String.getString(currencyLabel.text),
            
        ]
        
        let imageParam : [String:Any] = self.uploadImageArray.count > 0 ? [APIConstants.kImage: self.uploadImageArray[0],APIConstants.kImageName: "image_id"] : [:]
        
        
        CommonUtil.sharedInstance.postRequestToImageUpload(withParameter: params, url: APIUrl.kUpdateTrip, image: imageParam, controller: self, type: 0)
            
    }
    
    func createTripApi(){
        
        let params: [String:Any] = [
            
            "trip_name": tripNameTxf.text ?? "",
            "travel_agency": travelAgencyTxf.text ?? "",
            "country": String.getString(countryId!),
            "region": String.getString(regionId!),
            "adventure_type": String.getString(adventureId!),
            "duration": durationTxf.text ?? "",
            "intensity": String.getString(intensityId!),
            "website": websiteTxf.text ?? "",
            "price": priceTxf.text ?? "",
            "description": descriptionTextView.text ?? "",
            "currency": String.getString(currencyLabel.text),
           // "param": "trips"
            
        ]
        
        let imageParam : [String:Any] = [APIConstants.kImage: self.uploadImageArray[0],
                                         APIConstants.kImageName: "image_id"]
        
        
        CommonUtil.sharedInstance.postRequestToImageUpload(withParameter: params, url: APIUrl.kCreateTrip, image: imageParam, controller: self, type: 0)
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       self.view.endEditing(true)
       return false
     }
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
      }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.countryLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.intensityLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.durationLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.regionLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.adventuresLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.countryView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.durationView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.regionView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.intensityView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.adventuresView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        if textField == self.tripNameTxf
        {
            self.tripNameLabel.isHidden = false
          self.tripNameTxf.placeholder = ""
          self.tripNameView1.isHidden = false
          self.tripNameView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            self.tripNameLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
        }
        else if textField == self.travelAgencyTxf{
          
          self.travelAgencyLabel.isHidden = false
          self.travelAgencyTxf.placeholder = ""
        self.travelAgencyView1.isHidden = false
        self.travelAgencyView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            self.travelAgencyLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
        } else if textField == self.countryTxf{
          
          self.countryLabel.isHidden = false
          self.countryTxf.placeholder = ""
        self.countryView1.isHidden = false
        self.countryView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            self.countryLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
        }
        
        else if textField == self.regionTxf{
          
          self.regionLabel.isHidden = false
         self.regionTxf.placeholder = ""
        self.regionView1.isHidden = false
        self.regionView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
         
            self.regionLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
        }
          
        else if textField == self.adventuresTxf{
          
          self.adventuresLabel.isHidden = false
         self.adventuresTxf.placeholder = ""
        self.adventuresView1.isHidden = false
        self.adventuresView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            self.adventuresLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
          
        }
        else if textField == self.durationTxf{
          
          self.durationLabel.isHidden = false
         self.durationTxf.placeholder = ""
        self.durationView1.isHidden = false
        self.durationView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            self.durationLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
          
        }
          
        else if textField == self.intensityTxf{
          
          self.intensityLabel.isHidden = false
         self.intensityTxf.placeholder = ""
        self.intensityView1.isHidden = false
        self.intensityView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            self.intensityLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
          
        }
        else if textField == self.websiteTxf{
          
          self.websiteLabel.isHidden = false
         self.websiteTxf.placeholder = ""
        self.websiteView1.isHidden = false
        self.websiteView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            self.websiteLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
          
        }
          
        else if textField == self.priceTxf{
          
          self.priceLabel.isHidden = false
         self.priceTxf.placeholder = ""
        self.priceView1.isHidden = false
        self.priceView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            self.priceLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
          
        }
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.countryLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.intensityLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.durationLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.regionLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.adventuresLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        self.countryView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.durationView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.regionView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.intensityView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        self.adventuresView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
       if textView == self.descriptionTextView{
        
        if self.descriptionTextView.text == "Description" {
            self.descriptionTextView.text = nil
        }
        
        self.descriptionTextView.textColor = .black
        self.descriptionLabel.isHidden = false
       // self.timeTxf.placeholder = ""
      self.descriptionView1.isHidden = false
      self.descriptionView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        self.descriptionLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
       
        
      }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {


        //Checkes if textfield is empty or not after after user ends editing.
        if textField == self.tripNameTxf
        {
          //  if self.tripNameTxf.text == ""
            //{
            self.tripNameLabel.isHidden = false
            self.tripNameLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.tripNameTxf.placeholder = "Trip Name/Package Name"
                self.tripNameView1.isHidden = false
                tripNameView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            self.tripNameLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        //}


        }
        else if textField == self.travelAgencyTxf
        {
            //if self.travelAgencyTxf.text == ""
            //{
            self.travelAgencyLabel.isHidden = false
            self.travelAgencyLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.travelAgencyTxf.placeholder = "Travel Agency"
                self.travelAgencyView1.isHidden = false
                travelAgencyView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            self.travelAgencyLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
       // }
        }
        
        else if textField == self.countryTxf {
           // if self.countryTxf.text == ""{
                self.countryLabel.isHidden = false
            self.countryLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
                self.countryTxf.placeholder = "Travel Agency"
                self.countryView1.isHidden = false
                countryView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            //self.countryLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
            
           // }
        }
        
        else if textField == self.regionTxf
        {
            //if self.regionTxf.text == ""
            //{
            self.regionLabel.isHidden = false
            self.regionLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.regionTxf.placeholder = "region"
                self.regionView1.isHidden = false
                regionView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
         //   self.regionLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
        //}

        }
        
        else if textField == self.adventuresTxf
        {
           // if self.adventuresTxf.text == ""
            //{
            self.adventuresLabel.isHidden = false
            self.adventuresLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.adventuresTxf.placeholder = "Adventures"
                self.adventuresView1.isHidden = false
                adventuresView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
           // self.adventuresLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
       // }


        }
        else if textField == self.durationTxf
        {
            //if self.durationTxf.text == ""
            //{
            self.durationLabel.isHidden = false
            self.durationLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.durationTxf.placeholder = "Duration"
                self.durationView1.isHidden = false
                durationView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                
              
        //}
        }
        
        else if textField == self.intensityTxf
        {
            //if self.intensityTxf.text == ""
           // {
            self.intensityLabel.isHidden = false
            self.intensityLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.intensityTxf.placeholder = "Intensity"
                self.intensityView1.isHidden = false
                intensityView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                
              
       // }
        }
        
        else if textField == self.websiteTxf
        {
           // if self.websiteTxf.text == ""
            //{
            self.websiteLabel.isHidden = false
            self.websiteLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.websiteTxf.placeholder = "Website"
                self.websiteView1.isHidden = false
                websiteView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                
              
       // }
        }
        else if textField == self.priceTxf
        {
           // if self.priceTxf.text == ""
            //{
            self.priceLabel.isHidden = false
            self.priceLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            self.priceTxf.placeholder = "Price"
                self.priceView1.isHidden = false
                priceView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                
              
       // }
        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == self.descriptionTextView
        {
            //if self.descriptionTextView.text == ""
           // {
                self.descriptionLabel.isHidden = false
                self.descriptionLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
               // self.descriptionTextView.text = "Description"
                self.descriptionView1.isHidden = false
                self.descriptionTextView.textColor = .black
                descriptionView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                
                
           // }
            
            
        }
    }
    
    func property(){

        tripNameLabel.isHidden =  true
        travelAgencyLabel.isHidden = true
        regionLabel.isHidden = true
        adventuresLabel.isHidden = true
        durationLabel.isHidden = true
        descriptionLabel.isHidden = true
        websiteLabel.isHidden = true
        intensityLabel.isHidden = true
        priceLabel.isHidden = true

        
        descriptionTextView.text = "Description"
        descriptionTextView.textColor = .lightGray
        descriptionTextView.font = UIFont(name: "Montserrat", size: 16)
        
        tripNameView1.isHidden = true
        travelAgencyView1.isHidden = true
        regionView1.isHidden = true
        adventuresView1.isHidden = true
        durationView1.isHidden = true
        descriptionView1.isHidden = true
        websiteView1.isHidden = true
        intensityView1.isHidden = true
        priceView1.isHidden = true
        countryView1.isHidden = true
        
        tripNameTxf.autocorrectionType = .no
        travelAgencyTxf.autocorrectionType = .no
        priceTxf.autocorrectionType = .no
        descriptionTextView.autocorrectionType = .no
        websiteTxf.autocorrectionType = .no
        
        headerView.layer.masksToBounds = false
        headerView.layer.shadowRadius = 2
        headerView.layer.shadowOpacity = 0.2
        headerView.layer.shadowColor = UIColor.lightGray.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0 , height:2)
        
        imageView.layer.cornerRadius = 4
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        tripNameView.layer.cornerRadius = 4
        tripNameView.layer.borderWidth = 2
        tripNameView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        travelAgencyView.layer.cornerRadius = 4
        travelAgencyView.layer.borderWidth = 2
        travelAgencyView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        countryView.layer.cornerRadius = 4
        countryView.layer.borderWidth = 2
        countryView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        regionView.layer.cornerRadius = 4
        regionView.layer.borderWidth = 2
        regionView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        
        adventuresView.layer.cornerRadius = 4
        adventuresView.layer.borderWidth = 2
        adventuresView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        durationView.layer.cornerRadius = 4
        durationView.layer.borderWidth = 2
        durationView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        descriptionView.layer.cornerRadius = 4
        descriptionView.layer.borderWidth = 2
        descriptionView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        websiteView.layer.cornerRadius = 4
        websiteView.layer.borderWidth = 2
        websiteView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        intensityView.layer.cornerRadius = 4
        intensityView.layer.borderWidth = 2
        intensityView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        priceView.layer.cornerRadius = 4
        priceView.layer.borderWidth = 2
        priceView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
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

extension CreateTripsViewController{
    
    override func didUserGetData(from result: Any, type: Int) {
        
        
        let dicResponse = kSharedInstance.getDictionary(result)
        let dicData = kSharedInstance.getDictionary(dicResponse[APIConstants.kData])
        switch type {
        case 0:
            self.navigationController?.popViewController(animated: true)
        case 1:
            
          let filterCountry = kSharedInstance.signUpViewModel.arrSignUpStepOne.filter({$0.name == APIConstants.kCountry})
          if let array = dicResponse[APIConstants.kData] as? ArrayOfDictionary{
            filterCountry.first?.arrOptions = array.map({SignUpOptionsDataModel(withDictionary: $0)})
          }
         
        default:
          break
        }
        
    }
}


