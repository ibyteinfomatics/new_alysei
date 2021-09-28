//
//  TabBarViewC.swift
//  Alysie
//
//  Created by CodeAegis on 17/01/21.
//

import UIKit

class TabBarViewC: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    if  kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.voyagers.rawValue)" {
    if let viewController2 = self.tabBarController?.viewControllers?[1] {

       // viewController2.tabBarItem.image = UIImage(named: "b2btab1_icon")
        viewController2.tabBarItem.title = "Hubs"
       // viewController2.tabBarItem.isEnabled = false
        //viewController2.tabBarItem.selectedImage = UIImage(named: "turnoff_comments_icon")
    }else{
        if let viewController2 = self.tabBarController?.viewControllers?[1] {

            //viewController2.tabBarItem.image = UIImage(named: "b2b_normal")
            viewController2.tabBarItem.title = "B2B"
           // viewController2.tabBarItem.isEnabled = true
            //viewController2.tabBarItem.selectedImage = UIImage(named: "turnoff_comments_icon")
            
        }
    }
    
  }

}
}
