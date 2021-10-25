//
//  BusinessViewC.swift
//  Alysie
//
//  Created by CodeAegis on 24/01/21.
//

import UIKit
import DropDown

var cellCount: Int?
//var B2BLoadFirstTime = true


class BusinessViewC: AlysieBaseViewC {
    
    //MARK: - Properties -
    
    // blank data view
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var viewBlankHeading: UIView!
    @IBOutlet weak var blankdataView: UIView!
    @IBOutlet weak var imgReview: UIImageView!
    
    var currentIndex: Int = 0
    var businessViewModel = BusinessViewModel(currentIndex: 0)
    var txtkeywordSearch : String?
    var searchType:Int?
    
    var newSearchModel: NewFeedSearchModel?
    var arrSearchDataModel = [NewFeedSearchDataModel]()
    var arrSearchimpotrDataModel = [SubjectData]()
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
    var paginationData = false
    var searchImpDone = false
    //var selectedProducWithCategory:String
    var selectedProducWithCategory: String? = nil {
        didSet {
            self.tblViewSearchOptions.reloadData()
        }
    }

    var signUpStepOneDataModel: SignUpStepOneDataModel!
    var selectPrdctCatgryOptnNme :String?
    var selectFieldType:String?
    
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
    
    @IBOutlet weak var collectionViewBusinessCategory: UICollectionView!
    @IBOutlet weak var tblViewSearchOptions: UITableView!
    //@IBOutlet weak var tblViewHeightConstraint: NSLayoutConstraint!
    //@IBOutlet weak var containerView: UIView!
    
    //MARK: - ViewLifeCycle Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchType = 3
        if currentIndex == 0 {
        callSearchHubApi()
        }
        //self.tblViewHeightConstraint.constant = 300.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let data = kSharedUserDefaults.getLoggedInUserDetails()
        
