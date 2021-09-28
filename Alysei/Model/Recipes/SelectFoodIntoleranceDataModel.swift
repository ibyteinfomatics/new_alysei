//
//  SelectFoodIntoleranceDataModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 25/08/21.
//

import Foundation

class SelectFoodIntoleranceDataModel{
    
    var foodId: Int?
    var foodName: String?
    var imageId: ImageURL?
    var isSelected: Bool?
   
    init(with dictResponse: [String:Any]){
        self.foodId = Int.getInt(dictResponse["recipe_food_intolerance_id"])
        
            self.foodName = String.getString(dictResponse["name"])
        if let image = dictResponse["image_id"] as? [String:Any]{
            self.imageId = ImageURL.init(with: image)
            self.isSelected = false
        }
        }
}
