//
//  SelectCourseDataModel.swift
//  Alysei
//
//  Created by namrata upadhyay on 17/08/21.
//

import Foundation

class SelectCourseDataModel{
    
    var recipeCourseId: Int?
    var courseName: String?
    var imageId : ImageURL?
    var imageOnlyId: Int?
    init(with dictResponse: [String:Any]){
        self.recipeCourseId = Int.getInt(dictResponse["recipe_course_id"])
        
            self.courseName = String.getString(dictResponse["name"])
        if let image = dictResponse["image_id"] as? [String:Any]{
            self.imageId = ImageURL.init(with: image)
        }
        self.imageOnlyId = Int.getInt(dictResponse["image_id"])
        }
}
