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
    var firstPageUrl: String?
    var lastPageUrl: String?
    var lastPage: Int?

    init(with dictResponse: [String:Any]?) {
        self.success = Int.getInt(dictResponse?["success"])
        
        if let data = dictResponse?["data"] as? [[String:Any]]{
            self.data = data.map({BlogDatum.init(with: $0)})
        }
        
        self.firstPageUrl = String.getString(dictResponse?["first_page_url"])
        self.lastPageUrl = String.getString(dictResponse?["last_page_url"])
        self.lastPage = Int.getInt(dictResponse?["last_page"])
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
    var baseUrl : String?
    var fimageUrl : String
    var attachmenThumbnailUrl: String?
    var attachmentLargeUrl: String?
    var attachmentMediumUrl: String?
   
    
    
    init(with dictResponse: [String:Any]?) {
        self.attachmentURL = String.getString(dictResponse?["attachment_url"])
        self.baseUrl = String.getString(dictResponse?["base_url"])
        self.attachmentType = String.getString(dictResponse?["attachment_type"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        self.id = Int.getInt(dictResponse?["id"])
        self.fimageUrl = (self.baseUrl ?? "") + (self.attachmentURL ?? "")
        self.attachmenThumbnailUrl = String.getString(dictResponse?["attachment_thumbnail_url"])
        self.attachmentLargeUrl = String.getString(dictResponse?["attachment_large_url"])
        self.attachmentMediumUrl = String.getString(dictResponse?["attachment_medium_url"])
        
        
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
    var firstName: String?
    var lastName:String?
    
    init(with dictResponse: [String:Any]?) {
        self.name = String.getString(dictResponse?["name"])
        self.email = String.getString(dictResponse?["email"])
        self.companyName = String.getString(dictResponse?["company_name"])
        self.restaurantName = String.getString(dictResponse?["restaurant_name"])
        self.userID = Int.getInt(dictResponse?["user_id"])
        self.roleID = Int.getInt(dictResponse?["role_id"])
        self.firstName = String.getString(dictResponse?["first_name"])
        self.lastName = String.getString(dictResponse?["last_name"])
        if let avatar_id = dictResponse?["avatar_id"] as? [String:Any]{
            self.avatarID =  Attachment.init(with: avatar_id)
        }
        
    }
    
    

   
}

