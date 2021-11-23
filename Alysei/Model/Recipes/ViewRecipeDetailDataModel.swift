//
//  ViewRecipeDetailDataModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 07/10/21.
//

import Foundation
class ViewRecipeDetailDataModel{
    var recipeId: Int?
    var userId: Int?
    var recipeName: String?
    var mealId: Int?
    var courseId: Int?
    var hours: Int?
    var minute: Int?
    var serving: Int?
    var cousinId: Int?
    var regionId: Int?
    var dietId: Int?
    var intoleranceId: Int?
    var cookingSkillId: Int?
    var imageId: Int?
    var favCount: Int?
    var status: String?
    var createdAt: String?
    var updatedAt: String?
    var userName: String?
    var isFav: Int?
    var avgRating: String?
    var totalReview: Int?
    var total_one_star: Int?
    var total_two_star: Int?
    var total_three_star: Int?
    var total_four_star: Int?
    var total_five_star: Int?
    var latestReview: LatestReviewDataModel?
    var image: ImageURL?
    var meal: SelectMealDataModel?
    var region: SelectRegionDataModel?
    var userMain: UserDataModel?
    
    init(with dictResponse: [String:Any]){
        self.recipeId = Int.getInt(dictResponse["recipe_id"])
        self.userId = Int.getInt(dictResponse["user_id"])
        self.recipeName = String.getString(dictResponse["name"])
        self.mealId = Int.getInt(dictResponse["meal_id"])
        self.courseId = Int.getInt(dictResponse["course_id"])
        self.hours = Int.getInt(dictResponse["hours"])
        self.minute = Int.getInt(dictResponse["minutes"])
        self.serving = Int.getInt(dictResponse["serving"])
        self.cousinId = Int.getInt(dictResponse["cousin_id"])
        self.regionId = Int.getInt(dictResponse["region_id"])
        self.dietId = Int.getInt(dictResponse["diet_id"])
        self.intoleranceId = Int.getInt(dictResponse["intolerance_id"])
        self.cookingSkillId = Int.getInt(dictResponse["cooking_skill_id"])
        self.imageId = Int.getInt(dictResponse["image_id"])
        self.favCount = Int.getInt(dictResponse["favourite_count"])
        self.status = String.getString(dictResponse["status"])
        self.createdAt = String.getString(dictResponse["created_at"])
        self.updatedAt = String.getString(dictResponse["updated_at"])
        self.userName = String.getString(dictResponse["username"])
        self.isFav = Int.getInt(dictResponse["is_favourite"])
        self.avgRating = String.getString(dictResponse["avg_rating"])
        self.totalReview = Int.getInt(dictResponse["total_reviews"])
        self.total_one_star = Int.getInt(dictResponse["total_one_star"])
        self.total_two_star = Int.getInt(dictResponse["total_two_star"])
        self.total_three_star = Int.getInt(dictResponse["total_three_star"])
        self.total_four_star = Int.getInt(dictResponse["total_four_star"])
        self.total_five_star = Int.getInt(dictResponse["total_five_star"])
        
        if let data = dictResponse["latest_review"] as? [String:Any]{
            self.latestReview = LatestReviewDataModel.init(with: data)
        }
        
        if let image = dictResponse["image"] as? [String:Any]{
            self.image = ImageURL.init(with: image)
        }
        if let data = dictResponse["meal"] as? [String:Any]{
            self.meal = SelectMealDataModel.init(with: data)
        }
        if let data = dictResponse["region"] as? [String:Any]{
            self.region = SelectRegionDataModel.init(with: data)
        }
        if let data = dictResponse["user"] as? [String:Any]{
            self.userMain = UserDataModel.init(with: data)
        }
    }
    
}

class LatestReviewDataModel{
    var recipeReviewRateId: Int?
    var userId: Int?
    var recipeId: Int?
    var rating: Int?
    var review: String?
    var created: String?
    var updated: String?
    var user: UserDataModel?
    
    init(with dictResponse: [String:Any]){
        self.recipeReviewRateId = Int.getInt(dictResponse["recipe_review_rating_id"])
        self.userId = Int.getInt(dictResponse["user_id"])
        self.recipeId = Int.getInt(dictResponse["recipe_id"])
        self.rating = Int.getInt(dictResponse["rating"])
        self.review = String.getString(dictResponse["review"])
        self.created = String.getString(dictResponse["created_at"])
        self.updated = String.getString(dictResponse["updated_at"])
        if let data = dictResponse["user"] as? [String:Any]{
            self.user = UserDataModel.init(with: data)
        }
    }
}
    
