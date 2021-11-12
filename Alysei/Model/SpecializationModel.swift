//
//  SpecializationModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 12/11/21.
//
//
import Foundation

class SpecializationModel{
  
    var success: Int?
    var data: [SpecializationData]?
    
    var hubdata: [AllHubnData]?
    
    init(with dictResponse: [String:Any]?){
        
        self.success = Int.getInt(dictResponse?["success"])
        
        if let data = dictResponse?["data"] as? [[String:Any]]{
            self.data = data.map({SpecializationData.init(with: $0)})
        }
        
        if let data = dictResponse?["data"] as? [[String:Any]]{
            self.hubdata = data.map({AllHubnData.init(with: $0)})
        }
        
    }
}

class AllHubnData {
    
    var id: Int?
    var title: String?
    
    init(with dictResponse: [String:Any]){
        self.id = Int.getInt(dictResponse["id"])
        self.title = String.getString(dictResponse["title"])
    }
    
}

class SpecializationData {
    
    var id: Int?
    var title: String?
    
    init(with dictResponse: [String:Any]){
        self.id = Int.getInt(dictResponse["user_field_option_id"])
        self.title = String.getString(dictResponse["option"])
    }
    
}
