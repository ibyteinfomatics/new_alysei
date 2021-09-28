//
//  BlogModel.swift
//  Alysei
//
//  Created by Jai on 02/09/21.
//

import Foundation

// MARK: - BlogModel
class BlogModel {
    
    var success: Int?
    var data: [BlogDatum]?

    init(with dictResponse: [String:Any]?) {
        self.success = Int.getInt(dictResponse?["success"])
        
        if let data = dictResponse?["data"] as? [[String:Any]]{
            self.data = data.map({BlogDatum.init(with: $0)})
        }
    }
    
}

// MARK: - Datum
class BlogDatum {
    
    var blogID, userID: Int?
    var title, date, time, datumDescription: String?
    var imageID: Int?
    var status, createdAt, updatedAt: String?
    var user: BlogUser?
    var attachment: Attachment?
    
    init(with dictResponse: [String:Any]?) {
        
        self.title = String.getString(dictResponse?["title"])
        self.date = String.getString(dictResponse?["date"])
        self.time = String.getString(dictResponse?["time"])
        self.datumDescription = String.getString(dictResponse?["description"])
        self.status = String.getString(dictResponse?["status"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        self.blogID = Int.getInt(dictResponse?["blog_id"])
        self.userID = Int.getInt(dictResponse?["user_id"])
        self.imageID = Int.getInt(dictResponse?["image_id"])
        
        if let user = dictResponse?["user"] as? [String:Any]{
            self.user =  BlogUser.init(with: user)
        }
        
        if let attachment = dictResponse?["attachment"] as? [String:Any]{
            self.attachment =  Attachment.init(with: attachment)
        }
        
        
    }
    
    
}

// MARK: - Attachment
class Attachment {
    var id: Int?
    var attachmentURL, attachmentType, createdAt, updatedAt: String?
    
    
    init(with dictResponse: [String:Any]?) {
        self.attachmentURL = String.getString(dictResponse?["attachment_url"])
        self.attachmentType = String.getString(dictResponse?["attachment_type"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        self.id = Int.getInt(dictResponse?["id"])
        
    }
    
    
}

// MARK: - User
class BlogUser {
    
    var userID: Int?
    var name: String?
    var email, companyName: String?
    var restaurantName: String?
    var roleID: Int?
    var avatarID: Attachment?
    
    
    init(with dictResponse: [String:Any]?) {
        self.name = String.getString(dictResponse?["name"])
        self.email = String.getString(dictResponse?["email"])
        self.companyName = String.getString(dictResponse?["company_name"])
        self.restaurantName = String.getString(dictResponse?["restaurant_name"])
        self.userID = Int.getInt(dictResponse?["user_id"])
        self.roleID = Int.getInt(dictResponse?["role_id"])
        
        if let avatar_id = dictResponse?["avatar_id"] as? [String:Any]{
            self.avatarID =  Attachment.init(with: avatar_id)
        }
        
    }
    
    

   
}

