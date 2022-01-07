 //
 //  SignUpViewModel.swift
 //  Alysie
 //
 //  Created by CodeAegis on 31/01/21.
 //

 extension Array {
  func contains<T>(obj: T) -> Bool where T : Equatable {
         return self.filter({$0 as? T == obj}).count > 0
     }
 }
 
 import UIKit

 class SignUpViewModel: NSObject {
   
  var arrSignUpStepOne: [SignUpStepOneDataModel] = []
  var arrSignUpStepTwo: [SignUpStepTwoDataModel] = []
    var arrProductCategories: [ProductCategoriesDataModel] = []
    var profileData: ProfileData?

  var roleId: String?
 
  init(_ dictData: [String:Any], roleId: [GetRoleDataModel]? = nil) {
    
    super.init()
    self.roleId = roleId?.first?.roleId
    
    if let stepOne = dictData[APIConstants.kStepOne] as? ArrayOfDictionary{
      
      self.arrSignUpStepOne = stepOne.map({SignUpStepOneDataModel(withDictionary: $0)})
    }
    
    if let stepTwo = dictData[APIConstants.kStepTwo] as? ArrayOfDictionary{
      
      self.arrSignUpStepTwo = stepTwo.map({SignUpStepTwoDataModel(withDictionary: $0)})
    }

    if let arr = dictData[APIConstants.kProducts] as? ArrayOfDictionary{
        self.arrProductCategories = arr.map({ProductCategoriesDataModel(withDictionary: $0)})
    }
    if let userData = dictData["profile_data"] as? [String:Any]{
        self.profileData = ProfileData.init(with: userData)
    }
    
    

  }
  
  func validateFields() -> (Bool,String){
    
    for item in arrSignUpStepOne{
      
      if  (item.type == AppConstants.Terms) && ((item.selectedValue == AppConstants.No)){
        return(false,AlertMessage.kTermsAndConditions)
      }
      else if  (item.required == AppConstants.Yes) && (item.selectedValue?.isEmpty == true){
        return(false,AlertMessage.kRequiredInformation)
      }
      else if (item.type == AppConstants.Email){
      
        if item.selectedValue?.isEmail() == false{
          return(false,AlertMessage.kValidEmailAddress)
        }
      }
      else if (item.type == AppConstants.Password){
      
        if item.selectedValue?.isPassword() == false{
          return(false,AlertMessage.kValidPassword)
        }
      }
     }
    return (true,"")
   }
  
  func toDictionaryStepOne() -> [[String:String]]{
    
    var dicSignUp: [[String:String]] = [[:]]
    if String.getString(self.roleId).isEmpty == false{
      dicSignUp.append([APIConstants.kRoleId: String.getString(self.roleId)])
    }
    for i in 0...arrSignUpStepOne.count - 1{
     dicSignUp.append([self.arrSignUpStepOne[i].userFieldId: String.getString(self.arrSignUpStepOne[i].selectedValue)])
    }
      
      dicSignUp.append(["device_type": "2"])
      dicSignUp.append(["device_token": kSharedUserDefaults.getDeviceToken()])
      
    print(dicSignUp)
    return dicSignUp
  }
  
  func validateFieldsStepTwo() -> (Bool,String){
    
      for item in arrSignUpStepTwo{
        if  (item.type == AppConstants.Terms) && ((item.selectedValue ==  AppConstants.No)){
          return(false,AlertMessage.kTermsAndConditions)
        }
        else if (item.required == AppConstants.Yes) && (item.selectedValue?.isEmpty == true) && (item.isHidden == false){
          return (false,AlertMessage.kRequiredInformation)
        }
       }
      return (true,"")
 }
  
 func toDictionaryStepTwo() -> [[String:String]]{
    
    var dicSignUpStepTwo: [[String:String]] = []
   
    for i in 0...arrSignUpStepTwo.count - 1{
      dicSignUpStepTwo.append([self.arrSignUpStepTwo[i].userFieldId: String.getString(self.arrSignUpStepTwo[i].selectedValue)])
    }
    print(dicSignUpStepTwo)
    return dicSignUpStepTwo
  }
}
 class ProfileData {
    var avatarID: AvatarID?
    var coverID: AvatarID?
    
    init(with dictResponse: [String:Any]?){
        if let userData = dictResponse?["avatar_id"] as? [String:Any]{
            self.avatarID = AvatarID.init(with: userData)
        }
        if let userData = dictResponse?["cover_id"] as? [String:Any]{
            self.coverID = AvatarID.init(with: userData)
        }
    }
 }
