//
//  EditUserSettingsViewC.swift
//  Alysie
//
//  Created by Alendra Kumar on 18/01/21.
//

import UIKit

class EditUserSettingsViewC: AlysieBaseViewC {

  //MARK: - IBOutlet -
  
  @IBOutlet weak var tblViewEditUserSettings: UITableView!
  @IBOutlet weak var viewShadow: UIView!
  @IBOutlet weak var imgViewUser: UIImageView!
  @IBOutlet weak var lblUserName: UILabel!
  @IBOutlet weak var lblUserEmail: UILabel!
  @IBOutlet weak var btnSave: UIButton!
  //MARK: - Properties -
  
  var settingEditViewModel: SettingsEditViewModel!
  var featureListingId: String?
  var currentProductTitle: String?
  
  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setInitialData()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidLayoutSubviews(){
    
    super.viewDidLayoutSubviews()
    self.viewShadow.drawBottomShadow()
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapClose(_ sender: UIButton) {
    
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func tapSave(_ sender: UIButton) {

    guard self.settingEditViewModel.selectedUserName.isValid(.username) else {
        showAlert(withMessage: "Username can consist of alphabets, numeric, a set of special charters ( @ # $ _ ) and must be between 3 to 20 characters.")
        return
    }
    self.postRequestToUpdateUserSettings()
  }
  
  //MARK: - Private Methods -
  
    private func setInitialData() -> Void{
      //self.lblUserName.text = kSharedUserDefaults.loggedInUserModal.displayName
      let roleID = UserRoles(rawValue:Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId)  ) ?? .voyagers
      var name = ""
      switch roleID {
      case .distributer1, .distributer2, .distributer3, .producer, .travelAgencies :
          name = "\(kSharedUserDefaults.loggedInUserModal.companyName ?? "")"
  //                case .voiceExperts, .voyagers:
      case .restaurant :
          name = "\(kSharedUserDefaults.loggedInUserModal.restaurantName ?? "")"
      default:
          name = "\(kSharedUserDefaults.loggedInUserModal.firstName ?? "") \(kSharedUserDefaults.loggedInUserModal.lastName ?? "")"
      }
      self.lblUserName.text = name
      if kSharedUserDefaults.loggedInUserModal.userName == "" {
          self.lblUserEmail.isHidden = true
      }else{
          self.lblUserEmail.isHidden = false
        self.lblUserEmail.text = "@" + "\(kSharedUserDefaults.loggedInUserModal.userName ?? "")"
      }
      if let profilePhoto = LocalStorage.shared.fetchImage(UserDetailBasedElements().profilePhoto) {
          self.imgViewUser.image = profilePhoto
          self.imgViewUser.layer.cornerRadius = (self.imgViewUser.frame.width / 2.0)
          self.imgViewUser.layer.borderWidth = 5.0
          
          switch roleID {
          case .distributer1, .distributer2, .distributer3:
              self.imgViewUser.layer.borderColor = UIColor.init(hexString: RolesBorderColor.distributer1.rawValue).cgColor
          case .producer:
              self.imgViewUser.layer.borderColor = UIColor.init(hexString: RolesBorderColor.producer.rawValue).cgColor
          case .travelAgencies:
              self.imgViewUser.layer.borderColor = UIColor.init(hexString: RolesBorderColor.travelAgencies.rawValue).cgColor
          case .voiceExperts:
              self.imgViewUser.layer.borderColor = UIColor.init(hexString: RolesBorderColor.voiceExperts.rawValue).cgColor
          case .voyagers:
              self.imgViewUser.layer.borderColor = UIColor.init(hexString: RolesBorderColor.voyagers.rawValue).cgColor
          case .restaurant :
              self.imgViewUser.layer.borderColor = UIColor.init(hexString: RolesBorderColor.restaurant.rawValue).cgColor
          default:
              self.imgViewUser.layer.borderColor = UIColor.white.cgColor
          }
         
          self.imgViewUser.layer.masksToBounds = true
      }else{
          self.imgViewUser.layer.cornerRadius = (self.imgViewUser.frame.width / 2.0)
          self.imgViewUser.layer.borderWidth = 5.0
          self.imgViewUser.layer.borderColor = UIColor.white.cgColor
      }
      btnSave.setImage(UIImage(named: "blue_checkmark"), for: .normal)
      self.postRequestToGetUserSettings()
      
    }
 
  private func getEditUserSettingsTableCell(_ indexPath: IndexPath) -> UITableViewCell{
      
    let editUserSettingsTableCell = tblViewEditUserSettings.dequeueReusableCell(withIdentifier: EditUserSettingsTableCell.identifier(), for: indexPath) as! EditUserSettingsTableCell
    editUserSettingsTableCell.configure(withSettingsEditDataModel: self.settingEditViewModel.arrSections[indexPath.section].arrSettingsData[indexPath.row])
    return editUserSettingsTableCell
  }
  
  private func getLanguageTableCell(_ indexPath: IndexPath) -> UITableViewCell{
      
    let editLanguageTableCell = tblViewEditUserSettings.dequeueReusableCell(withIdentifier: EditLanguageTableCell.identifier(), for: indexPath) as! EditLanguageTableCell
    editLanguageTableCell.configure(withSettingsEditDataModel: self.settingEditViewModel.arrSections[indexPath.section].arrSettingsData[indexPath.row])
    return editLanguageTableCell
  }
  
  private func getFeaturedProductTableCell(_ indexPath: IndexPath) -> UITableViewCell{
      
    let featuredProductTableCell = tblViewEditUserSettings.dequeueReusableCell(withIdentifier: FeaturedProductTableCell.identifier(), for: indexPath) as! FeaturedProductTableCell
    featuredProductTableCell.delegate = self
//    featuredProductTableCell.selectProductDelegate = self
    featuredProductTableCell.configureData(withProductCategoriesDataModel: self.settingEditViewModel.arrSections[indexPath.section].arrProductCategories[indexPath.row])
    return featuredProductTableCell
  }

  //MARK: - WebService Methods -
  
  private func postRequestToGetUserSettings() -> Void{
   
    disableWindowInteraction()
    CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kUserSettings, method: .GET, controller: self, type: 0, param: [:], btnTapped: UIButton())
  }
  
