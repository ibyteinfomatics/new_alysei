//
//  SelectRecipeDietDataModel.swift
//  Alysei
//
//  Created by namrata upadhyay on 18/08/21.
//

import Foundation

class SelectRecipeDietDataModel{
    
    var dietId: Int?
    var dietName: String?
    var imageId: ImageURL?
    var isSelected: Bool?
    init(with dictResponse: [String:Any]){
        self.dietId = Int.getInt(dictResponse["recipe_diet_id"])
        
            self.dietName = String.getString(dictResponse["name"])
        if let image = dictResponse["image_id"] as? [String:Any]{
            self.imageId = ImageURL.init(with: image)
            self.isSelected = false
        }
        }
}
