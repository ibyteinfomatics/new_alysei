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
            
    
    init(with dictResponse: [String:Any]){
        self.recipeMealId = Int.getInt(dictResponse["recipe_meal_id"])
        
            self.mealName = String.getString(dictResponse["name"])
        }
}
