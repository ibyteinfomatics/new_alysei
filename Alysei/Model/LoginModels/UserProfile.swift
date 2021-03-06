//
//  UserProfile.swift
//  Alysei
//
//  Created by Janu Gandhi on 01/04/21.
//

import Foundation


enum UserProfile {
    struct profileTopSectionModel: Codable {
        var data: data?
        var success: Int?
    }

    struct data: Codable {
        var about: String?
        var postCount: Int?
        var followerCount: Int?
        var followingcount: Int?
        var connectionCount: Int?
        var userData: userDataModel?
        var contactTab: contactTab?
        var aboutTab: [aboutTab]?

        private enum CodingKeys: String, CodingKey {
            case about
            case postCount = "post_count"
            case userData = "user_data"
            case connectionCount = "connection_count"
            case followerCount = "follower_count"
            case followingcount = "following_count"
            case contactTab = "contact_tab"
            case aboutTab = "about_tab"
        }
    }
    
    struct userDataModel: Codable {
        var avatar: avatar?
        var cover: cover?
        var userID: Int?
        var companyName: String?
        var username: String?
        var roleID: Int?
        var firstName: String?
        var lastName: String?
        var restaurantName: String?
        var profileColor: String?
        var profilePercentage: Int?
        var followFlag: Int?
        var connectionFlag: Int?
        var availableToFollow: Int?
        var availableToConnect: Int?
        var whoCanViewProfile: String?
        var blockFlag: Int?
        
         private enum CodingKeys: String, CodingKey {
            case avatar = "avatar_id"
            case cover = "cover_id"
            case userID = "user_id"
            case companyName = "company_name"
            case restaurantName = "restaurant_name"
            case username
            case roleID = "role_id"
            case firstName = "first_name"
            case lastName = "last_name"
            case profilePercentage = "profile_percentage"
            case followFlag = "follow_flag"
            case whoCanViewProfile = "who_can_view_profile"
            case availableToFollow = "available_to_follow"
            case availableToConnect = "available_to_connect"
            case connectionFlag = "connection_flag"
            case blockFlag = "block_flag"
            case profileColor = "profile_color"
         }
    }


    struct contactTab: Codable {
        var website: String?
        var address: String?
        var email: String?
        var country_code: String?
        var phone: String?
        var roleID: Int?
        var userID: Int?
        var fbLink: String?

        private enum CodingKeys: String, CodingKey {
            case website
            case address
            case email
            case phone
            case country_code
            case roleID = "role_id"
            case userID = "user_id"
            case fbLink = "fb_link"
        }
    }

    struct aboutTab: Codable {
        var title: String
        var type: String
        var value: String
    }


    typealias avatar = imageAttachementModel
    typealias cover = imageAttachementModel

    struct imageAttachementModel: Codable {
        var id: Int?
        var imageURL: String?
        var base_url:String?

        private enum CodingKeys: String, CodingKey {
            case id
            case imageURL = "attachment_url"
            case base_url
        }

    }
}
//
//struct ProductCategoriesDataModel {
//
//}
