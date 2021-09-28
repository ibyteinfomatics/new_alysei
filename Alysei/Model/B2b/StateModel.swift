//
//  StateModel.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/18/21.
//

import Foundation

class StateModel{
    var id: Int?
    var name: String?
    var isSelected = false
    init(with data: [String:Any]?) {
        self.id = Int.getInt(data?["id"])
        self.name = String.getString(data?["name"])
    }
    
}

class ProductType{
    var options: [SignUpOptionsDataModel]?
    init(with data: [String:Any]?) {
        
        if let option = data?[APIConstants.kOptions] as? ArrayOfDictionary{
          
          self.options = option.map({SignUpOptionsDataModel(withDictionary: $0)})
        }
    }
}
