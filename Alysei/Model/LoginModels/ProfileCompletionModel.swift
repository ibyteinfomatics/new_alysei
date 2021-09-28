//
//  ProfileCompletionModel.swift
//  Alysei
//
//  Created by SHALINI YADAV on 4/20/21.
//

import Foundation

class ProfileCompletionModel {
    var title : String?
    var status: Bool?
    var isSelected: Bool?
    
    init(with data: [String:Any]) {
        self.title = String.getString(data["title"])
        self.status = Int.getInt(data["status"]) == 0 ? false: true
    }
}