  private func postRequestToUpdateUserSettings() -> Void{
    
    let param: [String:Any] = [APIConstants.kName: self.settingEditViewModel.selectedUserName,
                               APIConstants.kCompanyName: self.settingEditViewModel.selectedCompanyName,
                               APIConstants.kLocale: "en",
                               APIConstants.kWebsite: self.settingEditViewModel.selectedUrl
                               ]
    disableWindowInteraction()
    CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kUpdateUserSettings, method: .POST, controller: self, type: 1, param: param, btnTapped: UIButton())
  }
  
  private func postRequestToGetFeatureListing(_ featureListingId: String,navigationTitle: String) -> Void{
  
    self.featureListingId = featureListingId
    self.currentProductTitle = navigationTitle
    disableWindowInteraction()
    CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kGetFeatureListing + featureListingId, method: .GET, controller: self, type: 2, param: [:], btnTapped: UIButton())
  }
    
}

 //MARK: - TableView Methods -

 extension EditUserSettingsViewC: UITableViewDelegate, UITableViewDataSource{
  
  func numberOfSections(in tableView: UITableView) -> Int {
    
    if self.settingEditViewModel != nil{
      return self.settingEditViewModel.arrSections.count
    }
    else{
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    
    let model = self.settingEditViewModel.arrSections[section]
    
    switch model.sectionType {
    case 0:
      return self.settingEditViewModel.arrSections[section].arrSettingsData.count
    case 1:
      return self.settingEditViewModel.arrSections[section].arrProductCategories.count
    default:
      return 0
    }
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let model = self.settingEditViewModel.arrSections[indexPath.section]
    
    switch model.sectionType {
    case 0:
      
      let settingsModel = model.arrSettingsData[indexPath.row]
      
      switch settingsModel.settingsCellType {
      case .language:
        return self.getLanguageTableCell(indexPath)
      default:
        return self.getEditUserSettingsTableCell(indexPath)
      }
        // product listing from settings is disabled for now
//    case 1:
//      return self.getFeaturedProductTableCell(indexPath)
    default:
      return UITableViewCell()
    }
  }
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    let model = self.settingEditViewModel.arrSections[indexPath.section]
    
    switch model.sectionType {
    case 0:
      
      let settingsModel = model.arrSettingsData[indexPath.row]
      
      switch settingsModel.settingsCellType {
      case .language:
        return 96.0
      default:
        return 85.0
      }
    case 1:
      return 180.0
    default:
      return 0.0
    }
  }
}

