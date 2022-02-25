//
//  ChatModel.swift
//  RippleApp
//
//  Created by Mohd Aslam on 30/04/20.
//  Copyright © 2020 Fluper. All rights reserved.
//

import Foundation
import RealmSwift
import FirebaseDatabase

let chatOldDays = 13

//MARK:- Class for messgaes For Chat Halper
class MessageClass: Object {
    @objc dynamic var Senderid :String?
    @objc dynamic var Sendername :String?
    @objc dynamic var Receiverid :String?
    @objc dynamic var Message:String?
    @objc dynamic var isDeleted:String?
    @objc dynamic var uid:String?
    @objc dynamic var SendingTime =  Int()
    @objc dynamic var isOnline = Int()
    @objc dynamic var mediatype:String?
    @objc dynamic var thumnilimageurl : String?
    //@objc dynamic var location : [String:Any]?
    @objc dynamic var starmessage:String?
    @objc dynamic var imageurl:String?
    @objc dynamic var mediaurl :String?
    @objc dynamic var status :  String?
    @objc dynamic var isSongPlayed = false
    @objc dynamic var fileName : String?
    @objc dynamic var groupName : String?
    @objc dynamic var img_type : String?
    @objc dynamic var chat_id : String?
    @objc dynamic var like_status : String?
    
    class func addNewMessageInList(msgDict: Dictionary<String, Any>, userid: String) {
        
        let msgObj = MessageClass(value: msgDict)
        let loggedInUserid = kSharedUserDefaults.loggedInUserModal.userId ?? ""
        let chatId = loggedInUserid < userid ? "\(String.getString(loggedInUserid))_\(String.getString(userid))" : "\(String.getString(userid))_\(String.getString(loggedInUserid))"
        
        let realm = try? Realm()
        guard let result = realm?.objects(MessageList.self).filter("\(Parameters.chat_id) == %@", chatId) else { return }
        let obj1 = result.first ?? MessageList()
                        
        try? realm?.write {
            obj1.messages.append(msgObj)
        }
        
        if let result = realm?.objects(ResentUsers.self).filter("id == %@", userid) {
            if result.count > 0 {
                let obj = result[0]
                if !obj.isInvalidated {
                    try? realm?.write {
                        obj.lastmessage = msgDict["Message"] as? String ?? ""
                        obj.SendingTime = msgDict["SendingTime"] as? Int ?? 0
                        obj.readState = "not_seen"
                    }
               }
            }
        }
    }
}

class MessageList: Object {
    
    @objc dynamic var chat_id :String?
    var messages = List<MessageClass>()
    
    override static func primaryKey() -> String? {
           return Parameters.chat_id
       }
}

extension MessageList {
    
    class func saveMessages(result:Dictionary<String, Any>, userId: String) {
        
        let loggedInUserid = kSharedUserDefaults.loggedInUserModal.userId ?? ""
        
        var tempArr = [Dictionary<String, Any>]()
        
        result.forEach {(key, value) in
            let messageData = kSharedInstance.getDictionary(value)
            
            let Senderid  = String.getString(messageData[Parameters.senderid])
            let Message  = String.getString(messageData[Parameters.content])
            let SendingTime = Int.getInt(messageData[Parameters.timeStamp])
            let Receiverid = String.getString(messageData[Parameters.receiverid])
            let isDeleted = String.getString(messageData[Parameters.isDeleted])
            let starmessage = String.getString(messageData[Parameters.starmessage])
            let uid = String.getString(key)
            let mediatype = String.getString(messageData[Parameters.mediatype])
            let Sendername = String.getString(messageData[Parameters.sendername])
            let thumnilimageurl = String.getString(messageData[Parameters.thumnilimageurl])
            //let location       = sharedInstance.getDictionary(messageData[Parameters.location])
            let imageurl       = String.getString(messageData[Parameters.mediaurl])
            let mediaurl       = String.getString(messageData[Parameters.mediaurl])
            let status         = String.getString(messageData["status"])
            let fileName       = String.getString(messageData[Parameters.fileName])
            let groupName       = String.getString(messageData[Parameters.groupName])
            let img_type       = String.getString(messageData[Parameters.img_type])
            let chat_id       = String.getString(messageData[Parameters.chat_id])
            let like_status       = String.getString(messageData[Parameters.likeStatus])
                        
            let dict = ["Senderid" : Senderid,
                        "Message": Message,
                        "SendingTime": SendingTime,
                        "Receiverid": Receiverid,
                        "isDeleted": isDeleted,
                        "starmessage": starmessage,
                        "uid": uid,
                        "mediatype": mediatype,
                        "Sendername": Sendername,
                        "thumnilimageurl": thumnilimageurl,
                        //"location": location,
                        "imageurl": imageurl,
                        "mediaurl": mediaurl,
                        "status": status,
                        "fileName": fileName,
                        "groupName": groupName,
                        "img_type": img_type,
                        "chat_id": chat_id,
                        "like_status": like_status
                ] as [String : Any]
            
            
//            let date1 = SendingTime.dateFromTimeStamp()
//            let diffInDays = (Calendar.current.dateComponents([.day], from: date1, to: Date()).day) ?? 0

            if isDeleted == "" {
                if Receiverid.count > 0 {
//                    if diffInDays > chatOldDays {
//                        deletePerticularMessage(msgId: uid)
//                    }else {
                        tempArr.append(dict)
                    //}
                }
            }else {
                let isDeleted =  isDeleted.components(separatedBy: Parameters.saparaterString)
                if !(isDeleted.contains(loggedInUserid)) {
                    if Receiverid.count > 0 {
//                        if diffInDays > chatOldDays {
//                            deletePerticularMessage(msgId: uid)
//                        }else {
                            tempArr.append(dict)
                        //}
                    }
                }
            }
        }
//        if tempArr.count == 0 {
//            return
//        }
         let senderid  = String.getString(userId)
        let chatId = loggedInUserid < senderid ? "\(String.getString(loggedInUserid))_\(String.getString(senderid))" : "\(String.getString(senderid))_\(String.getString(loggedInUserid))"
        //Delete all messages for a user
        deleteMessagesForUser(userid: chatId)
       
        
        let dict = ["chat_id" : chatId,
                    "messages": tempArr
        ] as [String : Any]
        
