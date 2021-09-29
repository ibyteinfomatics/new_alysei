
//
//  ConnectionAPI.swift
//  Alysei
//
//  Created by Gitesh Dang on 24/08/21.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let connectionAPI = try? newJSONDecoder().decode(ConnectionAPI.self, from: jsonData)

import Foundation

// MARK: - ConnectionAPI
class ConnectionTabModel {
  
    var data: [Datum]?

    
    init(with data: [String:Any]?) {
        if let data = data?["data"] as? [[String:Any]]{
            self.data = data.map({Datum.init(with: $0)})
        }
    }
    
}

// MARK: - Datum
class Datum {
    var connectionID, resourceID, userID: Int?
    var reasonToConnect, isApproved: String?
    var productIDS: String?
    var createdAt, updatedAt: String?
    var user: User?
    
    init(with dictResponse:  [String:Any]?) {
        self.connectionID = Int.getInt(dictResponse?["connection_id"])
        self.resourceID = Int.getInt(dictResponse?["resource_id"])
        self.userID = Int.getInt(dictResponse?["user_id"])
        self.reasonToConnect = String.getString(dictResponse?["reason_to_connect"])
        self.isApproved = String.getString(dictResponse?["is_approved"])
        self.productIDS = String.getString(dictResponse?["product_ids"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        
        if dictResponse?["user"] == nil {
            if let userData = dictResponse?["followed_by"] as? [String:Any]{
                self.user = User.init(with: userData)
            }
        } else {
            if let userData = dictResponse?["user"] as? [String:Any]{
                self.user = User.init(with: userData)
            }
        }
        
    }
    
}



// MARK: - User
class User {
    var userID: Int
    var name: String
    var email, companyName,firstname,lastname: String
    var restaurantName: String
    var roleID: Int
    var avatarID: AvatarID?

    init(with dictResponse:  [String:Any]?) {
        self.userID = Int.getInt(dictResponse?["user_id"])
        self.name = String.getString(dictResponse?["name"])
        self.email = String.getString(dictResponse?["email"])
        self.firstname = String.getString(dictResponse?["first_name"])
        self.lastname = String.getString(dictResponse?["last_name"])
        self.companyName = String.getString(dictResponse?["company_name"])
        self.restaurantName = String.getString(dictResponse?["restaurant_name"])
        self.roleID = Int.getInt(dictResponse?["role_id"])
        
        if let userData = dictResponse?["avatar_id"] as? [String:Any]{
            self.avatarID = AvatarID.init(with: userData)
        }
        
    }
    
}

// MARK: - AvatarID
class AvatarID {
    var id: Int
    var attachmentURL, attachmentType, createdAt, updatedAt: String

 
    init(with dictResponse:  [String:Any]?) {
        self.id = Int.getInt(dictResponse?["id"])
        self.attachmentURL = String.getString(dictResponse?["attachment_url"])
        self.attachmentType = String.getString(dictResponse?["attachment_type"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
    }
    
}

