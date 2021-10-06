//
//  MarketplaceOptionModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 10/5/21.
//

import Foundation

// MARK: - MarketplaceOptionModel
class MarketplaceOptionModel {
    var userFieldOptionid, userFieldid: Int?
    var option: String?
    var hint: String?
    var parent, head: Int?
    var createdAt, updatedAt: String?
    var name: String?
    var marketplace_product_category_id: Int?
    var marketplace_product_id: Int?
    
    init(with dictResponse: [String:Any]?) {
        
        self.option = String.getString(dictResponse?["option"])
        self.hint = String.getString(dictResponse?["hint"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.userFieldOptionid = Int.getInt(dictResponse?["user_field_option_id"])
        self.userFieldid = Int.getInt(dictResponse?["user_field_id"])
        self.parent = Int.getInt(dictResponse?["parent"])
        self.head = Int.getInt(dictResponse?["head"])
        
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        self.name = String.getString(dictResponse?["name"])
        self.marketplace_product_category_id = Int.getInt(dictResponse?["marketplace_product_category_id"])
        self.marketplace_product_id = Int.getInt(dictResponse?["marketplace_product_id"])
       
    }

    
}
