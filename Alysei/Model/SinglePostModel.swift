//
//  SinglePostModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 30/10/21.
//

import Foundation

class SinglePostModel{
    var currentPage: Int?
    var data: SinglePostDataModel?
    var firstPageUrl: String?
    var lastPageUrl: String?
    var lastPage: Int?
    
    init(with dictResponse: [String:Any]){
        
        if let data = dictResponse["data"] as? [String:Any]{
            self.data = SinglePostDataModel.init(with: data)
        }
        
    }
}

class SinglePostDataModel{
    var activityActionId: Int?
    var subjectId: SinglePostData?
    var body: String?
    //var shared_post_id:
    var postID: Int?
    var attachmentCount: Int?
    var commentCount: Int?
    var likeCount: Int?
    var privacy: String?
    var likeFlag: Int?
    var posted_at: String?
    var attachments: [SinglePostAttachments]?
    var title: String?
    var image: SinglePostAttachmentLink?
    var id: Int?
    var shared_post_id: Int?
    var sharedPostData: SinglePostSharedPostData?
    var isExpand = false
    
    init(with dictResponse: [String:Any]){
        self.activityActionId = Int.getInt(dictResponse["activity_action_id"])
        if let subjectId = dictResponse["subject_id"] as? [String:Any]{
            self.subjectId = SinglePostData.init(with: subjectId)
        }
        self.body = String.getString(dictResponse["body"])
        self.attachmentCount = Int.getInt(dictResponse["attachment_count"])
        self.commentCount = Int.getInt(dictResponse["comment_count"])
        self.likeCount = Int.getInt(dictResponse["like_count"])
        self.privacy = String.getString(dictResponse["privacy"])
        self.id = Int.getInt(dictResponse["id"])
        self.likeFlag = Int.getInt(dictResponse["like_flag"])
        self.posted_at = String.getString(dictResponse["posted_at"])
        self.postID = Int.getInt(dictResponse["activity_action_id"])
        
        if let attachments = dictResponse["attachments"] as? [[String:Any]]{
            self.attachments = attachments.map({SinglePostAttachments.init(with: $0)})
        }
        self.title = String.getString(dictResponse["title"])
        if let image = dictResponse["image"] as? [String:Any]{
            self.image = SinglePostAttachmentLink.init(with: image)
        }
        
        if let sharePostData = dictResponse["shared_post"] as? [String:Any]{
            self.sharedPostData = SinglePostSharedPostData.init(with: sharePostData)
        }
        self.shared_post_id = Int.getInt(dictResponse["shared_post_id"])

    }
}

class SinglePostData: Codable {

    var userId: Int?
    var name: String?
    var email: String?
    var roleId: Int?
    var companyName: String?
    var restaurantName: String?
    var avatarId: SinglePostAvatar?
    var firstName: String?
    var lastName: String?

    init(with dictResponse: [String:Any]){
        self.userId = Int.getInt(dictResponse["user_id"])
        self.name = String.getString(dictResponse["name"])
        self.email = String.getString(dictResponse["email"])
        self.roleId = Int.getInt(dictResponse["role_id"])
        self.companyName = String.getString(dictResponse["company_name"])
        self.restaurantName = String.getString(dictResponse["restaurant_name"])
        if let avatar = dictResponse["avatar_id"] as? [String:Any]{
            self.avatarId = SinglePostAvatar.init(with: avatar)
        }
        self.firstName = String.getString(dictResponse[APIConstants.kFirstName])
        self.lastName = String.getString(dictResponse[APIConstants.kLastName])
    }


    private enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name
        case email
        case roleId = "role_id"
        case companyName = "company_name"
        case restaurantName = "restaurant_name"
        case avatarId = "avatar_id"
    }

    
}

class SinglePostAvatar: Codable {
    var id: Int?
    var attachmentUrl: String?
    
    init(with dictResponse: [String:Any]){
        self.id = Int.getInt(dictResponse["id"])
        self.attachmentUrl = String.getString(dictResponse["attachment_url"])
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case attachmentUrl = "attachment_url"
    }
}
class SinglePostAttachments: Codable{
    var activityAttachmentId: Int?
    var attachmentLink: SinglePostAttachmentLink?
    init(with dictResponse: [String:Any]){
        self.activityAttachmentId = Int.getInt(dictResponse["activity_attachment_id"])
        if let attachment_link = dictResponse["attachment_link"] as? [String:Any]{
            self.attachmentLink = SinglePostAttachmentLink.init(with: attachment_link)
        }
    }

    private enum CodingKeys: String, CodingKey {
        case activityAttachmentId = "activity_attachment_id"
        case attachmentLink = "attachment_link"
    }
}

class SinglePostAttachmentLink: Codable {
    var attachmentUrl: String?
    var height: Int?
    var width: Int?
    
    init(with dictResponse: [String:Any]){
        self.attachmentUrl = String.getString(dictResponse["attachment_url"])
        self.height = Int.getInt(dictResponse["height"])
        self.width = Int.getInt(dictResponse["width"])
    }

    private enum CodingKeys: String, CodingKey {
        case attachmentUrl = "attachment_url"
        case height = "height"
        case width = "width"
    }
}

class SinglePostSharedPostData: Codable {
    var activityActionId: Int?
    var subjectId: SinglePostData?
    var body: String?
    
    var shared_post_id:Int?

//    var postID: Int?
    var attachmentCount: Int?
    var commentCount: Int?
    var likeCount: Int?
    var privacy: String?
//    var likeFlag: Int?
//    var posted_at: String?
    var attachments: [SinglePostAttachments]?
//    var title: String?
//    var image: AttachmentLink?

//    var country: CountryModel?
//    var state: CountryModel?


//    var id: Int?
    
    init(with data: [String:Any]?){
        self.body = data?["body"] as? String
        self.shared_post_id = data?["shared_post_id"] as? Int
        self.attachmentCount = data?["attachment_count"] as? Int
        self.commentCount = data?["comment_count"] as? Int
        self.likeCount = data?["like_count"] as? Int
        self.privacy = data?["privacy"] as? String
        self.activityActionId = data?["activity_action_id"] as? Int
        
        if let subjectId = data?["subject_id"] as? [String:Any]{
            self.subjectId = SinglePostData.init(with: subjectId)
        }
        if let attachment = data?["attachments"] as? [[String:Any]]{
            self.attachments = attachment.map({SinglePostAttachments.init(with: $0)})
                //Attachments.init(with: attachment)
        }
    }
}