class UserDataModel{
    var userId: Int?
    var name: String?
    var email: String?
    var compnyName: String?
    var first_name: String?
    var last_name: String?
    var restaurantName: String?
    var roleId: Int?
    var avatarId: AvatarDataModel?
    
    init(with dictResponse: [String:Any]){
        self.userId = Int.getInt(dictResponse["user_id"])
        self.name = String.getString(dictResponse["name"])
        self.first_name = String.getString(dictResponse["first_name"])
        self.last_name = String.getString(dictResponse["last_name"])
        self.email = String.getString(dictResponse["email"])
        self.compnyName = String.getString(dictResponse["company_name"])
        self.restaurantName = String.getString(dictResponse["restaurant_name"])
        self.roleId = Int.getInt(dictResponse["role_id"])
      
        if let data = dictResponse["avatar_id"] as? [String:Any]{
            self.avatarId = AvatarDataModel.init(with: data)
        }
    }
}

class AvatarDataModel{
    var id: Int?
    var imageUrl: String?
    var imageType: String?
    
    init(with dictResponse: [String:Any]){
        self.id = Int.getInt(dictResponse["id"])
        self.imageUrl = String.getString(dictResponse["attachment_url"])
        self.imageType = String.getString(dictResponse["attachment_type"])
    }
}
      
       
class UsedIngridientDataModel{
    var recipeSavedIngridientId: Int?
    var recipeId: Int?
    var ingridientId: Int?
    var quantity: String?
    var unit: String?
    var createdAt: String?
    var updatedAt: String?
    var isSelected: Bool?
    var ingridient: IngridentArray?
    
    init(with dictResponse: [String:Any]){
        self.recipeSavedIngridientId = Int.getInt(dictResponse["recipe_saved_ingredient_id"])
        self.recipeId = Int.getInt(dictResponse["recipe_id"])
        self.ingridientId = Int.getInt(dictResponse["ingredient_id"])
        self.quantity = String.getString(dictResponse["quantity"])
        self.unit = String.getString(dictResponse["unit"])
        self.createdAt = String.getString(dictResponse["created_at"])
        self.updatedAt = String.getString(dictResponse["updated_at"])
        self.isSelected = Bool.getBool(dictResponse["is_selected"])
        
        if let data = dictResponse["ingredient"] as? [String:Any]{
            self.ingridient = IngridentArray.init(with: data)
        }
    }
}

class UsedToolsDataModel{
    var recipeSavedToolId: Int?
    var recipeToolId: Int?
    var toolId: Int?
    var quantityTool: String?
    var unitTool: String?
    var createdAt: String?
    var updatedAt: String?
    var isSelected: Bool?
    var tool: ToolsArray?
    
    init(with dictResponse: [String:Any]){
        self.recipeSavedToolId = Int.getInt(dictResponse["recipe_saved_tool_id"])
        self.recipeToolId = Int.getInt(dictResponse["recipe_id"])
        self.toolId = Int.getInt(dictResponse["tool_id"])
        self.quantityTool = String.getString(dictResponse["quantity"])
        self.unitTool = String.getString(dictResponse["unit"])
        self.createdAt = String.getString(dictResponse["created_at"])
        self.updatedAt = String.getString(dictResponse["updated_at"])
        self.isSelected = Bool.getBool(dictResponse["is_selected"])
        
        if let data = dictResponse["tool"] as? [String:Any]{
            self.tool = ToolsArray.init(with: data)
        }
    }
}

class StepsDataModel{
    var recipeStepId: Int?
    var recipeId: Int?
    var title: String?
    var description: String?
    var createdAt: String?
    var updatedAt: String?
    var stepIngridient: [UsedIngridientDataModel]?
    var stepTool: [UsedToolsDataModel]?
    
    init(with dictResponse: [String:Any]){
        self.recipeStepId = Int.getInt(dictResponse["recipe_step_id"])
        self.recipeId = Int.getInt(dictResponse["recipe_id"])
        self.title = String.getString(dictResponse["title"])
        self.description = String.getString(dictResponse["description"])
       
        self.createdAt = String.getString(dictResponse["created_at"])
        self.updatedAt = String.getString(dictResponse["updated_at"])
        
        if let data = dictResponse["step_ingredients"] as? [[String:Any]]{
            self.stepIngridient = data.map({UsedIngridientDataModel.init(with: $0)})
        }
        
        if let data = dictResponse["step_tools"] as? [[String:Any]]{
            self.stepTool = data.map({UsedToolsDataModel.init(with: $0)})
        }
    }
}

