//
//  BusinessButtonTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 24/01/21.
//

import UIKit
import DropDown


var expertCountryId:String?
var travelCountryId:String?

enum IdentifyUserForProduct {
    case productImporter
    case productProducer
    
}

class BusinessButtonTableCell: UITableViewCell {

  //MARK: - IBOutlet -
  @IBOutlet weak var btnBusiness: UIButtonExtended!
    
    let dataDropDown = DropDown()
    var passIdCallBack:((_ ExpertCountryId: String, _ travelCountryId: String) -> Void)? = nil
    var passCellCallback: ((String) -> Void)? = nil
    var passStateCellCallback:(() -> Void)? = nil
    var stateModel: [StateModel]?
    //var stateName = [String]()
    var userhubs : [HubCityArray]?
    var arrStateName = [String]()
    var arrHubName = [String]()
    var arrProductType = [String]()
    var arrImporterRole = [String]()
    var arrCountryStateName = [String]()
    var productType: ProductType?
    var currentIndex: Int?
    var businessModel: BusinessDataModel?
    var fieldValueId:Int?
    var getRoleViewModel: GetRoleViewModel!
    var arrOptions: [SignUpOptionsDataModel] = []
    var productoption: SignUpStepOneDataModel?
    var userRoleId: String?
    var pushVCCallback: (([HubCityArray]?,GetRoleViewModel,ProductType, [StateModel],[SignUpOptionsDataModel],String) -> Void)? = nil
    var pushedFrom: PushedFrom?
    
    var pushToProductTypeScreen:((SignUpStepOneDataModel,IdentifyUserForProduct) -> Void)? = nil
    var identifyUserForProduct: IdentifyUserForProduct?
    var index: Int?
    
