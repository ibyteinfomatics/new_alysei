//
//  SplashViewC.swift
//  Alysie
//
//  Created by CodeAegis on 12/02/21.
//

import UIKit

class SplashViewC: AlysieBaseViewC{
  
  override var prefersStatusBarHidden: Bool {
      return true
  }

  override func viewDidLoad() {
    
    super.viewDidLoad()
  
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
      
      if (kSharedUserDefaults.isUserLoggedIn == true) && (kSharedUserDefaults.logout == false) && (kSharedUserDefaults.loggedInUserModal.accessToken?.isEmpty == false){
        kSharedAppDelegate.pushToTabBarViewC()
      }
      else if (kSharedUserDefaults.isUserLoggedIn == true) && (kSharedUserDefaults.logout == true){
        kSharedAppDelegate.pushToLoginAccountViewC()
       
      }
      else{
        kSharedAppDelegate.pushToLanguageViewC()
      }
    }
  }
}
