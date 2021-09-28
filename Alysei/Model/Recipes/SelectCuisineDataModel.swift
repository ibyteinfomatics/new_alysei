//
//  SelectCuisineDataModel.swift
//  Alysei
//
//  Created by namrata upadhyay on 18/08/21.
//

import Foundation

class SelectCuisineDataModel{
    
    var cuisineId: Int?
    var cuisineName: String?
    var imageId: ImageURL?
    var imageOnlyID: Int?
    var isSelected: Bool?
    var status: Int?
    
    init(with dictResponse: [String:Any]){
        self.cuisineId = Int.getInt(dictResponse["cousin_id"])
        
            self.cuisineName = String.getString(dictResponse["name"])
        if let image = dictResponse["image_id"] as? [String:Any]{
            self.imageId = ImageURL.init(with: image)
        }
        self.isSelected = false
        self.status = Int.getInt(dictResponse["status"])
        self.imageOnlyID = Int.getInt(dictResponse["image_id"])
        }
}