class SignUpStepOneDataModel: NSObject{
 
 var hint: String?
 var name: String?
 var required: String?
 var roleId: String?
 var placeholder: String?
 var stepOne: String?
 var title: String?
 var type: String?
 var multipleOption: Bool?
 var userFieldId: String = ""
 var optionName: String?
 var selectedValue: String?
 var selectedOptionName: String?
 var parentId: String?
 var isHidden: Bool = false
 var is_selected: String?
 var arrOptions: [SignUpOptionsDataModel] = []
  
 var arrRestaurantOptions: [SignUpStepTwoOptionsModel] = []

 init(withDictionary dictStepOne: [String:Any]){
   
   super.init()
   self.hint = String.getString(dictStepOne[APIConstants.kHint])
   self.name = String.getString(dictStepOne[APIConstants.kName])
   self.multipleOption = Bool.getBool(dictStepOne[APIConstants.kMultipleOption])
   self.optionName = String.getString(dictStepOne[APIConstants.kOption])
   self.required = String.getString(dictStepOne[APIConstants.kRequired])
   self.roleId = String.getString(dictStepOne[APIConstants.kRoleId])
   self.stepOne = String.getString(dictStepOne[APIConstants.kStepOne])
   self.title = String.getString(dictStepOne[APIConstants.kTitle])
   self.isHidden = Bool.getBool(dictStepOne[APIConstants.kHidden])
   self.type = String.getString(dictStepOne[APIConstants.kType])
   self.parentId = String.getString(dictStepOne[APIConstants.kParentId])
   self.placeholder = String.getString(dictStepOne[APIConstants.kPlaceholder])
   self.userFieldId = String.getString(dictStepOne[APIConstants.kUserFieldId])
    self.is_selected = String.getString(dictStepOne[APIConstants.kIsSelected])
  
  if  (String.getString(dictStepOne[APIConstants.kType]) == AppConstants.Radio) || (String.getString(dictStepOne[APIConstants.kType]) == AppConstants.Terms){
    
    self.selectedValue = (String.getString(dictStepOne[APIConstants.kIsSelected]) == "1") ? AppConstants.Yes.capitalized : AppConstants.No
   }
   else{
    self.selectedValue = String.getString(dictStepOne[APIConstants.kIsSelected])
  }

  if let option = dictStepOne[APIConstants.kOptions] as? ArrayOfDictionary{
    
    self.arrOptions = option.map({SignUpOptionsDataModel(withDictionary: $0)})
    self.arrRestaurantOptions = option.map({SignUpStepTwoOptionsModel(withDictionary: $0)})
  }
  
  if type == AppConstants.Multiselect{
    let filterSelectedOptions = self.arrOptions.map({$0}).filter({$0.isSelected == true})
  
    if filterSelectedOptions.count == 0{
      self.selectedOptionName = ""
    }
    else if filterSelectedOptions.count == 1{
      self.selectedOptionName = filterSelectedOptions.first?.optionName
    }
    else {
      let count = filterSelectedOptions.count - 1
      self.selectedOptionName = String.getString(filterSelectedOptions.first?.optionName) + " & " + String.getString(count) + " More"
    }
  }
  else if type == AppConstants.Select{
    
    let filterSelectedOptions = self.arrOptions.map({$0}).filter({$0.isSelected == true})
    guard (filterSelectedOptions.count != 0) else { return }
    self.selectedValue = filterSelectedOptions.first?.userFieldOptionId
    self.selectedOptionName = filterSelectedOptions.first?.optionName
  }
  else if type == AppConstants.Checkbox{
    
    if multipleOption == true{
      
      let filterSelectedOptions = self.arrOptions.map({$0}).filter({$0.isSelected == true})
      var selectedArray: [String] = []
      
      for i in 0..<filterSelectedOptions.count{
        
        self.isHidden = false
        selectedArray.append(String.getString(filterSelectedOptions[i].userFieldOptionId))
      }
      self.selectedValue = selectedArray.joined(separator: ", ")
    }
  }
 }
}

 class SignUpOptionsDataModel: NSObject{
  
  var head: String?
  var optionName: String?
  var userFieldId: String?
  var userFieldOptionId: String?
  var isSelected: Bool = false
    //var isSelected: Bool?
    var arrSubSections: [SignUpSubSectionModel] = []
    var marketplaceProductCategoryId : Int?
    var marketplaceBrandLabelId: Int?
    var marketplaceProductSubcategoryId: Int?
    
  
  var id: String?
  var name: String?
    var title: String?
  var phoneCode: String?
  var countryId: String?
  var stateId: String?

  init(withDictionary dictOptions: [String:Any]){
    
    super.init()
    self.head = String.getString(dictOptions[APIConstants.kHead])
    self.optionName = String.getString(dictOptions[APIConstants.kOption])
    self.userFieldId = String.getString(dictOptions[APIConstants.kUserFieldId])
    self.userFieldOptionId = String.getString(dictOptions[APIConstants.kUserFieldOptionId])
    self.isSelected = Bool.getBool(dictOptions[APIConstants.kIsSelected])
    self.id = String.getString(dictOptions[APIConstants.kId])
    self.name = String.getString(dictOptions[APIConstants.kName])
    self.phoneCode = String.getString(dictOptions[APIConstants.kPhonecode])
    self.countryId = String.getString(dictOptions[APIConstants.kCountryId])
    self.stateId = String.getString(dictOptions[APIConstants.kStateId])
    self.title = String.getString(dictOptions[APIConstants.kTitle])
    self.marketplaceProductCategoryId = Int.getInt(dictOptions["marketplace_product_category_id"])
    self.marketplaceBrandLabelId = Int.getInt(dictOptions["marketplace_brand_label_id"])
    self.marketplaceProductSubcategoryId = Int.getInt(dictOptions["marketplace_product_subcategory_id"])
    if let option = dictOptions[APIConstants.kOptions] as? ArrayOfDictionary{
      
      self.arrSubSections = option.map({SignUpSubSectionModel(withDictionary: $0)})
    }
    
    self.isSelected = Bool.getBool(dictOptions[APIConstants.kIsSelected])
  }
 }
 
 class SignUpSubSectionModel: NSObject{
  
  var head: String?
  var hint: String?
  var sectionName: String?
  var userFieldId: String?
  var userFieldOptionId: String?
  
  var arrSelectedSubOptions:[String] = []
  var arrSubOptions: [SignUpSubOptionsModel] = []

  init(withDictionary dictSection: [String:Any]){
    
    super.init()
    self.head = String.getString(dictSection[APIConstants.kHead])
    self.sectionName = String.getString(dictSection[APIConstants.kOption])
    self.hint = String.getString(dictSection[APIConstants.kHint])
    self.userFieldId = String.getString(dictSection[APIConstants.kUserFieldId])
    self.userFieldOptionId = String.getString(dictSection[APIConstants.kUserFieldOptionId])
    
    if let option = dictSection[APIConstants.kOptions] as? ArrayOfDictionary{
      
      self.arrSubOptions = option.map({SignUpSubOptionsModel(withDictionary: $0)})
    }
    
    let selectedSubOptions = self.arrSubOptions.filter({$0.isSelected == true})
    self.arrSelectedSubOptions.append(String.getString(selectedSubOptions.first?.userFieldOptionId))
  }
 }
 
 class SignUpSubOptionsModel: NSObject{
  
  var head: String?
  var subOptionName: String?
  var userFieldId: String?
  var userFieldOptionId: String?
  var isSelected: Bool = false

  init(withDictionary dictSubOptions: [String:Any]){
    
    super.init()
    self.head = String.getString(dictSubOptions[APIConstants.kHead])
    self.subOptionName = String.getString(dictSubOptions[APIConstants.kOption])
    self.userFieldId = String.getString(dictSubOptions[APIConstants.kUserFieldId])
    self.userFieldOptionId = String.getString(dictSubOptions[APIConstants.kUserFieldOptionId])
    self.isSelected = Bool.getBool(dictSubOptions[APIConstants.kIsSelected])
  }
 }

