//
//  BusinessModel.swift
//  Alysie
//
//  Created by CodeAegis on 24/01/21.
//

import Foundation

enum BusinessCellType{
  
  case textFieldCell,collectionFilters,searchCell,collectionHubs,tableListCell,defaultCell
}
//MARK: UserListModel Multiple Hub Search
class BusinessViewModel: NSObject {
  
  var arrBusinessData: [BusinessDataModel] = []
  
//  var selectedEmail: String {
//
//    let modal = self.arrSignUpData.filter { $0.signUpHeading == AppConstants.Email }
//    return modal.first?.signUpSelectedValue ?? ""
//  }
//
//  var selectedPassword: String {
//
//    let modal = self.arrSignUpData.filter { $0.signUpHeading == AppConstants.Password }
//    return modal.first?.signUpSelectedValue ?? ""
//  }
//
//  var selectedCompanyName: String {
//
//    let modal = self.arrSignUpData.filter { $0.signUpHeading == AppConstants.CompanyName }
//    return modal.first?.signUpSelectedValue ?? ""
//  }
//
//  var selectedProductType: String {
//
//    let modal = self.arrSignUpData.filter { $0.signUpHeading == AppConstants.ProductType }
//    return modal.first?.signUpSelectedValue ?? ""
//  }
//
//  var selectedItalianRegion: String {
//
//    let modal = self.arrSignUpData.filter { $0.signUpHeading == AppConstants.ItalianRegion }
//    return modal.first?.signUpSelectedValue ?? ""
//  }
  
  func validateFields() -> (Bool,String){
    
    for item in arrBusinessData{
     if (item.businessSelectedValue?.isEmpty == true){
        return(false,String.getString(item.businessValidationMessage))
      }
     }
    return (true,"")
  }
 
   init(currentIndex: Int) {
    
    super.init()
    
    switch currentIndex {
    case 0:
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.KeywordSearch,businessCellType: .textFieldCell))
      //self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.TopHubs))
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.SelectState))
      self.arrBusinessData.append(BusinessDataModel(businessCellType: .searchCell))
        self.arrBusinessData.append(BusinessDataModel(businessCellType: .collectionHubs))
      //self.arrBusinessData.append(BusinessDataModel(businessCellType: .collectionHubs,cellCount: 3))
  
    case 1:
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.Hubs))
        self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.SelectUserType))
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.ProductTypeBusiness))
      //self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.SelectState))
      self.arrBusinessData.append(BusinessDataModel(businessCellType: .collectionFilters, arrFilters: StaticArrayData.kImporterFilter))
      self.arrBusinessData.append(BusinessDataModel(businessCellType: .searchCell))
       // self.arrBusinessData.append(BusinessDataModel(businessCellType: .tableListCell))
        for _ in 0..<(cellCount ?? 0) {
        self.arrBusinessData.append(BusinessDataModel(businessCellType: .tableListCell,cellCount: 9))

      }
    case 2:
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.Hubs))
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.RestaurantType))
      self.arrBusinessData.append(BusinessDataModel(businessCellType: .collectionFilters, arrFilters: StaticArrayData.kRestaurantFilter))
      self.arrBusinessData.append(BusinessDataModel(businessCellType: .searchCell))
        //self.arrBusinessData.append(BusinessDataModel(businessCellType: .tableListCell))
        for _ in 0..<(cellCount ?? 0) {
        self.arrBusinessData.append(BusinessDataModel(businessCellType: .tableListCell,cellCount: 9))

      }
    case 3:
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.Hubs))
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.Expertise))
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.Title))
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.SelectCountry))
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.SelectState))
      self.arrBusinessData.append(BusinessDataModel(businessCellType: .searchCell))
   //     self.arrBusinessData.append(BusinessDataModel(businessCellType: .tableListCell))
        for _ in 0..<(cellCount ?? 0) {
        self.arrBusinessData.append(BusinessDataModel(businessCellType: .tableListCell,cellCount: 9))

      }
    case 4:
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.Hubs))
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.Speciality))
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.SelectCountry))
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.SelectState))
      self.arrBusinessData.append(BusinessDataModel(businessCellType: .searchCell))
     //   self.arrBusinessData.append(BusinessDataModel(businessCellType: .tableListCell))
        for _ in 0..<(cellCount ?? 0) {
        self.arrBusinessData.append(BusinessDataModel(businessCellType: .tableListCell,cellCount: 9))

      }
    case 5:
        self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.Hubs))
        self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.ProductTypeBusiness))
        //self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.SelectState))
        self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.SelectRegion))
        self.arrBusinessData.append(BusinessDataModel(businessCellType: .collectionFilters, arrFilters: StaticArrayData.kImporterFilter))
        self.arrBusinessData.append(BusinessDataModel(businessCellType: .searchCell))
  
        for _ in 0..<(cellCount ?? 0) {
        self.arrBusinessData.append(BusinessDataModel(businessCellType: .tableListCell,cellCount: 9))

      }
    default:
      break
    }
  }
 }




//MARK: UserListModel For Single Hub Selection

class BusinessSingleHubViewModel: NSObject {
  
