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
            
    
    init(with dictResponse: [String:Any]){
        self.recipeCourseId = Int.getInt(dictResponse["recipe_course_id"])
        
            self.courseName = String.getString(dictResponse["name"])
        }
}
