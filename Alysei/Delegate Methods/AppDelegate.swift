//
//  AppDelegate.swift
//  Alysie
//
//  Created by CodeAegis on 11/01/21.
//

import UIKit
import SVProgressHUD
import GoogleMaps
import GooglePlaces
//import CoreLocation
import IQKeyboardManagerSwift
import FirebaseMessaging
import Firebase
import Zoomy
import FreshchatSDK


var editHubValue: String?
@main
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate,UNUserNotificationCenterDelegate, MessagingDelegate {
    
    let locationManager = CLLocationManager()
    //MARK: - Properties -
    
    var window: UIWindow?
   
    var checkDict: [String:Any]?
    var isSelectRole = false
    
    //var locationManager: CLLocationManager!
    var googleAPIKey = "AIzaSyDX4HE7708TQYkE0WoOlzTDlq7_9nneUHY"
    //var googleAPIKey = "AIzaSyCHoKV0CQU2zctfEt3-8H-cX2skMbMpmsM"
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let URLCache1 = URLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
        URLCache.shared = URLCache1
        
        IQKeyboardManager.shared.enable = true
        self.setInitialViewController()
        self.setDefaultProgressHud()
        GMSServices.provideAPIKey(googleAPIKey)
        GMSPlacesClient.provideAPIKey(googleAPIKey)
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        self.registerForFirebaseNotification(application: application)
        self.pushNotificationSetup(withApplication: application)
        //Current location
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        changeTabBarFont()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        let FreshChatAppID = "d4b977a6-ea91-495e-a750-e6abd6463344"
        let FreshChatAppKey = "140931b5-5f54-4022-96a8-2c017e818f57"
        let freshchatConfig:FreshchatConfig = FreshchatConfig.init(appID: FreshChatAppID, andAppKey: FreshChatAppKey)
        freshchatConfig.domain = "msdk.in.freshchat.com"
        freshchatConfig.gallerySelectionEnabled = true;
        // set FALSE to disable picture selection for messaging via gallery
            freshchatConfig.cameraCaptureEnabled = true;
        // set FALSE to disable picture selection for messaging via camera
            freshchatConfig.teamMemberInfoVisible = true;
        // set to FALSE to turn off showing a team member avatar. To customize the avatar shown, use the theme file
            freshchatConfig.showNotificationBanner = true;
        freshchatConfig.eventsUploadEnabled = true
        freshchatConfig.responseExpectationVisible = true
        freshchatConfig.errorLogsEnabled = true
        // set to FALSE if you don't want to show the in-app notification banner upon receiving a new message while the app is open
         //   freshchatConfig.responseExpectations = true;
        //set to FALSE if you want to hide the response expectations for the Topics
        Freshchat.sharedInstance().initWith(freshchatConfig)

       
        return true
    }

    
    //    private func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any] = [:]) -> Bool {
    //        print(url)
    //        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
    //        let host = urlComponents?.host ?? ""
    //        print(host)
    //        if host == ""{
    //            let sb = UIStoryboard(name: "Recipe", bundle: nil)
    //            let vc = sb.instantiateViewController(identifier: "DiscoverRecipeViewController") as? DiscoverRecipeViewController
    //            window?.rootViewController = vc
    //        }
    //      return true
    //    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        guard let url = userActivity.webpageURL else{
            return false
        }
        
        let sb = UIStoryboard(name: "Recipe", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "DiscoverRecipeViewController") as? DiscoverRecipeViewController
        
        guard let viewController = vc else {
            application.canOpenURL(url)
            return false
        }
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        //            guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
        //                let url = userActivity.webpageURL, let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
        //                    return false
        //                }
        
        
        //FOR A URL "https://yourwebsite.com/testing/24
        //this will print the ID 24
        
        //            if (components.path.contains("")) {
        //                if let theid = Int(url.lastPathComponent) {
        //                    print("test id from deep link \(theid)")
        //                }
        //            }
        
        
        return true
    }
    func changeTabBarFont(){
        let systemFontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)]
        UITabBarItem.appearance().setTitleTextAttributes(systemFontAttributes, for: .normal)
        
        //Mark:- You can also set any custom fonts in the code
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "Montserrat-Medium", size: 13.0)!]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        // UITabBarItem.appearance().tintColor = UIColor.black
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        // print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    //MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    func registerForFirebaseNotification(application: UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
    }
    
    
    
    func pushNotificationSetup(withApplication application: UIApplication) {
        
        let center  = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.sound, .alert]) { (granted, error) in
            
            if error == nil {
                
                DispatchQueue.main.async { UIApplication.shared.registerForRemoteNotifications() }
            }
        }
        //application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
    }
    
    // MARK: UISceneSession Lifecycle
    func applicationDidBecomeActive(_ application: UIApplication) {
        self.pushNotificationSetup(withApplication: application)
        application.registerForRemoteNotifications()
        
    }
    
    
    
    
    //MessagingDelegate
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        kSharedUserDefaults.setDeviceToken(deviceToken: fcmToken)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        kSharedUserDefaults.setDeviceToken(deviceToken: fcmToken!)
        print("Firebase registration token: \(fcmToken)")
        print("device token ",kSharedUserDefaults.getDeviceToken())
        //self.connectToFcm()
    }
    
    
    
    func application(_ application: UIApplication,didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        _ = tokenParts.joined()
        //print("Device Token: \(tokenParts.joined())")
        Messaging.messaging().apnsToken = deviceToken
        Messaging.messaging().setAPNSToken(deviceToken,type: MessagingAPNSTokenType.unknown)
        //        Messaging.messaging().subscribe(toTopic: "all")
    }
    
    //UNUserNotificationCenterDelegate
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("APNs received with: \(userInfo)")
        
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
        let dicData = kSharedInstance.getDictionary(notification.request.content.userInfo)
        SKDeepHalper.shared.handelPushNotification(notiResponse: dicData, isTapped: false)
        completionHandler([.alert, .sound])
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let dicData = kSharedInstance.getDictionary(response.notification.request.content.userInfo)
        SKDeepHalper.shared.handelPushNotification(notiResponse: dicData, isTapped: true)
        print("Push notification received : ",dicData)
    
    }
    
    //MARK: - Public Methods -
    
    @objc func setInitialViewController() {
        
        let storyboard = UIStoryboard(name: StoryBoardConstants.kSplash, bundle: nil)
        let navigationC = storyboard.instantiateViewController(withIdentifier: "SplashNavigation")
        kSharedAppDelegate.window = self.window
        self.window?.rootViewController = navigationC
        self.window?.makeKeyAndVisible()
    }
    
    public func setDefaultProgressHud() -> Void{
        
        //SVProgressHUD.setBackgroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor.clear)
        SVProgressHUD.setForegroundColor(AppColors.blue.color)
        SVProgressHUD.setRingThickness(4.0)
        SVProgressHUD.setAnimationsEnabled(true)
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
    
    public func callLogoutApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kLogout, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictResponse, error, errotype, statusCode in
            let token = kSharedUserDefaults.getDeviceToken()
            let retriveArrayData = kSharedUserDefaults.stringArray(forKey:  "SavedWalkthrough") ?? [String]()
            let postTourguide = kSharedUserDefaults.object(forKey:  "userSeenShowCasePost")
            let hubTourguide = kSharedUserDefaults.object(forKey:  "userSeenShowCaseHub")
            let recipeTourguide = kSharedUserDefaults.object(forKey:  "userSeenShowCase")
            let profileTourguide = kSharedUserDefaults.object(forKey:  "userSeenShowCaseProfile")
            let appLanguage = kSharedUserDefaults.object(forKey: "locale")
            kSharedUserDefaults.clearAllData()
            kSharedUserDefaults.setValue(retriveArrayData, forKey: "SavedWalkthrough")
            kSharedUserDefaults.setValue(postTourguide, forKey: "userSeenShowCasePost")
            kSharedUserDefaults.setValue(hubTourguide, forKey: "userSeenShowCaseHub")
            kSharedUserDefaults.setValue(recipeTourguide, forKey: "userSeenShowCase")
            kSharedUserDefaults.setValue(profileTourguide, forKey: "userSeenShowCaseProfile")
            kSharedUserDefaults.setValue(appLanguage, forKey: "locale")
            kSharedUserDefaults.setDeviceToken(deviceToken: token)
        }
    }
    
    public func pushToBlanktViewC() {
        
        /*let storyboard = UIStoryboard(name: StoryBoardConstants.kHome, bundle: nil)
         let navigationC = storyboard.instantiateViewController(withIdentifier: "NotificationList")
         kSharedAppDelegate.window = self.window
         self.window?.rootViewController = navigationC
         self.window?.makeKeyAndVisible()
         self.window?.rootViewController?.present(navigationC, animated: true, completion: nil)*/
        
        let storyboard = UIStoryboard(name: StoryBoardConstants.kHome, bundle: nil)
        let authVC = storyboard.instantiateViewController(withIdentifier: "NotificationList")
        window?.makeKeyAndVisible()
        window?.rootViewController?.present(authVC, animated: true, completion: nil)
        
        /*guard let vc = UIStoryboard(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(identifier: "NotificationList") as? NotificationList else {return}
         self.navigationController?.pushViewController(vc, animated: true)
         self.hidesBottomBarWhenPushed = true*/
        
    }
    
    func moveInqueryChat(receiverid:String,username:String){
        
        let storyboard = UIStoryboard(name: StoryBoardConstants.kChat, bundle: nil)
        guard let nextvc = storyboard.instantiateViewController(withIdentifier: "InquiryConverstionController") as? InquiryConverstionController else { return }
//        nextvc.userId = receiverid
//        nextvc.name = username
//        nextvc.fromvc = .Notification
//        nextvc.passProductId = self.inquiryNewOpenModel?.dataOpen?[indexPath.row].product_id
//        nextvc.passProductImageUrl = (self.inquiryNewOpenModel?.dataOpen?[indexPath.row].product?.galleries?.baseUrl ?? "") + (self.inquiryNewOpenModel?.dataOpen?[indexPath.row].product?.galleries?.attachment_url ?? "")
//        nextvc.passProductName = self.inquiryNewOpenModel?.dataOpen?[indexPath.row].product?.title ?? ""
        nextvc.passReceiverId =  receiverid
       
        let navigationController = UINavigationController(rootViewController: nextvc)
        navigationController.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        
    }
    
    func moveChat(receiverid:String,username:String){
        
        let storyboard = UIStoryboard(name: StoryBoardConstants.kChat, bundle: nil)
        guard let nextvc = storyboard.instantiateViewController(withIdentifier: "ConversationViewController") as? ConversationViewController else { return }
        nextvc.userId = receiverid
        nextvc.name = username
        nextvc.fromvc = .Notification
        let navigationController = UINavigationController(rootViewController: nextvc)
        navigationController.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        
    }
    
    func moveToPost(postid:String){
        
        let storyboard = UIStoryboard(name: StoryBoardConstants.kHome, bundle: nil)
        guard let nextvc = storyboard.instantiateViewController(withIdentifier: "PhotosPost") as? PhotosPost else { return }
        postId = postid
        nextvc.fromvc = .Notification
        let navigationController = UINavigationController(rootViewController: nextvc)
        navigationController.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
    }
    
    func moveToNetwork(index:Int){
        
        /*let storyboard = UIStoryboard(name: StoryBoardConstants.kHome, bundle: nil)
        guard let nextvc = storyboard.instantiateViewController(withIdentifier: "NetworkViewC") as? NetworkViewC else { return }
        networkcurrentIndex = index
        nextvc.fromvc = .Notification
        let navigationController = UINavigationController(rootViewController: nextvc)
        navigationController.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()*/
        //self.inputViewController?.tabBarController?.selectedIndex = 3
        
        networkcurrentIndex = index
        let tabBarController = self.window!.rootViewController as? UITabBarController
        tabBarController?.selectedIndex = 3
        
        
        
    }
    
    func moveToMemberShip(){
        
        let storyboard = UIStoryboard(name: StoryBoardConstants.kHome, bundle: nil)
        guard let nextvc = storyboard.instantiateViewController(withIdentifier: "MembershipViewC") as? MembershipViewC else { return }
        nextvc.fromvc = .Notification
        let navigationController = UINavigationController(rootViewController: nextvc)
        navigationController.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
    }
    
    public func pushToTabBarViewC() {
        
        let storyboard = UIStoryboard(name: StoryBoardConstants.kHome, bundle: nil)
        let navigationC = storyboard.instantiateViewController(withIdentifier: TabBarViewC.id())
        self.window?.rootViewController = navigationC
        kSharedAppDelegate.window = self.window
        self.window?.makeKeyAndVisible()
    }
    
    public func pushToProfileViewC() {
        let storyboard = UIStoryboard(name: StoryBoardConstants.kHome, bundle: nil)
        let navigationC = storyboard.instantiateViewController(withIdentifier: ProfileViewC.id())
        //self.window?.rootViewController = navigationC
        kSharedAppDelegate.window = self.window
        self.window?.makeKeyAndVisible()
        window?.rootViewController?.present(navigationC, animated: true, completion: nil)
    }
    


}

