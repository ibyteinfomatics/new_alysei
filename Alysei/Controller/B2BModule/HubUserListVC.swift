//
//  HubUserListVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/27/21.
//

import UIKit

class HubUserListVC: AlysieBaseViewC {
    
    var currentIndex:Int?
    var businessViewModel: BusinessSingleHubViewModel?
    var searchType:Int?
    var newSearchModel: NewFeedSearchModel?
    var arrSearchDataModel = [NewFeedSearchDataModel]()
    var arrSearchimpotrDataModel = [SubjectData]()
    var txtkeywordSearch: String?
    
    //var arrImpSearchList:  NewFeedSearchModel?
    var indexOfPageToRequest = 1
    
    var selectStateId:String?
    var selectImpHubId: String?
    var selectImpProductId: String?
    var selectImpRegionTypeId:String?
    var selectImpRoleId: String?
    var resHubId: String?
    var resTypeId: String?
    var selectExpertHubId: String?
    var selectExpertExpertiseId: String?
    var selectExpertTitleId: String?
    var selectExpertCountryId: String?
    var selectExpertRegionId: String?
    var selectTravelHubId: String?
    var selectTravelSpecialityId: String?
    var selectTravelCountryId: String?
    var selectTravelRegionId: String?
    var selectProducerHubId: String?
    var selectProducerRegionId: String?
    var selectProducerProductType: String?
    var selectedImpOptionId = [Int]()
    var horecaValue: String?
    var privateValue: String?
    var alyseiBrandValue: String?
    var extraCell: Int?
    var restPickUp: String?
    var restDelivery:String?
    var passHubId:String?
    var passRoleId:String?
    var passUserTitle: String?
    
    var searchImpDone = false
    var signUpStepOneDataModel: SignUpStepOneDataModel!
    var selectPrdctCatgryOptnNme :String?
    var selectFieldType:String?
    
    var identifyUserForProduct: IdentifyUserForProduct?
    var selectedProducWithCategory: String? = nil {
        didSet {
            self.tblViewSearchOptions.reloadData()
        }
    }
    private var currentChild: UIViewController {
        return self.children.last!
    }
    