        //Save messages for a user
        let realm = try? Realm()
        let resultList = realm?.objects(MessageList.self)
        let obj = MessageList(value: dict)
        let predicate = NSPredicate(format: "chat_id == %@", chatId)
        let filteredArr = resultList?.filter { predicate.evaluate(with: $0) }
        if filteredArr?.count ?? 0 > 0 {
            try? realm?.write ({
                realm?.add(obj, update: .all)
                NotificationCenter.default.post(name: NSNotification.Name("ChatNotificationReceived"), object: nil)
            })
        }else {
            try? realm?.write ({
                realm?.add(obj, update: .error)
                NotificationCenter.default.post(name: NSNotification.Name("ChatNotificationReceived"), object: nil)
            })
        }
        
    }
    
    
    class func saveUnreadMessages(result:Dictionary<String, Any>, userId: String) {
        
        let loggedInUserid = kSharedUserDefaults.loggedInUserModal.userId ?? ""
        
        var tempArr = [Dictionary<String, Any>]()
        
        let messages = MessageList.fetchMessagesForUser(userid: userId) ?? []
        messages.forEach { (object) in
            let Senderid  = String.getString(object.Senderid)
            let Message  = String.getString(object.Message)
            let SendingTime = Int.getInt(object.SendingTime)
            let Receiverid = String.getString(object.Receiverid)
            let isDeleted = String.getString(object.isDeleted)
            let starmessage = String.getString(object.starmessage)
            let uid = String.getString(object.uid)
            let mediatype = String.getString(object.mediatype)
            let Sendername = String.getString(object.Sendername)
            let thumnilimageurl = String.getString(object.thumnilimageurl)
            //let location       = sharedInstance.getDictionary(messageData[Parameters.location])
            let imageurl       = String.getString(object.imageurl)
            let mediaurl       = String.getString(object.mediaurl)
            let status         = String.getString(object.status)
            let fileName       = String.getString(object.fileName)
            let groupName       = String.getString(object.groupName)
            let img_type       = String.getString(object.img_type)
            let chat_id       = String.getString(object.chat_id)
            let like_status       = String.getString(object.like_status)
                        
            let dict = ["Senderid" : Senderid,
                        "Message": Message,
                        "SendingTime": SendingTime,
                        "Receiverid": Receiverid,
                        "isDeleted": isDeleted,
                        "starmessage": starmessage,
                        "uid": uid,
                        "mediatype": mediatype,
                        "Sendername": Sendername,
                        "thumnilimageurl": thumnilimageurl,
                        //"location": location,
                        "imageurl": imageurl,
                        "mediaurl": mediaurl,
                        "status": status,
                        "fileName": fileName,
                        "groupName": groupName,
                        "img_type": img_type,
                        "chat_id": chat_id,
                        "like_status": like_status
                ] as [String : Any]
            
            tempArr.append(dict)
        }
        
        result.forEach {(key, value) in
            let messageData = kSharedInstance.getDictionary(value)
            
            let Senderid  = String.getString(messageData[Parameters.senderid])
            let Message  = String.getString(messageData[Parameters.content])
            let SendingTime = Int.getInt(messageData[Parameters.timeStamp])
            let Receiverid = String.getString(messageData[Parameters.receiverid])
            let isDeleted = String.getString(messageData[Parameters.isDeleted])
            let starmessage = String.getString(messageData[Parameters.starmessage])
            let uid = String.getString(key)
            let mediatype = String.getString(messageData[Parameters.mediatype])
            let Sendername = String.getString(messageData[Parameters.sendername])
            let thumnilimageurl = String.getString(messageData[Parameters.thumnilimageurl])
            //let location       = sharedInstance.getDictionary(messageData[Parameters.location])
            let imageurl       = String.getString(messageData[Parameters.mediaurl])
            let mediaurl       = String.getString(messageData[Parameters.mediaurl])
            let status         = String.getString(messageData["status"])
            let fileName       = String.getString(messageData[Parameters.fileName])
            let groupName       = String.getString(messageData[Parameters.groupName])
            let img_type       = String.getString(messageData[Parameters.img_type])
            let chat_id       = String.getString(messageData[Parameters.chat_id])
            let like_status   = String.getString(messageData[Parameters.likeStatus])
            
            let dict = ["Senderid" : Senderid,
                        "Message": Message,
                        "SendingTime": SendingTime,
                        "Receiverid": Receiverid,
                        "isDeleted": isDeleted,
                        "starmessage": starmessage,
                        "uid": uid,
                        "mediatype": mediatype,
                        "Sendername": Sendername,
                        "thumnilimageurl": thumnilimageurl,
                        //"location": location,
                        "imageurl": imageurl,
                        "mediaurl": mediaurl,
                        "status": status,
                        "fileName": fileName,
                        "groupName": groupName,
                        "img_type": img_type,
                        "chat_id": chat_id,
                        "like_status": like_status
                ] as [String : Any]
            
            tempArr.append(dict)
        }
        if tempArr.count == 0 {
            return
        }
         let senderid  = String.getString(userId)
        let chatId = loggedInUserid < senderid ? "\(String.getString(loggedInUserid))_\(String.getString(senderid))" : "\(String.getString(senderid))_\(String.getString(loggedInUserid))"
        
        
        let dict = ["chat_id" : chatId,
                    "messages": tempArr
        ] as [String : Any]
        
