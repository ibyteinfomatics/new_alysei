//
//  SettingsEditModel.swift
//  Alysie
//
//  Created by CodeAegis on 19/01/21.
//

import Foundation

enum SettingsCellType{
  
  case info,defaultCell,language
}

class SettingsEditViewModel: NSObject {
  
  var arrSections:[SettingsEditSectionModel] = []

  var selectedUrl: String {
      
    let modal = self.arrSections[0].arrSettingsData.filter { $0.settingsHeading == AppConstants.URL }
    return modal.first?.settingsSelectedValue ?? ""
  }
  
  var selectedCompanyName: String {
      
    let modal = self.arrSections[0].arrSettingsData.filter { $0.settingsHeading == AppConstants.CompanyName }
    return modal.first?.settingsSelectedValue ?? ""
  }
    var selectedRestaurantName: String {
        
      let modal = self.arrSections[0].arrSettingsData.filter { $0.settingsHeading == AppConstants.RestaurantName }
      return modal.first?.settingsSelectedValue ?? ""
    }
    var selectedDisplayName: String {
        
      let modal = self.arrSections[0].arrSettingsData.filter { $0.settingsHeading == AppConstants.DisplayName }
      return modal.first?.settingsSelectedValue ?? ""
    }
    
  var selectedUserName: String {
      
    let modal = self.arrSections[0].arrSettingsData.filter { $0.settingsHeading == AppConstants.Username }
    return modal.first?.settingsSelectedValue ?? ""
  }
  
  var selectedLanguage: String {
      
    let modal = self.arrSections[0].arrSettingsData.filter { $0.settingsHeading == AppConstants.Language }
    return modal.first?.settingsSelectedValue ?? ""
  }
 
  init(_ dictResult: [String:Any]) {
    
    super.init()
    
    self.arrSections.append(SettingsEditSectionModel(withDictionary: dictResult, sectionType: 0))
    self.arrSections.append(SettingsEditSectionModel(withDictionary: dictResult, sectionType: 1))
  }
 }


class SettingsEditSectionModel: NSObject {
  
  var sectionType: Int?
  var arrSettingsData: [SettingsEditDataModel] = []
  var arrProductCategories: [ProductCategoriesDataModel] = []

  init(withDictionary dictResult: [String:Any], sectionType: Int) {
    
    super.init()
    
    self.sectionType = sectionType
    let dicData = kSharedInstance.getDictionary(dictResult[APIConstants.kData])
    
    if sectionType == 0 {

        let userID = kSharedUserDefaults.loggedInUserModal.role ?? .voyagers

        self.arrSettingsData.append(SettingsEditDataModel(settingsHeading: AppConstants.URL, settingsPlaceholder: AppConstants.EnterURL, settingsSelectedValue: String.getString(kSharedUserDefaults.loggedInUserModal.website), settingsCellType: .info))

        self.arrSettingsData.append(SettingsEditDataModel(settingsHeading: AppConstants.Username, settingsPlaceholder: AppConstants.EnterUsername, settingsSelectedValue: String.getString(kSharedUserDefaults.loggedInUserModal.userName)))

        switch userID {
        case .restaurant:
            //self.arrSettingsData.append(SettingsEditDataModel(settingsHeading: AppConstants.RestaurantName, settingsPlaceholder: AppConstants.EnterRestaurantName, settingsSelectedValue: String.getString(kSharedUserDefaults.loggedInUserModal.displayName), settingsCellType: .info))
            
            self.arrSettingsData.append(SettingsEditDataModel(settingsHeading: AppConstants.RestaurantName, settingsPlaceholder: AppConstants.EnterRestaurantName, settingsSelectedValue: String.getString(kSharedUserDefaults.loggedInUserModal.restaurantName), settingsCellType: .info))

        case .voyagers, .voiceExperts:
            self.arrSettingsData.append(SettingsEditDataModel(settingsHeading: AppConstants.FirstName, settingsPlaceholder: AppConstants.EnterFirstName, settingsSelectedValue: String.getString(kSharedUserDefaults.loggedInUserModal.firstName), settingsCellType: .info))

            self.arrSettingsData.append(SettingsEditDataModel(settingsHeading: AppConstants.LastName, settingsPlaceholder: AppConstants.EnterLastName, settingsSelectedValue: String.getString(kSharedUserDefaults.loggedInUserModal.lastName), settingsCellType: .info))

        default:
           // self.arrSettingsData.append(SettingsEditDataModel(settingsHeading: AppConstants.DisplayName, settingsPlaceholder: AppConstants.EnterDisplayName, settingsSelectedValue: String.getString(kSharedUserDefaults.loggedInUserModal.displayName), settingsCellType: .info))
            
            self.arrSettingsData.append(SettingsEditDataModel(settingsHeading: AppConstants.CompanyName, settingsPlaceholder: AppConstants.EnterCompanyName, settingsSelectedValue: String.getString(kSharedUserDefaults.loggedInUserModal.companyName), settingsCellType: .info))
        }


        self.arrSettingsData.append(SettingsEditDataModel(settingsHeading: AppConstants.Email.capitalized ,settingsPlaceholder: AppConstants.EnterEmail, settingsSelectedValue: String.getString(kSharedUserDefaults.loggedInUserModal.email)))

        self.arrSettingsData.append(SettingsEditDataModel(settingsHeading: AppConstants.Language, settingsPlaceholder: AppConstants.SelectLanguage, settingsSelectedValue: "", settingsCellType: .language))
    }
    else{
      
      if let arr = dicData[APIConstants.kProducts] as? ArrayOfDictionary{
        self.arrProductCategories = arr.map({ProductCategoriesDataModel(withDictionary: $0)})
      }
    }
  }
}

 class SettingsEditDataModel: NSObject{
  
  var settingsHeading: String?
  var settingsPlaceholder: String?
  var settingsSelectedValue: String?
  var settingsCellType: SettingsCellType?
  var settingsValidationMessage: String?

  init(settingsHeading heading: String,settingsPlaceholder placeholder: String,settingsSelectedValue value: String, settingsCellType cellType: SettingsCellType = .defaultCell,settingsValidationMessage message: String = ""){
    
    super.init()
    self.settingsHeading = heading
    self.settingsPlaceholder = placeholder
    self.settingsSelectedValue = value
    self.settingsCellType = cellType
    self.settingsValidationMessage = message
  }
}

