//
//  AddIngridentDataModel.swift
//  Alysei
//
//  Created by namrata upadhyay on 17/08/21.
//

import Foundation

//class AddMissingIngridientDataModel{
//
//    var addIngridientType: [IngridentType]?
//
//    init(with dictResponse: [String:Any]){
//
//    if let data = dictResponse["type"] as? [[String:Any]]{
//    self.addIngridientType = data.map({IngridentType.init(with: $0)})
//     }
//    }
//
//}

class AddIngridientDataModel {

    var ingridientDataName: String?
    var ingridents: [IngridentArray]?
    var ingridientId: Int?
    init(with dictResponse: [String:Any]){
       
            self.ingridientDataName = String.getString(dictResponse["title"])
            self.ingridientId = Int.getInt(dictResponse["recipe_tool_id"])
            if let data = dictResponse["ingredients"] as? [[String:Any]]{
            self.ingridents = data.map({IngridentArray.init(with: $0)})
                
          
        }
    
    
    
}

}
class IngridentTypeDataModel{
    
    var ingridientType: String?
    var ingridientName: String?
    var count: Int?
    
    init(with dictResponse: [String:Any]){
        self.ingridientType = String.getString(dictResponse["ingredient_types"])
        self.count = Int.getInt(dictResponse["count"])
        
        }
        
}

class IngridentArray{
    
    var recipeIngredientIds: Int?
    var ingridientTitle: String?
    var imageId: ImageURL?
    var parent: Int?
    var pickerData: String?
    var quantity: Int?
    var unit: String?
    
    var createdAt: String?
    var updatedAt: String?
    var isSelected: Bool?
    
    init(with dictResponse: [String:Any]){
        self.recipeIngredientIds = Int.getInt(dictResponse["recipe_ingredient_id"])
            self.ingridientTitle = String.getString(dictResponse["title"])
        self.updatedAt = String.getString(dictResponse["created_at"])
        self.createdAt = String.getString(dictResponse["updated_at"])
        self.parent = Int.getInt(dictResponse["parent"])
        self.pickerData = ""
        self.quantity = 0
        self.unit = "Kg"
        self.isSelected = false
        if let image = dictResponse["image_id"] as? [String:Any]{
            self.imageId = ImageURL.init(with: image)
        }
        }
    
    init(){
        
    }
   
}

