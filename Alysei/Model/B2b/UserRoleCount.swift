//
//  UserRoleCount.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/25/21.
//

import Foundation

class UserRoleCount {
    var role_id: Int?
    var name: String?
    var slug: String?
    var userCount: Int?
    var image:String?
    
    init(with data: [String:Any]) {
        self.role_id = Int.getInt(data["role_id"])
        self.name = String.getString(data["name"])
        self.slug = String.getString(data["slug"])
        self.image = String.getString(data["image"])
        self.userCount = Int.getInt(data["user_count"])
    }
}
