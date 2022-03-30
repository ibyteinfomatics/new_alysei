//
//  BlockModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 05/10/21.
//

import Foundation

// MARK: - BlockModel
class BlockModel {
    var success, blockCountUser: Int?
    var data: [BlockDatum]?

        
    init(with dictResponse: [String:Any]?) {
        
        self.success = Int.getInt(dictResponse?["success"])
        self.blockCountUser = Int.getInt(dictResponse?["block_count_user"])
        
        if let data = dictResponse?["data"] as? [[String:Any]]{
            self.data = data.map({BlockDatum.init(with: $0)})
        }
        
    }
    
}

// MARK: - Datum
class BlockDatum {
    var blockListid, userid, blockUserid: Int?
    var createdAt, updatedAt: String?
    var user, blockuser: BlockUser?
    
    init(with dictResponse: [String:Any]?) {
        
        self.blockListid = Int.getInt(dictResponse?["block_list_id"])
        self.userid = Int.getInt(dictResponse?["user_id"])
        self.blockUserid = Int.getInt(dictResponse?["block_user_id"])
        
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        
        if let data = dictResponse?["user"] as? [String:Any]{
            self.user =  BlockUser.init(with: data)
        }
        
        if let data = dictResponse?["blockuser"] as? [String:Any]{
            self.blockuser =  BlockUser.init(with: data)
        }
        
    }

   
}

// MARK: - User
class BlockUser {
    var userid: Int?
    var name: String?
    var email, companyName: String?
    var restaurantName: String?
    var roleid: Int?
    var avatarid: BlockAvatarid?
    
    init(with dictResponse: [String:Any]?) {
        
        self.userid = Int.getInt(dictResponse?["user_id"])
        self.roleid = Int.getInt(dictResponse?["role_id"])
        
        self.email = String.getString(dictResponse?["email"])
        self.companyName = String.getString(dictResponse?["company_name"])
        self.restaurantName = String.getString(dictResponse?["restaurant_name"])
        
        if let data = dictResponse?["avatar_id"] as? [String:Any]{
            self.avatarid =  BlockAvatarid.init(with: data)
        }
        
    }

    
}

// MARK: - Avatarid
class BlockAvatarid {
    var id: Int?
    var attachmenturl, attachmentType: String?
    var height, width: Int?
    var createdAt, updatedAt: String?
    var baseUrl: String?
    init(with dictResponse: [String:Any]?) {
        self.id = Int.getInt(dictResponse?["id"])
        self.height = Int.getInt(dictResponse?["height"])
        self.width = Int.getInt(dictResponse?["width"])
        
        self.attachmenturl = String.getString(dictResponse?["attachment_url"])
        self.baseUrl = String.getString(dictResponse?["base_url"])
        self.attachmentType = String.getString(dictResponse?["attachment_type"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        
    }

}

