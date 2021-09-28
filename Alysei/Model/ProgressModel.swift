//
//  ProgressModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 26/08/21.
//


import Foundation

// MARK: - ProgressModel
class ProgressModel {
    
    var success: Int?
    var data: DataClass?
    var alyseiProgress: [AlyseiProgress]?

    init(with dictResponse: [String:Any]?) {
        self.success = Int.getInt(dictResponse?["success"])
        
        if let data = dictResponse?["data"] as? [String:Any]{
            self.data =  DataClass.init(with: data)
        }
        
        if let alysei_progress = dictResponse?["alysei_progress"] as? [[String:Any]]{
            self.alyseiProgress = alysei_progress.map({AlyseiProgress.init(with: $0)})
        }
    }
    
}

// MARK: - AlyseiProgress
class AlyseiProgress {
    
    var title: String?
    var status: Bool?
    var alyseiProgressDescription: String?

    init(with dictResponse:  [String:Any]?) {
        self.title = String.getString(dictResponse?["title"])
        self.status = Bool.getBool(dictResponse?["status"])
        self.alyseiProgressDescription = String.getString(dictResponse?["description"])
    }
}

// MARK: - DataClass
class DataClass {
    var userId: Int?
    var email: String?
    var roleId: Int?
    var alyseiReview, alyseiCertification, alyseiRecognition, alyseiQualitymark: String?

    init(with dictResponse:  [String:Any]?) {
        self.userId = Int.getInt(dictResponse?["user_id"])
        self.email = String.getString(dictResponse?["email"])
        self.roleId = Int.getInt(dictResponse?["role_id"])
        self.alyseiReview = String.getString(dictResponse?["alysei_review"])
        self.alyseiCertification = String.getString(dictResponse?["alysei_certification"])
        self.alyseiRecognition = String.getString(dictResponse?["alysei_recognition"])
        self.alyseiQualitymark = String.getString(dictResponse?["alysei_qualitymark"])
    }
}
