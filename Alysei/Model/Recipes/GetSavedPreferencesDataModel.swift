//
//  GetSavedPreferencesDataModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 22/09/21.
//

import Foundation

class GetSavedPreferencesDataModel{
    
    var preferenceId : Int?
    var name: String?
    var createdAt: String?
    var updatedAt: String?
    var maps: [MapDataModel]?
    var title: String?
    init(with dictResponse: [String:Any]){
        self.preferenceId = Int.getInt(dictResponse["preference_id"])
        self.name = String.getString(dictResponse["name"])
        self.createdAt = String.getString(dictResponse["created_at"])
        self.updatedAt = String.getString(dictResponse["updated_at"])
        self.title = String.getString(dictResponse["title"])
        if let data = dictResponse["maps"] as? [[String:Any]]{
        self.maps = data.map({MapDataModel.init(with: $0)})
        }
    }
    
}

class MapDataModel{
    var cousinId: Int?
    var name: String?
    var title: String?
    var imageId: ImageURL?
    var status : String?
    var isSelected: Int?
    var foodId: Int?
    var dietId: Int?
    var ingridientId: Int?
    var cookingSkillId: Int?
    var ingridientTitle: String?
    init(with dictResponse: [String:Any]){
        self.cousinId = Int.getInt(dictResponse["cousin_id"])
        self.foodId = Int.getInt(dictResponse["recipe_food_intolerance_id"])
        self.dietId = Int.getInt(dictResponse["recipe_diet_id"])
        self.ingridientId = Int.getInt(dictResponse["recipe_ingredient_id"])
        self.cookingSkillId = Int.getInt(dictResponse["recipe_cooking_skill_id"])
        self.ingridientTitle = String.getString(dictResponse["ingridientTitle"])
        if let image = dictResponse["image_id"] as? [String:Any]{
            self.imageId = ImageURL.init(with: image)
        }
            self.name = String.getString(dictResponse["name"])
            self.title = String.getString(dictResponse["title"])
            self.status = String.getString(dictResponse["status"])
            self.isSelected = Int.getInt(dictResponse["is_selected"])
        
        
        }
    }

