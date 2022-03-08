//
//  FaqModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 08/03/22.
//

import Foundation
class FaqModel {
    
    var success: Int?
    var data: [FaqData]?

    init(with dictResponse: [String:Any]?) {
        self.success = Int.getInt(dictResponse?["success"])
        
        if let data = dictResponse?["data"] as? [[String:Any]]{
            self.data = data.map({FaqData.init(with: $0)})
        }
        
    }
    
}

class FaqData {
    
    var ID: Int?
    var question, answer: String?
    var isExpand = true
    
    init(with dictResponse: [String:Any]?) {
        
        self.question = String.getString(dictResponse?["question"])
        self.answer = String.getString(dictResponse?["answer"])
        self.ID = Int.getInt(dictResponse?["id"])
        
    }
    
    
}
