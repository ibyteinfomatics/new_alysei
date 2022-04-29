//
//  NewFeedModel.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/4/21.
//

import Foundation

class NewFeedSearchModel{
    var currentPage: Int?
    var data: [NewFeedSearchDataModel]?
    var importerSeacrhData : [SubjectData]?
   // var discover_alysei : [NewDiscoverDataModel]?
    var firstPageUrl: String?
    var lastPageUrl: String?
    var lastPage: Int?
    
    init(with dictResponse: [String:Any]){
        self.currentPage = Int.getInt(dictResponse["current_page"])
        if let data = dictResponse["data"] as? [[String:Any]]{
            self.data = data.map({NewFeedSearchDataModel.init(with: $0)})
        }
        if let data = dictResponse["data"] as? [[String:Any]]{
            self.importerSeacrhData = data.map({SubjectData.init(with: $0)})
        }
//        if let discover_alysei = dictResponse["discover_alysei"] as? [[String:Any]]{
//            self.discover_alysei = discover_alysei.map({NewDiscoverDataModel.init(with: $0)})
//        }
        self.firstPageUrl = String.getString(dictResponse["first_page_url"])
        self.lastPageUrl = String.getString(dictResponse["last_page_url"])
        self.lastPage = Int.getInt(dictResponse["last_page"])
    }
}

class NewDiscoverDataModel{
    
    var title: String?
    var discover_alysei_id: Int?
    var image_id: Int?
    var description: String?
    var status: String?
    var name: String?
    var image: AttachmentLink?
    
    init(with dictResponse: [String:Any]){
        
        self.title = String.getString(dictResponse["title"])
        self.discover_alysei_id = Int.getInt(dictResponse["discover_alysei_id"])
        self.image_id = Int.getInt(dictResponse["image_id"])
        self.description = String.getString(dictResponse["description"])
        self.status = String.getString(dictResponse["status"])
        self.name = String.getString(dictResponse["name"])
       
        if let image = dictResponse["attachment"] as? [String:Any]{
            self.image = AttachmentLink.init(with: image)
        }
        
    }
    
}

class NewFeedSearchDataModel{
    var activityActionId: Int?
    var subjectId: SubjectData?
    var body: String?
    //var shared_post_id:
    var postID: Int?
    var attachmentCount: Int?
    var commentCount: Int?
    var follower_count: Int?
    var likeCount: Int?
    var privacy: String?
    var likeFlag: Int?
    var posted_at: String?
    var attachments: [Attachments]?
    var title: String?
    var image: AttachmentLink?
    var country: CountryModel?
    var state: CountryModel?
    var id: Int?
    var shared_post_id: Int?
    var sharedPostData: SharedPostData?
    var isExpand = false
  
    
    init(with dictResponse: [String:Any]){
        self.activityActionId = Int.getInt(dictResponse["activity_action_id"])
        if let subjectId = dictResponse["subject_id"] as? [String:Any]{
            self.subjectId = SubjectData.init(with: subjectId)
        }
        self.body = String.getString(dictResponse["body"])
        self.attachmentCount = Int.getInt(dictResponse["attachment_count"])
        self.commentCount = Int.getInt(dictResponse["comment_count"])
        self.follower_count = Int.getInt(dictResponse["follower_count"])
        self.likeCount = Int.getInt(dictResponse["like_count"])
        self.privacy = String.getString(dictResponse["privacy"])
        self.id = Int.getInt(dictResponse["id"])
        self.likeFlag = Int.getInt(dictResponse["like_flag"])
        self.posted_at = String.getString(dictResponse["posted_at"])
        self.postID = Int.getInt(dictResponse["activity_action_id"])
        if let attachments = dictResponse["attachments"] as? [[String:Any]]{
            self.attachments = attachments.map({Attachments.init(with: $0)})
        }
        self.title = String.getString(dictResponse["title"])
        if let image = dictResponse["image"] as? [String:Any]{
            self.image = AttachmentLink.init(with: image)
        }
        if let country = dictResponse["country"] as? [String:Any]{
            self.country = CountryModel.init(data: country)
        }
        
        if let state = dictResponse["state"] as? [String:Any]{
            self.state = CountryModel.init(data: state)
        }
        if let sharePostData = dictResponse["shared_post"] as? [String:Any]{
            self.sharedPostData = SharedPostData.init(with: sharePostData)
        }
        self.shared_post_id = Int.getInt(dictResponse["shared_post_id"])
//        if let sharedPostDict = dictResponse["shared_post"] {
//            do {
//                let data = try JSONSerialization.data(withJSONObject: sharedPostDict, options: .prettyPrinted)
//                print(data)
//
//                let jsonData = try JSONDecoder().decode(SharedPostData.self, from: data)
//                self.sharedPostData = jsonData
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
    }



