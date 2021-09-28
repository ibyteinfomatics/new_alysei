//
//  SearchIngridientModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 13/09/21.
//

import Foundation

class SearchIngridientDataModel{
    var recipeIngridientId :    Int?
    var ingridienttitle: String?
    var ingridientName: String?
    var imageIngridient: ImageURL?
    var parentIngridient: Int?
    var createdAt:String?
    var updatedAt: String?
    var pickerData: String?
    var quantity: Int?
    var unit: String?
    var isSelected: Bool?
    
    init(with dictResponse: [String:Any]){
        self.recipeIngridientId = Int.getInt(dictResponse["recipe_ingredient_id"])
            self.ingridienttitle = String.getString(dictResponse["title"])
        self.updatedAt = String.getString(dictResponse["created_at"])
        self.createdAt = String.getString(dictResponse["updated_at"])
        self.parentIngridient = Int.getInt(dictResponse["parent"])
        if let image = dictResponse["image_id"] as? [String:Any]{
            self.imageIngridient = ImageURL.init(with: image)
        }
        self.pickerData = ""
        self.quantity = 0
        self.unit = "Kg"
        self.isSelected = false
    }
    init(){
        
    }
}
