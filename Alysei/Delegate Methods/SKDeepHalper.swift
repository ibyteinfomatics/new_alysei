//
//  SKDeepHalper.swift
//  Alysei
//
//  Created by Gitesh Dang on 30/09/21.
//


import Foundation
import UIKit
import Firebase

class SKDeepHalper {
    static let shared = SKDeepHalper()
    
    func handelPushNotification(notiResponse data:[String:Any]?,isTapped:Bool) {
        if isTapped {
            if kSharedUserDefaults.isUserLoggedIn == false { return }
            self.handelPushredirection(data: data)
        }
    }
    
    func handelPushredirection(data:[String:Any]?) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        let response = kSharedInstance.getDictionary(data)
        let type = Int.getInt(response["notification_type"])
        print("type---- ",type)
        /*switch type {
        case 1,4:
            kSharedAppDelegate.moveToUser(userId: String.getString(String.getString(response["sender_id"])))
        case 2:
            kSharedAppDelegate.movetoRequest()
        case 3,8:
            kSharedAppDelegate.moveChat(receiverid: String.getString(response["sender_id"]),username: String.getString(response["user_name"]),profileimage: String.getString(response["profile_image"]))
        case 9:
            kSharedAppDelegate.moveChat(receiverid: String.getString(response["_id"]),username: String.getString(response["user_name"]),profileimage: String.getString(response["profile_image"]))
        case 10:
                        
            if UserData.shared.id.contains(String.getString(response["user_id"])) {
                kSharedAppDelegate.movetoJoin(chatRoomID: String.getString(response["chat_room_id"]))
            } else {
                kSharedAppDelegate.movetoHome()
            }
            
        case 7:
            kSharedAppDelegate.moveChat(receiverid: String.getString(response["sender_id"]),username: String.getString(response["user_name"]),profileimage: String.getString(response["profile_image"]))
        default:
            kSharedAppDelegate.movetoHome()
    
        }*/
        
    }
    
}
