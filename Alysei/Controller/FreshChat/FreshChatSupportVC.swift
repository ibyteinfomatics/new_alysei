//
//  FreshChatSupportVC.swift
//  Alysei
//
//  Created by Gitesh Dang on 05/07/22.
//

import UIKit

import FreshchatSDK
class FreshChatSupportVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a user object
        let user = FreshchatUser.sharedInstance();
        // To set an identifiable first name for the user
        user.firstName = "John"
        // To set an identifiable last name for the user
        user.lastName = "Doe"
        //To set user's email id
        user.email = "john.doe.1982@mail.com"
        //To set user's phone number
        user.phoneCountryCode="00"
        user.phoneNumber = "9999999999"
        Freshchat.sharedInstance().setUser(user)
        
        //You can set custom user properties for a particular user
        Freshchat.sharedInstance().setUserPropertyforKey("customerType", withValue: "Premium")
        //You can set user demographic information
        Freshchat.sharedInstance().setUserPropertyforKey("city", withValue: "San Bruno")
        //You can segment based on where the user is in their journey of using your app
        Freshchat.sharedInstance().setUserPropertyforKey("loggedIn", withValue: "true")
        //You can capture a state of the user that includes what the user has done in your app
        Freshchat.sharedInstance().setUserPropertyforKey("transactionCount", withValue: "3")
        
        presentConversation(sender: self)
    }
    func presentConversation(sender: Any)
    {
            Freshchat.sharedInstance().showConversations(self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