    private lazy var selectedHubsViewC: SelectedHubsViewC = {
        
        let selectedHubsViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: SelectedHubsViewC.id()) as! SelectedHubsViewC
        return selectedHubsViewC
    }()
    
    private lazy var businessListViewC: BusinessListViewC = {
        
        let businessListViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: BusinessListViewC.id()) as! BusinessListViewC
        return businessListViewC
    }()
    private lazy var hubsViewC: HubsViewC = {
        
        let hubsViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: HubsViewC.id()) as! HubsViewC
        return hubsViewC
    }()
    
    //MARK: - IBOutlet -

    @IBOutlet weak var tblViewSearchOptions: UITableView!
    @IBOutlet weak var lblTiltle: UILabel!
    //@IBOutlet weak var containerView: UIView!
    
    //MARK: - ViewLifeCycle Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchType = 2
        lblTiltle.text = passUserTitle
        self.getUserListFromHubSelctionApi()
        self.businessViewModel = BusinessSingleHubViewModel(currentIndex: self.currentIndex ?? 0)
        //self.tblViewHeightConstraint.constant = 300.0
    }
    
    //MARK: IBAction
    
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    private func getBusinessTextFieldTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let businessTextFieldTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: BusinessTextFieldTableCell.identifier()) as! BusinessTextFieldTableCell
        businessTextFieldTableCell.passTextCallBack = { text in
            self.txtkeywordSearch = text
        }
        return businessTextFieldTableCell
    }
    
    private func getBusinessButtonTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let businessButtonTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: BusinessButtonTableCell.identifier()) as! BusinessButtonTableCell
        //businessButtonTableCell.configureData(withBusinessDataModel: self.businessViewModel?.arrBusinessData[indexPath.row] ?? BusinessDataModel(), currentIndex: self.currentIndex ?? 0)
        if self.searchImpDone == false{
            businessButtonTableCell.configureData(withBusinessDataModel: self.businessViewModel?.arrBusinessData[indexPath.row] ?? BusinessDataModel(), currentIndex: self.currentIndex ?? 0)
        }else{
            if identifyUserForProduct == .productImporter{
            if self.selectFieldType == AppConstants.ProductTypeBusiness && indexPath.row == 1{
                businessButtonTableCell.btnBusiness.setTitle(self.selectPrdctCatgryOptnNme, for: .normal)
            }else{
            print("No update")
            }
            }else{
                if self.selectFieldType == AppConstants.ProductTypeBusiness && indexPath.row == 0{
                    businessButtonTableCell.btnBusiness.setTitle(self.selectPrdctCatgryOptnNme, for: .normal)
                }else{
                print("No update")
                }
            }
        }

        businessButtonTableCell.pushVCCallback = { arruserHubs,getRoleViewModel,productType,stateModel,arrStateRegionById,selectFieldType in
            let controller = self.pushViewController(withName: BusinessMultiOptionsVC.id(), fromStoryboard: StoryBoardConstants.kHome) as? BusinessMultiOptionsVC
            controller?.arrUserHubs = arruserHubs ?? [HubCityArray]()
            controller?.selectFieldType = selectFieldType
            controller?.getRoleViewModel = getRoleViewModel
            controller?.stateModel = stateModel
            controller?.productType = productType
            controller?.arrStateRegion = arrStateRegionById
            controller?.currentIndex = self.currentIndex
            if self.currentIndex == B2BSearch.Hub.rawValue{
                if selectFieldType == AppConstants.SelectState{
                    let Arr =  self.selectStateId?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }
            }
            if self.currentIndex == B2BSearch.Voyager.rawValue {
                if selectFieldType == AppConstants.SelectState{
                    let Arr =  self.selectStateId?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }
            }
            if self.currentIndex == B2BSearch.Importer.rawValue{
                if selectFieldType == AppConstants.Hubs{
                    let Arr =  self.selectImpHubId?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }else if selectFieldType == AppConstants.SelectUserType{
                    let Arr =  self.selectImpRoleId?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }else if selectFieldType == AppConstants.ProductTypeBusiness{
                    let Arr =  self.selectImpProductId?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }else if selectFieldType == AppConstants.SelectState{
                    let Arr =  self.selectImpRegionTypeId?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }
            }else if self.currentIndex == B2BSearch.Restaurant.rawValue{
                if selectFieldType == AppConstants.Hubs{
                    let Arr =  self.resHubId?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }else if selectFieldType == AppConstants.RestaurantType{
                    let Arr =  self.resTypeId?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }
            }else if self.currentIndex == B2BSearch.Expert.rawValue{
                if selectFieldType == AppConstants.Hubs{
                    let Arr =  self.selectExpertHubId?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }else if selectFieldType == AppConstants.Expertise{
                    let Arr =  self.selectExpertExpertiseId?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }else if selectFieldType == AppConstants.Title{
                    let Arr =  self.selectExpertTitleId?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }else if selectFieldType == AppConstants.SelectState {
                    let Arr =  self.selectExpertRegionId?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }else if selectFieldType == AppConstants.SelectRegion{
                    let Arr =  self.selectExpertRegionId?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }
            }else if self.currentIndex == B2BSearch.TravelAgencies.rawValue{
                if selectFieldType == AppConstants.Hubs{
                    let Arr =  self.selectTravelHubId?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }else if selectFieldType == AppConstants.Speciality{
                    let Arr =  self.selectTravelSpecialityId?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }else if selectFieldType == AppConstants.SelectState {
                    let Arr =  self.selectTravelRegionId?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }else if selectFieldType == AppConstants.SelectRegion{
                    let Arr =  self.selectTravelRegionId?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }
                
            }else if self.currentIndex == B2BSearch.Producer.rawValue{
                if selectFieldType == AppConstants.Hubs{
                    let Arr =  self.selectProducerHubId?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }else if selectFieldType == AppConstants.ProductTypeBusiness{
                    let Arr =  self.selectProducerProductType?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }else if selectFieldType == AppConstants.SelectRegion{
                    let Arr =  self.selectProducerRegionId?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }
                
            }
            controller?.doneCallBack = { arrSelectOptionName , arrSelectOptionId in
                let optionName = arrSelectOptionName?.joined(separator: ",")
                let  optionId = arrSelectOptionId?.joined(separator: ",")
                if self.currentIndex == B2BSearch.Hub.rawValue{
                    if selectFieldType == AppConstants.SelectState{
                    businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                    self.selectStateId = optionId
                    }
                }
                if self.currentIndex == B2BSearch.Voyager.rawValue{
                    if selectFieldType == AppConstants.SelectState || selectFieldType == AppConstants.SelectRegion{
                    businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                    self.selectStateId = optionId
                    }
                }
                if self.currentIndex == B2BSearch.Importer.rawValue{
                if selectFieldType == AppConstants.Hubs{
                businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                self.selectImpHubId = optionId
                }else if selectFieldType == AppConstants.SelectUserType{
                    businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                    self.selectImpRoleId = optionId
                }else if selectFieldType == AppConstants.ProductTypeBusiness{
                    businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                    self.selectImpProductId = optionId
                }else if selectFieldType == AppConstants.SelectState{
                    businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                    self.selectImpRegionTypeId = optionId
                }
                }else if self.currentIndex == B2BSearch.Restaurant.rawValue{
                    if selectFieldType == AppConstants.Hubs{
                    businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                    self.resHubId = optionId
                    }else if selectFieldType == AppConstants.RestaurantType{
                        businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                        self.resTypeId = optionId
                        }
                }else if self.currentIndex == B2BSearch.Expert.rawValue{
                    if selectFieldType == AppConstants.Hubs{
                    businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                    self.selectExpertHubId = optionId
                    }else if selectFieldType == AppConstants.Expertise{
                        businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                        self.selectExpertExpertiseId = optionId
                    }else if selectFieldType == AppConstants.Title{
                        businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                        self.selectExpertTitleId = optionId
                    }else if selectFieldType == AppConstants.SelectState{
                        businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                        self.selectExpertRegionId = optionId
                        }
                }else if self.currentIndex == B2BSearch.TravelAgencies.rawValue{
                    if selectFieldType == AppConstants.Hubs{
                    businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                    self.selectTravelHubId = optionId
                    }else if selectFieldType == AppConstants.Speciality{
                        businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                        self.selectTravelSpecialityId = optionId
                    }else if selectFieldType == AppConstants.SelectState{
                        businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                        self.selectTravelRegionId = optionId
                    }
                
                }else if self.currentIndex == B2BSearch.Producer.rawValue{
                    if selectFieldType == AppConstants.Hubs{
                    businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                    self.selectProducerHubId = optionId
                    }else if selectFieldType == AppConstants.ProductTypeBusiness{
                        businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                        self.selectProducerProductType = optionId
                    }else if selectFieldType == AppConstants.SelectRegion{
                        businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                        self.selectProducerRegionId = optionId
                    }
                
                }
                print("stringRepresentation--------------------------\(optionId ?? "")")
                
            }
        }
        businessButtonTableCell.passIdCallBack = {  exprtCuntryId, trvlCuntryId in
            
            self.selectExpertCountryId = exprtCuntryId
           
            self.selectTravelCountryId = trvlCuntryId
            
            
        }
        businessButtonTableCell.passCellCallback = { country in
            if self.businessViewModel?.arrBusinessData[indexPath.row + 1].businessHeading == AppConstants.SelectState || self.businessViewModel?.arrBusinessData[indexPath.row + 1].businessHeading == AppConstants.SelectRegion {
                if country == "Italy" || country == "italy"{
                    self.businessViewModel?.arrBusinessData[indexPath.row + 1].businessHeading = AppConstants.SelectRegion
                }else if country == "United States" || country == "USA"{
                    self.businessViewModel?.arrBusinessData[indexPath.row + 1].businessHeading = AppConstants.SelectState
                }else{
                    self.businessViewModel?.arrBusinessData[indexPath.row + 1].businessHeading = AppConstants.SelectState
                }
                self.selectTravelRegionId = ""
                self.selectExpertRegionId = ""
              //  self.businessViewModel.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.ProductTypeBusiness))
                self.tblViewSearchOptions.reloadRows(at: [IndexPath(row: indexPath.row + 1, section: 0)], with: .automatic)
            }
            
        }
        businessButtonTableCell.pushToProductTypeScreen = { signUpmodel, IdentifyUserForProduct in
             //   let model = self.signUpViewModel.arrSignUpStepOne[indexPath.row]
                let controller = self.pushViewController(withName: SelectProductViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? SelectProductViewC
            let signupmodel = signUpmodel
            for _ in signupmodel.arrOptions {
                if self.signUpStepOneDataModel == nil{
                    controller?.signUpStepOneDataModel = signupmodel
                    controller?.stepOneDelegate = self
                    return
                }
//                for selectedOptions in self.signUpStepOneDataModel.arrOptions{
//                    options.isSelected = selectedOptions.id == options.id
//                    for suboptions in options.arrSubSections{
//
//                        for selectedSuboptions in selectedOptions.arrSubSections {
//
//                            for subSuboptions in suboptions.arrSubOptions{
//                                for selectedSubSuboption in selectedSuboptions.arrSubOptions{
//                                    subSuboptions.isSelected = subSuboptions.userFieldOptionId == selectedSubSuboption.userFieldOptionId
//                                }
//                            }
//                        }
//                    }
//                }
            }
           
                controller?.signUpStepOneDataModel = signupmodel
                controller?.stepOneDelegate = self
            }
        return businessButtonTableCell
    }
    
    private func getBusinessFiltersTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let businessFiltersTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: BusinessFiltersTableCell.identifier()) as! BusinessFiltersTableCell
        //businessFiltersTableCell.configureData(withBusinessDataModel: self.businessViewModel?.arrBusinessData[indexPath.row] ??  BusinessDataModel())
        if self.searchImpDone == false{
            businessFiltersTableCell.configureData(withBusinessDataModel: self.businessViewModel?.arrBusinessData[indexPath.row] ?? BusinessDataModel())
        }else{
            print("No update")
        }
        businessFiltersTableCell.passIdCallback = { arrSelectedIndex in
            if self.currentIndex == B2BSearch.Importer.rawValue || self.currentIndex == B2BSearch.Producer.rawValue{
                self.selectedImpOptionId = arrSelectedIndex
                if self.selectedImpOptionId.contains(0){
                    self.horecaValue = AppConstants.HorecaValue
                }else{
                    self.horecaValue = ""
                }
                if self.selectedImpOptionId.contains(1){
                    self.privateValue = AppConstants.PrivateLabelValue
                }else{
                    self.privateValue = ""
                }
                if self.selectedImpOptionId.contains(2){
                    self.alyseiBrandValue = AppConstants.AlyseiBrandValue
                }else{
                    self.alyseiBrandValue = ""
                }
            }else{
                self.selectedImpOptionId = arrSelectedIndex
                if self.selectedImpOptionId.contains(0){
                    self.restPickUp = "\(RestValue.pickUp.rawValue)"
                }else{
                    self.restPickUp = ""
                }
                if self.selectedImpOptionId.contains(1){
                    self.restDelivery = "\(RestValue.delivery.rawValue)"
                }else{
                    self.restDelivery = ""
                }
            }
        }
        return businessFiltersTableCell
    }
    
    private func getBusinessSearchTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let businessSearchTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: BusinessSearchTableCell.identifier()) as! BusinessSearchTableCell
        businessSearchTableCell.searchTappedCallback = {
//            if self.currentIndex == B2BSearch.Hub.rawValue{
//                self.callSearchHubApi()
//            }else
            self.searchImpDone = true
            if self.currentIndex == B2BSearch.Importer.rawValue{
                self.callSearchImporterApi()
            }else if self.currentIndex == B2BSearch.Restaurant.rawValue {
                self.callSearchResturntApi()
            }else if self.currentIndex == B2BSearch.Expert.rawValue {
                self.callSearchExpertApi()
            }else if self.currentIndex == B2BSearch.TravelAgencies.rawValue{
                self.callSearchTravelApi()
            }else if self.currentIndex == B2BSearch.Producer.rawValue {
                self.callSearchProducerApi()
            }else if self.currentIndex == B2BSearch.Voyager.rawValue{
                self.callSearchVoyagerApi()
            }
        }
        return businessSearchTableCell
    }
    
    private func getSelectedHubsTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let selectedHubsTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: SelectedHubsTableCell.identifier()) as! SelectedHubsTableCell
        selectedHubsTableCell.delegate = self
        selectedHubsTableCell.configData(arrSearchDataModel)
        selectedHubsTableCell.collectionViewSelectedHubs.reloadData()
        return selectedHubsTableCell
    }
    
    private func getBusinessListTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let businessListTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: BusinessListTableCell.identifier()) as! BusinessListTableCell
        businessListTableCell.configData(arrSearchimpotrDataModel[(indexPath.row - (self.extraCell ?? 0))])
        return businessListTableCell
    }


}
//MARK:  - UITableViewMethods -