enum AppManager {
  // MARK: App      Tutorial=============================================================================================================
 
    
    static func setUserSeenAppInstructionPost() {
        kSharedUserDefaults.set(true, forKey: "userSeenShowCasePost")
    }
     static func getUserSeenAppInstructionPost() -> Bool {
       let userSeenShowCaseObject1 = kSharedUserDefaults.object(forKey: "userSeenShowCasePost")
       if let userSeenShowCasePost = userSeenShowCaseObject1 as? Bool {
         return userSeenShowCasePost
       }
       return false
       }
    
    static func setUserSeenAppInstructionHub() {
        kSharedUserDefaults.set(true, forKey: "userSeenShowCaseHub")
    }
     static func getUserSeenAppInstructionHub() -> Bool {
       let userSeenShowCaseObject = kSharedUserDefaults.object(forKey: "userSeenShowCaseHub")
       if let userSeenShowCase = userSeenShowCaseObject as? Bool {
         return userSeenShowCase
       }
       return false
       }
    
    static func setUserSeenAppInstruction() {
        kSharedUserDefaults.set(true, forKey: "userSeenShowCase")
    }
     static func getUserSeenAppInstruction() -> Bool {
       let userSeenShowCaseObject = kSharedUserDefaults.object(forKey: "userSeenShowCase")
       if let userSeenShowCase = userSeenShowCaseObject as? Bool {
         return userSeenShowCase
       }
       return false
       }
    
    static func setUserSeenAppInstructionProfile() {
        kSharedUserDefaults.set(true, forKey: "userSeenShowCaseProfile")
    }
     static func getUserSeenAppInstructionProfile() -> Bool {
       let userSeenShowCaseObject = kSharedUserDefaults.object(forKey: "userSeenShowCaseProfile")
       if let userSeenShowCase = userSeenShowCaseObject as? Bool {
         return userSeenShowCase
       } 
       return false
       }
    
    
      
}


   

