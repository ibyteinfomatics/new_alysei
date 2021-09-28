//
//  SelectCookigSkillsDataModel.swift
//  Alysei
//
//  Created by namrata upadhyay on 18/08/21.
//

import Foundation

class SelectCookingSkillsDataModel{
    
    var cookinSkillId: Int?
    var cookingSkillName: String?
    var imageId: ImageURL?
    var isSelected: Bool?
    init(with dictResponse: [String:Any]){
        self.cookinSkillId = Int.getInt(dictResponse["recipe_cooking_skill_id"])
        
            self.cookingSkillName = String.getString(dictResponse["name"])
        if let image = dictResponse["image_id"] as? [String:Any]{
            self.imageId = ImageURL.init(with: image)
            self.isSelected = false
        }
        }
}