        //Save messages for a user
        let realm = try? Realm()
        let resultList = realm?.objects(MessageList.self)
        let obj = MessageList(value: dict)
        let predicate = NSPredicate(format: "chat_id == %@", chatId)
        let filteredArr = resultList?.filter { predicate.evaluate(with: $0) }
        if filteredArr?.count ?? 0 > 0 {
            try? realm?.write ({
                realm?.add(obj, update: .all)
                NotificationCenter.default.post(name: NSNotification.Name("ChatNotificationReceived"), object: nil)
            })
        }
        else {
            try? realm?.write ({
                realm?.add(obj, update: .error)
                NotificationCenter.default.post(name: NSNotification.Name("ChatNotificationReceived"), object: nil)
            })
        }
        
    }
    
   
    
    class func emptyMessagesTableInDatabase() {
        let realm = try? Realm()
        if let result = realm?.objects(MessageClass.self) {
            try! realm?.write {
                if !result.isInvalidated {
                    try? realm?.write ({
                            realm?.delete(result)
                    })
                }
            }
        }
    }
    
    class func deleteMessagesForUser(userid: String) {
        let realm = try? Realm()
        if let result = realm?.objects(MessageList.self).filter("\(Parameters.uid) == %@", userid) {
            if result.count > 0 {
                let obj = result[0]
                if !obj.isInvalidated {
                    try? realm?.write ({
                            realm?.delete(obj)
                    })
               }
            }
        }
    }
    
    class func fetchMessagesForUser(userid: String) -> [MessageClass]? {
        
        let loggedInUserid = kSharedUserDefaults.loggedInUserModal.userId ?? ""
        let chatId = loggedInUserid < userid ? "\(String.getString(loggedInUserid))_\(String.getString(userid))" : "\(String.getString(userid))_\(String.getString(loggedInUserid))"
        var resentList = [MessageClass]()
        let realm = try? Realm()
        guard let result = realm?.objects(MessageList.self).filter("\(Parameters.chat_id) == %@", chatId) else { return  resentList}
       let obj = result.first ?? MessageList()
               
        let array = Array(obj.messages)
        
        let sortedResult = array.sorted(by: { (model1, model2) -> Bool in
            model1.SendingTime <  model2.SendingTime
        })
        resentList = sortedResult
        return resentList
    
    }
    
    class func deleteAllDatabase() {
        let realm = try? Realm()
        try? realm?.write({
            realm?.deleteAll()
        })
    }
}

class MessageObject {
    var SendingTime =  Int()
    var messages = [ReceivedMessageClass]()
    
    init(time :Int , messageList:[ReceivedMessageClass]) {
        self.messages = messageList
        self.SendingTime = time
    }
}

//MARK:- Class for Chat Backup
class ChatbackupOnetoOne {
    var Senderid :String?
    var Receiverid :String?
    var Message:String?
    var isDeleted:String?
    var uid:String?
    var SendingTime =  Int()
    var isOnline = Int()
    var mediatype:String?
    var thumnilimageurl : String?
    var Sendername :String?
    var location : [String:Any]?

    init(uid :String , messageData:[String:Any]) {
        self.Senderid  = String.getString(messageData[Parameters.senderid])
        self.Message  = String.getString(messageData[Parameters.content])
        self.SendingTime = Int.getInt(messageData[Parameters.timeStamp])
        self.Receiverid = String.getString(messageData[Parameters.receiverid])
        self.isDeleted = String.getString(messageData[Parameters.isDeleted])
        self.uid = String.getString(uid)
        self.mediatype = String.getString(messageData[Parameters.mediatype])
        self.Sendername = String.getString(messageData[Parameters.sendername])
        self.thumnilimageurl = String.getString(messageData[Parameters.thumnilimageurl])
        self.location       = kSharedInstance.getDictionary(messageData[Parameters.location])
    }
}

class InquiryReceivedMessageClass {
    var chat_id:String?
    var deleted :String?
    var like : Bool?
    var mediaType :messageType?
    var message :String?
    var receiverImage:String?
    var receiverName:String?
    var receiverid :String?
    var senderImage:String?
    var senderName:String?
    var senderid :String?
    var timestamp : String?
    
    var productImage:String?
    var producerUserId:String?
    var productName:String?
    var productId :String?
    var storeId :String?
    var storeName :String?
    