  var arrBusinessData: [BusinessDataModel] = []
  
//  var selectedEmail: String {
//
//    let modal = self.arrSignUpData.filter { $0.signUpHeading == AppConstants.Email }
//    return modal.first?.signUpSelectedValue ?? ""
//  }
//
//  var selectedPassword: String {
//
//    let modal = self.arrSignUpData.filter { $0.signUpHeading == AppConstants.Password }
//    return modal.first?.signUpSelectedValue ?? ""
//  }
//
//  var selectedCompanyName: String {
//
//    let modal = self.arrSignUpData.filter { $0.signUpHeading == AppConstants.CompanyName }
//    return modal.first?.signUpSelectedValue ?? ""
//  }
//
//  var selectedProductType: String {
//
//    let modal = self.arrSignUpData.filter { $0.signUpHeading == AppConstants.ProductType }
//    return modal.first?.signUpSelectedValue ?? ""
//  }
//
//  var selectedItalianRegion: String {
//
//    let modal = self.arrSignUpData.filter { $0.signUpHeading == AppConstants.ItalianRegion }
//    return modal.first?.signUpSelectedValue ?? ""
//  }
  
  func validateFields() -> (Bool,String){
    
    for item in arrBusinessData{
     if (item.businessSelectedValue?.isEmpty == true){
        return(false,String.getString(item.businessValidationMessage))
      }
     }
    return (true,"")
  }
 
   init(currentIndex: Int) {
    
    super.init()
    
    switch currentIndex {
    case 0:
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.KeywordSearch,businessCellType: .textFieldCell))
      //self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.TopHubs))
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.SelectState))
      self.arrBusinessData.append(BusinessDataModel(businessCellType: .searchCell))
        self.arrBusinessData.append(BusinessDataModel(businessCellType: .collectionHubs))
      //self.arrBusinessData.append(BusinessDataModel(businessCellType: .collectionHubs,cellCount: 3))
  
    case 1:
     // self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.Hubs))
        self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.SelectUserType))
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.ProductTypeBusiness))
      //self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.SelectState))
      self.arrBusinessData.append(BusinessDataModel(businessCellType: .collectionFilters, arrFilters: StaticArrayData.kImporterFilter))
      self.arrBusinessData.append(BusinessDataModel(businessCellType: .searchCell))
       // self.arrBusinessData.append(BusinessDataModel(businessCellType: .tableListCell))
        for _ in 0..<(cellCount ?? 0) {
        self.arrBusinessData.append(BusinessDataModel(businessCellType: .tableListCell,cellCount: 9))

      }
    case 2:
      //self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.Hubs))
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.RestaurantType))
      self.arrBusinessData.append(BusinessDataModel(businessCellType: .collectionFilters, arrFilters: StaticArrayData.kRestaurantFilter))
      self.arrBusinessData.append(BusinessDataModel(businessCellType: .searchCell))
        //self.arrBusinessData.append(BusinessDataModel(businessCellType: .tableListCell))
        for _ in 0..<(cellCount ?? 0) {
        self.arrBusinessData.append(BusinessDataModel(businessCellType: .tableListCell,cellCount: 9))

      }
    case 3:
     // self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.Hubs))
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.Expertise))
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.Title))
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.SelectCountry))
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.SelectState))
      self.arrBusinessData.append(BusinessDataModel(businessCellType: .searchCell))
   //     self.arrBusinessData.append(BusinessDataModel(businessCellType: .tableListCell))
        for _ in 0..<(cellCount ?? 0) {
        self.arrBusinessData.append(BusinessDataModel(businessCellType: .tableListCell,cellCount: 9))

      }
    case 4:
     // self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.Hubs))
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.Speciality))
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.SelectCountry))
      self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.SelectState))
      self.arrBusinessData.append(BusinessDataModel(businessCellType: .searchCell))
     //   self.arrBusinessData.append(BusinessDataModel(businessCellType: .tableListCell))
        for _ in 0..<(cellCount ?? 0) {
        self.arrBusinessData.append(BusinessDataModel(businessCellType: .tableListCell,cellCount: 9))

      }
    case 5:
       // self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.Hubs))
        self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.ProductTypeBusiness))
       // self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.SelectState))
        self.arrBusinessData.append(BusinessDataModel(businessHeading: AppConstants.SelectRegion))
        self.arrBusinessData.append(BusinessDataModel(businessCellType: .collectionFilters, arrFilters: StaticArrayData.kImporterFilter))
        self.arrBusinessData.append(BusinessDataModel(businessCellType: .searchCell))
  
        for _ in 0..<(cellCount ?? 0) {
        self.arrBusinessData.append(BusinessDataModel(businessCellType: .tableListCell,cellCount: 9))

      }
    default:
      break
    }
  }
 }





 class BusinessDataModel: NSObject{
  
  var businessHeading: String?
  var businessSelectedValue: String?
  var businessCellType: BusinessCellType?
  var businessValidationMessage: String?
  var arrFilters: [String] = []
  var cellCount: Int = 1

  init(businessHeading heading: String = "",signUpSelectedValue value: String = "", businessCellType cellType: BusinessCellType = .defaultCell,businessValidationMessage message: String = "",arrFilters arr: [String] = [],cellCount count: Int = 1 ){
    
   // init(businessHeading heading: String = "",signUpSelectedValue value: String = "", businessCellType cellType: BusinessCellType = .defaultCell,businessValidationMessage message: String = "",arrFilters arr: [String] = []){
    
    super.init()
    self.businessHeading = heading
    self.businessSelectedValue = value
    self.businessCellType = cellType
    self.businessValidationMessage = message
    self.cellCount = count
    self.arrFilters = arr
  }
}



