//
//  AddFeaturedModel.swift
//  Alysie
//
//  Created by CodeAegis on 20/01/21.
//

import UIKit

class AddFeaturedViewModel: NSObject {
  
  var arrFeaturedProductData: [AddFeaturedDataModel] = []
  
//  var selectedEmail: String {
//
//    let modal = self.arrSettingsData.filter { $0.settingsHeading == AppConstants.Email }
//    return modal.first?.settingsSelectedValue ?? ""
//  }
//
//  var selectedPassword: String {
//
//    let modal = self.arrSettingsData.filter { $0.settingsHeading == AppConstants.Password }
//    return modal.first?.settingsSelectedValue ?? ""
//  }
//
//  var selectedCompanyName: String {
//
//    let modal = self.arrSettingsData.filter { $0.settingsHeading == AppConstants.CompanyName }
//    return modal.first?.settingsSelectedValue ?? ""
//  }
  
  func validateFields() -> (Bool,String){
    
    for item in arrFeaturedProductData{
     if (item.productSelectedValue?.isEmpty == true){
        return(false,String.getString(item.productValidationMessage))
      }
     }
    return (true,"")
  }
 
   init(_ model: AddFeaturedDataModel? = nil) {
    
    super.init()
    self.arrFeaturedProductData.append(AddFeaturedDataModel(productHeading: AppConstants.Title, productPlaceholder: AppConstants.AddTitle))
    self.arrFeaturedProductData.append(AddFeaturedDataModel(productHeading: AppConstants.Description, productPlaceholder: AppConstants.AddDescription))
    self.arrFeaturedProductData.append(AddFeaturedDataModel(productHeading: AppConstants.Tags, productPlaceholder: AppConstants.SeparateTags))
  }
 }

 class AddFeaturedDataModel: NSObject{
  
  var productHeading: String?
  var productPlaceholder: String?
  var productSelectedValue: String?
  var productValidationMessage: String?

  init(productHeading heading: String,productPlaceholder placeholder: String,productSelectedValue value: String = "",productValidationMessage message: String = ""){
    
    super.init()
    self.productHeading = heading
    self.productPlaceholder = placeholder
    self.productSelectedValue = value
    self.productValidationMessage = message
  }
}




