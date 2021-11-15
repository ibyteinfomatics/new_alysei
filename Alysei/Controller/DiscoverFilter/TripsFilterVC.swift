//
//  TripsFilterVC.swift
//  Alysei
//
//  Created by Gitesh Dang on 11/9/21.
//

import UIKit
import DropDown

class TripsFilterVC: AlysieBaseViewC {

    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var vw0: UIView!
    @IBOutlet weak var vw1: UIView!
    @IBOutlet weak var vw2: UIView!
    @IBOutlet weak var vw3: UIView!
    @IBOutlet weak var vw4: UIView!
    @IBOutlet weak var vw5: UIView!
    
    @IBOutlet weak var intensityEvent: UIButton!
    @IBOutlet weak var durationEvent: UIButton!
    @IBOutlet weak var currencyEvent: UIButton!
    @IBOutlet weak var regionEvent: UIButton!
    @IBOutlet weak var adventureEvent: UIButton!
    @IBOutlet weak var countryEvent: UIButton!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var adventuresLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var intensityLabel: UILabel!
    @IBOutlet weak var currencyLabel: UITextField!
    
    var intensityModel:IntensityModel?
    var intensityarrData = [String]()
    
    var adventureModel:AdventureModel?
    var adventurearrData = [String]()
    
    var regionarrOptions: [SignUpOptionsDataModel] = []
    var regionarrCountryStateName = [String]()
    
    var arrOptions: [SignUpOptionsDataModel] = []
    var arrCountryStateName = [String]()
    
    var countryId,regionId,adventureId,intensityId: String?
    
    var dataDropDown = DropDown()
    var currencyArray = ["USD","Euro"]
    
    var DayarrData = ["1 Day","2 Days","3 Days","4 Days","5 Days","6 Days","7 Days"]
    
    
    var passSelectedCountry: String?
    var passRegions: String?
    var passAdventure:String?
    var passDuration:String?
    var passIntensity:String?
    var passprice:String?
    
   
    
    var passSelectedDataCallback: ((String,String,String,String,String,String,_ regionid: String?,_ adventureId: String?,_ intensityId: String?) -> Void)? = nil
    