  override func awakeFromNib() {
   // self.callStateApi()
   // self.callUserHubsApi()
   
    super.awakeFromNib()
    self.btnBusiness.makeCornerRadius(radius: 6.0)
    
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapBusiness(_ sender: UIButton) {
      self.index = sender.tag
    if (currentIndex ==  B2BSearch.Hub.rawValue && businessModel?.businessHeading == AppConstants.SelectState) || (currentIndex ==  B2BSearch.Importer.rawValue && businessModel?.businessHeading == AppConstants.SelectState) || (currentIndex ==  B2BSearch.Producer.rawValue && businessModel?.businessHeading == AppConstants.SelectRegion){
        callStateApi()
    }else if (currentIndex == B2BSearch.Importer.rawValue && sender.tag ==  1 && pushedFrom != .hubUserListVC){
        callImporterRoleApi()
    }else if (currentIndex == B2BSearch.Importer.rawValue && pushedFrom == .hubUserListVC && sender.tag ==  0){
        callImporterRoleApi()
    }else if (currentIndex == B2BSearch.Importer.rawValue && pushedFrom == .hubUserListVC && sender.tag ==  1){
        fieldValueId = B2BFieldId.productType.rawValue
        self.identifyUserForProduct = .productImporter
        self.callGetValueOfFieldApi()
        
    }
      else if (currentIndex ==  B2BSearch.Importer.rawValue && sender.tag == 0 && pushedFrom != .hubUserListVC) || (currentIndex ==  B2BSearch.Restaurant.rawValue && sender.tag == 0 && pushedFrom != .hubUserListVC) || (currentIndex ==  B2BSearch.Expert.rawValue && sender.tag == 0 && pushedFrom != .hubUserListVC) || (currentIndex ==  B2BSearch.TravelAgencies.rawValue && sender.tag == 0 && pushedFrom != .hubUserListVC) ||  (currentIndex ==  B2BSearch.Producer.rawValue && sender.tag == 0 && pushedFrom != .hubUserListVC){
        self.callUserHubsApi()
    }else if (currentIndex ==  B2BSearch.Importer.rawValue && sender.tag == 2) {
        fieldValueId = B2BFieldId.productType.rawValue
        self.identifyUserForProduct = .productImporter
        self.callGetValueOfFieldApi()
        
    }else if ((currentIndex ==  B2BSearch.Producer.rawValue) && (businessModel?.businessHeading == AppConstants.ProductTypeBusiness) && (pushedFrom == .hubUserListVC)){
          fieldValueId = B2BFieldId.productType.rawValue
          self.identifyUserForProduct = .productProducer
          self.callGetValueOfFieldApi()
      }else if (currentIndex ==  B2BSearch.Producer.rawValue && sender.tag == 1){
        fieldValueId = B2BFieldId.productType.rawValue
        self.identifyUserForProduct = .productProducer
        self.callGetValueOfFieldApi()
      }else if (currentIndex ==  B2BSearch.Restaurant.rawValue && sender.tag == 0 && pushedFrom == .hubUserListVC ){
        fieldValueId = B2BFieldId.restaurantType.rawValue
        self.callGetValueOfFieldApi()
        
    }
      else if (currentIndex ==  B2BSearch.Restaurant.rawValue && sender.tag == 1 && pushedFrom != .hubUserListVC){
        fieldValueId = B2BFieldId.restaurantType.rawValue
        self.callGetValueOfFieldApi()
        
    }else if (currentIndex ==  B2BSearch.Expert.rawValue && sender.tag == 1 && pushedFrom != .hubUserListVC){
        fieldValueId = B2BFieldId.expertise.rawValue
        self.callGetValueOfFieldApi()
        
    }
      else if (currentIndex ==  B2BSearch.Expert.rawValue && sender.tag == 0 && pushedFrom == .hubUserListVC){
          fieldValueId = B2BFieldId.expertise.rawValue
          self.callGetValueOfFieldApi()
          
      }
      else if (currentIndex ==  B2BSearch.Expert.rawValue && sender.tag == 2 && pushedFrom != .hubUserListVC){
        fieldValueId = B2BFieldId.title.rawValue
        self.callGetValueOfFieldApi()
        
    }else if (currentIndex ==  B2BSearch.Expert.rawValue && sender.tag == 1 && pushedFrom == .hubUserListVC){
        fieldValueId = B2BFieldId.title.rawValue
        self.callGetValueOfFieldApi()
        
    }
      else if (currentIndex ==  B2BSearch.Expert.rawValue && sender.tag == 3 && pushedFrom != .hubUserListVC) {
        //fieldValueId = B2BFieldId.country.rawValue
       // self.callGetValueOfFieldApi()
        self.callGetCountryApi("\(UserRoles.voiceExperts.rawValue)")
        
    } else if (currentIndex ==  B2BSearch.Expert.rawValue && sender.tag == 2 && pushedFrom == .hubUserListVC) {
        //fieldValueId = B2BFieldId.country.rawValue
       // self.callGetValueOfFieldApi()
        self.callGetCountryApi("\(UserRoles.voiceExperts.rawValue)")
        
    }
      else if ((currentIndex ==  B2BSearch.TravelAgencies.rawValue && sender.tag == 2 && pushedFrom != .hubUserListVC) || (currentIndex ==  B2BSearch.TravelAgencies.rawValue && sender.tag == 1 && pushedFrom == .hubUserListVC)) {
        self.callGetCountryApi("\( UserRoles.travelAgencies.rawValue)")
    }
      else if (currentIndex ==  B2BSearch.Expert.rawValue && sender.tag == 3) || (currentIndex ==  B2BSearch.TravelAgencies.rawValue && sender.tag == 2 && pushedFrom == .hubUserListVC)  {
        //fieldValueId = B2BFieldId.region.rawValue
        //self.callGetValueOfFieldApi()
        if currentIndex == 4 {
            self.callGetStatesWithCountryIdApi(travelCountryId ?? "")
        }else{
        self.callGetStatesWithCountryIdApi(expertCountryId ?? "")
        }
        
    }
      else if (currentIndex ==  B2BSearch.Expert.rawValue && sender.tag == 4) || (currentIndex ==  B2BSearch.TravelAgencies.rawValue && sender.tag == 4 && pushedFrom != .hubUserListVC) {
        //fieldValueId = B2BFieldId.region.rawValue
        //self.callGetValueOfFieldApi()
        if currentIndex == 4 {
            self.callGetStatesWithCountryIdApi(travelCountryId ?? "")
        }else{
        self.callGetStatesWithCountryIdApi(expertCountryId ?? "")
        }
        
    }
      else if (currentIndex ==  B2BSearch.TravelAgencies.rawValue && sender.tag == 3 && pushedFrom != .hubUserListVC){
        self.callGetStatesWithCountryIdApi(travelCountryId ?? "")
    }
      else if (currentIndex ==  B2BSearch.TravelAgencies.rawValue && sender.tag == 1 && pushedFrom != .hubUserListVC){
        fieldValueId = B2BFieldId.speciality.rawValue
        self.callGetValueOfFieldApi()
        
    }
      
      else if (currentIndex ==  B2BSearch.TravelAgencies.rawValue && sender.tag == 0 && pushedFrom == .hubUserListVC){
        fieldValueId = B2BFieldId.speciality.rawValue
        self.callGetValueOfFieldApi()
        
      }else if currentIndex == B2BSearch.Voyager.rawValue && sender.tag == 0 {
        callStateApi()
    }
        
  }
  
    func opendropDown(){
        dataDropDown.show()
        dataDropDown.anchorView = btnBusiness
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btnBusiness.setTitle(item, for: .normal)
           
             if self.currentIndex == B2BSearch.Expert.rawValue{
                switch businessModel?.businessHeading {
                case AppConstants.SelectCountry:
                    selectExpertCountryName =  self.arrOptions[index].name
                    selectExpertRegionName = ""
                    
                    expertCountryId = self.arrOptions[index].id
                default:
                    print("Invalid")
                }
            }else if self.currentIndex == B2BSearch.TravelAgencies.rawValue{
                switch self.index {
                case 2:
                    travelCountryId = self.arrOptions[index].id
                    selectTravelRegionName = ""
                    selectTravelCountryName = self.arrOptions[index].name
                default:
                    print("Invalid")
                    
                }
            }
            if businessModel?.businessHeading == AppConstants.SelectCountry {
           // if item == "Italy" || item == "italy"{
               passCellCallback?(item)
            }
            passIdCallBack?(expertCountryId ?? "0", travelCountryId ?? "0")
        }
        dataDropDown.cellHeight = 50
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
  //MARK: - Public Methods -
  
  public func configureData(withBusinessDataModel model: BusinessDataModel, currentIndex: Int,index: Int) -> Void{
    
    self.btnBusiness.setTitle(model.businessHeading, for: .normal)
    self.businessModel = model
    self.currentIndex = currentIndex
      self.index  = index

    
  }
}
extension BusinessButtonTableCell{
func callStateApi() {
    TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetCountryStates + "?param=usa", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
        
        let response = dictResponse as? [String:Any]
        if let data = response?["data"] as? [[String:Any]]{
            self.stateModel = data.map({StateModel.init(with: $0)})
            for state in 0..<(self.stateModel?.count ?? 0) {
                self.arrStateName.append(self.stateModel?[state].name ?? "")
            }
        }
        if self.currentIndex == B2BSearch.Importer.rawValue{
        self.pushVCCallback?([HubCityArray](),GetRoleViewModel([:]),ProductType(with: [:]),self.stateModel ?? [StateModel](),[SignUpOptionsDataModel](),AppConstants.SelectState)
        }else{
            if self.currentIndex == B2BSearch.Voyager.rawValue {
            self.pushVCCallback?([HubCityArray](),GetRoleViewModel([:]),ProductType(with: [:]),self.stateModel ?? [StateModel](),[SignUpOptionsDataModel](),AppConstants.SelectState)
            }else{
                self.pushVCCallback?([HubCityArray](),GetRoleViewModel([:]),ProductType(with: [:]),self.stateModel ?? [StateModel](),[SignUpOptionsDataModel](),AppConstants.SelectRegion)
            }
        }
    }
}
    