    init(_ data: PostList.innerData) {
        self.body = data.body
        self.subjectId = data.subjectData
        self.attachmentCount = data.attachmentCount
        self.attachments = data.attachments
    }
}

class SubjectData: Codable {

    var userId: Int?
    var name: String?
    var email: String?
    var roleId: Int?
    var companyName: String?
    var restaurantName: String?
    var avatarId: Avatar?
    var firstName: String?
    var lastName: String?
    var follower_count : Int?
   

    init(with dictResponse: [String:Any]){
        self.userId = Int.getInt(dictResponse["user_id"])
        self.name = String.getString(dictResponse["name"])
        self.email = String.getString(dictResponse["email"])
        self.roleId = Int.getInt(dictResponse["role_id"])
        self.companyName = String.getString(dictResponse["company_name"])
        self.restaurantName = String.getString(dictResponse["restaurant_name"])
        if let avatar = dictResponse["avatar_id"] as? [String:Any]{
            self.avatarId = Avatar.init(with: avatar)
        }
        
        self.follower_count = Int.getInt(dictResponse["follower_count"])
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

class Avatar: Codable {
    var id: Int?
    var attachmentUrl: String?
    var baseUrl: String?
    
    init(with dictResponse: [String:Any]){
        self.id = Int.getInt(dictResponse["id"])
        self.attachmentUrl = String.getString(dictResponse["attachment_url"])
        self.baseUrl = String.getString(dictResponse["base_url"])
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case attachmentUrl = "attachment_url"
    }
}
class Attachments: Codable{
    var activityAttachmentId: Int?
    var attachmentLink: AttachmentLink?
    init(with dictResponse: [String:Any]){
        self.activityAttachmentId = Int.getInt(dictResponse["activity_attachment_id"])
        if let attachment_link = dictResponse["attachment_link"] as? [String:Any]{
            self.attachmentLink = AttachmentLink.init(with: attachment_link)
        }
    }

    private enum CodingKeys: String, CodingKey {
        case activityAttachmentId = "activity_attachment_id"
        case attachmentLink = "attachment_link"
    }
}

class AttachmentLink: Codable {
    var attachmentUrl: String?
    var baseUrl : String?
    var height: Int?
    var width: Int?
    var attachmenThumbnailUrl: String?
    var attachmentLargeUrl: String?
    var attachmentMediumUrl: String?
    
    init(with dictResponse: [String:Any]){
        self.attachmentUrl = String.getString(dictResponse["attachment_url"])
        self.baseUrl = String.getString(dictResponse["base_url"])
        self.height = Int.getInt(dictResponse["height"])
        self.width = Int.getInt(dictResponse["width"])
        self.attachmenThumbnailUrl = String.getString(dictResponse["attachment_thumbnail_url"])
        self.attachmentLargeUrl = String.getString(dictResponse["attachment_large_url"])
        self.attachmentMediumUrl = String.getString(dictResponse["attachment_medium_url"])
    }

    private enum CodingKeys: String, CodingKey {
        case attachmentUrl = "attachment_url"
        case height = "height"
        case width = "width"
    }
}

class SharedPostData: Codable {
    var activityActionId: Int?
    var subjectId: SubjectData?
    var body: String?
    
    var shared_post_id:Int?

//    var postID: Int?
    var attachmentCount: Int?
    var commentCount: Int?
    var likeCount: Int?
    var privacy: String?
//    var likeFlag: Int?
//    var posted_at: String?
    var attachments: [Attachments]?
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
            self.subjectId = SubjectData.init(with: subjectId)
        }
        if let attachment = data?["attachments"] as? [[String:Any]]{
            self.attachments = attachment.map({Attachments.init(with: $0)})
                //Attachments.init(with: attachment)
        }
    }
}
