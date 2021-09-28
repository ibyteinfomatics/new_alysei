//
//  SelectRegionDataModel.swift
//  Alysei
//
//  Created by namrata upadhyay on 18/08/21.
//

import Foundation

class SelectRegionDataModel{
    var regionId: Int?
    var cousinId: Int?
    var regionName: String?
    var regionImage: ImageURL?
    var imageOnlyId: Int?
    
    init(with dictResponse: [String:Any]){
        self.regionId = Int.getInt(dictResponse["recipe_region_id"])
        self.cousinId = Int.getInt(dictResponse["cousin_id"])
            self.regionName = String.getString(dictResponse["name"])
        if let image = dictResponse["image_id"] as? [String:Any]{
            self.regionImage = ImageURL.init(with: image)
        }
        self.imageOnlyId = Int.getInt(dictResponse["image_id"])
        }
               
}