    func callUserHubsApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetAllHubs, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let response = dictResponse as? [String:Any]
           if let data = response?["hubs"] as? [[String:Any]]{
                self.userhubs = data.map({HubCityArray.init(with: $0)})
                for hub in 0..<(self.userhubs?.count ?? 0) {
                    self.arrHubName.append(self.userhubs?[hub].title ?? "")
                }
            }
            self.pushVCCallback?(self.userhubs,GetRoleViewModel([:]),ProductType(with: [:]),[StateModel](),[SignUpOptionsDataModel](), AppConstants.Hubs)
        }
    }
    func callGetValueOfFieldApi(){
        self.arrProductType.removeAll()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetFieldValue + "\(self.fieldValueId ?? 0)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let response = dictResponse as? [String:Any]
            
            if  self.fieldValueId == B2BFieldId.productType.rawValue{
                if let data = response?["data"] as? [String:Any]{
                self.productoption = SignUpStepOneDataModel.init(withDictionary: data)
                }

            }else{
            if let data = response?["data"] as? [String:Any]{
                self.productType = ProductType.init(with: data)
                print("Count ------------------------------\(self.productType?.options?.count ?? 0)")
                for product in 0..<(self.productType?.options?.count ?? 0) {
                    self.arrProductType.append(self.productType?.options?[product].optionName ?? "")
                }
            }
            }
                //self.dataDropDown.dataSource = self.arrProductType
                //self.opendropDown()
                if self.fieldValueId == B2BFieldId.productType.rawValue{
//                    self.pushVCCallback?([HubCityArray](),GetRoleViewModel([:]),self.productType ?? ProductType(with: [:]),[StateModel](),[SignUpOptionsDataModel](),AppConstants.ProductTypeBusiness)
                    self.pushToProductTypeScreen?(self.productoption ?? SignUpStepOneDataModel(withDictionary: [:]), self.identifyUserForProduct ?? .productImporter)
                }else if self.fieldValueId == B2BFieldId.restaurantType.rawValue{
                    self.pushVCCallback?([HubCityArray](),GetRoleViewModel([:]),self.productType ?? ProductType(with: [:]),[StateModel](),[SignUpOptionsDataModel](),AppConstants.RestaurantType)
                }else if self.fieldValueId == B2BFieldId.expertise.rawValue{
                    self.pushVCCallback?([HubCityArray](),GetRoleViewModel([:]),self.productType ?? ProductType(with: [:]),[StateModel](),[SignUpOptionsDataModel](),AppConstants.Expertise)
                }else if self.fieldValueId == B2BFieldId.title.rawValue{
                    self.pushVCCallback?([HubCityArray](),GetRoleViewModel([:]),self.productType ?? ProductType(with: [:]),[StateModel](),[SignUpOptionsDataModel](),AppConstants.Title)
                }else if self.fieldValueId == B2BFieldId.speciality.rawValue{
                    self.pushVCCallback?([HubCityArray](),GetRoleViewModel([:]),self.productType ?? ProductType(with: [:]),[StateModel](),[SignUpOptionsDataModel](),AppConstants.Speciality)
                }
                else{
                    print("chekcing")
                }
            }
        }
       
    
    func callImporterRoleApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetRoles, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errortype, statusCode) in
            
         let dicResponse = kSharedInstance.getDictionary(dictResponse)
        let dicData = kSharedInstance.getDictionary(dicResponse[APIConstants.kData])
        self.getRoleViewModel = GetRoleViewModel(dicData)
            for i in 0..<self.getRoleViewModel.arrImporter.count {
                self.arrImporterRole.append(self.getRoleViewModel.arrImporter[i].name ?? "")
            }
           // self.dataDropDown.dataSource = self.arrImporterRole
           // self.opendropDown()
            self.pushVCCallback?([HubCityArray](),self.getRoleViewModel,ProductType(with: [:]),[StateModel](),[SignUpOptionsDataModel](),AppConstants.SelectUserType)
        }
    }
    
    func callGetCountryApi(_ roleId: String?){
        arrOptions.removeAll()
        arrCountryStateName.removeAll()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetCountries + "\(roleId ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dicResponse, error, errorType, statusCode) in
            let response = dicResponse as? [String:Any]
            //let filterCountry = kSharedInstance.signUpViewModel.arrSignUpStepOne.filter({$0.name == APIConstants.kCountry})
            if let array = response?[APIConstants.kData] as? ArrayOfDictionary{
              self.arrOptions = array.map({SignUpOptionsDataModel(withDictionary: $0)})
           }
            for i in 0..<self.arrOptions.count {
                self.arrCountryStateName.append(self.arrOptions[i].name ?? "")
            }
            self.dataDropDown.dataSource = self.arrCountryStateName
            self.opendropDown()
        }
    }
    
    func callGetStatesWithCountryIdApi(_ expertCountryId: String){
        arrOptions.removeAll()
        arrCountryStateName.removeAll()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetStatesByCountryId + "\(expertCountryId)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dicResponse, error, errorType, statusCode) in
            let response = dicResponse as? [String:Any]
            //let filterCountry = kSharedInstance.signUpViewModel.arrSignUpStepOne.filter({$0.name == APIConstants.kCountry})
            if let array = response?[APIConstants.kData] as? ArrayOfDictionary{
              self.arrOptions = array.map({SignUpOptionsDataModel(withDictionary: $0)})
           }
            for i in 0..<self.arrOptions.count {
                self.arrCountryStateName.append(self.arrOptions[i].name ?? "")
            }
            if self.businessModel?.businessHeading ==  AppConstants.SelectRegion{
                self.pushVCCallback?([HubCityArray](),GetRoleViewModel([:]),ProductType(with: [:]),[StateModel](),self.arrOptions,AppConstants.SelectRegion)
            }else{
            self.pushVCCallback?([HubCityArray](),GetRoleViewModel([:]),ProductType(with: [:]),[StateModel](),self.arrOptions,AppConstants.SelectState)
            }
            //self.dataDropDown.dataSource = self.arrCountryStateName
            //self.opendropDown()
        }
    }
}
