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
    var base_url: String?
    var attachment: Attachment?
    
    
  init(withDictionary dictRoles: [String:Any]) {
    
    self.walkthroughDescription = String.getString(dictRoles[APIConstants.kDescription])
    self.order = String.getString(dictRoles[APIConstants.kOrder])
    self.title = String.getString(dictRoles[APIConstants.kTitle])
    self.roleId = String.getString(dictRoles[APIConstants.kRoleId])
    self.imageId = String.getString(dictRoles[APIConstants.kImageId])
      if let attachment = dictRoles["attachment"] as? [String:Any]{
          self.attachment =  Attachment.init(with: attachment)
      }
   
      self.base_url = String.getString(dictRoles["base_url"])
    
  }
}