extension HubUserListVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        let model = self.businessViewModel?.arrBusinessData[section]
        //let model = self.businessViewModel.arrBusinessData[currentIndex]
        switch model?.businessCellType {
        case .tableListCell:
            //return model.cellCount
            return model?.cellCount ?? 0
        default:
            return self.businessViewModel?.arrBusinessData.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.businessViewModel?.arrBusinessData[indexPath.row].businessCellType
        switch model {
        case .textFieldCell:
            return self.getBusinessTextFieldTableCell(indexPath)
        case .collectionFilters:
            return self.getBusinessFiltersTableCell(indexPath)
        case .searchCell:
            return self.getBusinessSearchTableCell(indexPath)
        case .collectionHubs:
            return self.getSelectedHubsTableCell(indexPath)
        case .tableListCell:
            return self.getBusinessListTableCell(indexPath)
        default:
            return self.getBusinessButtonTableCell(indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = self.businessViewModel?.arrBusinessData[indexPath.row]
        switch model?.businessCellType {
        case .searchCell:
            return 100.0
        case .collectionHubs:
            // let cellSize = CGFloat(model.cellCount) / 3.0
            return 180.0  //* cellSize
        case .tableListCell:
            return 66.0
        default:
            return 70.0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = pushViewController(withName: ProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? ProfileViewC
        controller?.userLevel = .other
        let index = (indexPath.row - (self.extraCell ?? 0))
        if arrSearchimpotrDataModel[index].userId == nil{
            print("Invalid Cell")
        }else{
        controller?.userID = arrSearchimpotrDataModel[index].userId
        }
        
        
    }
    
}
extension HubUserListVC: TappedHubs{
    
    func tapOnHub(_ hubId: String?, _ hubName: String?, _ hubLocation: String?){
        let controller = pushViewController(withName: HubsViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? HubsViewC
        controller?.passHubId = hubId
        controller?.passHubName = hubName
        controller?.passHubLocation = hubLocation
    }
}

extension HubUserListVC {
    func callSearchImporterApi(){
        arrSearchimpotrDataModel.removeAll()
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(passRoleId ?? "")" + "&hub_id=" + "\(self.passHubId ?? "")" + "&user_type=" + "\(selectImpRoleId ?? "")" + "&product_type=" + "\(self.selectImpProductId ?? "")" + "&horeca=" + "\(self.horecaValue ?? "")" + "&private_label=" + "\(self.privateValue ?? "")" + "&alysei_brand_label=" + "\(self.alyseiBrandValue ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 { self.arrSearchDataModel.removeAll() }
                //self.arrSearchDataModel.append(contentsOf: self.newSearchModel?.data ?? [NewFeedSearchDataModel(with: [:])])
               
                self.arrSearchimpotrDataModel.append(contentsOf: self.newSearchModel?.importerSeacrhData ?? [SubjectData(with: [:])])
            }
            print("CountImpSearch------------------------\(self.arrSearchimpotrDataModel.count)")
//            self.selectImpProductId = ""
//            self.selectImpRegionTypeId = ""
//            self.horecaValue = ""
//            self.privateValue = ""
//            self.alyseiBrandValue = ""
            cellCount = self.arrSearchimpotrDataModel.count
            self.extraCell = 4
            //self.tblViewSearchOptions.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .automatic)
            print("CellCount--------------------------------------------\(cellCount ?? 0)")
            self.businessViewModel = BusinessSingleHubViewModel(currentIndex: self.currentIndex ?? 0)
            self.tblViewSearchOptions.reloadData()
            
            
        }
    }
    func callSearchProducerApi(){
        arrSearchimpotrDataModel.removeAll()
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(UserRoles.producer.rawValue)" + "&hub_id=" + "\(self.passHubId ?? "")" + "&product_type=" + "\(selectProducerProductType ?? "")" + "&region=" + "\(self.selectProducerRegionId ?? "")" + "&horeca=" + "\(self.horecaValue ?? "")" + "&private_label=" + "\(self.privateValue ?? "")" + "&alysei_brand_label=" + "\(self.alyseiBrandValue ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 { self.arrSearchimpotrDataModel.removeAll() }
                self.arrSearchimpotrDataModel.append(contentsOf: self.newSearchModel?.importerSeacrhData ?? [SubjectData(with: [:])])
            }
            //self.collectionViewBusinessCategory.reloadData()
            print("CountImpSearch------------------------\(self.arrSearchimpotrDataModel.count)")
            cellCount = self.arrSearchimpotrDataModel.count
            self.extraCell = 3
//            self.selectProducerProductType = ""
//            self.selectProducerRegionId = ""
//            self.horecaValue = ""
//            self.privateValue = ""
//            self.alyseiBrandValue = ""
            //self.tblViewSearchOptions.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .automatic)
            self.businessViewModel = BusinessSingleHubViewModel(currentIndex: self.currentIndex ?? 0)
            
            self.tblViewSearchOptions.reloadData()
            
            
        }
    }
    func callSearchResturntApi(){
        arrSearchimpotrDataModel.removeAll()
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(UserRoles.restaurant.rawValue)" + "&hub_id=" + "\(self.passHubId  ?? "")" + "&restaurant_type=" + "\(self.resTypeId ?? "")" + "&pickup=" + "\(restPickUp ?? "")" + "&delivery=" + "\(restDelivery ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dicResponse, error, errorType, statusCode) in
            let dictResponse = dicResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 {self.arrSearchDataModel.removeAll() }
                self.arrSearchimpotrDataModel.append(contentsOf: self.newSearchModel?.importerSeacrhData ?? [SubjectData(with: [:])])
            }
            //self.collectionViewBusinessCategory.reloadData()
            print("CountImpSearch------------------------\(self.arrSearchimpotrDataModel.count)")
            cellCount = self.arrSearchimpotrDataModel.count
            self.extraCell = 3
//            self.resTypeId = ""
//            self.restPickUp = ""
//            self.restDelivery = ""
            self.businessViewModel = BusinessSingleHubViewModel(currentIndex: self.currentIndex ?? 0)
            self.tblViewSearchOptions.reloadData()
            
            
        }
    }
    
    func callSearchExpertApi(){
        arrSearchimpotrDataModel.removeAll()
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(UserRoles.voiceExperts.rawValue)" + "&hub_id=" + "\(self.passHubId  ?? "")" + "&expertise=" + "\(self.selectExpertExpertiseId ?? "")" + "&title=" + "\(self.selectExpertTitleId ?? "")" + "&country=" + "\(self.selectExpertCountryId ?? "")" + "&region=" + "\(self.selectExpertRegionId ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 {self.arrSearchimpotrDataModel.removeAll() }
                self.arrSearchimpotrDataModel.append(contentsOf: self.newSearchModel?.importerSeacrhData ?? [SubjectData(with: [:])])
            }
            //self.collectionViewBusinessCategory.reloadData()
            print("CountImpSearch------------------------\(self.arrSearchimpotrDataModel.count)")
            cellCount = self.arrSearchimpotrDataModel.count
            self.extraCell = 5
//            self.selectExpertExpertiseId = ""
//            self.selectExpertTitleId = ""
//            self.selectExpertCountryId = ""
//            self.selectExpertRegionId = ""
            self.businessViewModel = BusinessSingleHubViewModel(currentIndex: self.currentIndex ?? 0)
            self.tblViewSearchOptions.reloadData()
            
            
        }
    }
    
    func callSearchTravelApi(){
        arrSearchimpotrDataModel.removeAll()
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(UserRoles.travelAgencies.rawValue)" + "&hub_id=" + "\(self.passHubId  ?? "")" + "&speciality=" + "\(self.selectTravelSpecialityId ?? "")" + "&country=" + "\(self.selectTravelCountryId ?? "")" + "&region=" + "\(self.selectTravelRegionId ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 { self.arrSearchimpotrDataModel.removeAll() }
                self.arrSearchimpotrDataModel.append(contentsOf: self.newSearchModel?.importerSeacrhData ?? [SubjectData(with: [:])])
            }
            //self.collectionViewBusinessCategory.reloadData()
            print("CountImpSearch------------------------\(self.arrSearchimpotrDataModel.count)")
            cellCount = self.arrSearchimpotrDataModel.count
            self.extraCell = 4
//            self.selectTravelSpecialityId = ""
//            self.selectTravelCountryId = ""
//            self.selectTravelRegionId = ""
            self.businessViewModel = BusinessSingleHubViewModel(currentIndex: self.currentIndex ?? 0)
            self.tblViewSearchOptions.reloadData()
            
            
        }
    }
    func callSearchVoyagerApi(){
        arrSearchimpotrDataModel.removeAll()
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(passRoleId ?? "")" + "&state=" + "\(self.selectStateId ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 { self.arrSearchDataModel.removeAll() }
                //self.arrSearchDataModel.append(contentsOf: self.newSearchModel?.data ?? [NewFeedSearchDataModel(with: [:])])
               
                self.arrSearchimpotrDataModel.append(contentsOf: self.newSearchModel?.importerSeacrhData ?? [SubjectData(with: [:])])
            }
            print("CountImpSearch------------------------\(self.arrSearchimpotrDataModel.count)")
            cellCount = self.arrSearchimpotrDataModel.count
            self.extraCell = 2
            print("CellCount--------------------------------------------\(cellCount ?? 0)")
            self.businessViewModel = BusinessSingleHubViewModel(currentIndex: self.currentIndex ?? 0)
            self.tblViewSearchOptions.reloadData()
            
            
        }
    }
    //"&role_id="
        func getUserListFromHubSelctionApi(){
            arrSearchimpotrDataModel.removeAll()
            cellCount = 0
            TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetRoleListFromHubSlctn + "&role_id=" + "\(passRoleId ?? "")" + "&hub_id=" + "\(passHubId ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errtype, statusCode) in
                let response = dictResponse as? [String:Any]
    
                if let data = response?["data"] as? [[String:Any]]{
                   // self.newSearchModel = NewFeedSearchModel.init(with: data)
                    if self.indexOfPageToRequest == 1 { self.arrSearchimpotrDataModel.removeAll() }
                   // self.arrSearchimpotrDataModel.append(contentsOf: self.newSearchModel?.importerSeacrhData ?? [SubjectData(with: [:])])
                    self.arrSearchimpotrDataModel = data.map({SubjectData.init(with: $0)})
                }
                //self.collectionViewBusinessCategory.reloadData()
                print("CountImpSearch------------------------\(self.arrSearchimpotrDataModel.count)")
                cellCount = self.arrSearchimpotrDataModel.count
                if self.currentIndex == B2BSearch.Producer.rawValue{
                    self.extraCell = 3
                }else if self.currentIndex == B2BSearch.Importer.rawValue{
                    self.extraCell = 4
                }else if self.currentIndex == B2BSearch.Restaurant.rawValue{
                    self.extraCell = 3
                }else if self.currentIndex == B2BSearch.TravelAgencies.rawValue{
                    self.extraCell = 4
                }else if self.currentIndex == B2BSearch.Expert.rawValue{
                    self.extraCell = 5
                }else{
                    self.extraCell = 2
                }
                self.businessViewModel = BusinessSingleHubViewModel(currentIndex: self.currentIndex ?? 0)
                self.tblViewSearchOptions.reloadData()
    
    
            }
    
            }
        }

