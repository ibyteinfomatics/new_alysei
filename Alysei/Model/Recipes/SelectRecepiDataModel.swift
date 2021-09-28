//
//  SelectRecepiDataModel.swift
//  Alysei
//
//  Created by Mohit on 16/08/21.
//

import Foundation

class SelectRecepiDataModel{
    var recipeCategoryId: Int?
    var name: String?
    var imageId: ImageURL?
    
    init(with dictResponse: [String:Any]){
        self.recipeCategoryId = Int.getInt(dictResponse["recipe_category_id"])
        
        if let image = dictResponse["image_id"] as? [String:Any]{
            self.imageId = ImageURL.init(with: image)
        }
            self.name = String.getString(dictResponse["name"])
        }
    }

class ImageURL{
   
    var imgUrl: String?
    
    init(with dictResponse: [String:Any]){
       
        
            self.imgUrl = String.getString(dictResponse["attachment_url"])
        }
    }



