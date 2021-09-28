//
//  IntensityModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 13/09/21.
//

import Foundation

class IntensityModel {
    
    var success: Int?
    var data: [IntensityDatum]?

    init(with dictResponse: [String:Any]?) {
        self.success = Int.getInt(dictResponse?["success"])
        
        if let data = dictResponse?["data"] as? [[String:Any]]{
            self.data = data.map({IntensityDatum.init(with: $0)})
        }
    }
    
}

// MARK: - Datum
class IntensityDatum {
    
    var intensity_id:Int?
    var status, createdAt, updatedAt, intensity: String?
    
    init(with dictResponse: [String:Any]?) {
        self.intensity_id = Int.getInt(dictResponse?["intensity_id"])
        self.status = String.getString(dictResponse?["status"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        self.intensity = String.getString(dictResponse?["intensity"])
    }
    
    
}