    var clearfilterCallback: (() -> Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        vwHeader.drawBottomShadow()
        setData()
        vw1.addBorder()
        vw2.addBorder()
        vw3.addBorder()
        vw4.addBorder()
        vw5.addBorder()
        vw0.addBorder()
        
        let country = UITapGestureRecognizer(target: self, action: #selector(countrydropDown))
        self.vw0.addGestureRecognizer(country)
        
        let region = UITapGestureRecognizer(target: self, action: #selector(regiondropDown))
        self.vw1.addGestureRecognizer(region)
        
        let adventure = UITapGestureRecognizer(target: self, action: #selector(adventureDropDown))
        self.vw2.addGestureRecognizer(adventure)
        
        let duration = UITapGestureRecognizer(target: self, action: #selector(dayDropDown))
        self.vw3.addGestureRecognizer(duration)
        
        let intensity = UITapGestureRecognizer(target: self, action: #selector(intensityDropDown))
        self.vw4.addGestureRecognizer(intensity)
        
//        let currency = UITapGestureRecognizer(target: self, action: #selector(currencyDropDown))
//        self.vw5.addGestureRecognizer(currency)
//        
        getInensity()
        getAdventure()
        postRequestToGetCountries()
        
        // Do any additional setup after loading the view.
    }
    
    func setData(){
        if passSelectedCountry == "" || passSelectedCountry == nil {
            countryLabel.text = "Country"
        }else{
            countryLabel.text = passSelectedCountry
        }
        
        if passRegions == "" || passRegions == nil {
            regionLabel.text = "Regions"
        }else{
            regionLabel.text = passRegions
        }
        
        if passAdventure == "" || passAdventure == nil {
            adventuresLabel.text = "Adventures"
        }else{
            adventuresLabel.text = passAdventure
        }
        
        if passDuration == "" || passDuration == nil {
            durationLabel.text = "Duration"
        }else{
            durationLabel.text = passDuration
        }
        
        if passIntensity == "" || passIntensity == nil {
            intensityLabel.text = "Intensity"
        }else{
            intensityLabel.text = passIntensity
        }

        if passprice == "" || passprice == nil {
            currencyLabel.placeholder = "Price"
        }else{
            currencyLabel.text = passprice
        }
    }
    
    
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func btnFilterAction(_ sender: UIButton){
        setData()
        self.passSelectedDataCallback?(passSelectedCountry ?? "",passRegions ?? "",passAdventure ?? "", passDuration ?? "", passIntensity ?? "", passprice ?? "", regionId ?? "",adventureId ?? "", intensityId ?? "")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClearFilterAction(_ sender: UIButton){
        passSelectedCountry = ""
        passRegions = ""
        passAdventure = ""
        passDuration = ""
        passIntensity = ""
        passprice = ""
       // self.clearfilterCallback?()
       // self.navigationController?.popViewController(animated: true)
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
    
    private func getAdventure() -> Void{
      
          disableWindowInteraction()
        
          TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetAdventure+"?type=all", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
              
              let dictResponse = dictResponse as? [String:Any]
              
              self.adventureModel = AdventureModel.init(with: dictResponse)
                
              for i in 0..<(self.adventureModel?.data?.count)! {
                    self.adventurearrData.append(self.adventureModel?.data?[i].adventure_type ?? "")
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
    
    @objc func currencyDropDown(){
        
        self.dataDropDown.dataSource = self.currencyArray
        dataDropDown.show()
        dataDropDown.anchorView = self.vw5
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            //self.btnReport.setTitle(item, for: .normal)
            currencyLabel.text = item
          
        }
        dataDropDown.cellHeight = 50
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
        
    }
    
    
    @objc func dayDropDown(){
        self.dataDropDown.dataSource = self.DayarrData
        dataDropDown.show()
        dataDropDown.anchorView = self.vw3
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            //self.btnReport.setTitle(item, for: .normal)
            durationLabel.text = item
            
             }
        dataDropDown.cellHeight = 50
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
    
    
    @objc func countrydropDown(){
       self.dataDropDown.dataSource = self.arrCountryStateName
        dataDropDown.show()
        dataDropDown.anchorView = vw0
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            //self.btnReport.setTitle(item, for: .normal)
            countryLabel.text = item
              countryId = (arrOptions[index].id)
            
            
            callGetStatesWithCountryIdApi(String.getString(self.arrOptions[index].id))
           
        }
        dataDropDown.cellHeight = 50
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
    
    @objc func regiondropDown(){
         self.dataDropDown.dataSource = self.regionarrCountryStateName
        dataDropDown.show()
        dataDropDown.anchorView = vw1
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            //self.btnReport.setTitle(item, for: .normal)
            regionLabel.text = item
            regionId = (regionarrOptions[index].id)
            
            
            }
        dataDropDown.cellHeight = 50
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
    
    @objc func intensityDropDown(){
         self.dataDropDown.dataSource = self.intensityarrData
        dataDropDown.show()
        dataDropDown.anchorView = self.vw4
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            //self.btnReport.setTitle(item, for: .normal)
            intensityLabel.text = item
            intensityId = "\(self.intensityModel?.data?[index].intensity_id ?? 0)"
            
              }
        dataDropDown.cellHeight = 50
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
    
    @objc func adventureDropDown(){
        self.dataDropDown.dataSource = self.adventurearrData
        dataDropDown.show()
        dataDropDown.anchorView = self.vw2
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            //self.btnReport.setTitle(item, for: .normal)
            adventuresLabel.text = item
            adventureId = "\(self.adventureModel?.data?[index].adventure_type_id ?? 0)"
            
             }
        dataDropDown.cellHeight = 50
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
    

}