    var uid :String?
    var messageFrom:MessageFrom?
    init() { }
    init(uid :String , messageData:[String:Any]) {
        self.chat_id            = String.getString(messageData[Parameters.chat_id])
        self.deleted          = String.getString(messageData[Parameters.deleted])
        self.like          = Bool.getBool(messageData[Parameters.like])
        //self.mediaType        = String.getString(messageData[Parameters.mediaType])
        self.message           = String.getString(messageData[Parameters.messages])
        self.receiverImage             = String.getString(messageData[Parameters.receiverImage])
        self.receiverName           = String.getString(messageData[Parameters.receiverName])
        self.receiverid           = String.getString(messageData[Parameters.receiverids])
        self.senderImage           = String.getString(messageData[Parameters.senderImage])
        self.senderName           = String.getString(messageData[Parameters.senderName])
        self.senderid           = String.getString(messageData[Parameters.senderid])
        self.producerUserId     = String.getString(messageData[Parameters.producerUserId])
        self.storeName           = String.getString(messageData[Parameters.storeName])
        self.storeId           = String.getString(messageData[Parameters.storeId])
        self.productId           = String.getString(messageData[Parameters.productId])
        self.productName           = String.getString(messageData[Parameters.productName])
        self.productImage           = String.getString(messageData[Parameters.productImage])
        
        self.uid           = String.getString(messageData[Parameters.uid])
        self.timestamp         = String.getString(messageData[Parameters.timestamp])
        
        self.messageFrom         = String.getString(messageData[Parameters.senderid]) == String.getString(kSharedUserDefaults.loggedInUserModal.userId) ? .sender : .receiver
        //MARK:- Switch for media type
        switch  String.getString(messageData[Parameters.mediaType]) {
        case "text":
            self.mediaType = .text
        case "photos":
            self.mediaType = .photos
        case "video":
            self.mediaType = .video
        case "document":
            self.mediaType = .document
        case "location":
            self.mediaType = .location
        default:
            self.mediaType = .none
        }
    }
    func createDictonary (objects:InquiryReceivedMessageClass?) -> Dictionary<String , Any> {
        let params : [String:Any] = [
            Parameters.chat_id                       : objects?.chat_id ?? "",
            Parameters.deleted                  : objects?.deleted ?? "" ,
            Parameters.like                : objects?.like ?? "",
            Parameters.messages                : objects?.message  ?? "",
            Parameters.receiverImage              : objects?.receiverImage ?? "",
            Parameters.receiverName                   : objects?.receiverName ?? "",
            Parameters.receiverids                 : objects?.receiverid ?? "",
            Parameters.senderImage                 : objects?.senderImage ?? "",
            Parameters.sendername                 : objects?.senderName ?? "",
            Parameters.senderid           : objects?.senderid ?? "",
            Parameters.producerUserId       : objects?.producerUserId ?? "",
            Parameters.storeName                 : objects?.storeName ?? "",
            Parameters.storeId                 : objects?.storeId ?? "",
            Parameters.productId                 : objects?.productId ?? "",
            Parameters.productName                 : objects?.productName ?? "",
            Parameters.profile_image           : objects?.productImage ?? "",
            
            Parameters.uid                        : objects?.uid ?? "",
            Parameters.timestamp                 : objects?.timestamp ?? "",
            Parameters.mediaType                 : objects?.mediaType?.rawValue ?? ""
        ]
        return params
    }
}


class ReceivedMessageClass {
    var chat_id:String?
    var deleted :String?
    var like : Bool?
    var mediaType :messageType?
    var mediaImage :String?
    var message :String?
    var receiverImage:String?
    var receiverName:String?
    var receiverid :String?
    var senderImage:String?
    var senderName:String?
    var senderid :String?
    var timestamp : String?
    var uid :String?
    var messageFrom:MessageFrom?
    init() { }
    init(uid :String , messageData:[String:Any]) {
        self.chat_id            = String.getString(messageData[Parameters.chat_id])
        self.deleted          = String.getString(messageData[Parameters.deleted])
        self.like          = Bool.getBool(messageData[Parameters.like])
        //self.mediaType        = String.getString(messageData[Parameters.mediaType])
        self.message           = String.getString(messageData[Parameters.messages])
        self.mediaImage         = String.getString(messageData[Parameters.mediaImage])
        self.receiverImage             = String.getString(messageData[Parameters.receiverImage])
        self.receiverName           = String.getString(messageData[Parameters.receiverName])
        self.receiverid           = String.getString(messageData[Parameters.receiverids])
        self.senderImage           = String.getString(messageData[Parameters.senderImage])
        self.senderName           = String.getString(messageData[Parameters.senderName])
        self.senderid           = String.getString(messageData[Parameters.senderid])
        self.uid           = String.getString(messageData[Parameters.uid])
        self.timestamp         = String.getString(messageData[Parameters.timestamp])
        
        self.messageFrom         = String.getString(messageData[Parameters.senderid]) == String.getString(kSharedUserDefaults.loggedInUserModal.userId) ? .sender : .receiver
        //MARK:- Switch for media type
        switch  String.getString(messageData[Parameters.mediaType]) {
        case "text":
            self.mediaType = .text
        case "photos":
            self.mediaType = .photos
        case "textphotos":
            self.mediaType = .textphotos
        case "video":
            self.mediaType = .video
        case "document":
            self.mediaType = .document
        case "location":
            self.mediaType = .location
        default:
            self.mediaType = .none
        }
    }
    func createDictonary (objects:ReceivedMessageClass?) -> Dictionary<String , Any> {
        let params : [String:Any] = [
            Parameters.chat_id                       : objects?.chat_id ?? "",
            Parameters.deleted                  : objects?.deleted ?? "" ,
            Parameters.like                : objects?.like ?? "",
            Parameters.messages                : objects?.message  ?? "",
            Parameters.mediaImage               : objects?.mediaImage ?? "",
            Parameters.receiverImage              : objects?.receiverImage ?? "",
            Parameters.receiverName                   : objects?.receiverName ?? "",
            Parameters.receiverids                 : objects?.receiverid ?? "",
            Parameters.senderImage                 : objects?.senderImage ?? "",
            Parameters.sendername                 : objects?.senderName ?? "",
            Parameters.senderid           : objects?.senderid ?? "",
            Parameters.uid                        : objects?.uid ?? "",
            Parameters.timestamp                 : objects?.timestamp ?? "",
            Parameters.mediaType                 : objects?.mediaType?.rawValue ?? ""
        ]
        return params
    }
}

class PostClass {
    
    var commentCount:Int?
    var likeCount :Int?
    var postId : Int?
   
    
    init() { }
    init(uid :String , messageData:[String:Any]) {
        self.commentCount            = Int.getInt(messageData[Parameters.commentCount])
        self.likeCount          = Int.getInt(messageData[Parameters.likeCount])
        self.postId          = Int.getInt(messageData[Parameters.postId])
       
     
    }
    