//APIResponse
extension EditUserSettingsViewC{
  
  override func didUserGetData(from result: Any, type: Int) {
    
    let dicResult = kSharedInstance.getDictionary(result)
    let dicData = kSharedInstance.getDictionary(dicResult[APIConstants.kData])
    
    switch type {
    case 0:
      self.settingEditViewModel = SettingsEditViewModel(dicResult)
      //kSharedUserDefaults.setLoggedInUserDetails(loggedInUserDetails: dicResult)
      self.tblViewEditUserSettings.reloadData()
    case 1:
        self.btnSave.setImage(UIImage(named: "blue_checkmarked"), for: .normal)
        //showAlert(withMessage: AlertMessage.kProfileUpdated){
        kSharedUserDefaults.setLoggedInUserDetails(loggedInUserDetails: dicResult)
        //self.lblUserName.text = kSharedUserDefaults.loggedInUserModal.displayName
            let roleID = UserRoles(rawValue:Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId)  ) ?? .voyagers
            var name = ""
            switch roleID {
            case .distributer1, .distributer2, .distributer3, .producer, .travelAgencies :
                name = "\(kSharedUserDefaults.loggedInUserModal.companyName ?? "")"
        //                case .voiceExperts, .voyagers:
            case .restaurant :
                name = "\(kSharedUserDefaults.loggedInUserModal.restaurantName ?? "")"
            default:
                name = "\((kSharedUserDefaults.loggedInUserModal.firstName) ?? "") \((kSharedUserDefaults.loggedInUserModal.lastName) ?? "")"
           // }
        self.lblUserName.text = name
        self.lblUserEmail.text = "@" + "\(kSharedUserDefaults.loggedInUserModal.userName ?? "")"
      }
    case 2:
      var arrSelectedFields: [ProductFieldsDataModel] = []
      if let fields = dicData[APIConstants.kFields] as? ArrayOfDictionary{
        arrSelectedFields = fields.map({ProductFieldsDataModel(withDictionary: $0)})
      }
      let controller = pushViewController(withName: AddFeatureViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? AddFeatureViewC
      controller?.arrSelectedFields = arrSelectedFields
      controller?.featureListingId = self.featureListingId
      controller?.currentNavigationTitle = self.currentProductTitle
      controller?.delegate = self
    default:
      break
    }
  }
}


//ProductAdded
extension EditUserSettingsViewC: AddFeaturedProductCallBack{
  
  func productAdded() {
    self.navigationController?.popViewController(animated: true)
    self.postRequestToGetUserSettings()
  }
}

//AddProductCallBack
extension EditUserSettingsViewC: AddProductCallBack{
  
  func tappedAddProduct(withProductCategoriesDataModel model: ProductCategoriesDataModel, featureListingId: String?) {
    
    if featureListingId == nil{
      let controller = pushViewController(withName: AddFeatureViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? AddFeatureViewC
      controller?.productCategoriesDataModel = model
      controller?.delegate = self
    }
    else{
      self.postRequestToGetFeatureListing(String.getString(featureListingId), navigationTitle: String.getString(model.title))
    }
  }
}


