//
//  AdventureModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 13/09/21.
//

import Foundation

class AdventureModel {
    
    var success: Int?
    var data: [AdventureDatum]?

    init(with dictResponse: [String:Any]?) {
        self.success = Int.getInt(dictResponse?["success"])
        
        if let data = dictResponse?["data"] as? [[String:Any]]{
            self.data = data.map({AdventureDatum.init(with: $0)})
        }
    }
    
}

// MARK: - Datum
class AdventureDatum {
    
    var adventure_type_id:Int?
    var status, createdAt, updatedAt, adventure_type: String?
    
    init(with dictResponse: [String:Any]?) {
        self.adventure_type_id = Int.getInt(dictResponse?["adventure_type_id"])
        self.status = String.getString(dictResponse?["status"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        self.adventure_type = String.getString(dictResponse?["adventure_type"])
    }
    
    
}
