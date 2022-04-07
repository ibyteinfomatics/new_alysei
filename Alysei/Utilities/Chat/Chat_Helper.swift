//
//  Chat_Helper.swift
//  RippleApp
//
//  Created by Mohd Aslam on 30/04/20.
//  Copyright © 2020 Fluper. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import AVKit
import AVFoundation
import PDFKit

extension Array {
    func removingDuplicates<T: Hashable>(byKey key: (Element) -> T)  -> [Element] {
        var result = [Element]()
        var seen = Set<T>()
        for value in self {
            if seen.insert(key(value)).inserted {
                result.append(value)
            }
        }
        return result
    }
}

class Chat_hepler {
    //MARK:- Object for Chat Halper
    static let Shared_instance = Chat_hepler()
    var Databasereference: DatabaseReference!
    var dicResponce:[String:Any]?
    var Messageclass = [MessageClass]()
    var ChatBackupOnetoOne = [ChatbackupOnetoOne]()
    var ResentUser = [ResentUsers]()
    
    var inquiryresentReference     = Database.database().reference().child("Inquiry").child(Parameters.ResentMessage)
    var inquirymessageReference    = Database.database().reference().child("Inquiry").child(Parameters.message)
    
    var resentReference     = Database.database().reference().child(Parameters.ResentMessage)
    var messageReference    = Database.database().reference().child(Parameters.message)
    var postReference    = Database.database().reference().child(Parameters.post)
    var userReference    = Database.database().reference().child(Parameters.users)
    var commentLikeReference    = Database.database().reference().child(Parameters.commentLike)
    var resentUser = [RecentUser]()
    var inquiry_resentUser = [InquiryRecentUser]()
    
    var inquirymessageclass        = [InquiryReceivedMessageClass]()
    var inquirychatBackupOnetoOne  = [InquiryReceivedMessageClass]()
    
    var messageclass        = [ReceivedMessageClass]()
    var chatBackupOnetoOne  = [ReceivedMessageClass]()
    
    var commentmessageclass        = [CommentClass]()
    var postmessageclass        = [PostClass]()
    var postlikeclass        = [PostClass]()
    var userclass        = [userClass]()
    var commentBackupOnetoOne  = [LikeCommentClass]()
    var commentlikeclass        = [Comment_Like_Class]()
    
    var userState :UsersState?
    var receiverprofile_image:String?
    var readmessagesCountCheck = false
    let messageReferense = Database.database().reference().child(Parameters.Message).child(Parameters.PrivateMessages)
    let resentReferense = Database.database().reference().child(Parameters.ResentMessage)
    
    var Resentuser:[RecentUser]?
    var Inquiry_Resentuser:[InquiryRecentUser]?
    var unread: Int = 1
    
    
    //MARK:- Function For Send message one to one Chat
    func SendMessage(dic:Dictionary<String, Any> ,Senderid :String , Receiverid:String) {
        let node = Senderid < Receiverid ? "\(String.getString(Senderid))_\(String.getString(Receiverid))" :  "\(String.getString(Receiverid))_\(String.getString(Senderid))"
       
        if String.getString(node) == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        
        let ref =  messageReferense.child(node).childByAutoId()
        let autoKey = "\(String.getString(ref.key))"
        var messageData = kSharedInstance.getDictionary(dic)
        messageData["chat_id"] = String.getString(node)
        messageData["message_id"] = String.getString(autoKey)
        messageReferense.child(node).child(autoKey).setValue(kSharedInstance.getDictionary(messageData))
    }
    
    //MARK:- Func For send Resent Users and retrived data On resent Users Submit Data to Users Every User Submit 2 Node Data Sender and Receiver
    func updateLastMessage(lastmessage:String, Receiverid:String , Senderid :String  , name:String , profile_image:String , readState :String, isMsgSend: Bool, lastTimestamp: String, msgReceiverId: String, unreadCount: Int, friendStatus: Bool, userSenderId: String , blockId:String = "") {
        
        //let userSenderId = kSharedUserDefaults.getLoggedInUserId()
        if String.getString(userSenderId) == Parameters.emptyString || String.getString(Receiverid) == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        let userDetails = kSharedUserDefaults.getLoggedInUserDetails()
        
        let dic:[String : Any] = [ Parameters._id: String.getString(Receiverid),
                                   Parameters.name: String.getString(name),
                                   Parameters.profile_image: String.getString(profile_image),
                                   Parameters.lastmessage : String.getString(lastmessage),
                                   Parameters.readState : String.getString(readState),
                                   Parameters.senderid : String.getString(Senderid),
                                   Parameters.receiverid : String.getString(msgReceiverId),
                                   Parameters._friend : friendStatus ]
        
        
        
        let unreadDict = [Receiverid: unreadCount]
        
        let dicuser = [Parameters._id: kSharedUserDefaults.loggedInUserModal.userId ?? "",
                       Parameters.name: String.getString("\(String.getString(userDetails["user_name"]))"),
                       Parameters.profile_image: String.getString(userDetails["profile_image"]),
                       Parameters.timeStamp : String.getString(lastTimestamp) ,
                       Parameters.readState : String.getString(readState),
                       Parameters.senderid : String.getString(Senderid),
                       Parameters.receiverid : String.getString(msgReceiverId),
                       Parameters.unread_count: unreadDict,
                       Parameters._friend : friendStatus
            
            ] as [String : Any]
        
        
        
        resentReferense.child(String.getString("user_" + "\(String.getString(userSenderId))")).child(String.getString("user_" + "\(String.getString(Receiverid))")).observeSingleEvent(of:.value) { (snapshot) in
            if snapshot.exists() {
                self.resentReferense.child(String.getString("user_" + "\(String.getString(userSenderId))")).child(String.getString("user_" + "\(String.getString(Receiverid))")).updateChildValues(dic)
            }
            
        }
        resentReferense.child(String.getString("user_" + "\(String.getString(Receiverid))")).child(String.getString("user_" + "\(String.getString(userSenderId))")).observeSingleEvent(of:.value) { (snapshot) in
            if snapshot.exists() {
                self.resentReferense.child(String.getString("user_" + "\(String.getString(Receiverid))")).child(String.getString("user_" + "\(String.getString(userSenderId))")).updateChildValues(dicuser)
            }
        }
        
        //        Database.database().reference().child(Parameters.ResentMessage).child(String.getString("user_" + "\(String.getString(userSenderId))")).child(String.getString("user_" + "\(String.getString(Receiverid))")).updateChildValues(dic)
        //
        //        Database.database().reference().child(Parameters.ResentMessage).child(String.getString("user_" + "\(String.getString(Receiverid))")).child(String.getString("user_" + "\(String.getString(userSenderId))")).updateChildValues(dicuser)
        
    }
    //MARK:- Func For Receive Message for One To One Chat
    func Receivce_message(Senderid :String , Receiverid:String , message:@escaping (_ result: [MessageClass]? , _ chatBackup : [ChatbackupOnetoOne]?, _ success: Bool, _ isExist: Bool) -> ()) -> Void {
        self.Messageclass.removeAll()
        self.ChatBackupOnetoOne.removeAll()
        let node = Senderid < Receiverid ? "\(String.getString(Senderid))_\(String.getString(Receiverid))" : "\(String.getString(Receiverid))_\(String.getString(Senderid))"
        if String.getString(node) == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        messageReferense.child(node).observe(.value) { (snapshot) in
            if snapshot.exists() {
                let msgs = kSharedInstance.getDictionary(snapshot.value)
                //self.Messageclass.removeAll()
                guard let vc = UIApplication.topViewController() else {
                    message(self.Messageclass, self.ChatBackupOnetoOne, false, false)
                    return
                }
                if vc .isKind(of: ConversationViewController.self) {
                    MessageList.saveMessages(result: msgs, userId: Receiverid)
                }
                message(self.Messageclass, self.ChatBackupOnetoOne, true, true)
            }else {
                message(self.Messageclass, self.ChatBackupOnetoOne, true, false)
            }
        }
        message(self.Messageclass, self.ChatBackupOnetoOne, false, false)
    }
    
    func Receivce_Unread_message(Senderid :String , Receiverid:String, message:@escaping (_ isExist: Bool) -> ()) {
        let node = Senderid < Receiverid ? "\(String.getString(Senderid))_\(String.getString(Receiverid))" : "\(String.getString(Receiverid))_\(String.getString(Senderid))"
        if String.getString(node) == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        
        messageReferense.child(node).queryOrdered(byChild: Parameters.status).queryEqual(toValue: "not_seen").observe(.value) { (snapshot) in
            
            if snapshot.exists() {
                let msgs = kSharedInstance.getDictionary(snapshot.value)
                guard let vc = UIApplication.topViewController() else { return }
                if vc .isKind(of: ConversationViewController.self) {
                    //MessageList.saveUnreadMessages(result: msgs, userId: Receiverid)
                }
                else {
                    
                    msgs.forEach {(key, value) in
                        let dic = kSharedInstance.getDictionary(value)
                        let chatId       = String.getString(dic[Parameters.chat_id])
                        let messageId = String.getString(key)
                        
                        if !chatId.isEmpty && !messageId.isEmpty {
                            self.messageReferense.child(chatId).child(messageId).child(Parameters.status).observeSingleEvent(of: .value, with: { (SnapShot) in
                                if SnapShot.exists() {
                                    let status = SnapShot.value as? String  ?? ""
                                    if status != "seen" {
                                        self.messageReferense.child(chatId).child(messageId).updateChildValues([Parameters.status : "sent"])
                                    }
                                    
                                }
                            })
                        }
                    }
                }
                message(true)
            }
            
        }
        message(false)
        
    }
    
    func Receivce_Delivered_message(Senderid :String , Receiverid:String, message:@escaping (_ isExist: Bool) -> ()) {
        
        let node = Senderid < Receiverid ? "\(String.getString(Senderid))_\(String.getString(Receiverid))" : "\(String.getString(Receiverid))_\(String.getString(Senderid))"
        if String.getString(node) == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        messageReferense.child(node).queryOrdered(byChild: Parameters.status).queryEqual(toValue: "sent").observe(.value) { (snapshot) in
            
            if snapshot.exists() {
                let msgs = kSharedInstance.getDictionary(snapshot.value)
                guard let vc = UIApplication.topViewController() else { return }
                if vc .isKind(of: ConversationViewController.self) {
                    
                    MessageList.saveUnreadMessages(result: msgs, userId: Receiverid)
                }
                message(true)
            }
        }
        message(false)
    }
    
