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
        let type = convertToDictionary(text: response["gcm.notification.data"] as! String)?["notification_type"]//response["gcm.notification.data"]
        
        let json = convertToDictionary(text: response["gcm.notification.data"] as! String)
        print("type---- ",type ?? "")
        
        
        
        switch Int.getInt(type) {
        case 1:
            kSharedAppDelegate.moveChat(receiverid: String.getString(json?["redirect_to_id"]), username: String.getString(json?["sender_name"]))
            
        case 2,6,7,8:
            kSharedAppDelegate.moveToPost(postid: String.getString(json?["redirect_to_id"]))
            
        case 3:
            kSharedAppDelegate.moveToNetwork(index: 0)
            
        case 4:
            kSharedAppDelegate.moveToNetwork(index: 1)
            
        case 5:
            kSharedAppDelegate.moveToNetwork(index: 3)
            
        case 9:
            kSharedAppDelegate.moveToMemberShip()
        case 10:
            kSharedAppDelegate.moveInqueryChat(receiverid: String.getString(json?["redirect_to_id"]), username: String.getString(json?["sender_name"]))
       
        default:
            kSharedAppDelegate.pushToTabBarViewC()
    
        }
        
    }

   
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    
}
