//
//  PrivacyModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 20/10/21.
//

import Foundation

class PrivacyModel {
    var roles: [RolesData]?
    var privacyData: PrivacyData?
    var emailPreference : EmailPreference?
    
    init(with data: [String:Any]){
        if let data = data["roles"] as? [[String:Any]]{
            self.roles = data.map({RolesData.init(with: $0)})
        }
        if let data = data["privacy_data"] as? [String:Any]{
            self.privacyData = PrivacyData.init(with: data)
        }
        if let data = data["email_preference"] as? [String:Any]{
            self.emailPreference = EmailPreference.init(with: data)
        }
    }
}

class RolesData {
    var roleId: Int?
    var name: String?
    var slug: String?
    
    
    init(with data: [String:Any]){
        self.roleId = Int.getInt(data["role_id"])
        self.name = String.getString(data["name"])
        self.slug = String.getString(data["slug"])
    }
}
class PrivacyData {
    var user_id: Int?
    var allow_message_from: String?
    var who_can_view_age: String?
    var who_can_view_profile: String?
    var who_can_connect: String?
    init(with data: [String:Any]){
        self.user_id = Int.getInt(data["user_id"])
        self.allow_message_from = String.getString(data["allow_message_from"])
        self.who_can_view_age = String.getString(data["who_can_view_age"])
        self.who_can_view_profile = String.getString(data["who_can_view_profile"])
        self.who_can_connect = String.getString(data["who_can_connect"])
    }
}
class EmailPreference {
    var user_id: Int?
    var private_messages: String?
    var when_someone_request_to_follow: String?
    var weekly_updates: String?
   
    init(with data: [String:Any]){
        self.user_id = Int.getInt(data["user_id"])
        self.private_messages = String.getString(data["private_messages"])
        self.when_someone_request_to_follow = String.getString(data["when_someone_request_to_follow"])
        self.weekly_updates = String.getString(data["weekly_updates"])
       
    }
}