class SignUpStepTwoDataModel: NSObject{
  
  var multipleOption: Bool?
  var name: String?
  var required: String?
  var roleId: String?
  var stepOne: String?
  var title: String?
  var type: String?
  var hint: String?
  var parentId: String?
  var isHidden: Bool = false
  var userFieldId: String = ""
  var selectedValue: String?
  var selectedAddressLineOne: String?
  var selectedAddressLineTwo: String?
  var placeholder: String?
  var selectedOptionName: String?
  var arrOptions: [SignUpStepTwoOptionsModel] = []

  init(withDictionary dictStepTwo: [String:Any]){
    
    super.init()
    self.multipleOption = Bool.getBool(dictStepTwo[APIConstants.kMultipleOption])
    self.name = String.getString(dictStepTwo[APIConstants.kName])
    self.required = String.getString(dictStepTwo[APIConstants.kRequired])
    self.roleId = String.getString(dictStepTwo[APIConstants.kRoleId])
    self.stepOne = String.getString(dictStepTwo[APIConstants.kStepOne])
    self.title = String.getString(dictStepTwo[APIConstants.kTitle])
    self.hint = String.getString(dictStepTwo[APIConstants.kHint])
    self.type = String.getString(dictStepTwo[APIConstants.kType])
    self.placeholder = String.getString(dictStepTwo[APIConstants.kPlaceholder])
    self.selectedAddressLineOne = String.getString(dictStepTwo[APIConstants.kSelectedAddressOne])
    self.selectedAddressLineTwo = String.getString(dictStepTwo[APIConstants.kSelectedAddressTwo])
    
    self.userFieldId = String.getString(dictStepTwo[APIConstants.kUserFieldId])
    self.parentId = String.getString(dictStepTwo[APIConstants.kParentId])
    self.isHidden = Bool.getBool(dictStepTwo[APIConstants.kHidden])
    
    if (String.getString(dictStepTwo[APIConstants.kType]) == AppConstants.Radio) || (String.getString(dictStepTwo[APIConstants.kType]) == AppConstants.Terms){
      
      self.selectedValue = (String.getString(dictStepTwo[APIConstants.kIsSelected]) == "1") ? AppConstants.Yes.capitalized : AppConstants.No
    }
    else{
      self.selectedValue = String.getString(dictStepTwo[APIConstants.kIsSelected])
    }
    self.selectedOptionName = String.getString(dictStepTwo[APIConstants.kOptionName])
    
   if let option = dictStepTwo[APIConstants.kOptions] as? ArrayOfDictionary{
     
     self.arrOptions = option.map({SignUpStepTwoOptionsModel(withDictionary: $0)})
   }
  }
}
 
class SignUpStepTwoOptionsModel: NSObject{
  
  var optionName: String?
  var roleid: String?
  var userFieldId: String = ""
  var userFieldOptionId: String = ""
  var selectedOption: String?
  var isSelected: Bool?

  init(withDictionary dictStepTwo: [String:Any]){
    
    super.init()
    
    if String.getString(dictStepTwo[APIConstants.kOption]).isEmpty == true{
      self.optionName = String.getString(dictStepTwo[APIConstants.kName])
    }
    else{
      self.optionName = String.getString(dictStepTwo[APIConstants.kOption])
    }
    self.roleid = String.getString(dictStepTwo[APIConstants.kRoleId])
    self.userFieldId = String.getString(dictStepTwo[APIConstants.kUserFieldId])
    self.userFieldOptionId = String.getString(dictStepTwo[APIConstants.kUserFieldOptionId])
    self.selectedOption = String.getString(dictStepTwo[APIConstants.kSelectedOption])
    self.isSelected = Bool.getBool(dictStepTwo[APIConstants.kIsSelected])
  }

 }
