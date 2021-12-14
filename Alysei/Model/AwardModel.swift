//
//  AwardModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 26/10/21.
//

import Foundation

// MARK: - AwardModel
class AwardModel {
    var success: Int?
    var data: [AwardDatum]?

    init(with dictResponse: [String:Any]?) {
        
        self.success = Int.getInt(dictResponse?["success"])
        
        if let data = dictResponse?["data"] as? [[String:Any]]{
            self.data = data.map({AwardDatum.init(with: $0)})
        }
        
    }
    
}

// MARK: - Datum
class AwardDatum {
    var awardid, userid: Int?
    var awardName, winningProduct, medalid, competitionurl: String?
    var imageid: Int?
    var status, deletedAt, createdAt, updatedAt: String?
    var user: AwardUser?
    var attachment: AwardAttachment?
    var medal: AwardMedal?

    
    
    init(with dictResponse: [String:Any]?) {
        
        self.awardid = Int.getInt(dictResponse?["award_id"])
        self.userid = Int.getInt(dictResponse?["user_id"])
        self.imageid = Int.getInt(dictResponse?["image_id"])
        
        self.awardName = String.getString(dictResponse?["award_name"])
        self.winningProduct = String.getString(dictResponse?["winning_product"])
        self.medalid = String.getString(dictResponse?["medal_id"])
        self.competitionurl = String.getString(dictResponse?["competition_url"])
        self.status = String.getString(dictResponse?["status"])
        self.deletedAt = String.getString(dictResponse?["deleted_at"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        
        if let attachment = dictResponse?["attachment"] as? [String:Any]{
            self.attachment =  AwardAttachment.init(with: attachment)
        }
        
        if let user = dictResponse?["user"] as? [String:Any]{
            self.user =  AwardUser.init(with: user)
        }
        
        if let medal = dictResponse?["medal"] as? [String:Any]{
            self.medal =  AwardMedal.init(with: medal)
        }
        
    }
}

// MARK: - Attachment
class AwardAttachment {
    var id: Int?
    var attachmenturl, baseUrl, attachmentType, height, width: String?
    var createdAt, updatedAt: String?

    init(with dictResponse: [String:Any]?) {
        self.attachmenturl = String.getString(dictResponse?["attachment_url"])
        self.baseUrl = String.getString(dictResponse?["base_url"])
        self.attachmentType = String.getString(dictResponse?["attachment_type"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        self.height = String.getString(dictResponse?["height"])
        self.width = String.getString(dictResponse?["width"])
        self.id = Int.getInt(dictResponse?["id"])
    }

    
}

// MARK: - User
class AwardUser {
    var userid: Int?
    var name: String?
    var email, companyName, restaurantName: String?
    var roleid: Int?
    var avatarid: AwardAttachment?
    
    init(with dictResponse: [String:Any]?) {
        
        self.userid = Int.getInt(dictResponse?["user_id"])
        self.roleid = Int.getInt(dictResponse?["role_id"])
        
        self.name = String.getString(dictResponse?["name"])
        self.email = String.getString(dictResponse?["email"])
        self.companyName = String.getString(dictResponse?["company_name"])
        self.restaurantName = String.getString(dictResponse?["restaurant_name"])
        
        if let attachment = dictResponse?["avatar_id"] as? [String:Any]{
            self.avatarid =  AwardAttachment.init(with: attachment)
        }
        
    }
    
    
}

class AwardMedal {
    
    var medal_id:Int?
    var name, createdAt, updatedAt: String?
    
    init(with dictResponse: [String:Any]?) {
        self.medal_id = Int.getInt(dictResponse?["medal_id"])
        self.name = String.getString(dictResponse?["name"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
    }
    
    
}
