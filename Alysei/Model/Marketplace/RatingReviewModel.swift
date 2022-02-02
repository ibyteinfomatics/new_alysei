//
//  RatingReviewModel.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/6/21.
//

import Foundation

class RatingReviewModel {
    var marketplace_review_rating_id: Int?
    var user_id: Int?
    var id: Int?
    var rating: String?
    var review: String?
    var user: ReviewUserData?
    var created_at: String?

    
    init(with data: [String:Any]){
        self.marketplace_review_rating_id = Int.getInt(data["marketplace_review_rating_id"])
        self.user_id = Int.getInt(data["user_id"])
        self.id = Int.getInt(data["id"])
        self.rating = String.getString(data["rating"])
        self.review = String.getString(data["review"])
        self.created_at = String.getString(data["created_at"])
        if let userData = data["user"] as? [String:Any]{
            self.user = ReviewUserData.init(with: userData)
        }
    }
}

class ReviewUserData {
    var user_id: Int?
    var role_id: Int?
    var email: String?
    var company_name: String?
    var restaurant_name: String?
    var avatarId: AvatarId?
    var first_name: String?
    var last_name: String?
    
    init(with data: [String:Any]){
        self.user_id = Int.getInt(data["user_id"])
        self.email = String.getString(data["email"])
        self.company_name = String.getString(data["company_name"])
        self.role_id = Int.getInt(data["role_id"])
        self.restaurant_name = String.getString(data["restaurant_name"])
        self.first_name = String.getString(data["first_name"])
        self.last_name = String.getString(data["last_name"])
        if let avatarId = data["avatar_id"] as? [String:Any]{
            self.avatarId = AvatarId.init(with: avatarId)
        }
    }
}

class AvatarId{
    var attachment_url: String?
    var id: Int?
    var baseUrl : String?
    
    init(with data: [String:Any]){
        self.attachment_url = String.getString(data["attachment_url"])
        self.id = Int.getInt(data["id"])
        self.baseUrl = String.getString(data["base_url"])
    }
}
