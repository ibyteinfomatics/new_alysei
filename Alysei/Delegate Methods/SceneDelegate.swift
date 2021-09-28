//
//  SceneDelegate.swift
//  Alysie
//
//  Created by CodeAegis on 11/01/21.
//

import UIKit
import SVProgressHUD
import IQKeyboardManagerSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    IQKeyboardManager.shared.enable = true
    kSharedAppDelegate.window = self.window
    guard let windowScene = (scene as? UIWindowScene) else { return }
    self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    self.window?.windowScene = windowScene
    self.setInitialViewController()
  }

  func sceneDidDisconnect(_ scene: UIScene) {

  }

  func sceneDidBecomeActive(_ scene: UIScene) {
  
  }

  func sceneWillResignActive(_ scene: UIScene) {
  
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
   
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
   
  }
  
  //MARK: - Public Methods -
  
  @objc func setInitialViewController() {
    
    let storyboard = UIStoryboard(name: StoryBoardConstants.kSplash, bundle: nil)
    let navigationC = storyboard.instantiateViewController(withIdentifier: "SplashNavigation")
    kSharedAppDelegate.window = self.window
    self.window?.rootViewController = navigationC
    self.window?.makeKeyAndVisible()

  }

  public func pushToLanguageViewC() {
       
     let storyboard = UIStoryboard(name: StoryBoardConstants.kLogin, bundle: nil)
     let navigationC = storyboard.instantiateViewController(withIdentifier: "LoginNavigation")
     kSharedAppDelegate.window = self.window
     self.window?.rootViewController = navigationC
     self.window?.makeKeyAndVisible()
  }
  
  public func pushToLoginAccountViewC() {
       
     let storyboard = UIStoryboard(name: StoryBoardConstants.kLogin, bundle: nil)
     let navigationC = storyboard.instantiateViewController(withIdentifier: "LoginAccountNavigation")
     kSharedAppDelegate.window = self.window
     self.window?.rootViewController = navigationC
     self.window?.makeKeyAndVisible()
  }
  
  public func pushToTabBarViewC() {
     
     let storyboard = UIStoryboard(name: StoryBoardConstants.kHome, bundle: nil)
     let navigationC = storyboard.instantiateViewController(withIdentifier: TabBarViewC.id())
     self.window?.rootViewController = navigationC
     kSharedAppDelegate.window = self.window
     self.window?.makeKeyAndVisible()
   }

}

