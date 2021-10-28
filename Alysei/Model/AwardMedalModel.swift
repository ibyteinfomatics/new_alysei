//
//  AwardMedalModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 27/10/21.
//

import Foundation
class AwardMedalModel {
    
    var success: Int?
    var data: [AwardMedalDatum]?

    init(with dictResponse: [String:Any]?) {
        self.success = Int.getInt(dictResponse?["success"])
        
        if let data = dictResponse?["data"] as? [[String:Any]]{
            self.data = data.map({AwardMedalDatum.init(with: $0)})
        }
    }
    
}

// MARK: - Datum
class AwardMedalDatum {
    
    var medal_id:Int?
    var name, createdAt, updatedAt: String?
    
    init(with dictResponse: [String:Any]?) {
        self.medal_id = Int.getInt(dictResponse?["medal_id"])
        self.name = String.getString(dictResponse?["name"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
    }
    
    
}
