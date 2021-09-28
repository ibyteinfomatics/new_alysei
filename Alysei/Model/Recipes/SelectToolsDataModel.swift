//
//  SelectToolsDataModel.swift
//  Alysei
//
//  Created by namrata upadhyay on 19/08/21.
//

import Foundation

class AddToolsDataModel {
    
    var toolDataName: String?
    var tools: [ToolsArray]?
    var toolId: Int?
    
    init(with dictResponse: [String:Any]){
       
            self.toolDataName = String.getString(dictResponse["title"])
        self.toolId = Int.getInt(dictResponse["recipe_ingredient_id"])
        if let data = dictResponse["tools"] as? [[String:Any]]{
        self.tools = data.map({ToolsArray.init(with: $0)})
        }

     }
    
}

class stepDataModel {
    var title: String?
    var description: String?
    var toolsArray: [ToolsArray]?
    var ingridentsArray: [IngridentArray]?
    init() {
        self.title = ""
        self.description = ""
        self.toolsArray = []
        self.ingridentsArray = []
    }
}

class ToolTypeDataModel{
    
    var toolType: String?
    var toolName: String?
    var count: Int?
    
    init(with dictResponse: [String:Any]){
        self.toolType = String.getString(dictResponse["tool_types"])
        self.count = Int.getInt(dictResponse["count"])
        
    }
    
}

class ToolsArray{
    
    var recipeToolIds: Int?
    var toolTitle: String?
    var imageId: ImageURL?
    var parent: Int?
    var pickerData: String?
    var quantity: Int?
    var unit: String?
    var isSelected: Bool?
    
    init(with dictResponse: [String:Any]){
        self.recipeToolIds = Int.getInt(dictResponse["recipe_tool_id"])
            self.toolTitle = String.getString(dictResponse["title"])
        self.pickerData = ""
        self.quantity = 0
        self.unit = "Kg"
        self.isSelected = false
        self.parent = Int.getInt(dictResponse["parent"])
        if let image = dictResponse["image_id"] as? [String:Any]{
            self.imageId = ImageURL.init(with: image)
        }
        }
    
    init(){
        
    }
    
    
    
}
