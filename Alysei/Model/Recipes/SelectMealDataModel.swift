//
//  SelectMealDataModel.swift
//  Alysei
//
//  Created by namrata upadhyay on 17/08/21.
//

import Foundation

class SelectMealDataModel{
    
    var recipeMealId: Int?
    var mealName: String?
    var imageId : ImageURL?
    var imageOnlyId: Int?
    
    init(with dictResponse: [String:Any]){
        self.recipeMealId = Int.getInt(dictResponse["recipe_meal_id"])
        
            self.mealName = String.getString(dictResponse["name"])
        
        if let image = dictResponse["image_id"] as? [String:Any]{
            self.imageId = ImageURL.init(with: image)
        }
        self.imageOnlyId = Int.getInt(dictResponse["image_id"])
        }
}