class ProductCategoriesDataModel: NSObject {
  
  var title: String?
  var arrProductFields: [ProductFieldsDataModel] = []
  var arrAllProducts: [AllProductsDataModel] = []
  
  init(withDictionary dictCategory: [String:Any]){
    
    super.init()
    
    self.title = String.getString(dictCategory[APIConstants.kTitle])
    
    if let arrFields = dictCategory[APIConstants.kFields] as? ArrayOfDictionary{
      
      self.arrProductFields = arrFields.map({ProductFieldsDataModel(withDictionary: $0)})
    }
    
    if let arrProducts = dictCategory[APIConstants.kProducts] as? ArrayOfDictionary{
      
      self.arrAllProducts = arrProducts.map({AllProductsDataModel(withDictionary: $0)})
    }
  }
}

class ProductFieldsDataModel: NSObject{
  
  var productTitle: String?
  var productName: String?
  var featuredListingTypeTitle: String?
  var featuredListingFieldId: String?
  var featuredListingTypeId: String?
  var roleId: String?
  var type: String?
  var required: String?
  var selectedValue: String?
  var selectedOptionName: String?
  
  var arrOptions: [AllProductsOptionsModel] = []

  init(withDictionary dictAddFeatured: [String:Any]){
    
    super.init()
   
    self.productTitle = String.getString(dictAddFeatured[APIConstants.kTitle])
    self.productName = String.getString(dictAddFeatured[APIConstants.kName])
    self.featuredListingTypeTitle = String.getString(dictAddFeatured[APIConstants.kFeaturedTypeTitle])
    self.featuredListingFieldId = String.getString(dictAddFeatured[APIConstants.kFeaturedListingFieldId])
    self.featuredListingTypeId = String.getString(dictAddFeatured[APIConstants.kFeaturedListingTypeId])
    self.roleId = String.getString(dictAddFeatured[APIConstants.kRoleId])
    self.required = String.getString(dictAddFeatured[APIConstants.kRequired])
    self.type = String.getString(dictAddFeatured[APIConstants.kType])
    self.selectedValue = String.getString(dictAddFeatured["value"])

    //self.selectedOptionName = String.getString(dictAddFeatured["option"])
    
    if let options = dictAddFeatured[APIConstants.kOptions] as? ArrayOfDictionary{
      
      self.arrOptions = options.map({AllProductsOptionsModel(withDictionary: $0)})
      
    }
    
    if type == AppConstants.Select{
      
      let filterSelectedValue = self.arrOptions.filter({$0.isSelected == "1"})
      self.selectedOptionName = filterSelectedValue.first?.optionName
      
    }
    
  }
}

class AllProductsDataModel: NSObject{
  
  var productTitle: String?
  var productDescription: String?
  var featuredListingId: String?
  var featuredListingTypeId: String?
  var imagePath: String?
  
  var arrOptions: [AllProductsOptionsModel] = []

  init(withDictionary dictFeaturedProduct: [String:Any]){
    
    super.init()
    
    self.productTitle = String.getString(dictFeaturedProduct[APIConstants.kTitle])
    self.productDescription = String.getString(dictFeaturedProduct[APIConstants.kDescription])
    self.featuredListingId = String.getString(dictFeaturedProduct[APIConstants.kFeaturedListingId])
    self.featuredListingTypeId = String.getString(dictFeaturedProduct[APIConstants.kFeaturedListingTypeId])
    
    let dictImage = kSharedInstance.getDictionary(dictFeaturedProduct[APIConstants.kImage])
    self.imagePath = String.getString(dictImage[APIConstants.kAttachmentUrl])
  }
}

class AllProductsOptionsModel: NSObject{
  
  var optionName: String?
  var featuredListingOptionId: String?
  var isSelected: String?
  
  init(withDictionary dictOptions: [String:Any]){
    
    super.init()
    
    self.optionName = String.getString(dictOptions[APIConstants.kOption])
    self.featuredListingOptionId = String.getString(dictOptions[APIConstants.kFeaturedListingOptionId])
    self.isSelected = String.getString(dictOptions[APIConstants.kIsSelected])
  }
}