//SelectProduct Tapped Done

extension HubUserListVC: TappedDoneStepOne{
    
    func tapDone(_ signUpStepOneDataModel: SignUpStepOneDataModel) {
        
        self.signUpStepOneDataModel = nil
        self.signUpStepOneDataModel = signUpStepOneDataModel
        signUpStepOneDataModel.selectedValue = self.createStringForProducts()
        print("Values----------------------------------------",signUpStepOneDataModel.selectedValue ?? "")
        self.selectedProducWithCategory = signUpStepOneDataModel.selectedValue
        self.selectPrdctCatgryOptnNme = signUpStepOneDataModel.selectedOptionName
        self.searchImpDone = true
        self.selectFieldType = AppConstants.ProductTypeBusiness
        self.navigationController?.popViewController(animated: true)
        self.tblViewSearchOptions.reloadData()
    }
    private func createStringForProducts() -> String {
        let filteredSelectedProduct = self.signUpStepOneDataModel.arrOptions.map({$0}).filter({$0.isSelected == true})
        
        var selectedProductNames: [String] = []
        var selectedProductOptionIds: [String] = []
        var selectedSubProductOptionIds: [String] = []
        
        for index in 0..<filteredSelectedProduct.count {
            
            //var selectedProductId: [String] = []
            var selectedSubProductIdLocal: [String] = []
            
            selectedProductNames.append(String.getString(filteredSelectedProduct[index].optionName))
            selectedProductOptionIds.append(String.getString(filteredSelectedProduct[index].userFieldOptionId))
            
            let sections = filteredSelectedProduct[index].arrSubSections
            
            for sectionIndex in 0..<sections.count {
                
                print("arrSelectedSubOptions",sections[sectionIndex].arrSelectedSubOptions)
                selectedSubProductIdLocal.append(contentsOf: sections[sectionIndex].arrSelectedSubOptions.map({$0}))
            }
            selectedSubProductOptionIds.append(contentsOf: selectedSubProductIdLocal)
        }
        
        switch filteredSelectedProduct.count {
        case 0:
            print("No Products found")
            self.signUpStepOneDataModel.selectedOptionName = ""
        case 1:
            self.signUpStepOneDataModel.selectedOptionName = selectedProductNames[0]
        //     case 2:
        //      self.signUpStepOneDataModel.selectedOptionName = selectedProductNames[0] + ", " + selectedProductNames[1]
        default:
            let remainingProducts = (selectedProductNames.count - 1)
            self.signUpStepOneDataModel.selectedOptionName = selectedProductNames[0] + " & " + String.getString(remainingProducts) + " more"
        }
        print("product",selectedProductOptionIds)
        print("sub product",selectedSubProductOptionIds)
        
        let mergeArray = selectedProductOptionIds + selectedSubProductOptionIds
        return mergeArray.joined(separator: ", ")
    }
   

}