    func createDictonary (objects:PostClass?) -> Dictionary<String , Any> {
        let params : [String:Any] = [
            Parameters.commentCount                       : objects?.commentCount ?? 0,
            Parameters.likeCount                  : objects?.likeCount ?? 0 ,
            Parameters.postId                : objects?.postId ?? 0,
           
        ]
        return params
    }
}

class LikeCommentClass {
    
    var commentCount:Int?
    var likeCount :Int?
    var postId : Int?
    var data: CommentClass?
    
    init() { }
    init(uid :String ,with messageData: [String:Any]?) {
        self.commentCount            = Int.getInt(messageData?[Parameters.commentCount])
        self.likeCount          = Int.getInt(messageData?[Parameters.likeCount])
        self.postId          = Int.getInt(messageData?[Parameters.postId])
        
        if let data = messageData?["comment"] as? [String:Any]{
           // self.data = data.map({CommentClass.init(with: $0)})
            self.data =  CommentClass.init(with: data)
           /// self.data = CommentClass(with: data as! [String : Any])
        }
        
    }
    
    func createDictonary (objects:LikeCommentClass?,objects2:CommentClass?,objects3:PosterClass?,objects4:CommentAvatarId?) -> Dictionary<String , Any> {
        
        
        let params4 : [String:Any] = [

            Parameters.created_at                   : objects4?.poster_created_at ?? "",
            Parameters.attachment_type                 : objects4?.attachment_type ?? "",
            Parameters.attachment_url                 : objects4?.attachment_url ?? "",
            Parameters.id                 : objects4?.id ?? 0,
            Parameters.updated_at           : objects4?.updated_at ?? "",
        
        ]
        
        let params3 : [String:Any] = [
        
            Parameters.avatar_id : params4,
            Parameters.email                        : objects3?.email ?? "",
            Parameters.username                 : objects3?.name ?? "",
            Parameters.restaurant_name                 : objects3?.restaurant_name ?? "",
            Parameters.role_id                 : objects3?.role_id ?? 0,
            Parameters.userid                 : objects3?.user_id ?? 0,
          
        
        ]
        
        let params2 : [String:Any] = [
        
            Parameters.poster : params3,
            Parameters.body                : objects2?.body  ?? "",
            Parameters.core_comment_id              : objects2?.core_comment_id ?? 0,
            Parameters.created_at                   : objects2?.created_at ?? "",
            
          
        ]
 
        let params1 : [String:Any] = [
        
            String.getString(objects2?.core_comment_id) : params2,
          
        ]
        
        let params : [String:Any] = [
            
            Parameters.comment : params1,
            Parameters.commentCount                       : objects?.commentCount ?? 0,
            Parameters.likeCount                  : objects?.likeCount ?? 0 ,
            Parameters.postId                : objects?.postId ?? 0,
            
        ]
       
        
        return params
    }
    
    
    func createDictonary (objects:LikeCommentClass?) -> Dictionary<String , Any> {
        
       
        let params : [String:Any] = [
            
            Parameters.commentCount                       : objects?.commentCount ?? 0,
            Parameters.likeCount                  : objects?.likeCount ?? 0 ,
            Parameters.postId                : objects?.postId ?? 0,
            
        ]
       
        
        return params
    }
    
}


class CommentClass {
    
    var body:String?
    var core_comment_id :Int?
    var previous_comment_id :Int?
    var comment_like_count :Int?
    var created_at : String?
    var data : PosterClass?
    var reply = [ReplyDetailsClass]()
    var isSelected = false
    var isLike = false
   
    init() { }
    init(with messageData: [String:Any]?) {
        
        self.body           = String.getString(messageData?[Parameters.body])
        self.core_comment_id          = Int.getInt(messageData?[Parameters.core_comment_id])
        self.created_at             = String.getString(messageData?[Parameters.created_at])
        self.comment_like_count = Int.getInt(messageData?[Parameters.comment_like_count])
        self.previous_comment_id          = Int.getInt(messageData?[Parameters.previous_comment_id])
            
        if let poster = messageData?["poster"]  as? [String:Any]{
            self.data =  PosterClass.init(with: poster)
        }
        
        if let ReplyDetails = messageData?["ReplyDetails"]  as? [String:Any]{
            
            //self.reply = ReplyDetails.map({ReplyDetailsClass.init(with: $0)})
            reply.removeAll()
            ReplyDetails.forEach {(key, value) in
                
                let dic = kSharedInstance.getDictionary(value)
                reply.append(ReplyDetailsClass( with: dic))
                
                
                print("hello reply ",dic)
                
            }
        }
        
             
    }
    
    func createDictonary (objects:CommentClass?) -> Dictionary<String , Any> {
        let params : [String:Any] = [
            Parameters.body                : objects?.body  ?? "",
            Parameters.core_comment_id              : objects?.core_comment_id ?? 0,
            Parameters.created_at                   : objects?.created_at ?? "",
            Parameters.comment_like_count                   : objects?.comment_like_count ?? 0,
            Parameters.previous_comment_id                       : objects?.previous_comment_id ?? 0,
            Parameters.isLike : objects?.isLike ?? false
           
        ]
        return params
    }
    
}


class Comment_Like_Class {
    
    var user_id:Int?
    var comment_id :Int?
    var like_id :Int?
   
    init() { }
    init(with messageData: [String:Any]?) {
        
        self.user_id           = Int.getInt(messageData?[Parameters.userid])
        self.comment_id          = Int.getInt(messageData?[Parameters.core_comment_id])
        self.like_id = Int.getInt(messageData?[Parameters.like_id])
             
    }
    
