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
    var firstPageUrl: String?
    var lastPageUrl: String?
    var lastPage: Int?

    init(with dictResponse: [String:Any]?) {
        
        //self.success = Int.getInt(dictResponse?["success"])
        
        if let data = dictResponse?["data"] as? [[String:Any]]{
            self.data = data.map({RestaurantUser.init(with: $0)})
        }
        
        self.firstPageUrl = String.getString(dictResponse?["first_page_url"])
        self.lastPageUrl = String.getString(dictResponse?["last_page_url"])
        self.lastPage = Int.getInt(dictResponse?["last_page"])
        
    }
}


class RestaurantUser {
    var userid: Int
    var name: String?
    var email: String
    var companyName: String?
    var restaurantName: String?
    var lattitude: String?
    var longitude: String?
    var address: String?
    var restaurant_type: String?
    var roleid: Int?
    var avatarid: EventAttachment?

    init(with dictResponse: [String:Any]?) {
        
        self.name = String.getString(dictResponse?["name"])
        self.email = String.getString(dictResponse?["email"])
        self.restaurant_type = String.getString(dictResponse?["restaurant_type"])
        self.companyName = String.getString(dictResponse?["company_name"])
        self.restaurantName = String.getString(dictResponse?["restaurant_name"])
        self.address = String.getString(dictResponse?["address"])
        self.userid = Int.getInt(dictResponse?["user_id"])
        self.roleid = Int.getInt(dictResponse?["role_id"])
        
        self.lattitude = String.getString(dictResponse?["lattitude"])
        self.longitude = String.getString(dictResponse?["longitude"])
        
        if let avatar_id = dictResponse?["avatar_id"] as? [String:Any]{
            self.avatarid =  EventAttachment.init(with: avatar_id)
        }
        
    }

   
}
