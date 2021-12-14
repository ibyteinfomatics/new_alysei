//
//  EventModel.swift
//  Alysei
//
//  Created by Jai on 02/09/21.
//

import Foundation
// MARK: - EventModel
class EventModel {
    var success: Int?
    var data: [EventDatum]?
    var firstPageUrl: String?
    var lastPageUrl: String?
    var lastPage: Int?

    init(with dictResponse: [String:Any]?) {
        
        self.success = Int.getInt(dictResponse?["success"])
        
        if let data = dictResponse?["data"] as? [[String:Any]]{
            self.data = data.map({EventDatum.init(with: $0)})
        }
        self.firstPageUrl = String.getString(dictResponse?["first_page_url"])
        self.lastPageUrl = String.getString(dictResponse?["last_page_url"])
        self.lastPage = Int.getInt(dictResponse?["last_page"])
        
    }
}

// MARK: - Datum
class EventDatum {
    var eventid, userid: Int?
    var eventName, hostName, location, date: String?
    var time, datumDescription, website, eventType: String?
    var registrationType: String
    var imageid: Int
    var status, createdAt, updatedAt: String?
    var user: EventUser?
    var attachment: EventAttachment?
    var like_counts: Int?
    var url:String?
        
    init(with dictResponse: [String:Any]?) {
        
        self.eventName = String.getString(dictResponse?["event_name"])
        self.hostName = String.getString(dictResponse?["host_name"])
        self.location = String.getString(dictResponse?["location"])
        self.website = String.getString(dictResponse?["website"])
        self.date = String.getString(dictResponse?["date"])
        self.time = String.getString(dictResponse?["time"])
        self.eventType = String.getString(dictResponse?["event_type"])
        self.registrationType = String.getString(dictResponse?["registration_type"])
        self.datumDescription = String.getString(dictResponse?["description"])
        self.status = String.getString(dictResponse?["status"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        self.eventid = Int.getInt(dictResponse?["event_id"])
        self.userid = Int.getInt(dictResponse?["user_id"])
        self.imageid = Int.getInt(dictResponse?["image_id"])
        self.like_counts = Int.getInt(dictResponse?["like_counts"])
        self.url = String.getString(dictResponse?["url"])
        if let user = dictResponse?["user"] as? [String:Any]{
            self.user =  EventUser.init(with: user)
        }
        
        if let attachment = dictResponse?["attachment"] as? [String:Any]{
            self.attachment =  EventAttachment.init(with: attachment)
        }
        
    }

    
}

// MARK: - Attachment
class EventAttachment {
    var id: Int?
    var attachmenturl, baseUrl, attachmentType, createdAt, updatedAt: String?

    
    init(with dictResponse: [String:Any]?) {
        self.attachmenturl = String.getString(dictResponse?["attachment_url"])
        self.baseUrl = String.getString(dictResponse?["base_url"])
        self.attachmentType = String.getString(dictResponse?["attachment_type"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        self.id = Int.getInt(dictResponse?["id"])
    }

    
}

// MARK: - User
class EventUser {
    var userid: Int
    var name: String?
    var email: String
    var companyName: String?
    var restaurantName: String?
    var roleid: Int?
    var avatarid: EventAttachment?

    init(with dictResponse: [String:Any]?) {
        
        self.name = String.getString(dictResponse?["name"])
        self.email = String.getString(dictResponse?["email"])
        self.companyName = String.getString(dictResponse?["company_name"])
        self.restaurantName = String.getString(dictResponse?["restaurant_name"])
        self.userid = Int.getInt(dictResponse?["user_id"])
        self.roleid = Int.getInt(dictResponse?["role_id"])
        
        if let avatar_id = dictResponse?["avatar_id"] as? [String:Any]{
            self.avatarid =  EventAttachment.init(with: avatar_id)
        }
        
    }

   
}