    func createDictonary (objects:Comment_Like_Class?) -> Dictionary<String , Any> {
        let params : [String:Any] = [
            Parameters.userid              : objects?.user_id ?? 0,
            Parameters.core_comment_id                   : objects?.comment_id ?? 0,
            Parameters.like_id                   : objects?.like_id ?? 0,
           
        ]
        return params
    }
    
}

class ReplyDetailsClass {
    
    var body:String?
    var core_comment_id :Int?
    var previous_comment_id :Int?
    var parent_core_comment_id :String?
    var comment_like_count :Int?
    var created_at : String?
    var data : PosterClass?
    var isLike = false
    
    init() { }
    init(with messageData: [String:Any]?) {
        
        self.body           = String.getString(messageData?[Parameters.body])
        self.core_comment_id          = Int.getInt(messageData?[Parameters.core_comment_id])
        self.previous_comment_id          = Int.getInt(messageData?[Parameters.previous_comment_id])
        self.created_at             = String.getString(messageData?[Parameters.created_at])
        self.comment_like_count = Int.getInt(messageData?[Parameters.comment_like_count])
            
        if let poster = messageData?["poster"]  as? [String:Any]{
            self.data =  PosterClass.init(with: poster)
        }
        
        print("body--",body ?? "")
        
    }
    
    init(commentId: String) {
        
        self.parent_core_comment_id = commentId
        
    }
    
}

class PosterClass {
    
    var email:String?
    var name :String?
    var restaurant_name : String?
    var role_id :Int?
    var user_id : Int?
    var data : CommentAvatarId?
   
    init() { }
    init(with messageData: [String:Any]?) {
        
        self.email           = String.getString(messageData?[Parameters.email])
        self.name           = String.getString(messageData?[Parameters.username])
        self.restaurant_name           = String.getString(messageData?[Parameters.restaurant_name])
        
        if String.getString(messageData?[Parameters.company_name]) != ""{
            self.restaurant_name = String.getString(messageData?[Parameters.company_name])
        } else if String.getString(messageData?[Parameters.restaurant_name]) != ""{
            self.restaurant_name = String.getString(messageData?[Parameters.restaurant_name])
        } else if String.getString(messageData?[Parameters.first_name]) != ""{
            self.restaurant_name = String.getString(messageData?[Parameters.first_name])+" "+String.getString(messageData?["last_name"])
        }
        
        self.role_id         = Int.getInt(messageData?[Parameters.role_id])
        self.user_id         = Int.getInt(messageData?[Parameters.userid])
        
        
        if let avatar_id = messageData?["avatar_id"]  as? [String:Any]{
            //self.data = (data as AnyObject).map({CommentClass.init(messageData: $0)})
            self.data =  CommentAvatarId.init(with: avatar_id)
                // PosterClass(messageData: data as! [String : Any])
        }
        
    }
    
    
    func createDictonary (objects:PosterClass?) -> Dictionary<String , Any> {
        let params : [String:Any] = [
            Parameters.email                        : objects?.email ?? "",
            Parameters.username                 : objects?.name ?? "",
            Parameters.restaurant_name                 : objects?.restaurant_name ?? "",
            Parameters.role_id                 : objects?.role_id ?? 0,
            Parameters.userid                 : objects?.user_id ?? 0
        ]
        return params
    }
    
}

class CommentAvatarId {
    
    var attachment_type:String?
    var attachment_url :String?
    var poster_created_at : String?
    var id :Int?
    var updated_at : String?
    
    init() { }
    init(with messageData: [String:Any]) {
        
        self.poster_created_at       = String.getString(messageData[Parameters.created_at])
        self.attachment_type           = String.getString(messageData[Parameters.attachment_type])
        self.attachment_url           = String.getString(messageData[Parameters.attachment_url])
        self.id          = Int.getInt(messageData[Parameters.id])
        self.updated_at           = String.getString(messageData[Parameters.updated_at])
        
    }
    
    func createDictonary (objects:CommentAvatarId?) -> Dictionary<String , Any> {
        let params : [String:Any] = [
            Parameters.created_at                   : objects?.poster_created_at ?? "",
            Parameters.attachment_type                 : objects?.attachment_type ?? "",
            Parameters.attachment_url                 : objects?.attachment_url ?? "",
            Parameters.id                 : objects?.id ?? 0,
            Parameters.updated_at           : objects?.updated_at ?? "",
        ]
        return params
    }
    
}

//MARK:- Class for Resent Users

class InquiryRecentUser {
    var lastmessage:String?
    var mediaType:String?
    var otherId:String?
    var otherImage :String?
    var otherName : String?
    var readState:String?
    var timestamp =  Int()
    var readCount =  Int()
    var uid :String?
    var userTyping :Bool = false
    
    var productImage:String?
    var producerUserId:String?
    var productName:String?
    var productId :String?
    var storeId :String?
    var storeName :String?
    
