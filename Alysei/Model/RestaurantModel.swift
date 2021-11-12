//
//  RestaurantModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 11/11/21.
//

import Foundation

class RestaurantModel {
    var success: Int?
    var data: [RestaurantUser]?

    init(with dictResponse: [String:Any]?) {
        
        //self.success = Int.getInt(dictResponse?["success"])
        
        if let data = dictResponse?["data"] as? [[String:Any]]{
            self.data = data.map({RestaurantUser.init(with: $0)})
        }
        
    }
}


class RestaurantUser {
    var userid: Int
    var name: String?
    var email: String
    var companyName: String?
    var restaurantName: String?
    var address: String?
    var roleid: Int?
    var avatarid: EventAttachment?

    init(with dictResponse: [String:Any]?) {
        
        self.name = String.getString(dictResponse?["name"])
        self.email = String.getString(dictResponse?["email"])
        self.companyName = String.getString(dictResponse?["company_name"])
        self.restaurantName = String.getString(dictResponse?["restaurant_name"])
        self.address = String.getString(dictResponse?["address"])
        self.userid = Int.getInt(dictResponse?["user_id"])
        self.roleid = Int.getInt(dictResponse?["role_id"])
        
        if let avatar_id = dictResponse?["avatar_id"] as? [String:Any]{
            self.avatarid =  EventAttachment.init(with: avatar_id)
        }
        
    }

   
}
