//
//  SearcRecipeDataModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 30/09/21.
//

import Foundation

class SearchRecipeDataModel{
 
    var currentPage : Int?
    var dataRecipe : [DataRecipe]?
    var firstPageUrl: String?
    var lastPageUrl: String?
    var lastPage: Int?
    
    init(with dictResponse: [String:Any]){
        self.currentPage = Int.getInt(dictResponse["current_page"])
        if let data = dictResponse["data"] as? [[String:Any]]{
            self.dataRecipe = data.map({DataRecipe.init(with: $0)})
        }
        self.firstPageUrl = String.getString(dictResponse["first_page_url"])
        self.lastPageUrl = String.getString(dictResponse["last_page_url"])
        self.lastPage = Int.getInt(dictResponse["last_page"])

   }
}

class DataRecipe{
    var recipeId: Int?
    var userId: Int?
    var name: String?
    var mealId: Int?
    var courseId: Int?
    var hours: Int?
    var minutes: Int?
    var serving: Int?
    var cousinID : Int?
    var regionId: Int?
    var dietId: Int?
    var intoleranceId: Int?
    var cookingSkillId: Int?
    var imageId: Int?
    var favouriteCount: Int?
    var status: String?
    var createdAt: String?
    var updatedAt: String?
    var totalLikes: Int?
    var avgRating: Int?
    var username: String?
    var image: ImageURL?
    var meal: SelectMealDataModel?
  
    init(with dictResponse: [String:Any]){
        self.recipeId = Int.getInt(dictResponse["recipe_id"])
        self.userId = Int.getInt(dictResponse["user_id"])
        self.name = String.getString(dictResponse["name"])
        self.mealId = Int.getInt(dictResponse["meal_id"])
        self.courseId = Int.getInt(dictResponse["course_id"])
        self.hours = Int.getInt(dictResponse["hours"])
        self.minutes = Int.getInt(dictResponse["minutes"])
        self.serving = Int.getInt(dictResponse["serving"])
        self.cousinID = Int.getInt(dictResponse["cousin_id"])
        self.regionId = Int.getInt(dictResponse["region_id"])
        self.dietId = Int.getInt(dictResponse["diet_id"])
        self.intoleranceId = Int.getInt(dictResponse["intolerance_id"])
        self.cookingSkillId = Int.getInt(dictResponse["cooking_skill_id"])
        self.imageId = Int.getInt(dictResponse["image_id"])
        self.favouriteCount = Int.getInt(dictResponse["favourite_count"])
        self.status = String.getString(dictResponse["status"])
        self.createdAt = String.getString(dictResponse["created_at"])
        self.updatedAt = String.getString(dictResponse["updated_at"])
        self.totalLikes = Int.getInt(dictResponse["total_likes"])
        self.avgRating = Int.getInt(dictResponse["avg_rating"])
        self.username = String.getString(dictResponse["username"])
        if let image = dictResponse["image"] as? [String:Any]{
            self.image = ImageURL.init(with: image)
        }
        if let data = dictResponse["meal"] as? [String:Any]{
            self.meal = SelectMealDataModel.init(with: data)
        }
    }
}