    init() { }
    init(userdata:[String:Any]) {
        self.lastmessage         = String.getString(userdata[Parameters.lastmessage])
        self.mediaType = String.getString(userdata[Parameters.mediaType])
        self.otherId       = String.getString(userdata[Parameters.otherId])
        self.otherImage     = String.getString(userdata[Parameters.otherImage])
        self.otherName      = String.getString(userdata[Parameters.otherName])
        self.timestamp      = Int.getInt(userdata[Parameters.timestamp])
        self.readCount      = Int.getInt(userdata[Parameters.readCount])
        self.readState         = String.getString(userdata[Parameters.readState])
        self.uid        = String.getString(userdata[Parameters.uid])
        self.userTyping = Bool.getBool(userdata[Parameters.userTyping])
        
        self.storeId           = String.getString(userdata[Parameters.storeId])
        self.storeName           = String.getString(userdata[Parameters.storeName])
        self.productId           = String.getString(userdata[Parameters.productId])
        self.productName           = String.getString(userdata[Parameters.productName])
        self.productImage           = String.getString(userdata[Parameters.productImage])
        self.producerUserId           = String.getString(userdata[Parameters.producerUserId])
        
    }
    //MARK:- Func for createDictonary
    func createDictonary(objects:InquiryRecentUser?) -> Dictionary<String , Any> {
        let params : [String:Any] = [
            Parameters.lastmessage                     : objects?.lastmessage ?? "" ,
            Parameters.mediaType                     : objects?.mediaType ?? "" ,
            Parameters.otherId                     : objects?.otherId ?? "" ,
            Parameters.otherImage                     : objects?.otherImage ?? "" ,
            Parameters.otherName                     : objects?.otherName ?? "" ,
            Parameters.timestamp                           : objects?.timestamp ?? "",
            Parameters.readCount                           : objects?.readCount ?? "",
            Parameters.readState                        : objects?.readState ?? "",
            Parameters.uid                        : objects?.uid ?? "",
            Parameters.userTyping                        : objects?.userTyping ?? "",
            Parameters.producerUserId               :objects?.producerUserId ?? "",
            Parameters.storeId                 : objects?.storeId ?? "",
            Parameters.storeName                 : objects?.storeName ?? "",
            Parameters.productId                 : objects?.productId ?? "",
            Parameters.productName                 : objects?.productName ?? "",
            Parameters.profile_image           : objects?.productImage ?? ""
        ]
        return params
    }
}

class RecentUser {
    var lastmessage:String?
    var mediaType:String?
    var otherId:String?
    var otherImage :String?
    var otherName : String?
    var readState:String?
    var timestamp =  Int()
    var readCount =  Int()
    var uid :String?
    var userTyping :Bool = false
    
    
    
    init() { }
    init(userdata:[String:Any]) {
        self.lastmessage         = String.getString(userdata[Parameters.lastmessage])
        self.mediaType = String.getString(userdata[Parameters.mediaType])
        self.otherId       = String.getString(userdata[Parameters.otherId])
        self.otherImage     = String.getString(userdata[Parameters.otherImage])
        self.otherName      = String.getString(userdata[Parameters.otherName])
        self.timestamp      = Int.getInt(userdata[Parameters.timestamp])
        self.readCount      = Int.getInt(userdata[Parameters.readCount])
        self.readState         = String.getString(userdata[Parameters.readState])
        self.uid        = String.getString(userdata[Parameters.uid])
        self.userTyping = Bool.getBool(userdata[Parameters.userTyping])
        
       
        
    }
    //MARK:- Func for createDictonary
    func createDictonary(objects:RecentUser?) -> Dictionary<String , Any> {
        let params : [String:Any] = [
            Parameters.lastmessage                     : objects?.lastmessage ?? "" ,
            Parameters.mediaType                     : objects?.mediaType ?? "" ,
            Parameters.otherId                     : objects?.otherId ?? "" ,
            Parameters.otherImage                     : objects?.otherImage ?? "" ,
            Parameters.otherName                     : objects?.otherName ?? "" ,
            Parameters.timestamp                           : objects?.timestamp ?? "",
            Parameters.readCount                           : objects?.readCount ?? "",
            Parameters.readState                        : objects?.readState ?? "",
            Parameters.uid                        : objects?.uid ?? "",
            Parameters.userTyping                        : objects?.userTyping ?? ""
            
            
        ]
        return params
    }
}


//MARK:- Class for Resent Users

class ResentList: Object {
    
    @objc dynamic var user_id :String?
    var userList = List<ResentUsers>()
    
    override static func primaryKey() -> String? {
           return "user_id"
       }
}

class ResentUsers: Object {
    @objc dynamic var Senderid :String?
    @objc dynamic var id :String?
    @objc dynamic var Receiverid :String?
    @objc dynamic var name :String?
    @objc dynamic var lastmessage:String?
    @objc dynamic var SendingTime =  Int()
    @objc dynamic var imageUrl :String?
    @objc dynamic var readState :String?
    @objc dynamic var isOnline :Bool = false
    @objc dynamic var type :String?
    @objc dynamic var CreatedBy:String?
    @objc dynamic var readCount:String?
    @objc dynamic var timeStamp:String?
    @objc dynamic var unread_count = Int()
    @objc dynamic var isFriend : Bool = true
    @objc dynamic var blockUsers:String?
    @objc dynamic var anonymous_chat:String?
    
//    override static func primaryKey() -> String? {
//        return Parameters._id
//    }
//
    
}

extension ResentUsers {
    
    class func saveRecentUser(result:Dictionary<String, Any>) {
        // print(Realm.Configuration.defaultConfiguration.fileURL)
        let loggedInUserid = kSharedUserDefaults.loggedInUserModal.userId ?? ""
        
        var tempArr = [Dictionary<String, Any>]()
        
