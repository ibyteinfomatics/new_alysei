//
//  ProfileCompletionModel.swift
//  Alysei
//
//  Created by SHALINI YADAV on 4/20/21.
//

import Foundation

class ProfileCompletionModel {
    var title : String?
    var status: Bool?
    var isSelected: Bool?
    var user_field_id: Int?
    var description: String?
    
    init(with data: [String:Any]) {
        self.title = String.getString(data["title"])
        self.status = Int.getInt(data["status"]) == 0 ? false: true
        self.user_field_id = Int.getInt(data["user_field_id"])
        self.description = String.getString(data["description"])
    }
}
