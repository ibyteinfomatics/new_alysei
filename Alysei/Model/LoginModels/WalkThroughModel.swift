//
//  WalkThroughModel.swift
//  Alysie
//
//  Created by CodeAegis on 06/02/21.
//

import Foundation

class GetWalkThroughViewModel: NSObject {

  var arrWalkThroughs: [GetWalkThroughDataModel] = []
  
  init(_ dictResult: [String:Any]) {
    
    if let role = dictResult[APIConstants.kData] as? ArrayOfDictionary{
      
      self.arrWalkThroughs = role.map({GetWalkThroughDataModel(withDictionary: $0)})
    }
  }
}


class GetWalkThroughDataModel: NSObject {
  
  var walkthroughDescription: String?
  var order: String?
  var title: String?
  var roleId: String?
  var imageId: String?
    

  init(withDictionary dictRoles: [String:Any]) {
    
    self.walkthroughDescription = String.getString(dictRoles[APIConstants.kDescription])
    self.order = String.getString(dictRoles[APIConstants.kOrder])
    self.title = String.getString(dictRoles[APIConstants.kTitle])
    self.roleId = String.getString(dictRoles[APIConstants.kRoleId])
    self.imageId = String.getString(dictRoles[APIConstants.kImageId])
    
  }
}