        let role = Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId)
        
        if role != 10 {
            if Int.getInt(data["alysei_review"]) == 0 {
                
                blankdataView.isHidden = false
                
            } else if Int.getInt(data["alysei_review"]) == 1{
                
                blankdataView.isHidden = true
               
            }
        } else {
            blankdataView.isHidden = true
        }
        
        if currentIndex == 0 {
        callSearchHubApi()
        }
    }
    
    @IBAction func tapLogout(_ sender: UIButton) {
        let token = kSharedUserDefaults.getDeviceToken()
        kSharedUserDefaults.clearAllData()
        kSharedUserDefaults.setDeviceToken(deviceToken: token)
     // kSharedUserDefaults.clearAllData()
    }
    
    //MARK: - IBAction -
    
    @IBAction func tapNotification(_ sender: UIButton) {
        
        _ = pushViewController(withName: NotificationViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
    }
    
    //MARK:- Pagination
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height - (self.view.frame.height * 2) {
            if indexOfPageToRequest >= newSearchModel?.lastPage ?? 0{
                print("No Data")
            }else{
                // increments the number of the page to request
                indexOfPageToRequest += 1
                self.searchImpDone = true
                paginationData = true
                // call your API for more data
                switch  self.currentIndex {
                case 1:
                    callSearchProducerApi()
                case B2BSearch.Importer.rawValue:
                    callSearchImporterApi()
                case B2BSearch.Restaurant.rawValue:
                    callSearchResturntApi()
                case B2BSearch.TravelAgencies.rawValue:
                    callSearchTravelApi()
                case B2BSearch.Expert.rawValue:
                    callSearchExpertApi()
                    
                default:
                    break
                }
                
                
                // tell the table view to reload with the new data
                
                
            }
        }
    }
    
    //MARK: - Private Methods -
    
    //  private func moveToNew(childViewController newVC: UIViewController,fromController oldVC: UIViewController, completion:((() ->Void)? ) = nil){
    //
    //      if  oldVC == newVC {
    //        completion?()
    //        return
    //      }
    //      DispatchQueue.main.async {
    //
    //          self.view.isUserInteractionEnabled = false
    //          self.addChild(newVC)
    //          newVC.view.frame = self.containerView.bounds
    //
    //        oldVC.willMove(toParent: nil)
    //
    //        self.transition(from: oldVC, to: newVC, duration: 0.25, options: UIView.AnimationOptions(rawValue: 0), animations:{
    //
    //          })
    //          { (_) in
    //
    //              oldVC.removeFromParent()
    //              newVC.didMove(toParent: self)
    //              self.view.isUserInteractionEnabled = true
    //              completion?()
    //          }
    //      }
    //  }
    
    private func getBusinessCategoryCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
        
        let businessCategoryCollectionCell = collectionViewBusinessCategory.dequeueReusableCell(withReuseIdentifier: BusinessCategoryCollectionCell.identifier(), for: indexPath) as! BusinessCategoryCollectionCell
        //_ = (self.currentIndex == 0) ? self.moveToNew(childViewController: selectedHubsViewC, fromController: self.currentChild) :   self.moveToNew(childViewController: businessListViewC, fromController: self.currentChild)
        businessCategoryCollectionCell.configureData(indexPath: indexPath, currentIndex: self.currentIndex)
        return businessCategoryCollectionCell
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
        if self.searchImpDone == false{
            businessButtonTableCell.configureData(withBusinessDataModel: self.businessViewModel.arrBusinessData[indexPath.row], currentIndex: self.currentIndex)
        }else{
            if self.selectFieldType == AppConstants.ProductTypeBusiness && indexPath.row == 2{
                businessButtonTableCell.btnBusiness.setTitle(self.selectPrdctCatgryOptnNme, for: .normal)
            }else{
            print("No update")
            }
        }
        
      
        businessButtonTableCell.pushVCCallback = { arruserHubs,getRoleViewModel,productType,stateModel,arrStateRegionById,selectFieldType in
            let controller = self.pushViewController(withName: BusinessMultiOptionsVC.id(), fromStoryboard: StoryBoardConstants.kHome) as? BusinessMultiOptionsVC
            controller?.arrUserHubs = arruserHubs ?? [HubCityArray]()
            controller?.selectFieldType = selectFieldType
            self.selectFieldType = ""
            controller?.getRoleViewModel = getRoleViewModel
            controller?.stateModel = stateModel
            controller?.productType = productType
            controller?.arrStateRegion = arrStateRegionById
            controller?.currentIndex = self.currentIndex
            if self.currentIndex == B2BSearch.Hub.rawValue{
                if selectFieldType == AppConstants.SelectState ||  selectFieldType == AppConstants.SelectRegion{
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
                    //let Arr =  self.selectedProducWithCategory
                   // controller?.passSelectOptionId = Arr ?? [""]
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
                    //let Arr =  self.selectProducerProductType?.components(separatedBy: ",")
                    //controller?.passSelectOptionId = Arr ?? [""]
                }else if selectFieldType == AppConstants.SelectRegion{
                    let Arr =  self.selectProducerRegionId?.components(separatedBy: ",")
                    controller?.passSelectOptionId = Arr ?? [""]
                }
                
            }
            //controller?.passSelectOptionId = self.selectedOptionId ?? [""]
            controller?.doneCallBack = { arrSelectOptionName , arrSelectOptionId in
                
                let optionName = arrSelectOptionName?.joined(separator: ",")
                let  optionId = arrSelectOptionId?.joined(separator: ",")
                if self.currentIndex == B2BSearch.Hub.rawValue{
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
                        businessButtonTableCell.btnBusiness.setTitle(self.selectedProducWithCategory ?? "", for: .normal)
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
                    }else if selectFieldType == AppConstants.SelectState {
                        businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                        self.selectExpertRegionId = optionId
                    }else if selectFieldType == AppConstants.SelectRegion{
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
                    }else if selectFieldType == AppConstants.SelectState {
                        businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                        self.selectTravelRegionId = optionId
                    }else if selectFieldType == AppConstants.SelectRegion{
                        businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                        self.selectTravelRegionId = optionId
                    }
                    
                }else if self.currentIndex == B2BSearch.Producer.rawValue{
                    if selectFieldType == AppConstants.Hubs{
                        businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                        self.selectProducerHubId = optionId
                    }else if selectFieldType == AppConstants.ProductTypeBusiness{
                        businessButtonTableCell.btnBusiness.setTitle(self.selectedProducWithCategory ?? "", for: .normal)
                        self.selectProducerProductType = optionId
                    }else if selectFieldType == AppConstants.SelectRegion{
                        businessButtonTableCell.btnBusiness.setTitle(optionName ?? "", for: .normal)
                        self.selectProducerRegionId = optionId
                    }
                    
                }
                print("stringRepresentation--------------------------\(optionId ?? "")")
                
            }
        }
        businessButtonTableCell.pushToProductTypeScreen = { signUpmodel in
             //   let model = self.signUpViewModel.arrSignUpStepOne[indexPath.row]
                let controller = self.pushViewController(withName: SelectProductViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? SelectProductViewC
            let signupmodel = signUpmodel
            for options in signupmodel.arrOptions {
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
//        businessButtonTableCell.pushToProductTypeScreen = { productType in
//            guard let controller = UIStoryboard(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(identifier: SelectB2BProductViewController.id()) as? SelectB2BProductViewController else {return}
//            controller.arrProductType = productType
//
//            self.navigationController?.pushViewController(controller, animated: true)
//        }
        businessButtonTableCell.passIdCallBack = {  exprtCuntryId, trvlCuntryId in
            
            self.selectExpertCountryId = exprtCuntryId
            self.selectTravelCountryId = trvlCuntryId
            
        }
        businessButtonTableCell.passCellCallback = { country in
            if self.businessViewModel.arrBusinessData[indexPath.row + 1].businessHeading == AppConstants.SelectState || self.businessViewModel.arrBusinessData[indexPath.row + 1].businessHeading == AppConstants.SelectRegion {
                if country == "Italy" || country == "italy"{
                    self.businessViewModel.arrBusinessData[indexPath.row + 1].businessHeading = AppConstants.SelectRegion
                }else if country == "United States" || country == "USA"{
                    self.businessViewModel.arrBusinessData[indexPath.row + 1].businessHeading = AppConstants.SelectState
                }else{
                    self.businessViewModel.arrBusinessData[indexPath.row + 1].businessHeading = AppConstants.SelectState
                }
                self.selectTravelRegionId = ""
                self.selectExpertRegionId = ""
                //  self.businessViewModel.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.ProductTypeBusiness))
                self.tblViewSearchOptions.reloadRows(at: [IndexPath(row: indexPath.row + 1, section: 0)], with: .automatic)
            }
            
        }
        return businessButtonTableCell
    }
    
    private func getBusinessFiltersTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let businessFiltersTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: BusinessFiltersTableCell.identifier()) as! BusinessFiltersTableCell
        if self.searchImpDone == false{
            businessFiltersTableCell.configureData(withBusinessDataModel: self.businessViewModel.arrBusinessData[indexPath.row])
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
            self.searchImpDone = true
            if self.currentIndex == B2BSearch.Hub.rawValue{
                self.callSearchHubApi()
            }else if self.currentIndex == B2BSearch.Importer.rawValue{
                self.callSearchImporterApi()
            }else if self.currentIndex == B2BSearch.Restaurant.rawValue {
                self.callSearchResturntApi()
            }else if self.currentIndex == B2BSearch.Expert.rawValue {
                self.callSearchExpertApi()
            }else if self.currentIndex == B2BSearch.TravelAgencies.rawValue{
                self.callSearchTravelApi()
            }else if self.currentIndex == B2BSearch.Producer.rawValue {
                self.callSearchProducerApi()
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
    
    func removeSelectedOption(){
        self.selectStateId = ""
        self.searchImpDone = false
        self.selectImpHubId = ""
        self.selectImpRoleId = ""
        self.selectImpProductId = ""
        self.selectImpRegionTypeId = ""
        self.horecaValue = ""
        self.privateValue = ""
        self.alyseiBrandValue = ""
        self.selectProducerHubId = ""
        self.selectProducerProductType = ""
        self.selectProducerRegionId = ""
        self.horecaValue = ""
        self.privateValue = ""
        self.alyseiBrandValue = ""
        self.resHubId = ""
        self.resTypeId = ""
        self.restPickUp = ""
        self.restDelivery = ""
        self.selectExpertHubId = ""
        self.selectExpertExpertiseId = ""
        self.selectExpertTitleId = ""
        self.selectExpertCountryId = ""
        self.selectExpertRegionId = ""
        self.selectTravelHubId = ""
        self.selectTravelSpecialityId = ""
        self.selectTravelCountryId = ""
        self.selectTravelRegionId = ""
    }
}

//MARK: - CollectionView Methods -

extension BusinessViewC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "10"{
            return 1
        }else{
            return StaticArrayData.kBusinessCategoryDict.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.currentIndex == 0 {
            self.searchType = 3
        }else{
            self.searchType = 2
        }
        return self.getBusinessCategoryCollectionCell(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> Void {
        self.view.isUserInteractionEnabled = false
        self.currentIndex = indexPath.item
        switch indexPath.item {
        case 0:
            self.searchType = 3
            self.searchImpDone = false
            callSearchHubApi()
        case 1:
            self.searchType = 2
            self.extraCell = B2BSeacrhExtraCell.producrImporterTravel.rawValue
            self.searchImpDone = false
            callSearchImporterApi()
        case 2:
            self.searchType = 2
            self.extraCell =  B2BSeacrhExtraCell.restaurant.rawValue
            self.searchImpDone = false
            callSearchResturntApi()
        case 3:
            self.searchType = 2
            self.extraCell = B2BSeacrhExtraCell.voExpert.rawValue
            self.searchImpDone = false
            callSearchExpertApi()
        case 4:
            self.searchType = 2
            self.extraCell = B2BSeacrhExtraCell.producrImporterTravel.rawValue
            self.searchImpDone = false
            callSearchTravelApi()
        case 5:
            self.searchType = 2
            self.extraCell = B2BSeacrhExtraCell.producrImporterTravel.rawValue
            self.searchImpDone = false
            callSearchProducerApi()
        default:
            break
        }
        
        //self.businessViewModel = BusinessViewModel(currentIndex: indexPath.item)
        self.removeSelectedOption()
        collectionViewBusinessCategory.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        //self.tblViewHeightConstraint.constant = (CGFloat(self.businessViewModel.arrBusinessData.count) * 70.0) + 90.0
        self.collectionViewBusinessCategory.reloadData()
        //self.tblViewSearchOptions.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 145.0, height: 45.0)
    }
    
}


//MARK:  - UITableViewMethods -

extension BusinessViewC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let model = self.businessViewModel.arrBusinessData[section]
        //let model = self.businessViewModel.arrBusinessData[currentIndex]
        switch model.businessCellType {
        case .tableListCell:
            //return model.cellCount
            return model.cellCount
        default:
            return self.businessViewModel.arrBusinessData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.businessViewModel.arrBusinessData[indexPath.row].businessCellType
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
        
        let model = self.businessViewModel.arrBusinessData[indexPath.row]
        switch model.businessCellType {
        case .searchCell:
            return 100.0
        case .collectionHubs:
            // let cellSize = CGFloat(model.cellCount) / 3.0
            return 220.0  //* cellSize
        case .tableListCell:
            return 66.0
        default:
            return 70.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = pushViewController(withName: ProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? ProfileViewC
        controller?.userLevel = .other
        let index = indexPath.row - (self.extraCell ?? 0)
        controller?.userID = arrSearchimpotrDataModel[index].userId
        
    }
    
}


extension BusinessViewC: TappedHubs{
    
    func tapOnHub(_ hubId: String?, _ hubName: String?, _ hubLocation: String?){
        let controller = pushViewController(withName: HubsViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? HubsViewC
        controller?.passHubId = hubId
        controller?.passHubName = hubName
        controller?.passHubLocation = hubLocation
    }
}


extension BusinessViewC {
    func callSearchHubApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&keyword=" + "\(txtkeywordSearch ?? "")" + "&state=" + "\(self.selectStateId ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 { self.arrSearchDataModel.removeAll() }
                self.arrSearchDataModel.append(contentsOf: self.newSearchModel?.data ?? [NewFeedSearchDataModel(with: [:])])
                // self.selectStateId = ""
                // self.searchImpDone = false
            }
            self.businessViewModel = BusinessViewModel(currentIndex: self.currentIndex)
            self.collectionViewBusinessCategory.reloadData()
            self.tblViewSearchOptions.reloadData()
            self.view.isUserInteractionEnabled = true
            
        }
    }
    func callSearchImporterApi(){
        if paginationData == false{
            arrSearchimpotrDataModel.removeAll()
        }
        
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(UserRoles.distributer3.rawValue)" + "&hubs=" + "\(self.selectImpHubId ?? "")" + "&user_type=" + "\(selectImpRoleId ?? "")" + "&product_type=" + "\(selectedProducWithCategory?.replacingOccurrences(of: " ", with: "") ?? "")" + "&horeca=" + "\(self.horecaValue ?? "")" + "&private_label=" + "\(self.privateValue ?? "")" + "&alysei_brand_label=" + "\(self.alyseiBrandValue ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 { self.arrSearchDataModel.removeAll() }
                //self.arrSearchDataModel.append(contentsOf: self.newSearchModel?.data ?? [NewFeedSearchDataModel(with: [:])])
                
                self.arrSearchimpotrDataModel.append(contentsOf: self.newSearchModel?.importerSeacrhData ?? [SubjectData(with: [:])])
                // self.searchImpDone = false
            }
            self.extraCell = B2BSeacrhExtraCell.producrImporterTravel.rawValue
            //            self.selectImpHubId = ""
            //            self.selectImpProductId = ""
            //            self.selectImpRegionTypeId = ""
            //            self.horecaValue = ""
            //            self.privateValue = ""
            //            self.alyseiBrandValue = ""
            print("CountImpSearch------------------------\(self.arrSearchimpotrDataModel.count)")
            cellCount = self.arrSearchimpotrDataModel.count
            
            //self.tblViewSearchOptions.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .automatic)
            print("CellCount--------------------------------------------\(cellCount ?? 0)")
            self.paginationData = false
            self.businessViewModel = BusinessViewModel(currentIndex: self.currentIndex)
            self.tblViewSearchOptions.reloadData()
            self.view.isUserInteractionEnabled = true
            //self.tblViewSearchOptions.reloadDataSavingSelections()
            
            
        }
    }
    func callSearchProducerApi(){
        if paginationData == false{
            arrSearchimpotrDataModel.removeAll()
        }
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(UserRoles.producer.rawValue)" + "&hubs=" + "\(self.selectProducerHubId ?? "")" + "&product_type=" + "\(selectedProducWithCategory?.replacingOccurrences(of: " ", with: "") ?? "")" + "&region=" + "\(self.selectProducerRegionId ?? "")" + "&horeca=" + "\(self.horecaValue ?? "")" + "&private_label=" + "\(self.privateValue ?? "")" + "&alysei_brand_label=" + "\(self.alyseiBrandValue ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 { self.arrSearchimpotrDataModel.removeAll() }
                self.arrSearchimpotrDataModel.append(contentsOf: self.newSearchModel?.importerSeacrhData ?? [SubjectData(with: [:])])
                // self.searchImpDone = false
            }
            //self.collectionViewBusinessCategory.reloadData()
            print("CountImpSearch------------------------\(self.arrSearchimpotrDataModel.count)")
            cellCount = self.arrSearchimpotrDataModel.count
            self.extraCell = B2BSeacrhExtraCell.producrImporterTravel.rawValue
            //            self.selectProducerHubId = ""
            //            self.selectProducerProductType = ""
            //            self.selectProducerRegionId = ""
            //            self.horecaValue = ""
            //            self.privateValue = ""
            //            self.alyseiBrandValue = ""
            //self.tblViewSearchOptions.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .automatic)
            self.paginationData = false
            self.businessViewModel = BusinessViewModel(currentIndex: self.currentIndex)
            
            self.tblViewSearchOptions.reloadData()
            self.view.isUserInteractionEnabled = true
            
            
        }
    }
    func callSearchResturntApi(){
        if paginationData == false{
            arrSearchimpotrDataModel.removeAll()
        }
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(UserRoles.restaurant.rawValue)" + "&hubs=" + "\(self.resHubId  ?? "")" + "&restaurant_type=" + "\(self.resTypeId ?? "")" + "&pickup=" + "\(restPickUp ?? "")" + "&delivery=" + "\(restDelivery ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dicResponse, error, errorType, statusCode) in
            let dictResponse = dicResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 {self.arrSearchDataModel.removeAll() }
                self.arrSearchimpotrDataModel.append(contentsOf: self.newSearchModel?.importerSeacrhData ?? [SubjectData(with: [:])])
                // self.searchImpDone = false
            }
            //self.collectionViewBusinessCategory.reloadData()
            print("CountImpSearch------------------------\(self.arrSearchimpotrDataModel.count)")
            cellCount = self.arrSearchimpotrDataModel.count
            self.extraCell = B2BSeacrhExtraCell.restaurant.rawValue
            //            self.resHubId = ""
            //            self.resTypeId = ""
            //            self.restPickUp = ""
            //            self.restDelivery = ""
            self.paginationData = false
            self.businessViewModel = BusinessViewModel(currentIndex: self.currentIndex)
            self.tblViewSearchOptions.reloadData()
            self.view.isUserInteractionEnabled = true
            
            
        }
    }
    
    func callSearchExpertApi(){
        if paginationData == false{
            arrSearchimpotrDataModel.removeAll()
        }
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(UserRoles.voiceExperts.rawValue)" + "&hubs=" + "\(self.selectExpertHubId  ?? "")" + "&expertise=" + "\(self.selectExpertExpertiseId ?? "")" + "&title=" + "\(self.selectExpertTitleId ?? "")" + "&country=" + "\(self.selectExpertCountryId ?? "")" + "&region=" + "\(self.selectExpertRegionId ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 {self.arrSearchimpotrDataModel.removeAll() }
                self.arrSearchimpotrDataModel.append(contentsOf: self.newSearchModel?.importerSeacrhData ?? [SubjectData(with: [:])])
                // self.searchImpDone = false
            }
            //self.collectionViewBusinessCategory.reloadData()
            print("CountImpSearch------------------------\(self.arrSearchimpotrDataModel.count)")
            cellCount = self.arrSearchimpotrDataModel.count
            self.extraCell = B2BSeacrhExtraCell.voExpert.rawValue
            
            //            self.selectExpertHubId = ""
            //            self.selectExpertExpertiseId = ""
            //            self.selectExpertTitleId = ""
            //            self.selectExpertCountryId = ""
            //            self.selectExpertRegionId = ""
            self.paginationData = false
            self.businessViewModel = BusinessViewModel(currentIndex: self.currentIndex)
            self.tblViewSearchOptions.reloadData()
            self.view.isUserInteractionEnabled = true
            
            
        }
    }
    
    func callSearchTravelApi(){
        if paginationData == false{
            arrSearchimpotrDataModel.removeAll()
        }
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(UserRoles.travelAgencies.rawValue)" + "&hubs=" + "\(self.selectTravelHubId  ?? "")" + "&speciality=" + "\(self.selectTravelSpecialityId ?? "")" + "&country=" + "\(self.selectTravelCountryId ?? "")" + "&region=" + "\(self.selectTravelRegionId ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 { self.arrSearchimpotrDataModel.removeAll() }
                self.arrSearchimpotrDataModel.append(contentsOf: self.newSearchModel?.importerSeacrhData ?? [SubjectData(with: [:])])
                //self.searchImpDone = false
            }
            //self.collectionViewBusinessCategory.reloadData()
            print("CountImpSearch------------------------\(self.arrSearchimpotrDataModel.count)")
            cellCount = self.arrSearchimpotrDataModel.count
            self.extraCell = B2BSeacrhExtraCell.producrImporterTravel.rawValue
            //            self.selectTravelHubId = ""
            //            self.selectTravelSpecialityId = ""
            //            self.selectTravelCountryId = ""
            //            self.selectTravelRegionId = ""
            self.paginationData = false
            self.businessViewModel = BusinessViewModel(currentIndex: self.currentIndex)
            self.tblViewSearchOptions.reloadData()
            self.view.isUserInteractionEnabled = true
            
            
        }
    }
    
    
}
extension UITableView {
    /// Reloads a table view without losing track of what was selected.
    func reloadDataSavingSelections() {
        let selectedRows = indexPathsForSelectedRows
        
        reloadData()
        
        if let selectedRow = selectedRows {
            for indexPath in selectedRow {
                selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
        }
    }
}
//SelectProduct Tapped Done

extension BusinessViewC: TappedDoneStepOne{
    
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