    //MARK:- Func For send Resent Users and retrived data On resent Users Submit Data to Users Every User Submit 2 Node Data Sender and Receiver
    func ResentUser(lastmessage:String, Receiverid:String , Senderid :String  , name:String , profile_image:String , readState :String, isMsgSend: Bool, lastTimestamp: String, msgReceiverId: String, unreadCount: Int, friendStatus: Bool, userSenderId: String , blockId:String = "",isAnonymous:Bool = false,senderName:String,senderImage:String) {
        
        //let userSenderId = kSharedUserDefaults.getLoggedInUserId()
        if String.getString(userSenderId) == Parameters.emptyString || String.getString(Receiverid) == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
      //  let userDetails = kSharedUserDefaults.getLoggedInUserDetails()
        
        let dic:[String : Any] = [ Parameters._id: String.getString(Receiverid),
                                   Parameters.name: String.getString(name),
                                   Parameters.profile_image: String.getString(profile_image),
                                   Parameters.lastmessage : String.getString(lastmessage),
                                   Parameters.timeStamp : String.getString(lastTimestamp) ,
                                   Parameters.readState : String.getString(readState),
                                   Parameters.senderid : String.getString(Senderid),
                                   Parameters.receiverid : String.getString(msgReceiverId),
                                   Parameters._friend : friendStatus,
                                   Parameters.anonymous_chat : isAnonymous ? "1" : "0"
        ]
        
        
        let unreadDict = [Receiverid: unreadCount]
        
        let dicuser = [Parameters._id: kSharedUserDefaults.loggedInUserModal.userId ?? "",
                       Parameters.name: senderName,
                       Parameters.profile_image: senderImage,
                       Parameters.lastmessage : String.getString(lastmessage),
                       Parameters.timeStamp : String.getString(lastTimestamp) ,
                       Parameters.readState : String.getString(readState),
                       Parameters.senderid : String.getString(Senderid),
                       Parameters.receiverid : String.getString(msgReceiverId),
                       Parameters.unread_count: unreadDict,
                       Parameters._friend : friendStatus,
                       Parameters.anonymous_chat : isAnonymous ? "1" : "0"
            
            ] as [String : Any]
        
        resentReferense.child(String.getString("user_" + "\(String.getString(userSenderId))")).child(String.getString("user_" + "\(String.getString(Receiverid))")).updateChildValues(dic)
        
        resentReferense.child(String.getString("user_" + "\(String.getString(Receiverid))")).child(String.getString("user_" + "\(String.getString(userSenderId))")).updateChildValues(dicuser)
        
    }
    
    func deletePerticularMessage(msgId: [String],user_id: String) {
        
        for i in 0..<msgId.count {
            self.messageReferense.child(user_id).child(msgId[i]).removeValue()
        }
        
       
    }
    func deletePost(postId: String) {
        
        self.postReference.child(postId).removeValue()
       
    }
    
    func deleteCommentMessage(commentId: String,user_id: String) {
        
        self.messageReferense.child(user_id).child(commentId).removeValue()
       
    }
    
    func deleteReplyCommentMessage(replyId: String,commentId: String,user_id: String) {
        
        self.messageReferense.child(user_id).child(commentId).child("ReplyDetails").child(replyId).removeValue()
       
    }
    
    func deleteEnquiryPerticularMessage(msgId: [String],user_id: String) {
        
        for i in 0..<msgId.count {
            self.inquirymessageReference.child("PrivateMessages").child(user_id).child(msgId[i]).removeValue()
        }
        
       
    }
    
    
    func deleteUser(child:String, user_id: String,receiverId:String) {
        
        self.inquiryresentReference.child(child).child(user_id).child(receiverId).removeValue()
       
    }
    
