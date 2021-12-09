//
//  NotificationListModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 30/08/21.
//


import Foundation

// MARK: - NotificationListModel
class NotificationListModel {
    var success: Int?
    var data: NotiDataClass?

    init(success: Int, data: NotiDataClass) {
        self.success = success
        self.data = data
    }
    
    init(with dictResponse: [String:Any]?) {
        self.success = Int.getInt(dictResponse?["success"])
        
        if let data = dictResponse?["data"] as? [String:Any]{
            self.data =  NotiDataClass.init(with: data)
        }
    }
    
}

// MARK: - DataClass
class NotiDataClass {
    var currentPage: Int?
    var data: [NotiDatum]?
    var firstPageurl: String?
    var from, lastPage: Int?
    var lastPageurl: String?
    var nextPageurl: String?
    var path: String?
    var perPage: Int?
    var prevPageurl: String?
    var to, total: Int?
    
    
    init(with dictResponse: [String:Any]?) {
        
        self.currentPage = Int.getInt(dictResponse?["current_page"])
        self.firstPageurl = String.getString(dictResponse?["first_page_url"])
        self.from = Int.getInt(dictResponse?["from"])
        self.lastPage = Int.getInt(dictResponse?["last_page"])
        self.lastPageurl = String.getString(dictResponse?["last_page_url"])
        self.nextPageurl = String.getString(dictResponse?["next_page_url"])
        self.path = String.getString(dictResponse?["path"])
        self.perPage = Int.getInt(dictResponse?["per_page"])
        self.prevPageurl = String.getString(dictResponse?["prev_page_url"])
        self.to = Int.getInt(dictResponse?["to"])
        self.total = Int.getInt(dictResponse?["total"])
        
        if let data = dictResponse?["data"] as? [[String:Any]]{
            
            self.data = data.map({NotiDatum.init(with: $0)})
        }
        
    }
    
    
}

// MARK: - Datum
class NotiDatum {
    var notificationid, from, to: Int?
    var notificationType, title: String?
    var body: String?
    var redirectTo: String?
    var redirectToid: Int?
    var isRead, createdAt, updatedAt,sender_name: String?
    var user: NotiUser?

    
    
    init(with dictResponse: [String:Any]?) {
            
            self.notificationid = Int.getInt(dictResponse?["notification_id"])
            self.from = Int.getInt(dictResponse?["from"])
            self.to = Int.getInt(dictResponse?["to"])
            self.notificationType = String.getString(dictResponse?["notification_type"])
            self.title = String.getString(dictResponse?["title"])
            self.body = String.getString(dictResponse?["body"])
            self.redirectTo = String.getString(dictResponse?["redirect_to"])
            self.redirectToid = Int.getInt(dictResponse?["redirect_to_id"])
            self.isRead = String.getString(dictResponse?["is_read"])
            self.createdAt = String.getString(dictResponse?["created_at"])
            self.updatedAt = String.getString(dictResponse?["updated_at"])
            self.sender_name = String.getString(dictResponse?["sender_name"])
            
            if let data = dictResponse?["user"] as? [String:Any]{
                self.user =  NotiUser.init(with: data)
            }
    }
    
    
}

// MARK: - User
class NotiUser {
    
    var userid: Int?
    var name: String
    var email: String?
    var companyName: String?
    var roleid, avatarid: Int?
    
        init(with dictResponse: [String:Any]?) {
            self.userid = Int.getInt(dictResponse?["user_id"])
            self.name = String.getString(dictResponse?["name"])
            self.email = String.getString(dictResponse?["email"])
            self.companyName = String.getString(dictResponse?["company_name"])
            self.roleid = Int.getInt(dictResponse?["role_id"])
            self.avatarid = Int.getInt(dictResponse?["avatar_id"])
        }
    
}
