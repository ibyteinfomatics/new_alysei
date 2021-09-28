//
//  GetRoleModel.swift
//  Alysie
//
//  Created by CodeAegis on 31/01/21.
//

import UIKit

class GetRoleViewModel: NSObject {

  var title: String?
  var subTitle: String?
  var roleDescription: String?
  var arrRoles: [GetRoleDataModel] = []
var arrImporter: [GetRoleDataModel] = []
  
  init(_ dictData: [String:Any]) {
    
    self.title = String.getString(dictData[APIConstants.kTitle])
    self.subTitle = String.getString(dictData[APIConstants.kSubtitle])
    self.roleDescription = String.getString(dictData[APIConstants.kDescription])
    
    if let role = dictData[APIConstants.kRoles] as? ArrayOfDictionary{
      
      self.arrRoles = role.map({GetRoleDataModel(withDictionary: $0)})
    }
    
    if let role = dictData[APIConstants.kImporterRoles] as? ArrayOfDictionary{
      
      self.arrImporter = role.map({GetRoleDataModel(withDictionary: $0)})
    }

  }
}


class GetRoleDataModel: NSObject {
  
  var displayName: String?
  var image: String?
  var name: String?
  var roleId: String?
  var slug: String?
  var isSelected: Bool?
  
  init(withDictionary dictRoles: [String:Any]) {
    
    self.displayName = String.getString(dictRoles[APIConstants.kDisplayName])
    self.image = String.getString(dictRoles[APIConstants.kImage])
    self.name = String.getString(dictRoles[APIConstants.kName])
    self.roleId = String.getString(dictRoles[APIConstants.kRoleId])
    self.slug = String.getString(dictRoles[APIConstants.kSlug])
    self.isSelected = Bool.getBool(dictRoles[APIConstants.kIsSelected])
    
  }
}
