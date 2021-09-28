//
//  GetHomePageModelData.swift
//  Alysei
//
//  Created by namrata upadhyay on 25/09/21.
//

import Foundation

class GetHomePageModelData{
    var ingridients : [IngridentArray]?
    var meals : [SelectMealDataModel]?
    var regions : [SelectRegionDataModel]?
    var trending : [HomeTrending]?
    var quickEasy : [HomeQuickEasy]?
    
    init(with dictResponse: [String:Any]){
        if let data = dictResponse["ingredients"] as? [[String:Any]]{
        self.ingridients = data.map({IngridentArray.init(with: $0)})
    }
        if let data = dictResponse["meals"] as? [[String:Any]]{
        self.meals = data.map({SelectMealDataModel.init(with: $0)})
    }
        if let data = dictResponse["regions"] as? [[String:Any]]{
        self.regions = data.map({SelectRegionDataModel.init(with: $0)})
    }
        if let data = dictResponse["trending_recipes"] as? [[String:Any]]{
        self.trending = data.map({HomeTrending.init(with: $0)})
    }
        if let data = dictResponse["quick_easy"] as? [[String:Any]]{
        self.quickEasy = data.map({HomeQuickEasy.init(with: $0)})
    }
        
    }
}



class HomeTrending{
    
    var recipeId: Int?
    var userId: Int?
    var name: String?
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
    var favouriteCount: Int?
    var status: String?
    var createdAt: String?
    var updatedAt: String?
    var totalLikes: Int?
    var avgRating: Int?
    var userName: String?
    var image: ImageURL?
    var meal: SelectMealDataModel?
    var course: SelectCourseDataModel?
    var cuisin: SelectCuisineDataModel?
    var region: SelectRegionDataModel?
    var diet: SelectRecipeDietDataModel?
    var intolerance: SelectFoodIntoleranceDataModel?
    var cookingSkill: SelectCookingSkillsDataModel?
                    
    init(with dictResponse: [String:Any]){
        self.recipeId = Int.getInt(dictResponse["recipe_id"])
        self.userId = Int.getInt(dictResponse["user_id"])
        self.name = String.getString(dictResponse["name"])
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
        self.favouriteCount = Int.getInt(dictResponse["favourite_count"])
        self.status = String.getString(dictResponse["status"])
        self.createdAt = String.getString(dictResponse["created_at"])
        self.updatedAt = String.getString(dictResponse["updated_at"])
        self.totalLikes = Int.getInt(dictResponse["total_likes"])
        self.avgRating = Int.getInt(dictResponse["avg_rating"])
        self.userName = String.getString(dictResponse["username"])
        if let image = dictResponse["image"] as? [String:Any]{
            self.image = ImageURL.init(with: image)
        }
        if let data = dictResponse["meal"] as? [String:Any]{
            self.meal = SelectMealDataModel.init(with: data)
        }
        if let data = dictResponse["course"] as? [String:Any]{
        self.course = SelectCourseDataModel.init(with: data)
            
        }
        if let data = dictResponse["cousin"] as? [String:Any]{
        self.cuisin = SelectCuisineDataModel.init(with: data)
        }
        if let data = dictResponse["region"] as? [String:Any]{
        self.region = SelectRegionDataModel.init(with: data)
        }
        if let data = dictResponse["diet"] as? [String:Any]{
        self.diet = SelectRecipeDietDataModel.init(with: data)
        }
        if let data = dictResponse["intolerance"] as? [String:Any]{
        self.intolerance = SelectFoodIntoleranceDataModel.init(with: data)
        }
        if let data = dictResponse["cookingskill"] as? [String:Any]{
        self.cookingSkill = SelectCookingSkillsDataModel.init(with: data)
        }
                    
    }
                  
}


class HomeQuickEasy{
    var recipeId: Int?
    var userId: Int?
    var name: String?
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
    var favouriteCount: Int?
    var status: String?
    var createdAt: String?
    var updatedAt: String?
    var image: ImageURL?
    var meal: SelectMealDataModel?
    var course: SelectCourseDataModel?
    var cuisin: SelectCuisineDataModel?
    var region: SelectRegionDataModel?
    var diet: SelectRecipeDietDataModel?
    var intolerance: SelectFoodIntoleranceDataModel?
    var cookingSkill: SelectCookingSkillsDataModel?
                    
    init(with dictResponse: [String:Any]){
        self.recipeId = Int.getInt(dictResponse["recipe_id"])
        self.userId = Int.getInt(dictResponse["user_id"])
        self.name = String.getString(dictResponse["name"])
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
        self.favouriteCount = Int.getInt(dictResponse["favourite_count"])
        self.status = String.getString(dictResponse["status"])
        self.createdAt = String.getString(dictResponse["created_at"])
        self.updatedAt = String.getString(dictResponse["updated_at"])
        
        if let image = dictResponse["image"] as? [String:Any]{
            self.image = ImageURL.init(with: image)
        }
        if let data = dictResponse["meal"] as? [String:Any]{
            self.meal = SelectMealDataModel.init(with: data)
        }
        if let data = dictResponse["course"] as? [String:Any]{
        self.course = SelectCourseDataModel.init(with: data)
            
        }
        if let data = dictResponse["cousin"] as? [String:Any]{
        self.cuisin = SelectCuisineDataModel.init(with: data)
        }
        if let data = dictResponse["region"] as? [String:Any]{
        self.region = SelectRegionDataModel.init(with: data)
        }
        if let data = dictResponse["diet"] as? [String:Any]{
        self.diet = SelectRecipeDietDataModel.init(with: data)
        }
        if let data = dictResponse["intolerance"] as? [String:Any]{
        self.intolerance = SelectFoodIntoleranceDataModel.init(with: data)
        }
        if let data = dictResponse["cookingskill"] as? [String:Any]{
        self.cookingSkill = SelectCookingSkillsDataModel.init(with: data)
        }
                    
    }
}