    //MARK:- Func For send Resent Users and retrived data On resent Users Submit Data to Users Every User Submit 2 Node Data Sender and Receiver
    func updatereadStateUser(lastmessage:String, Receiverid:String , Senderid :String  , name:String , profile_image:String , readState :String, isMsgSend: Bool, lastTimestamp: String, msgReceiverId: String, unreadCount: Int, friendStatus: Bool, userSenderId: String , blockId:String = "") {
        
        //let userSenderId = kSharedUserDefaults.getLoggedInUserId()
        if String.getString(userSenderId) == Parameters.emptyString || String.getString(Receiverid) == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        let userDetails = kSharedUserDefaults.getLoggedInUserDetails()
        
        let dic:[String : Any] = [ Parameters._id: String.getString(Receiverid),
                                   Parameters.name: String.getString(name),
                                   Parameters.profile_image: String.getString(profile_image),
                                   Parameters.lastmessage : String.getString(lastmessage),
                                   Parameters.timeStamp : String.getString(lastTimestamp) ,
                                   Parameters.readState : String.getString(readState),
                                   Parameters.senderid : String.getString(Senderid),
                                   Parameters.receiverid : String.getString(msgReceiverId),
                                   Parameters._friend : friendStatus ]
        
        let unreadDict = [Receiverid: unreadCount]
        let dicuser = [Parameters._id: kSharedUserDefaults.loggedInUserModal.userId ?? "",
                       Parameters.name: String.getString("\(String.getString(userDetails["user_name"]))"),
                       Parameters.profile_image: String.getString(userDetails["profile_image"]),
                       Parameters.lastmessage : String.getString(lastmessage),
                       Parameters.timeStamp : String.getString(lastTimestamp) ,
                       Parameters.readState : String.getString(readState),
                       Parameters.senderid : String.getString(Senderid),
                       Parameters.receiverid : String.getString(msgReceiverId),
                       Parameters.unread_count: unreadDict,
                       Parameters._friend : friendStatus
            
            ] as [String : Any]
        //        Database.database().reference().child(Parameters.ResentMessage).child(String.getString("user_" + "\(String.getString(userSenderId))")).child(String.getString("user_" + "\(String.getString(Receiverid))")).updateChildValues(dic)
        //
        //        Database.database().reference().child(Parameters.ResentMessage).child(String.getString("user_" + "\(String.getString(Receiverid))")).child(String.getString("user_" + "\(String.getString(userSenderId))")).updateChildValues(dicuser)
        
        resentReferense.child(String.getString("user_" + "\(String.getString(userSenderId))")).child(String.getString("user_" + "\(String.getString(Receiverid))")).observeSingleEvent(of:.value) { (snapshot) in
            if snapshot.exists() {
                self.resentReferense.child(String.getString("user_" + "\(String.getString(userSenderId))")).child(String.getString("user_" + "\(String.getString(Receiverid))")).updateChildValues(dic)
            }
            
        }
        resentReferense.child(String.getString("user_" + "\(String.getString(Receiverid))")).child(String.getString("user_" + "\(String.getString(userSenderId))")).observeSingleEvent(of:.value) { (snapshot) in
            if snapshot.exists() {
                self.resentReferense.child(String.getString("user_" + "\(String.getString(Receiverid))")).child(String.getString("user_" + "\(String.getString(userSenderId))")).updateChildValues(dicuser)
            }
        }
    }
    
    
    func changeStatusFromBackground() {
        let userIdStr = kSharedUserDefaults.loggedInUserModal.userId ?? ""
        if userIdStr == "" {
            return
        }
        resentReferense.child("user_" + userIdStr).observeSingleEvent(of: .value) { [weak self](snapshot) in
            if snapshot.exists() {
                let msgs = kSharedInstance.getDictionary(snapshot.value)
                
                msgs.forEach {(key, value) in
                    let dic = kSharedInstance.getDictionary(value)
                    
                    let Senderid = String.getString(dic[Parameters.senderid])
                    let Receiverid = String.getString(dic[Parameters.receiverid])
                    
                    var friendId = Receiverid
                    if Receiverid == userIdStr {
                        friendId = Senderid
                    }
                    if !friendId.isEmpty {
                        
                        Chat_hepler.Shared_instance.getUeadCountForAConversation(Senderid: friendId, Receiverid: userIdStr) { (count, success) in
                            if success {
                                if count > 0 {
                                    self?.resentReferense.child(String.getString("user_" + "\(String.getString(friendId))")).child(String.getString("user_" + "\(String.getString(userIdStr))")).observeSingleEvent(of: .value) { (snapshot) in
                                        if snapshot.exists() {
                                        //    self?.resentReferense.child(String.getString("user_" + "\(String.getString(friendId))")).child(String.getString("user_" + "\(String.getString(userIdStr))")).updateChildValues([Parameters.readState : "sent"])
                                        }
                                    }
                                    self?.readAllMessageFromBackground(Senderid: userIdStr, Receiverid: friendId)
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    func readAllMessageFromBackground(Senderid :String , Receiverid:String) {
        let node = Senderid < Receiverid ? "\(String.getString(Senderid))_\(String.getString(Receiverid))" : "\(String.getString(Receiverid))_\(String.getString(Senderid))"
        if String.getString(node) == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        Database.database().reference().child(Parameters.Message).child(Parameters.PrivateMessages).child(node).observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                let msgs = kSharedInstance.getDictionary(snapshot.value)
                
                msgs.forEach {(key, value) in
                    let dic = kSharedInstance.getDictionary(value)
                    let deleteStr = String.getString(dic[Parameters.isDeleted])
                    if deleteStr == "" {
                        self.readPerticularMsgFromBackground(data: dic, Senderid: Senderid, Receiverid: Receiverid, uid: String.getString(key))
                    }
                    
                }
            }
            
        }
        
    }
    
    func readPerticularMsgFromBackground(data: [String: Any], Senderid :String , Receiverid:String, uid: String)  {
        let node = Senderid < Receiverid ? "\(String.getString(Senderid))_\(String.getString(Receiverid))" : "\(String.getString(Receiverid))_\(String.getString(Senderid))"
        if String.getString(node) == Parameters.emptyString || String.getString(Senderid) == Parameters.emptyString || String.getString(Receiverid) == Parameters.emptyString || String.getString(uid) == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        
        let msgSenderId  = String.getString(data[Parameters.senderid])
        let status = String.getString(data["status"])
        
        if status == "not_seen" || status == "sent" || status == "" {
            if msgSenderId.count > 1 {
                Database.database().reference().child(Parameters.Message).child(Parameters.PrivateMessages).child(node).child(uid).child(Parameters.senderid).observeSingleEvent(of: .value, with: { (SnapShot) in
                    if SnapShot.exists() {
                        let str = SnapShot.value as? String ?? ""
                        if str != kSharedUserDefaults.loggedInUserModal.userId ?? "" && str.count > 1{
                            Database.database().reference().child(Parameters.Message).child(Parameters.PrivateMessages).child(node).child(uid).updateChildValues([Parameters.status : "sent"])
                            
                            //NotificationCenter.default.post(name: NSNotification.Name(Notifications.kChatNotificationReceived), object: nil)
                            
                        }
                    }
                })
                
                
            }
        }
        
    }
    
    func readPerticularMsgInForeround(data: [String: Any])  {
        let messageId = String.getString(data["message_id"])
        let chatId = String.getString(data["chat_id"])
        let senderId = String.getString(data["sender_id"])
        let receiverId = String.getString(data["friend_id"])
        //let userDetails = sharedUserDefaults.getLoggedInUserDetails()
        //let userid = String.getString(userDetails[APIKeys.user_id])
        
        if chatId == "" || messageId == "" || receiverId == ""{
            return
        }
        
        //NotificationCenter.default.post(name: NSNotification.Name(Notifications.kChatNotificationReceived), object: nil)
        
        Chat_hepler.Shared_instance.Receivce_Unread_message(Senderid: senderId, Receiverid: receiverId) { (isExist) in
            
        }
        
        //Private Message
        //        Database.database().reference().child(Parameters.Message).child(Parameters.PrivateMessages).child(chatId).child(messageId).child(Parameters.status).observeSingleEvent(of: .value, with: { (SnapShot) in
        //            if SnapShot.exists() {
        //                let status = SnapShot.value as? String  ?? ""
        //                if status != "seen" {
        //                    Database.database().reference().child(Parameters.Message).child(Parameters.PrivateMessages).child(chatId).child(messageId).updateChildValues([Parameters.status : "sent"])
        //                }
        //
        //            }
        //        })
        
        //Recent Message
        Database.database().reference().child(Parameters.ResentMessage).child(String.getString("user_" + "\(String.getString(senderId))")).child(String.getString("user_" + "\(String.getString(receiverId))")).child(Parameters.readState).observeSingleEvent(of: .value, with: { (SnapShot) in
            if SnapShot.exists() {
                let status = SnapShot.value as? String  ?? ""
                if status != "seen" {
                    Database.database().reference().child(Parameters.ResentMessage).child(String.getString("user_" + "\(String.getString(senderId))")).child(String.getString("user_" + "\(String.getString(receiverId))")).updateChildValues([Parameters.readState : "sent"])
                }
                
            }
        })
        
    }
    
    func send_post(messageDic:PostClass, postId :Int) {
        
        let sendReference = postReference.child(String.getString(postId))
        let message = messageDic.createDictonary(objects: messageDic)
        sendReference.setValue(kSharedInstance.getDictionary(message))
        
    }
    
    func update_post(likecount :Int, postId :Int){
        postReference.child(String.getString(postId)).updateChildValues(["likeCount":likecount])
    }
    
    
    
    func update_comment_message(msg :String, postId :Int, commentId :Int){
        postReference.child(String.getString(postId)).child("comment").child(String.getString(commentId)).updateChildValues(["body":msg])
    }
    
    func update_replycomment_message(msg :String, postId :Int, commentId :Int, replycommentId :Int){
        postReference.child(String.getString(postId)).child("comment").child(String.getString(commentId)).child("ReplyDetails").child(String.getString(replycommentId)).updateChildValues(["body":msg])
    }
    
    func update_replycomment_Like_count(likecount :Int, postId :Int, commentId :Int, replycommentId :Int){
        postReference.child(String.getString(postId)).child("comment").child(String.getString(commentId)).child("ReplyDetails").child(String.getString(replycommentId)).updateChildValues(["comment_like_count":likecount])
    }
    
    func update_comment_Like_count(likecount :Int, postId :Int, commentId :Int){
        postReference.child(String.getString(postId)).child("comment").child(String.getString(commentId)).updateChildValues(["comment_like_count":likecount])
    }
    
    func send_comment(countDic:LikeCommentClass, commentDisc:CommentClass, poster: PosterClass,avtar: CommentAvatarId, postId :String) {
        
        //countDic.data = commentDisc
        //countDic.data?.data = poster
        //countDic.data?.data?.data = avtar
        
        
        let sendReference = postReference.child(postId)
        //let message = countDic.createDictonary(objects: countDic, objects2: commentDisc, objects3: poster, objects4: avtar)
        let message = countDic.createDictonary(objects: countDic)
        
        let message1 = commentDisc.createDictonary(objects: commentDisc)
        let message2 = poster.createDictonary(objects: poster)
        let message3 = avtar.createDictonary(objects: avtar)
        
        //sendReference.setValue(message)
        sendReference.child("comment").child(String.getString(commentDisc.core_comment_id)).setValue(message1)
        sendReference.child("comment").child(String.getString(commentDisc.core_comment_id)).child("poster").setValue(message2)
        sendReference.child("comment").child(String.getString(commentDisc.core_comment_id)).child("poster").child("avatar_id").setValue(message3)
        
        
        //sendReference.setValue(countDic)
        
        
    }
    
    
    func send_comment_like(commentlike:Comment_Like_Class,postid:String) {
        
        //countDic.data = commentDisc
        //countDic.data?.data = poster
        //countDic.data?.data?.data = avtar
        
        
        let sendReference = commentLikeReference.child(postid)
        let message1 = commentlike.createDictonary(objects: commentlike)
        //sendReference.setValue(message)
        sendReference.child(String.getString(commentlike.like_id)).setValue(message1)
        
        
        //sendReference.setValue(countDic)
        
        
    }
    
    
    func send_reply_comment(countDic:LikeCommentClass, commentDisc:CommentClass, poster: PosterClass,avtar: CommentAvatarId, postId :String, replypostId :String) {
        
        //countDic.data = commentDisc
        //countDic.data?.data = poster
        //countDic.data?.data?.data = avtar
        
        
        let sendReference = postReference.child(postId).child("comment").child(replypostId)
        //let message = countDic.createDictonary(objects: countDic, objects2: commentDisc, objects3: poster, objects4: avtar)
        let message = countDic.createDictonary(objects: countDic)
        
        let message1 = commentDisc.createDictonary(objects: commentDisc)
        let message2 = poster.createDictonary(objects: poster)
        let message3 = avtar.createDictonary(objects: avtar)
        
        //sendReference.setValue(message)
        sendReference.child("ReplyDetails").child(String.getString(commentDisc.core_comment_id)).setValue(message1)
        sendReference.child("ReplyDetails").child(String.getString(commentDisc.core_comment_id)).child("poster").setValue(message2)
        sendReference.child("ReplyDetails").child(String.getString(commentDisc.core_comment_id)).child("poster").child("avatar_id").setValue(message3)
        
        
        //sendReference.setValue(countDic)
        
        
    }
    
    //MARK:- Function For Send message one to one Chat
    
    
    func inquirysend_message(child:String,messageDic:InquiryReceivedMessageClass,senderId :String , receiverId:String, storeId:String) {
        
       // unread = 0
        inquiryreceiveUsers(otherId: receiverId, child: child)
        
        //DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
            let messageNode = "\(String.getString(senderId))_\(String.getString(receiverId))_\(storeId)"//self.createNode(senderId: senderId, receiverId: receiverId)
            if String.getString(messageNode) == Parameters.emptyString {
                print(Parameters.alertmessage)
                return
            }
            
            let sendReference = self.inquirymessageReference.child("PrivateMessages").child(messageNode).childByAutoId()
            messageDic.uid = sendReference.key
            let message = messageDic.createDictonary(objects: messageDic)
            print("send message to node \(messageNode) with key \(sendReference.key ?? "") with message \(message)")
            sendReference.setValue(kSharedInstance.getDictionary(message))
            
            //recevier semd messgae
            let recemessageNode = "\(String.getString(receiverId))_\(String.getString(senderId))_\(storeId)"//self.createNode(senderId: receiverId, receiverId: senderId)
            if String.getString(recemessageNode) == Parameters.emptyString {
                print(Parameters.alertmessage)
                return
            }
            let receiveReference = self.inquirymessageReference.child("PrivateMessages").child(recemessageNode).child(sendReference.key!)
            //messageDic.uid = sendReference.key
            //let recmessage = messageDic.createDictonary(objects: messageDic)
            print("send message to node \(recemessageNode) with key \(receiveReference.key ?? "") with message \(message)")
            receiveReference.setValue(kSharedInstance.getDictionary(message))
            
            
            self.inquiry_resentUser(messageDetails: messageDic, child: child)
       // })
            
            
        
    }
    
    
    func send_message(messageDic:ReceivedMessageClass,senderId :String , receiverId:String) {
        
        receiveUsers(otherId: receiverId)
        
        let messageNode = "\(String.getString(senderId))_\(String.getString(receiverId))"//self.createNode(senderId: senderId, receiverId: receiverId)
        if String.getString(messageNode) == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        
        let sendReference = messageReference.child("PrivateMessages").child(messageNode).childByAutoId()
        messageDic.uid = sendReference.key
        let message = messageDic.createDictonary(objects: messageDic)
        print("send message to node \(messageNode) with key \(sendReference.key ?? "") with message \(message)")
        sendReference.setValue(kSharedInstance.getDictionary(message))
        
        //recevier semd messgae
        let recemessageNode = "\(String.getString(receiverId))_\(String.getString(senderId))"//self.createNode(senderId: receiverId, receiverId: senderId)
        if String.getString(recemessageNode) == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        let receiveReference = messageReference.child("PrivateMessages").child(recemessageNode).child(sendReference.key!)
        //messageDic.uid = sendReference.key
        //let recmessage = messageDic.createDictonary(objects: messageDic)
        print("send message to node \(recemessageNode) with key \(receiveReference.key ?? "") with message \(message)")
        receiveReference.setValue(kSharedInstance.getDictionary(message))
        
        self.resentUser(messageDetails: messageDic)
        
    }
    
    //MARK:- Func For send Resent Users and retrived data On resent Users Submit Data to Users Every User Submit 2 Node  Sender and Receiver
    func inquiry_resentUser(messageDetails:InquiryReceivedMessageClass,child : String) {
        let senderId = messageDetails.senderid ?? ""
        let receiverId = messageDetails.receiverid ?? ""
        if String.getString(senderId) == Parameters.emptyString || String.getString(receiverId) == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        let receiverDetails = [ Parameters.uid : String.getString(messageDetails.uid),
                                Parameters.otherId : String.getString(receiverId),
                                Parameters.lastmessage : String.getString(messageDetails.message),
                                Parameters.mediaType    : String.getString(messageDetails.mediaType?.rawValue) ,
                                Parameters.timeStamp : String.getString(Int(Date().timeIntervalSince1970 * 1000)),
                                Parameters.otherImage : String.getString(messageDetails.receiverImage) ,
                                Parameters.otherName : String.getString(messageDetails.receiverName),
                                Parameters.producerUserId : String.getString(messageDetails.producerUserId),
                                Parameters.storeId : String.getString(messageDetails.storeId),
                                Parameters.storeName : String.getString(messageDetails.storeName),
                                Parameters.productId : String.getString(messageDetails.productId),
                                Parameters.productName : String.getString(messageDetails.productName),
                                Parameters.productImage : String.getString(messageDetails.productImage),
                                
                                Parameters.readCount : 0,
                                Parameters.userTyping : false] as [String : Any]
        
      
        let senderDetails =   [Parameters.uid : String.getString(messageDetails.uid),
                               Parameters.otherId : String.getString(senderId),
                               Parameters.lastmessage : String.getString(messageDetails.message),
                               Parameters.mediaType    : String.getString(messageDetails.mediaType?.rawValue) ,
                               Parameters.timeStamp : String.getString(Int(Date().timeIntervalSince1970 * 1000)),
                               Parameters.otherImage : String.getString(messageDetails.senderImage) ,
                               Parameters.otherName : String.getString(messageDetails.senderName),
                               Parameters.producerUserId : String.getString(messageDetails.producerUserId),
                               Parameters.storeId : String.getString(messageDetails.storeId),
                               Parameters.storeName : String.getString(messageDetails.storeName),
                               Parameters.productId : String.getString(messageDetails.productId),
                               Parameters.productName : String.getString(messageDetails.productName),
                               Parameters.productImage : String.getString(messageDetails.productImage),
                               
                               Parameters.readCount : unread, // increase count
                               Parameters.userTyping : false] as [String : Any]
        
        
        print("recent receiverDetails ",receiverDetails)
        print("recent senderDetails ",senderDetails)
        
        if child == "New" {
            inquiryresentReference.child("Opened").child("user_\(senderId)").child("user_\(receiverId)_\(String.getString(messageDetails.productId))").updateChildValues(receiverDetails)
            inquiryresentReference.child(child).child("user_\(receiverId)").child("user_\(senderId)_\(String.getString(messageDetails.productId))").updateChildValues(senderDetails)
           // unread = 0
        } else if child == "Opened"{
            deleteUser(child: "New", user_id: "user_"+(String.getString(kSharedUserDefaults.loggedInUserModal.userId)), receiverId: "user_"+receiverId+"_\(String.getString(messageDetails.productId))")
            
            inquiryresentReference.child(child).child("user_\(senderId)").child("user_\(receiverId)_\(String.getString(messageDetails.productId))").updateChildValues(receiverDetails)
            inquiryresentReference.child(child).child("user_\(receiverId)").child("user_\(senderId)_\(String.getString(messageDetails.productId))").updateChildValues(senderDetails)
            //unread = 0
        } else if child == "Closed" {
            
            deleteUser(child: "Closed", user_id: "user_"+(String.getString(kSharedUserDefaults.loggedInUserModal.userId)), receiverId: "user_"+receiverId+"_\(String.getString(messageDetails.productId))")
            
            deleteUser(child: "Closed", user_id: "user_"+receiverId, receiverId: "user_"+(String.getString(kSharedUserDefaults.loggedInUserModal.userId))+"_\(String.getString(messageDetails.productId))")
            
            inquiryresentReference.child("Opened").child("user_\(senderId)").child("user_\(receiverId)_\(String.getString(messageDetails.productId))").updateChildValues(receiverDetails)
            inquiryresentReference.child("Opened").child("user_\(receiverId)").child("user_\(senderId)_\(String.getString(messageDetails.productId))").updateChildValues(senderDetails)
           // unread = 0
            
        } else if child == "Blocked" {
            
            deleteUser(child: "Opened", user_id: "user_"+(String.getString(kSharedUserDefaults.loggedInUserModal.userId)), receiverId: "user_"+receiverId+"_\(String.getString(messageDetails.productId))")
            
            deleteUser(child: "Opened", user_id: "user_"+receiverId, receiverId: "user_"+(String.getString(kSharedUserDefaults.loggedInUserModal.userId))+"_\(String.getString(messageDetails.productId))")
            
            inquiryresentReference.child("Closed").child("user_\(senderId)").child("user_\(receiverId)_\(String.getString(messageDetails.productId))").updateChildValues(receiverDetails)
            inquiryresentReference.child("Closed").child("user_\(receiverId)").child("user_\(senderId)_\(String.getString(messageDetails.productId))").updateChildValues(senderDetails)
           // unread = 0
            
        }
        
        
    }
    
    func resentUser(messageDetails:ReceivedMessageClass) {
        let senderId = messageDetails.senderid ?? ""
        let receiverId = messageDetails.receiverid ?? ""
        if String.getString(senderId) == Parameters.emptyString || String.getString(receiverId) == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        let receiverDetails = [ Parameters.uid : String.getString(messageDetails.uid),
                                Parameters.otherId : String.getString(receiverId),
                                Parameters.lastmessage : String.getString(messageDetails.message),
                                Parameters.mediaType    : String.getString(messageDetails.mediaType?.rawValue) ,
                                Parameters.timeStamp : String.getString(Int(Date().timeIntervalSince1970 * 1000)),
                                Parameters.otherImage : String.getString(messageDetails.receiverImage) ,
                                Parameters.otherName : String.getString(messageDetails.receiverName),
                                Parameters.readCount : 0,
                                Parameters.userTyping : false] as [String : Any]
        
        let senderDetails =   [Parameters.uid : String.getString(messageDetails.uid),
                               Parameters.otherId : String.getString(senderId),
                               Parameters.lastmessage : String.getString(messageDetails.message),
                               Parameters.mediaType    : String.getString(messageDetails.mediaType?.rawValue) ,
                               Parameters.timeStamp : String.getString(Int(Date().timeIntervalSince1970 * 1000)),
                               Parameters.otherImage : String.getString(messageDetails.senderImage) ,
                               Parameters.otherName : String.getString(messageDetails.senderName),
                               Parameters.readCount : unread, // increase count
                               Parameters.userTyping : false] as [String : Any]
        
        resentReference.child("user_\(senderId)").child("user_\(receiverId)").updateChildValues(receiverDetails)
        resentReference.child("user_\(receiverId)").child("user_\(senderId)").updateChildValues(senderDetails)
    }
    
    
    func receiveUsers(otherId: String) {
        
        kChatharedInstance.receiveResentUsers(userid:otherId) { (users) in
            self.Resentuser?.removeAll()
            self.Resentuser = users
            
            //self.unread = 0
            for i in 0..<(self.Resentuser?.count ?? 0){
                
                if self.Resentuser![i].otherId == String.getString(kSharedUserDefaults.loggedInUserModal.userId) {
                    self.unread = self.Resentuser![i].readCount + 1
                    
                }
                
            }
            
            print("unread count ",self.unread)
            
        }
        
    }
    
    
    func inquiryreceiveUsers(otherId: String,child: String) {
        
        kChatharedInstance.inquiry_receiveResentUsers(userid:otherId, child: child) { (users) in
            self.Inquiry_Resentuser?.removeAll()
            self.Inquiry_Resentuser = users
            
            //self.unread = 0
            for i in 0..<(self.Inquiry_Resentuser?.count ?? 0){
                
                if self.Inquiry_Resentuser![i].otherId == String.getString(kSharedUserDefaults.loggedInUserModal.userId) {
                    self.unread = self.Inquiry_Resentuser![i].readCount + 1
                    
                }
                
            }
            
            if self.Inquiry_Resentuser?.count == 0 {
                self.unread = 1
            }
            
            print("unread count ",self.unread)
            
        }
        
    }
    
    func deleteParticularComment(post_id: String,comment_id: String) {
        
        postReference.child(post_id).child("comment").child(comment_id).removeValue()
       
    }
    
    func deleteParticularCommentLike(like_id: String,post_id: String) {
        
        commentLikeReference.child(post_id).child(like_id).removeValue()
       
    }
    
    func deleteParticularCommentLike(comment_id: String,post_id: String,replycomment_id: String) {
        
        postReference.child(post_id).child("comment").child(comment_id).child("ReplyDetails").child(replycomment_id).removeValue()
       
    }
    
    
    //MARK:- Func For Receive Message for One To One Chat
    func receivce_Comment(postId :String , message:@escaping (_ result: [CommentClass]?) -> ()) -> Void {
        
        postReference.child(postId).child("comment").observe(.value) { [weak self] (snapshot) in
            self?.commentmessageclass.removeAll()
            if snapshot.exists() {
                let msgs = kSharedInstance.getDictionary(snapshot.value)
               
                msgs.forEach {(key, value) in
                   
                    let dic = kSharedInstance.getDictionary(value)
                    self?.commentmessageclass.append(CommentClass( with: dic))
                    
                    self?.commentmessageclass.sort{ Int.getInt($0.core_comment_id) > Int.getInt($1.core_comment_id) }
                    
                    
                }
            }
            message(self?.commentmessageclass)
        }
    }
    
    
    
    
    func receivce_Post_like(postId :String , message:@escaping (_ result: [PostClass]?) -> ()) -> Void {
        
        postReference.observe(.value) { [weak self] (snapshot) in
            
            self?.postlikeclass.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {

                           let position = child as! DataSnapshot

                           let positionsInfo = position.value as! [String: Any]
                
                if positionsInfo[Parameters.postId] != nil  && positionsInfo[Parameters.likeCount] != nil {
                   // let jobTitle = positionsInfo[Parameters.postId] as! Int
                    
                    let resentusersDetails = PostClass()
                    resentusersDetails.postId     =  Int.getInt(positionsInfo[Parameters.postId])
                    resentusersDetails.likeCount    =  Int.getInt(positionsInfo[Parameters.likeCount])
                    resentusersDetails.commentCount       =  Int.getInt(positionsInfo[Parameters.commentCount])
                    
                    
                    self?.postlikeclass.append(resentusersDetails)
                    
                }
            
            }
            message(self?.postlikeclass)
            
        }
        
       
    }
    
    func receivce_Comment_Like(postId :String, message:@escaping (_ result: [Comment_Like_Class]?) -> ()) -> Void {
        
        commentLikeReference.child(postId).observe(.value) { [weak self] (snapshot) in
            //self?.commentlikeclass.removeAll()
            
            if snapshot.exists() {
                let usersDetails = kSharedInstance.getDictionary(snapshot.value)
                self?.commentlikeclass.removeAll()
                usersDetails.forEach {(key, value) in
                    
                    let positionsInfo = kSharedInstance.getDictionary(value)
                    
                    let likeDetails = Comment_Like_Class()
                    likeDetails.user_id = Int.getInt(positionsInfo[Parameters.userid])
                    likeDetails.like_id = Int.getInt(positionsInfo[Parameters.like_id])
                    likeDetails.comment_id = Int.getInt(positionsInfo[Parameters.core_comment_id])
                    
                    self?.commentlikeclass.append(likeDetails)
                }
                
            }
            

            message(self?.commentlikeclass)
        }
    }
    
    func receivce_user_data(userID :String , message:@escaping (_ result: [userClass]?) -> ()) -> Void {
        
        userReference.child(userID).observe(.value) { [weak self] (snapshot) in
            
            if snapshot.exists() {
                
                let usersDetails = kSharedInstance.getDictionary(snapshot.value)
                self?.userclass.removeAll()
                //usersDetails.forEach {(key, value) in
                    
                    //let positionsInfo = kSharedInstance.getDictionary(value)
                    
                    let resentusersDetails = userClass()
                    resentusersDetails.user_id     =  Int.getInt(usersDetails[Parameters.userid])
                    resentusersDetails.alysei_approval    =  Bool.getBool(usersDetails[Parameters.alysei_approval])
                    resentusersDetails.name       =  String.getString(usersDetails[Parameters.name])
                    resentusersDetails.notification = Int.getInt(usersDetails[Parameters.notification])
                    self?.userclass.append(resentusersDetails)
                //}
                
            }
            
            message(self?.userclass)
            
        }
        
    }
    
    func notificationUpdate(userID :String){
        userReference.child(userID).updateChildValues(["notification": 0])
    }
    
    
    //MARK:- Func For Receive Message for One To One Chat
    
    func inquiryreceivce_message(senderId :String , receiverId:String, storeId:String , message:@escaping (_ result: [InquiryReceivedMessageClass]? , _ chatBackup : [InquiryReceivedMessageClass]?) -> ()) -> Void {
        
        let messageNode = "\(String.getString(senderId))_\(String.getString(receiverId))_\(storeId)"//self.createNode(senderId: senderId, receiverId: receiverId)
        if String.getString(messageNode) == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        
        inquirymessageReference.child("PrivateMessages").child(messageNode).observe(.value) { [weak self] (snapshot) in
            self?.inquirychatBackupOnetoOne.removeAll()
            self?.inquirymessageclass.removeAll()
            if snapshot.exists() {
                let msgs = kSharedInstance.getDictionary(snapshot.value)
                msgs.forEach {(key, value) in
                    let dic = kSharedInstance.getDictionary(value)
                    let isDeleted =  String.getString(dic[Parameters.deleted]).components(separatedBy: Parameters.saparaterString)
                    
                    if !(isDeleted.contains(String.getString(senderId))) {
                        self?.inquirymessageclass.append(InquiryReceivedMessageClass(uid: String.getString(key), messageData: dic))
                        self?.inquirymessageclass.sort{ Int.getInt($0.timestamp) < Int.getInt($1.timestamp) }
                    } else {
                        self?.inquirychatBackupOnetoOne.append(InquiryReceivedMessageClass(uid: String.getString(key), messageData: dic))
                        self?.inquirychatBackupOnetoOne.sort{ Int.getInt($0.timestamp) < Int.getInt($1.timestamp)}
                    }
                    
                }
            }
            message(self?.inquirymessageclass, self?.inquirychatBackupOnetoOne)
        }
    }
    
    func receivce_message(senderId :String , receiverId:String , message:@escaping (_ result: [ReceivedMessageClass]? , _ chatBackup : [ReceivedMessageClass]?) -> ()) -> Void {
        
        let messageNode = "\(String.getString(senderId))_\(String.getString(receiverId))"//self.createNode(senderId: senderId, receiverId: receiverId)
        if String.getString(messageNode) == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        
        messageReference.child("PrivateMessages").child(messageNode).observe(.value) { [weak self] (snapshot) in
            self?.chatBackupOnetoOne.removeAll()
            self?.messageclass.removeAll()
            if snapshot.exists() {
                let msgs = kSharedInstance.getDictionary(snapshot.value)
                msgs.forEach {(key, value) in
                    let dic = kSharedInstance.getDictionary(value)
                    let isDeleted =  String.getString(dic[Parameters.deleted]).components(separatedBy: Parameters.saparaterString)
                    
                    if !(isDeleted.contains(String.getString(senderId))) {
                        self?.messageclass.append(ReceivedMessageClass(uid: String.getString(key), messageData: dic))
                        self?.messageclass.sort{ Int.getInt($0.timestamp) < Int.getInt($1.timestamp) }
                    } else {
                        self?.chatBackupOnetoOne.append(ReceivedMessageClass(uid: String.getString(key), messageData: dic))
                        self?.chatBackupOnetoOne.sort{ Int.getInt($0.timestamp) < Int.getInt($1.timestamp)}
                    }
                    
                }
            }
            message(self?.messageclass, self?.chatBackupOnetoOne)
        }
    }
    
    func updateRecentChatMessageCount(receiverId: String, senderId: String) {
        let messageNode = self.createNode(senderId: senderId, receiverId: receiverId)
        messageReference.child(messageNode).updateChildValues(["readState": "0"])
        resentReference.child(senderId).child(receiverId).observeSingleEvent(of: .value) { (snapshot) in
            var senderDetails: [String:Any]?
            if snapshot.exists() {
                 senderDetails = kSharedInstance.getDictionary(snapshot.value)
            }
            
            if senderDetails != nil {
                self.resentReference.child(senderId).child(receiverId).updateChildValues(["unread_count": "0"])
            }
        }
    }
    
    //MARK:- Func for createNode
    func createNode(senderId:String, receiverId:String) -> String {
        return senderId < receiverId ? "\(String.getString(senderId))_\(String.getString(receiverId))" : "\(String.getString(receiverId))_\(String.getString(senderId))"
    }
    
    //MARK:- Func For Resent Users retrived on Recent Screen user User Id
    func inquiry_receiveResentUsers(userid:String,child: String, resentUsers:@escaping (_ result: [InquiryRecentUser]?) -> ()) -> Void{
        if userid == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        self.inquiry_resentUser.removeAll()
        inquiryresentReference.child(child).child("user_\(userid)").observe(.value) { [weak self](snapshot) in
            self?.inquiry_resentUser.removeAll()
            if snapshot.exists() {
                let usersDetails = kSharedInstance.getDictionary(snapshot.value)
                self?.inquiry_resentUser.removeAll()
                usersDetails.forEach {(key, value) in
                    let details = kSharedInstance.getDictionary(value)
                    //details[Parameters.otherId] = key
                    
                    let resentusersDetails = InquiryRecentUser()
                    resentusersDetails.lastmessage     =  String.getString(details[Parameters.lastmessage])
                    resentusersDetails.mediaType    =  String.getString(details[Parameters.mediaType])
                    resentusersDetails.otherId       =  String.getString(details[Parameters.otherId])
                    resentusersDetails.otherName    =  String.getString(details[Parameters.otherName])
                    resentusersDetails.otherImage      =  String.getString(details[Parameters.otherImage])
                    resentusersDetails.readState       = String.getString(details[Parameters.readState])
                    
                    resentusersDetails.storeId       = String.getString(details[Parameters.storeId])
                    resentusersDetails.storeName       = String.getString(details[Parameters.storeName])
                    resentusersDetails.productId       = String.getString(details[Parameters.productId])
                    resentusersDetails.productName       = String.getString(details[Parameters.productName])
                    resentusersDetails.productImage       = String.getString(details[Parameters.productImage])
                    resentusersDetails.producerUserId       = String.getString(details[Parameters.producerUserId])
                    
                    resentusersDetails.timestamp       = Int.getInt(details[Parameters.timestamp])
                    resentusersDetails.readCount       = Int.getInt(details[Parameters.readCount])
                    resentusersDetails.uid = String.getString(details[Parameters.uid])
                    resentusersDetails.userTyping      = Bool.getBool(details[Parameters.userTyping])
                    
                   // let firstIndex = self?.inquiry_resentUser.firstIndex{$0.productId == resentusersDetails.productId}
                   // if firstIndex != nil { self?.inquiry_resentUser.remove(at: firstIndex!) }
                    self?.inquiry_resentUser.append(resentusersDetails)
                    self?.inquiry_resentUser.sort { $0.timestamp > $1.timestamp }
                  //  self?.resentUser = self?.resentUser.uniqueArray(map: {$0.uid}) ?? []
                    resentUsers(self?.inquiry_resentUser)
                    
                }
            }
        }
    }
    
    
    func receiveResentUsers(userid:String, resentUsers:@escaping (_ result: [RecentUser]?) -> ()) -> Void{
        if userid == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        self.resentUser.removeAll()
        resentReference.child("user_\(userid)").observe(.value) { [weak self](snapshot) in
            self?.resentUser.removeAll()
            if snapshot.exists() {
                let usersDetails = kSharedInstance.getDictionary(snapshot.value)
                self?.resentUser.removeAll()
                usersDetails.forEach {(key, value) in
                    let details = kSharedInstance.getDictionary(value)
                    //details[Parameters.otherId] = key
                    
                    let resentusersDetails = RecentUser()
                    resentusersDetails.lastmessage     =  String.getString(details[Parameters.lastmessage])
                    resentusersDetails.mediaType    =  String.getString(details[Parameters.mediaType])
                    resentusersDetails.otherId       =  String.getString(details[Parameters.otherId])
                    resentusersDetails.otherName    =  String.getString(details[Parameters.otherName])
                    resentusersDetails.otherImage      =  String.getString(details[Parameters.otherImage])
                    resentusersDetails.readState       = String.getString(details[Parameters.readState])
                    resentusersDetails.timestamp       = Int.getInt(details[Parameters.timestamp])
                    resentusersDetails.readCount       = Int.getInt(details[Parameters.readCount])
                    resentusersDetails.uid = String.getString(details[Parameters.uid])
                    resentusersDetails.userTyping      = Bool.getBool(details[Parameters.userTyping])
                    
                    let firstIndex = self?.resentUser.firstIndex{$0.otherId == resentusersDetails.otherId}
                    if firstIndex != nil { self?.resentUser.remove(at: firstIndex!) }
                    self?.resentUser.append(resentusersDetails)
                    self?.resentUser.sort { $0.timestamp > $1.timestamp }
                  //  self?.resentUser = self?.resentUser.uniqueArray(map: {$0.uid}) ?? []
                    resentUsers(self?.resentUser)
                    
                }
            }
        }
    }
    
    //MARK:- Func For Resent Users retrived on Recent Screen user User Id
    func Resent_Users(userid:String , message:@escaping (_ result: [ResentUsers]?) -> ()) -> Void{
        CommonUtil.showHudWithNoInteraction(show: true)
        if userid == Parameters.emptyString {
            print(Parameters.alertmessage)
            CommonUtil.showHudWithNoInteraction(show: false)
            return
        }
        self.ResentUser.removeAll()
        Database.database().reference().child(Parameters.ResentMessage).child("user_" + "\(String.getString(userid))").observe(.value) { [weak self](snapshot) in
            CommonUtil.showHudWithNoInteraction(show: false)
            if snapshot.exists() {
                let msgs = kSharedInstance.getDictionary(snapshot.value)
                self?.ResentUser.removeAll()
                guard let vc = UIApplication.topViewController() else { return }
                //if vc .isKind(of: ChatsViewController.self) {
                ResentUsers.saveRecentUser(result: msgs)
                NotificationCenter.default.post(name: NSNotification.Name(Notifications.kChatNotificationReceived), object: nil)
                //}
                
                msgs.forEach {(key, value) in
                    let dic = kSharedInstance.getDictionary(value)
                    let sendId = String.getString(dic[Parameters.senderid])
                    let recId = String.getString(dic[Parameters.receiverid])
                    if recId.count > 1 {
                        
                        var friendId = recId
                        if userid == recId {
                            friendId = sendId
                        }
                        if !(vc .isKind(of: ConversationViewController.self)) {
                            let unreadDic = kSharedInstance.getDictionary(dic[Parameters.unread_count])
                            var count = 0
                            unreadDic.forEach {(key, value) in
                                count = Int.getInt(value)
                            }
                            if count > 0 {
                                Database.database().reference().child(Parameters.ResentMessage).child(String.getString("user_" + "\(String.getString(friendId))")).child(String.getString("user_" + "\(String.getString(userid))")).observeSingleEvent(of: .value) { (snapshot) in
                                    if snapshot.exists() {
                                        Database.database().reference().child(Parameters.ResentMessage).child(String.getString("user_" + "\(String.getString(friendId))")).child(String.getString("user_" + "\(String.getString(userid))")).updateChildValues([Parameters.readState : "sent"])
                                    }
                                }
                                
                                //Messages
                                Chat_hepler.Shared_instance.Receivce_Unread_message(Senderid: userid, Receiverid: String.getString(friendId)) { (isExist) in
                                    
                                }
                                
                                //                                 Chat_hepler.Shared_instance.Receivce_message(Senderid: userid, Receiverid: String.getString(friendId)) { (value, ChatBackUp, success, isExist)  in
                                //
                                //                                }
                            }
                        }
                        
                    }
                    
                }
            }
            message(self?.ResentUser)
        }
    }
    
    
    
    
    
    
    //MARK:- Function For Star   message One to One Only Star Perticular Message
    func starMessage(Senderid :String , Receiverid:String , uid:String) {
        
        if String.getString(Senderid) == Parameters.emptyString || String.getString(Receiverid) == Parameters.emptyString || String.getString(uid) == Parameters.emptyString {
            //CommonUtils.showNotification(message: Parameters.alertmessage)
            print(Parameters.alertmessage)
            return
        }
        
        let node = Senderid > Receiverid ? "\(String.getString(Senderid))_\(String.getString(Receiverid))" :  "\(String.getString(Receiverid))_\(String.getString(Senderid))"
        var starmessage = String()
        Database.database().reference().child(Parameters.Message).child(node).child(uid).child(Parameters.starmessage).observe(.value) { (snapshot) in
            if snapshot.exists() {
                starmessage = String.getString(snapshot.value)
                print(starmessage)
            }
        }
        Database.database().reference().child(Parameters.Message).child(node).observeSingleEvent(of: .value, with: { (SnapShot) in
            if SnapShot.exists() {
                starmessage.isEmpty ? Database.database().reference().child(Parameters.Message).child(node).child(uid).child(Parameters.starmessage).setValue(Senderid) :  Database.database().reference().child(Parameters.Message).child(node).child(uid).child(Parameters.starmessage).setValue("\(starmessage)_\(Senderid)")
            }
        })
    }
    
    func changeLikeStatus(chatId: String, uid: String, likeStatus:String) {
        if chatId == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        messageReferense.child(chatId).child(uid).child(Parameters.likeStatus).setValue(likeStatus)
    }
    
    //MARK:- Function For Read message Count ForScreen Batch
    func readMessage(Senderid :String , Receiverid:String , readstate:String , counters:@escaping (_ result: Int) -> ()) {
        let node = Senderid > Receiverid ? "\(String.getString(Senderid))_\(String.getString(Receiverid))" : "\(String.getString(Receiverid))_\(String.getString(Senderid))"
        if node == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        var countreadMessage = 0
        
        Database.database().reference().child(Parameters.Message).child(node).observe(.value, with: { (snapshot) in
            if snapshot.exists() {
                countreadMessage = 0
                let msgs = kSharedInstance.getDictionary(snapshot.value)
                msgs.forEach {(key, value) in
                    let dic = kSharedInstance.getDictionary(value)
                    let isDeleted =  String.getString(dic[Parameters.isDeleted]).components(separatedBy: Parameters.saparaterString)
                    
                    if !(isDeleted.contains(kSharedUserDefaults.loggedInUserModal.userId ?? "")) {
                        countreadMessage += 1
                    }
                }
            }
            counters(Int(countreadMessage) - Int.getInt(readstate))
        })
    }
    
    
    //MARK:- Function For Read message Count For Resent Screen Batch Only Read Messages
    
    func seenMessageCount( Receiverid:String , Senderid :String , readState :String) {
        if Receiverid == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        if Senderid == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        Database.database().reference().child(Parameters.ResentMessage).child(Senderid).child(Receiverid).updateChildValues([Parameters.readState:readState])
    }
    
    
    
    //MARK:- Func for Clear All Messages From One to One Chat
    func ClearChat(msgclass:[MessageClass] , Senderid:String, Receiverid:String) {
        if Receiverid == Parameters.emptyString || Senderid == Parameters.emptyString{
            print(Parameters.alertmessage)
            return
        }
        
        let node = Senderid < Receiverid ? "\(String.getString(Senderid))_\(String.getString(Receiverid))" :  "\(String.getString(Receiverid))_\(String.getString(Senderid))"
        if node == Parameters.emptyString {
            return
        }
        for index in msgclass {
            let uid = index.uid
            var isDeleted = String()
            messageReferense.child(node).child(uid ?? "").child(Parameters.isDeleted).observe(.value) { (snapshot) in
                if snapshot.exists() {
                    isDeleted = String.getString(snapshot.value)
                    print(isDeleted)
                }
            }
            
            messageReferense.child(node).observeSingleEvent(of: .value, with: { (SnapShot) in
                if SnapShot.exists() {
                    isDeleted.isEmpty ? self.messageReferense.child(node).child(uid ?? "").child(Parameters.isDeleted).setValue(kSharedUserDefaults.loggedInUserModal.userId ?? "") :  self.messageReferense.child(node).child(uid ?? "").child(Parameters.isDeleted).setValue("\(isDeleted)_\(kSharedUserDefaults.loggedInUserModal.userId ?? "")")
                     
                    
                }
            })
        }
    }
    
    func removeFromresent(senderid:String, receiverid:String) {
        //ResentUsers.deleteRecordForUser(userid: String.getString(senderid))
        // ResentUsers.deleteRecordForUser(userid: String.getString(receiverid))
        ResentUsers.deleteChatListForUser(userid1: String.getString(senderid))
        ResentUsers.deleteChatListForUser(userid1: String.getString(receiverid))
        resentReferense.child(String.getString("user_" + "\(String.getString(senderid))")).child(String.getString("user_" + "\(String.getString(receiverid))")).removeValue()
    }
    
    //MARK:- Func for One to One Chat BackUp from remove isDeleted ID from Chat messages
    func ChatBackUpOneToOne(msgclass:[ChatbackupOnetoOne] , Senderid:String, Receiverid:String) {
        if Receiverid == Parameters.emptyString || Senderid == Parameters.emptyString{
            print(Parameters.alertmessage)
            return
        }
        
        let node = Senderid > Receiverid ? "\(String.getString(Senderid))_\(String.getString(Receiverid))" :  "\(String.getString(Receiverid))_\(String.getString(Senderid))"
        for  index in msgclass {
            let uid = index.uid
            var isDeleted = [String]()
            Database.database().reference().child(Parameters.Message).child(node).child(uid ?? "").child(Parameters.isDeleted).observe(.value) { (snapshot) in
                if snapshot.exists() {
                    isDeleted = String.getString(snapshot.value).components(separatedBy: Parameters.saparaterString)
                    
                    if (isDeleted.index{$0 == String.getString(Senderid)} != nil) {
                        isDeleted.remove(at: isDeleted.index{$0 == String.getString(Senderid)}!)
                    }
                    
                    print(isDeleted)
                }
            }
            Database.database().reference().child(Parameters.Message).child(node).observeSingleEvent(of: .value, with: { (SnapShot) in
                if SnapShot.exists() {
                    Database.database().reference().child(Parameters.Message).child(node).child(uid ?? "").child(Parameters.isDeleted).setValue("\(isDeleted.joined(separator: Parameters.saparaterString))")
                }
            })
        }
    }
    
    
    //MARK:- Func for Update User Model for Block Users
    func  UpdateUserModel(userid:String , message:@escaping (_ id: String, _ blockedUsers: [String]) -> ()) -> Void{
        if userid == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        
        Database.database().reference().child(Parameters.UserState).child(userid).observe( .value) { (snapshot) in
            if snapshot.exists() {
                let msgs = kSharedInstance.getDictionary(snapshot.value)
                let status = UsersState(userid: String.getString(msgs[Parameters._id]), lastmessage: String.getString(msgs[Parameters.lastmessage]), time: String.getString(msgs[Parameters.timeStamp]), name: String.getString(msgs[Parameters.name]), imageUrl: String.getString(msgs[Parameters.profile_image]), isOnline: String.getString(msgs[Parameters.OnlineState]), blockUsers: kSharedInstance.getStringArray(msgs[Parameters.blockUsers]))
                message(status.userid ?? Parameters.emptyString, (status.blockUsers ?? [Parameters.emptyString]))
            }
        }
    }
    
    
    
    //MARK:- Func for Block Users And Unblock Users
    
    func blockUnblockUser( Receiverid:String , Senderid :String , BlockCheck : Bool) {
        if Receiverid == Parameters.emptyString || Senderid == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        
        var blockUsers = [String]()
        var blockreceiveruser : [String] = []
        Database.database().reference().child(Parameters.UserState).child(Senderid).child(Parameters.blockUsers).observeSingleEvent(of: .value, with:  { (snapshot) in
            if snapshot.exists() {
                blockUsers = kSharedInstance.getStringArray(snapshot.value)
                print(blockUsers)
                if !BlockCheck {
                    if (blockUsers.index{$0 == String.getString(Receiverid)} != nil) {
                        blockUsers.remove(at: blockUsers.index{$0 == String.getString(Receiverid)}!)
                    }
                }
                BlockCheck ? blockUsers.append(Receiverid) : print("")
                
                BlockCheck ? Database.database().reference().child(Parameters.UserState).child(Senderid).updateChildValues([Parameters.blockUsers : kSharedInstance.getStringArray(blockUsers)]) : Database.database().reference().child(Parameters.UserState).child(Senderid).updateChildValues([Parameters.blockUsers:kSharedInstance.getStringArray(blockUsers)])
            }else {
                BlockCheck ? blockUsers.append(Receiverid) : print("")
                
                BlockCheck ? Database.database().reference().child(Parameters.UserState).child(Senderid).updateChildValues([Parameters.blockUsers : kSharedInstance.getStringArray(blockUsers)]) : Database.database().reference().child(Parameters.UserState).child(Senderid).updateChildValues([Parameters.blockUsers:kSharedInstance.getStringArray(blockUsers)])
            }
        })
        
        Database.database().reference().child(Parameters.UserState).child(Receiverid).child(Parameters.blockUsers).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                blockreceiveruser = kSharedInstance.getStringArray(snapshot.value)
                print(blockreceiveruser)
                if !BlockCheck {
                    if (blockreceiveruser.index{$0 == String.getString(Senderid)} != nil) {
                        blockreceiveruser.remove(at: blockreceiveruser.index{$0 == String.getString(Senderid)}!)
                    }
                    BlockCheck ? blockreceiveruser.append(Senderid) : print("")
                    BlockCheck ? Database.database().reference().child(Parameters.UserState).child(Receiverid).updateChildValues([Parameters.blockUsers:kSharedInstance.getStringArray(blockreceiveruser)]) : Database.database().reference().child(Parameters.UserState).child(Receiverid).updateChildValues([Parameters.blockUsers: kSharedInstance.getStringArray(blockreceiveruser)])
                }
            } else {
                BlockCheck ? blockreceiveruser.append(Senderid) : print("")
                BlockCheck ? Database.database().reference().child(Parameters.UserState).child(Receiverid).updateChildValues([Parameters.blockUsers:kSharedInstance.getStringArray(blockreceiveruser)]) : Database.database().reference().child(Parameters.UserState).child(Receiverid).updateChildValues([Parameters.blockUsers: kSharedInstance.getStringArray(blockreceiveruser)])
            }
        })
        
    }
    
}


//MARK:- Extension for Chat_halper for Group Chat
extension Chat_hepler {
    
    //MARK:- Function For Create Group for Group Chat
    func CreateGroup(groupdic:Dictionary<String, Any> , userdic:[Any] , groupid:@escaping (_ id: String) -> ()) -> Void {
        var groupsDetails = groupdic
        let ref =  Database.database().reference().child(Parameters.Groups).childByAutoId()
        let autoKey = "group_" + "\(String.getString(ref.key))"
        let reference = Database.database().reference().child(Parameters.Groups)
        groupsDetails[Parameters._id] = String.getString(autoKey)
        
        
        let details:[String : Any] = [Parameters.information : kSharedInstance.getDictionary(groupsDetails) , Parameters.Users : kSharedInstance.getArray(userdic)]
        reference.child(autoKey).setValue(details)
        
        let resentDetails = ["id" : String.getString(autoKey) , "name" : String.getString(groupdic["group_name"]) , "profile_image" : "" , "readState" : "" , "receiverid" : "" , "senderid" : ""  , "timestamp" : String.getString(Int(Date().timeIntervalSince1970 * 1000)) , Parameters.CreatedBy : String.getString(autoKey)]
        
        Database.database().reference().child(Parameters.ResentMessage).child(String.getString("user_" + "\(String.getString(groupdic[Parameters.admin_id]))")).child(String.getString(groupsDetails[Parameters._id])).updateChildValues(resentDetails)
        groupid(autoKey)
        
        for users in userdic {
            let userdata = kSharedInstance.getDictionary(users)
            let id = String.getString(userdata["id"])
            Database.database().reference().child(Parameters.ResentMessage).child(String.getString("user_" + "\(String.getString(id))")).child(String.getString(groupsDetails[Parameters._id])).updateChildValues(resentDetails)
        }
        
    }
    
    
    
    //MARK:- Function For Send message to group Chat
    func SendMessagetoGroup(dic:Dictionary<String, Any> , Senderid :String , groupid:String ) {
        
        let node = String.getString(groupid)
        
        if node == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        Database.database().reference().child(Parameters.Message).child("GroupMessages").child(node).childByAutoId().setValue(kSharedInstance.getDictionary(dic))
    }
    
    
    
    //MARK:- Func For Receive Message from Group Chat
    func Receivce_messagefromGroup(groupid :String , message:@escaping (_ result: [MessageClass]?, _ chatbackup : [ChatbackupOnetoOne]?) -> ()) -> Void {
        self.Messageclass.removeAll()
        let node =  String.getString(groupid)
        if node == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        
        Database.database().reference().child(Parameters.Message).child("GroupMessages").child(node).observe(.value) { (snapshot) in
            if snapshot.exists() {
                let msgs = kSharedInstance.getDictionary(snapshot.value)
                self.Messageclass.removeAll()
                
                self.ChatBackupOnetoOne.removeAll()
                msgs.forEach {(key, value) in
                    let dic = kSharedInstance.getDictionary(value)
                    let isDeleted =  String.getString(dic[Parameters.isDeleted]).components(separatedBy: Parameters.saparaterString)
                    let loggedInUserid = kSharedUserDefaults.loggedInUserModal.userId ?? ""
                    if !(isDeleted.contains(loggedInUserid)) {
                        //self.Messageclass.append(MessageClass(uid: String.getString(key), messageData: dic))
                        self.Messageclass.sort{ $0.SendingTime < $1.SendingTime }
                    } else {
                        self.ChatBackupOnetoOne.append(ChatbackupOnetoOne(uid: String.getString(key), messageData: dic))
                        self.ChatBackupOnetoOne.sort{ $0.SendingTime < $1.SendingTime }
                    }
                }
            }
            message(self.Messageclass , self.ChatBackupOnetoOne)
        }
    }
    
    
    
    //MARK:- Function For Updated Group Infromarion for Every users
    func  UpdateGroup(userid:String ,groupid :String, message:@escaping (_ result : GroupModel) -> ()) -> Void{
        
        if  groupid == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        
        Database.database().reference().child(Parameters.Groups).child(groupid).observe( .value) { (snapshot) in
            if snapshot.exists() {
                let msgs = kSharedInstance.getDictionary(snapshot.value)
                let status = GroupModel(userid: String.getString(msgs[Parameters._id]), name: String.getString(msgs[Parameters.name]), imageUrl: String.getString(msgs[Parameters.profile_image]), user: kSharedInstance.getArray(msgs[Parameters.Users]))
                message(status)
            }
        }
    }
    
    
    //MARK:- Func For send Resent Users For Group Chat  Create a Loop And Send Resend Users Information
    
    func GroupResentUser(lastmessage:String, groupid:String , adminid :String  , name:String , profile_image:String , readState :String) {
        
        let timeStamp = String.getString(Int(Date().timeIntervalSince1970 * 1000))
        if  groupid == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        
        let dic = [
            Parameters._id:      String.getString(groupid),
            Parameters.name:    String.getString(name),
            Parameters.profile_image: String.getString(profile_image),
            Parameters.lastmessage : String.getString(lastmessage),
            Parameters.timeStamp : String.getString(timeStamp) ,
            Parameters.CreatedBy : String.getString(groupid)
        ]
        
        self.UpdateGroup(userid: adminid, groupid: groupid) { (value) in
            for users in kSharedInstance.getArray(value.user) {
                let userData = kSharedInstance.getDictionary(users)
                Database.database().reference().child(Parameters.ResentMessage).child(String.getString("user_" + "\(String.getString(userData["id"]))")).child(String.getString(groupid)).updateChildValues(dic)
            }
        }
        
    }

    //MARK:- Func For seenUnseenmessageforGroup
    func seenUnseenmessageforGroup( groupid:String , adminid :String  , userid:String, readState :String) {
        if String.getString(groupid) == Parameters.emptyString || String.getString(adminid) == Parameters.emptyString{
            //CommonUtils.showNotification(message: Parameters.alertmessage)
            print(Parameters.alertmessage)
            return
        }
        
        Database.database().reference().child(Parameters.Groups).child(adminid).child(groupid).child(Parameters.UserSeenCount).child(userid).updateChildValues([Parameters.readState:readState])
    }
    
    
    //MARK:- Function For Delete  message One to One Only Delete Perticular Messege
    func deleteMessage(Senderid :String , Receiverid:String , uid:String) {
        if String.getString(Senderid) == Parameters.emptyString || String.getString(Receiverid) == Parameters.emptyString || String.getString(uid) == Parameters.emptyString {
            //CommonUtils.showNotification(message: Parameters.alertmessage)
            print(Parameters.alertmessage)
            return
        }
        let node = Senderid < Receiverid ? "\(String.getString(Senderid))_\(String.getString(Receiverid))" :  "\(String.getString(Receiverid))_\(String.getString(Senderid))"
        if node == Parameters.emptyString {
            return
        }
        var isDeleted = String()
        messageReferense.child(node).child(uid).child(Parameters.isDeleted).observe(.value) { (snapshot) in
            if snapshot.exists() {
                isDeleted = String.getString(snapshot.value)
                print(isDeleted)
            }
        }
        messageReferense.child(node).observeSingleEvent(of: .value, with: { (SnapShot) in
            if SnapShot.exists() {
                isDeleted.isEmpty ? self.messageReferense.child(node).child(uid).child(Parameters.isDeleted).setValue(kSharedUserDefaults.loggedInUserModal.userId ?? "") :  self.messageReferense.child(node).child(uid).child(Parameters.isDeleted).setValue("\(isDeleted)_\(kSharedUserDefaults.loggedInUserModal.userId ?? "")")
            }
        })
    }

    //MARK:- Func for Delete message from group Only One
    func deletemessagefromgroup(groupid:String , uid :String , Senderid:String) {
        
        if String.getString(groupid) == Parameters.emptyString || String.getString(uid) == Parameters.emptyString{
            //CommonUtils.showNotification(message: Parameters.alertmessage)
            print(Parameters.alertmessage)
            return
        }
        
        var isDeleted = String()
        Database.database().reference().child(Parameters.Message).child("GroupMessages").child(groupid).child(uid).child(Parameters.isDeleted).observe(.value) { (snapshot) in
            if snapshot.exists() {
                isDeleted = String.getString(snapshot.value)
                print(isDeleted)
            }
        }
        Database.database().reference().child(Parameters.Message).child("GroupMessages").child(groupid).observeSingleEvent(of: .value, with: { (SnapShot) in
            if SnapShot.exists() {
                isDeleted.isEmpty ? Database.database().reference().child(Parameters.Message).child("GroupMessages").child(groupid).child(uid).child(Parameters.isDeleted).setValue(Senderid) :  Database.database().reference().child(Parameters.Message).child("GroupMessages").child(groupid).child(uid).child(Parameters.isDeleted).setValue("\(isDeleted)_\(Senderid)")
            }
        })
    }
    
    //MARK:- Func for Delete message from group Only One
    func starmessageIngroup(groupid:String , uid :String , Senderid:String) {
        if String.getString(groupid) == Parameters.emptyString || String.getString(uid) == Parameters.emptyString{
            //CommonUtils.showNotification(message: Parameters.alertmessage)
            print(Parameters.alertmessage)
            return
        }
        
        var starmessage = String()
        Database.database().reference().child(Parameters.Message).child(groupid).child(uid).child(Parameters.starmessage).observe(.value) { (snapshot) in
            if snapshot.exists() {
                starmessage = String.getString(snapshot.value)
                print(starmessage)
            }
        }
        Database.database().reference().child(Parameters.Message).child(groupid).observeSingleEvent(of: .value, with: { (SnapShot) in
            if SnapShot.exists() {
                starmessage.isEmpty ? Database.database().reference().child(Parameters.Message).child(groupid).child(uid).child(Parameters.starmessage).setValue(Senderid) :  Database.database().reference().child(Parameters.Message).child(groupid).child(uid).child(Parameters.starmessage).setValue("\(starmessage)_\(Senderid)")
            }
        })
    }
    
    
    //MARK:- Func for Clear All Messages From group
    func ClearChatFromGroup(msgclass:[MessageClass] , Senderid:String, groupid:String) {
        for  index in msgclass {
            let uid = index.uid
            var isDeleted = String()
            Database.database().reference().child(Parameters.Message).child(groupid).child(uid ?? "").child(Parameters.isDeleted).observe(.value) { (snapshot) in
                if snapshot.exists() {
                    isDeleted = String.getString(snapshot.value)
                    print(isDeleted)
                }
            }
            Database.database().reference().child(Parameters.Message).child(groupid).observeSingleEvent(of: .value, with: { (SnapShot) in
                if SnapShot.exists() {
                    isDeleted.isEmpty ? Database.database().reference().child(Parameters.Message).child(groupid).child(uid ?? "").child(Parameters.isDeleted).setValue(Senderid) :  Database.database().reference().child(Parameters.Message).child(groupid).child(uid ?? "").child(Parameters.isDeleted).setValue("\(isDeleted)_\(Senderid)")
                }
            })
        }
    }

    //MARK:- Func for One to One Chat BackUp
    func ChatBackUpGroup(msgclass:[ChatbackupOnetoOne] , Senderid:String, groupid:String) {
        
        if groupid == Parameters.emptyString || Senderid == Parameters.emptyString{
            print(Parameters.alertmessage)
            return
        }
        for  index in msgclass {
            let uid = index.uid
            var isDeleted = [String]()
            Database.database().reference().child(Parameters.Message).child(groupid).child(uid ?? "").child(Parameters.isDeleted).observe(.value) { (snapshot) in
                if snapshot.exists() {
                    isDeleted = String.getString(snapshot.value).components(separatedBy: Parameters.saparaterString)
                    if (isDeleted.index{$0 == String.getString(Senderid)} != nil) {
                        isDeleted.remove(at: isDeleted.index{$0 == String.getString(Senderid)}!)
                    }
                    print(isDeleted)
                }
            }
            Database.database().reference().child(Parameters.Message).child(groupid).observeSingleEvent(of: .value, with: { (SnapShot) in
                if SnapShot.exists() {
                    Database.database().reference().child(Parameters.Message).child(groupid).child(uid ?? "").child(Parameters.isDeleted).setValue("\(isDeleted.joined(separator: "_"))")
                }
            })
        }
    }

    //MARK:- Function For Group Read Messages
    func readMessageforGroup(groupid :String , readstate:String , counters:@escaping (_ result: Int) -> ()) {
        if groupid == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        
        var countreadMessage = 0
        Database.database().reference().child(Parameters.Message).child(groupid).observe(.value, with: { (snapshot) in
            if snapshot.exists() {
                countreadMessage = 0
                let msgs = kSharedInstance.getDictionary(snapshot.value)
                msgs.forEach {(key, value) in
                    let dic = kSharedInstance.getDictionary(value)
                    let isDeleted =  String.getString(dic[Parameters.isDeleted]).components(separatedBy: Parameters.saparaterString)
                    let loggedInUserid = kSharedUserDefaults.loggedInUserModal.userId ?? ""
                    if !(isDeleted.contains(loggedInUserid)) {
                        countreadMessage += 1
                    }
                }
            }
            counters(Int(countreadMessage) - Int.getInt(readstate))
        })
        
    }
    
    //Func for read perticular messgae
    func readperticularMessage(Senderid :String , Receiverid:String , array:[MessageClass] ) {
        let loggedInUserid = kSharedUserDefaults.loggedInUserModal.userId ?? ""
        let node = Senderid < Receiverid ? "\(String.getString(Senderid))_\(String.getString(Receiverid))" : "\(String.getString(Receiverid))_\(String.getString(Senderid))"
        if String.getString(node) == Parameters.emptyString || String.getString(Senderid) == Parameters.emptyString || String.getString(Receiverid) == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        for i in 0..<array.count {
            
            let index = array[i]
            if index.isInvalidated {
                return
            }
            if Senderid != index.Senderid {
                messageReferense.child(node).child(index.uid ?? "").child(Parameters.senderid).observeSingleEvent(of: .value) {
                    (snapshot) in
                    
                    if snapshot.exists() {
                        if let str = snapshot.value as? String {
                            if str.count > 1 {
                                if str != loggedInUserid {
                                    self.resentReferense.child(String.getString("user_" + "\(String.getString(Receiverid))")).child(String.getString("user_" + "\(String.getString(Senderid))")).observeSingleEvent(of: .value) { (snapshot) in
                                        if snapshot.exists() {
                                            self.messageReferense.child(node).child(index.uid ?? "").updateChildValues([Parameters.status : "seen"])
                                        }
                                    }
                                }
                                
                                if str != loggedInUserid && (i == array.count - 1) {
                                    self.resentReferense.child(String.getString("user_" + "\(String.getString(Receiverid))")).child(String.getString("user_" + "\(String.getString(Senderid))")).observeSingleEvent(of: .value) { (snapshot) in
                                        if snapshot.exists() {
                                            //    Database.database().reference().child(Parameters.ResentMessage).child(String.getString("user_" + "\(String.getString(Receiverid))")).child(String.getString("user_" + "\(String.getString(Senderid))")).updateChildValues([Parameters.readState : "seen"])
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func readMessageCountForAConversation(Senderid :String , Receiverid:String) {
        let unreadDict = [Senderid: 0]
        resentReferense.child(String.getString("user_" + "\(String.getString(Senderid))")).child(String.getString("user_" + "\(String.getString(Receiverid))")).observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                DispatchQueue.main.async {
                    self.resentReferense.child(String.getString("user_" + "\(String.getString(Senderid))")).child(String.getString("user_" + "\(String.getString(Receiverid))")).child(Parameters.unread_count).updateChildValues(unreadDict)
                    
                }
                //                Database.database().reference().child(Parameters.ResentMessage).child(String.getString("user_" + "\(String.getString(Senderid))")).child(String.getString("user_" + "\(String.getString(Receiverid))")).child(Parameters.unread_count).updateChildValues(unreadDict)
            }
            
        }
    }
    
    func changeFriendStatusForAConversation(Senderid :String , Receiverid:String, status: Bool) {
        
        Database.database().reference().child(Parameters.ResentMessage).child(String.getString("user_" + "\(String.getString(Senderid))")).child(String.getString("user_" + "\(String.getString(Receiverid))")).observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                Database.database().reference().child(Parameters.ResentMessage).child(String.getString("user_" + "\(String.getString(Senderid))")).child(String.getString("user_" + "\(String.getString(Receiverid))")).child(Parameters._friend).setValue(status)
            }
        }
        
        Database.database().reference().child(Parameters.ResentMessage).child(String.getString("user_" + "\(String.getString(Receiverid))")).child(String.getString("user_" + "\(String.getString(Senderid))")).observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                Database.database().reference().child(Parameters.ResentMessage).child(String.getString("user_" + "\(String.getString(Receiverid))")).child(String.getString("user_" + "\(String.getString(Senderid))")).child(Parameters._friend).setValue(status)
            }
        }
    }
    
    
    func getUeadCountForAConversation(Senderid :String , Receiverid:String, unreadCount:@escaping (_ count: Int, _ success: Bool) -> ()) -> Void {
        var count = 0
        Database.database().reference().child(Parameters.ResentMessage).child(String.getString("user_" + "\(String.getString(Receiverid))")).child(String.getString("user_" + "\(String.getString(Senderid))")).child(Parameters.unread_count).observe(.value) { (snapshot) in
            if snapshot.exists() {
                guard let vc = UIApplication.topViewController() else { return }
                if vc .isKind(of: ConversationViewController.self) {
                    let msgs = kSharedInstance.getDictionary(snapshot.value)
                    msgs.forEach {(key, value) in
                        count = Int.getInt(value)
                    }
                    unreadCount(count, true)
                }
                
            }
        }
        unreadCount(count, false)
    }
    
    //MARK:- Function For Group Read Messages from users perticular
    func  readMessagecountforGroupusers(adminid :String , groupid:String , userid:String , message:@escaping (_ id: String, _ status: String) -> ()) -> Void{
        if userid == Parameters.emptyString ||  groupid == Parameters.emptyString || adminid == Parameters.emptyString {
            print(Parameters.alertmessage)
            return
        }
        
        Database.database().reference().child(Parameters.Groups).child(adminid).child(groupid).child(Parameters.UserSeenCount).child(userid).observe( .value) { (snapshot) in
            if snapshot.exists() {
                let msgs = kSharedInstance.getDictionary(snapshot.value)
                message(groupid,  String.getString(msgs[Parameters.readState]))
            }else {
                
            }
        }
    }
    
}


//MARK:- Extension of Chat_Halper for get some data for Chat like timeStamp , thumbnil image
extension Chat_hepler{
    //MARK;- Func for Get time from Time Stamp
    func getTime(timeStamp :Double) ->String {
        let time = Double(timeStamp) / 1000
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return String.getString(localDate)
    }
    
    func getTime(date :Date) ->String {
        let date = date
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return String.getString(localDate)
    }
    
    //MARK:- Func for get  ThumNil Image from Video
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
            print("Error for geting the thumnbnil image for Video ")
        }
        return nil
    }
    
    @available(iOS 11.0, *)
    func pdfThumbnail(url: URL, width: CGFloat = 240) -> UIImage? {
        guard let data = try? Data(contentsOf: url),
            let page = PDFDocument(data: data)?.page(at: 0) else {
                return nil
        }
        
        let pageSize = page.bounds(for: .mediaBox)
        let pdfScale = width / pageSize.width
        let scale = UIScreen.main.scale * pdfScale
        let screenSize = CGSize(width: pageSize.width * scale, height: pageSize.height * scale)
        return page.thumbnail(of: screenSize, for: .mediaBox)
    }
    
}