        result.forEach {(key, value) in
        let userdata = kSharedInstance.getDictionary(value)
        let Senderid = String.getString(userdata[Parameters.senderid])
        let Receiverid = String.getString(userdata[Parameters.receiverid])
        let lastmessage = String.getString(userdata[Parameters.lastmessage])
        let SendingTime = Int.getInt(userdata[Parameters.timeStamp])
        let name = String.getString(userdata[Parameters.name])
        let imageUrl = String.getString(userdata[Parameters.profile_image])
        let readState = String.getString(userdata[Parameters.readState])
        let CreatedBy = String.getString(userdata[Parameters.CreatedBy])
        let idStr = String.getString(userdata[Parameters._id])
        var friend = Bool.getBool(userdata[Parameters._friend])
        let blockUser = String.getString(userdata[Parameters.blockUsers])
        let anonymous_chat = String.getString(userdata[Parameters.anonymous_chat])
        if userdata[Parameters._friend] == nil {
            friend = true
        }
        
        let dic = kSharedInstance.getDictionary(userdata[Parameters.unread_count])
        var count = 0
        dic.forEach {(key, value) in
            count = Int.getInt(value)
        }
        
        var friendId = Senderid
        if loggedInUserid == Senderid {
            friendId = Receiverid
        }
        
        
        let dict = ["Senderid" : Senderid,
                    "Receiverid": Receiverid,
                    "lastmessage": lastmessage,
                    "SendingTime": SendingTime,
                    "name": name,
                    "imageUrl": imageUrl,
                    "readState": readState,
                    "CreatedBy": CreatedBy,
                    "id": friendId,
                    "unread_count":count,
                    "isFriend": friend,
                    Parameters.anonymous_chat : anonymous_chat,
                    Parameters.blockUsers : blockUser,
            ] as [String : Any]
        
            if friendId.count > 0 {
//            let date1 = SendingTime.dateFromTimeStamp()
//            let diffInDays = (Calendar.current.dateComponents([.day], from: date1, to: Date()).day) ?? 0
//            if diffInDays > chatOldDays {
//                deleteRecordForUser(userid: friendId)
//            }else {
//                if idStr != loggedInUserid {
//                    tempArr.append(dict)
//                }
//            }
                if idStr != loggedInUserid {
                    tempArr.append(dict)
                }
            }
        }
        
        //Delete all chat list for a user
         deleteChatListForUser(userid: loggedInUserid)
         
         let dict = ["user_id" : loggedInUserid,
                     "userList": tempArr
         ] as [String : Any]
         
         let realm = try? Realm()
         let resultList = realm?.objects(ResentList.self)
         let obj = ResentList(value: dict)
         let predicate = NSPredicate(format: "user_id == %@", loggedInUserid)
         let filteredArr = resultList?.filter { predicate.evaluate(with: $0) }
         if filteredArr?.count ?? 0 > 0 {
            try? realm?.write ({
                realm?.add(obj, update: .all)
                NotificationCenter.default.post(name: NSNotification.Name("ChatNotificationReceived"), object: nil)
            })
         }
         else {
            try? realm?.write ({
                realm?.add(obj, update: .error)
                NotificationCenter.default.post(name: NSNotification.Name("ChatNotificationReceived"), object: nil)
            })
         }
                        
    
    }
    
    //Fetch Resent User List
    class func fetchResentListFromDatabase() -> [ResentUsers]? {
        
        let loggedInUserid = kSharedUserDefaults.loggedInUserModal.userId ?? ""
        
        var resentList = [ResentUsers]()
         let realm = try? Realm()
         guard let result = realm?.objects(ResentList.self).filter("user_id == %@", loggedInUserid) else { return  resentList}
        let obj = result.first ?? ResentList()
        let array = Array(obj.userList)
         let sortedResult = array.sorted(by: { (model1, model2) -> Bool in
             model1.SendingTime >  model2.SendingTime
         })
         resentList = sortedResult
        return resentList
    }
    
    class func emptyResentTableInDatabase() {
        let realm = try? Realm()
        if let result = realm?.objects(ResentUsers.self) {
            try! realm?.write {
                if !result.isInvalidated {
                    realm?.delete(result)
                }
            }
        }
    }
    
    class func deleteRecordForUser(userid: String) {
        let realm = try? Realm()
        if let result = realm?.objects(ResentUsers.self).filter("id == %@", userid) {
            if result.count > 0 {
                let obj = result[0]
                if !obj.isInvalidated {
                    try? realm?.write {
                        realm?.delete(obj)
                    }
               }
            }
        }
    }
    
    class func deleteChatListForUser(userid: String) {
        let realm = try? Realm()
        if let result = realm?.objects(ResentList.self).filter("user_id == %@", userid) {
            if result.count > 0 {
                let obj = result[0]
                if !obj.isInvalidated {
                    try? realm?.write {
                        realm?.delete(obj)
                    }
               }
            }
        }
    }
    
    static func deleteChatListForUser(userid1: String) {
        let realm = try? Realm()
        if let result = realm?.objects(ResentList.self).filter("user_id == %@", userid1) {
            if result.count > 0 {
                let obj = result[0]
                if !obj.isInvalidated {
                    try? realm?.write {
                        realm?.delete(obj)
                    }
               }
            }
        }
    }
    
}




//MARK:- Class for User Information
class UsersState {
    var userid :String?
    var name :String?
    var lastmessage:String?
    var SendingTime =  Int()
    var imageUrl :String?
    var isOnline :String?
    var blockUsers :[String]?
    init(userid:String , lastmessage :String , time :String , name :String , imageUrl:String ,  isOnline:String , blockUsers:[String]) {
        self.userid = String.getString(userid)
        self.lastmessage = String.getString(lastmessage)
        self.SendingTime = Int.getInt(time)
        self.name = String.getString(name)
        self.imageUrl = String.getString(imageUrl)
        self.isOnline = String.getString(isOnline)
        self.blockUsers = kSharedInstance.getStringArray(blockUsers)
    }
}


//MARK:- Class for Group Model
class GroupModel {
    var userid :String?
    var name :String?
    var lastmessage:String?
    var imageUrl :String?
    var isOnline :String?
    var user :[Any]?
    init(userid:String   , name :String , imageUrl:String , user:[Any]){
        self.userid = String.getString(userid)
        self.name = String.getString(name)
        self.imageUrl = String.getString(imageUrl)
        self.user = user
    }
}
enum messageType:String {
    case text , photos , textphotos , video , document , location , audio
}

enum MessageFrom:String {
    case sender , receiver
}
