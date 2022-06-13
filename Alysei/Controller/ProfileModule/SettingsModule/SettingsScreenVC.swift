//
//  SettingsScreenVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 3/31/21.
//

import UIKit


class SettingsScreenVC: AlysieBaseViewC {

    @IBOutlet weak var settingCollectionView: UICollectionView!
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var userId: String?
    var signUpViewModel: SignUpViewModel!
    //var imgPUrl: String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("modelRoleID--------------------------------\(kSharedUserDefaults.loggedInUserModal.memberRoleId ?? "")")
       // lblTitle.text = AppConstants.Settings
        self.viewShadow.drawBottomShadow()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableWindowInteraction()
        print("modelRoleID--------------------------------\(kSharedUserDefaults.loggedInUserModal.memberRoleId ?? "")")
        lblTitle.text = AppConstants.Settings
        settingCollectionView.reloadData()
        
    }
  
    private func getSettingCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
        
        guard let settingsTableCell = settingCollectionView.dequeueReusableCell(withReuseIdentifier: SettingsScreenCollectionVC.identifier(), for: indexPath) as? SettingsScreenCollectionVC else{return UICollectionViewCell()}
        
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.producer.rawValue)"{
        settingsTableCell.arrData = [(image: "icons8_settings", name: AppConstants.Settings),
                                     (image: "icons8_shop", name: AppConstants.Marketplace),
                                     (image: "icons8_business", name:"Company".localizableString(loc: kSharedUserDefaults.getAppLanguage())),
                                     (image: "icons8_security_lock", name: AppConstants.Privacy),
                                     (image: "passwordSetting", name: AppConstants.CapPassword),
                                     (image: "icons8_unavailable", name: AppConstants.Blocking),
                                     (image: "icons8_debit_card_1", name: AppConstants.Membership),
                                     (image: "icons8_purchase_order", name: AppConstants.Billing),
                                     (image: "icons8_terms_and_conditions", name: AppConstants.TermsAndConditions),
                                     (image: "icons8_data_protection", name: AppConstants.PrivacyPolicy),
                                     (image: "Faq", name: AppConstants.FAQ),
                                     (image: "yourData", name: AppConstants.YourData),
                                      (image: "icons8_exit", name: AppConstants.Logout),
]
        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.voyagers.rawValue)"{
            settingsTableCell.arrData = [(image: "icons8_settings", name: AppConstants.Settings),
                                                    
                                                    (image: "icons8_security_lock", name: AppConstants.Privacy),
                                                    (image: "passwordSetting", name: AppConstants.CapPassword),
                                                    (image: "icons8_unavailable", name: AppConstants.Blocking),
                                                   // (image: "icons8_debit_card_1", name: "Membership"),
                                                    (image: "icons8_purchase_order", name:  AppConstants.Billing),
                                                    (image: "icons8_terms_and_conditions", name:AppConstants.TermsAndConditions),
                                                    (image: "icons8_data_protection", name: AppConstants.PrivacyPolicy),
                                                    (image: "Faq", name: AppConstants.FAQ),
                                                    
                                                    (image: "icons8_exit", name: AppConstants.Logout),
                                                    (image: "yourData", name: AppConstants.YourData)
                                                    
                                                    
                                                    
            ]
        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.restaurant.rawValue)"{
            settingsTableCell.arrData = [(image: "icons8_settings", name: AppConstants.Settings),
                                                    (image: "icons8_shop", name:  AppConstants.Marketplace),
                                                    (image: "calendar (2)", name: AppConstants.Events),
                                                    (image: "icons8_security_lock", name: AppConstants.Privacy),
                                                    (image: "passwordSetting", name: AppConstants.CapPassword),
                                                    (image: "icons8_unavailable", name: AppConstants.Blocking),
                                                    (image: "icons8_debit_card_1", name: AppConstants.Membership),
                                                    (image: "icons8_purchase_order", name:  AppConstants.Billing),
                                                    (image: "icons8_terms_and_conditions", name: AppConstants.TermsAndConditions),
                                                    (image: "icons8_data_protection", name: AppConstants.PrivacyPolicy),
                                                    (image: "Faq", name: AppConstants.FAQ),
                                                    (image: "yourData", name: AppConstants.YourData),
                                                    (image: "icons8_exit", name: AppConstants.Logout)
                                                    
                                                    
            ]
            
        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.voiceExperts.rawValue)" {
            settingsTableCell.arrData = [(image: "icons8_settings", name: AppConstants.Settings),
                                                      (image: "icons8_shop", name:  AppConstants.Marketplace),
                                                      (image: "Featured", name: AppConstants.Featured),
                                                      (image: "icons8_security_lock", name: AppConstants.Privacy),
                                                      (image: "passwordSetting", name: AppConstants.CapPassword),
                                                      (image: "icons8_unavailable", name: AppConstants.Blocking),
                                                      (image: "icons8_debit_card_1", name: AppConstants.Membership),
                                                      (image: "icons8_purchase_order", name:  AppConstants.Billing),
                                                      (image: "icons8_terms_and_conditions", name: AppConstants.TermsAndConditions),
                                                      (image: "icons8_data_protection", name: AppConstants.PrivacyPolicy),
                                                      (image: "Faq", name: AppConstants.FAQ),
                                                      (image: "yourData", name: AppConstants.YourData),
                                                      (image: "icons8_exit", name: AppConstants.Logout)
          ]
        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.travelAgencies.rawValue)"{
            settingsTableCell.arrData =  [(image: "icons8_settings", name: AppConstants.Settings),
                                                     (image: "icons8_shop", name:  AppConstants.Marketplace),
                                                     (image: "icons8_security_lock", name: AppConstants.Privacy),
                                                     (image: "passwordSetting", name: AppConstants.CapPassword),
                                                     (image: "icons8_unavailable", name: AppConstants.Blocking),
                                                     (image: "icons8_debit_card_1", name: AppConstants.Membership),
                                                     (image: "icons8_purchase_order", name:  AppConstants.Billing),
                                                     (image: "icons8_terms_and_conditions", name: AppConstants.TermsAndConditions),
                                                     (image: "icons8_data_protection", name: AppConstants.PrivacyPolicy),
                                                     (image: "Faq", name: AppConstants.FAQ),
                                                    
                                                     (image: "icons8_exit", name:AppConstants.Logout),
                                                     (image: "yourData", name: AppConstants.YourData)
                                                     
                                                     
            ]
        }else{
            settingsTableCell.arrData =  [(image: "icons8_settings", name: AppConstants.Settings),
                                                      (image: "icons8_shop", name:  AppConstants.Marketplace),
                                                      (image: "icons8_security_lock", name: AppConstants.Privacy),
                                                      (image: "passwordSetting", name: AppConstants.CapPassword),
                                                      (image: "icons8_unavailable", name: AppConstants.Blocking),
                                                      (image: "icons8_debit_card_1", name: AppConstants.Membership),
                                                      (image: "icons8_purchase_order", name:  AppConstants.Billing),
                                                      (image: "icons8_terms_and_conditions", name: AppConstants.TermsAndConditions),
                                                      (image: "icons8_data_protection", name: AppConstants.PrivacyPolicy),
                                                      (image: "Faq", name: AppConstants.FAQ),
                                                      (image: "icons8_exit", name: AppConstants.Logout),
                                                      (image: "yourData", name: AppConstants.YourData)
                                                     
                                                      
            ]
            
        }
        settingsTableCell.configure(indexPath)
       
      return settingsTableCell
    }

    @IBAction func tapBack(_ sender: UIButton) {
      
      self.navigationController?.popViewController(animated: true)
    }
    @IBAction func tapLogout(_ sender: UIButton) {
        kSharedAppDelegate.callLogoutApi()
     // kSharedUserDefaults.clearAllData()
    }
}

extension SettingsScreenVC: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "3"{
        return StaticArrayData.kSettingPrducrColScreenDict.count
        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId == "10"{
            return StaticArrayData.kSettingVoyaColScreenDict.count
        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId == "9"{
            return StaticArrayData.kSettingRestColScreenDict.count
        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId == "7"{
            return StaticArrayData.kSettingExpertColScreenDict.count
        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId == "8"{
            return StaticArrayData.kSettingTravlColScreenDict.count
        }else {
            return StaticArrayData.kSettingImprtrColScreenDict.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.getSettingCollectionCell(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.producer.rawValue)" {
            switch indexPath.row {
           
            case 0:
             // _ = pushViewController(withName: EditUserSettingsViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as! EditUserSettingsViewC
                let vc = pushViewController(withName: EditSetingTypeViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! EditSetingTypeViewController
                vc.imgPUrl = imgPUrl
            case 1:
              _ = pushViewController(withName: MarketplaceHomePageVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)
            case 2:
              _ = pushViewController(withName: CompanyViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
            case 3:
              _ = pushViewController(withName: Privacy.id(), fromStoryboard: StoryBoardConstants.kHome)
            case 4:
              _ = pushViewController(withName: UpdatePasswordViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
            case 5:
              _ = pushViewController(withName: BlockingViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
            case 6:
              _ = pushViewController(withName: MembershipViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
            case 8,9:
                let controller  = pushViewController(withName:  WebKitViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as? WebKitViewController
               
                controller?.strngTitle = StaticArrayData.kSettingPrducrColScreenDict[indexPath.row].name
            case 10:
                          _ = pushViewController(withName: FAQController.id(), fromStoryboard: StoryBoardConstants.kHome)
            case 11:
              _ = pushViewController(withName: YourDataViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
            case (StaticArrayData.kSettingPrducrColScreenDict.count - 1):
              
                kSharedAppDelegate.callLogoutApi()
                
            default:
              break
            }
        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.voyagers.rawValue)" {
        switch indexPath.row {
        case 0:
          //_ = pushViewController(withName: EditUserSettingsViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as! EditUserSettingsViewC
            _ = pushViewController(withName: EditSetingTypeViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! EditSetingTypeViewController
        case 1:
          _ = pushViewController(withName: Privacy.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 2:
          _ = pushViewController(withName: UpdatePasswordViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 3:
          _ = pushViewController(withName: BlockingViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        //case 4:
         // _ = pushViewController(withName: MembershipViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 9:
          _ = pushViewController(withName: YourDataViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 5,6:
            let controller  = pushViewController(withName:  WebKitViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as? WebKitViewController
            controller?.strngTitle = StaticArrayData.kSettingVoyaColScreenDict[indexPath.row].name
        case 7:
            _ = pushViewController(withName: FAQController.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 8:
            kSharedAppDelegate.callLogoutApi()
           
          
        default:
          break
        }

        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.restaurant.rawValue)" {
        switch indexPath.row {
        case 0:
         // _ = pushViewController(withName: EditUserSettingsViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as! EditUserSettingsViewC
            _ = pushViewController(withName: EditSetingTypeViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! EditSetingTypeViewController
        case 1:
          _ = pushViewController(withName: MarketplaceHomePageVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)
        case 2:
          let vc = pushViewController(withName: EventsView.id(), fromStoryboard: StoryBoardConstants.kHome) as? EventsView
            vc!.userId = userId
        case 3:
          _ = pushViewController(withName: Privacy.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 4:
          _ = pushViewController(withName: UpdatePasswordViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 5:
          _ = pushViewController(withName: BlockingViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 6:
          _ = pushViewController(withName: MembershipViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 8,9:
            let controller  = pushViewController(withName:  WebKitViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as? WebKitViewController
            controller?.strngTitle = StaticArrayData.kSettingRestColScreenDict[indexPath.row].name
        case 10:
            _ = pushViewController(withName: FAQController.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 11:
          _ = pushViewController(withName: YourDataViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
            
        case StaticArrayData.kSettingRestColScreenDict.count - 1:
            
            kSharedAppDelegate.callLogoutApi()
        default:
          break
        }
        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.voiceExperts.rawValue)"{
        switch indexPath.row {
        case 0:
          //_ = pushViewController(withName: EditUserSettingsViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as! EditUserSettingsViewC
            _ = pushViewController(withName: EditSetingTypeViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! EditSetingTypeViewController
        case 1:
          _ = pushViewController(withName: MarketplaceHomePageVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)
        case 2:
            print("AddFeature")
            CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kUserSubmittedFields+"/"+String.getString(kSharedUserDefaults.loggedInUserModal.userId), method: .GET, controller: self, type: 0, param: [:], btnTapped: UIButton())
            
        case 3:
          _ = pushViewController(withName: Privacy.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 4:
          _ = pushViewController(withName: UpdatePasswordViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 5:
          _ = pushViewController(withName: BlockingViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 6:
          _ = pushViewController(withName: MembershipViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 8,9:
            let controller  = pushViewController(withName:  WebKitViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as? WebKitViewController
            controller?.strngTitle = StaticArrayData.kSettingRestColScreenDict[indexPath.row].name
        case 10:
            _ = pushViewController(withName: FAQController.id(), fromStoryboard: StoryBoardConstants.kHome)
        case StaticArrayData.kSettingExpertColScreenDict.count - 2:
          _ = pushViewController(withName: YourDataViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case StaticArrayData.kSettingExpertColScreenDict.count - 1:
            kSharedAppDelegate.callLogoutApi()
           
        default:
          break
        }
        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.travelAgencies.rawValue)"{
        switch indexPath.row {
        case 0:
         // _ = pushViewController(withName: EditUserSettingsViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as! EditUserSettingsViewC
            _ = pushViewController(withName: EditSetingTypeViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! EditSetingTypeViewController
        case 1:
          _ = pushViewController(withName: MarketplaceHomePageVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)
        case 2:
          _ = pushViewController(withName: Privacy.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 3:
          _ = pushViewController(withName: UpdatePasswordViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 4:
          _ = pushViewController(withName: BlockingViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 5:
          _ = pushViewController(withName: MembershipViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 7,8:
            let controller  = pushViewController(withName:  WebKitViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as? WebKitViewController
            controller?.strngTitle = StaticArrayData.kSettingTravlColScreenDict[indexPath.row].name
        case 9:
            _ = pushViewController(withName: FAQController.id(), fromStoryboard: StoryBoardConstants.kHome)
        case StaticArrayData.kSettingTravlColScreenDict.count - 1:
          _ = pushViewController(withName: YourDataViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case StaticArrayData.kSettingTravlColScreenDict.count - 2:
            kSharedAppDelegate.callLogoutApi()
        default:
          break
        }
    }else{
        switch indexPath.row {
        case 0:
         // _ = pushViewController(withName: EditUserSettingsViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as! EditUserSettingsViewC
            _ = pushViewController(withName: EditSetingTypeViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! EditSetingTypeViewController
        case 1:
          _ = pushViewController(withName: MarketplaceHomePageVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)
        case 2:
          _ = pushViewController(withName: Privacy.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 3:
          _ = pushViewController(withName: UpdatePasswordViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 4:
          _ = pushViewController(withName: BlockingViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 5:
          _ = pushViewController(withName: MembershipViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 7,8:
            let controller  = pushViewController(withName:  WebKitViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as? WebKitViewController
            controller?.strngTitle = StaticArrayData.kSettingImprtrColScreenDict[indexPath.row].name
        case 9:
            _ = pushViewController(withName: FAQController.id(), fromStoryboard: StoryBoardConstants.kHome)
        case StaticArrayData.kSettingImprtrColScreenDict.count - 1:
          _ = pushViewController(withName: YourDataViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case StaticArrayData.kSettingImprtrColScreenDict.count - 2:
            kSharedAppDelegate.callLogoutApi()
        default:
          break
        }
    }
    }
}
//extension SettingsScreenVC: CHTCollectionViewDelegateWaterfallLayout  {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        //let itemWidth = itemsArray[indexPath.row].width
//       // let itemHeight = itemsArray[indexPath.row].height
//        let itemWidth = 80
//        let itemHeight = 80
//        return CGSize(width: itemWidth, height: itemHeight)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, columnCountFor section: Int) -> Int {
//        return 2
//    }
//    
//}
extension SettingsScreenVC: CHTCollectionViewDelegateWaterfallLayout {

    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        if indexPath.item == 1 {
            return CGSize(width: Int((view.bounds.width - 40)/3), height: 85)
        }else{
            return CGSize(width: Int((view.bounds.width - 40)/3), height: 86)
        }

    }
}

extension SettingsScreenVC{
override func didUserGetData(from result: Any, type: Int) {
 
        let dicResult = kSharedInstance.getDictionary(result)
        let dicData = kSharedInstance.getDictionary(dicResult[APIConstants.kData])
        self.signUpViewModel = SignUpViewModel(dicData, roleId: nil)
        print("Some")
    let productCategoriesDataModel = self.signUpViewModel?.arrProductCategories.first
    
    let controller = pushViewController(withName: AddFeatureViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? AddFeatureViewC
    controller?.productCategoriesDataModel = productCategoriesDataModel
    controller?.delegate = self
        
    }
    
}

extension SettingsScreenVC: AddFeaturedProductCallBack {
    func productAdded() {
        print("Push------")
    }
    
    
    func tappedAddProduct(withProductCategoriesDataModel model: ProductCategoriesDataModel, featureListingId: String?) {
        if featureListingId == nil{
            //self.postRequestToUpdateUserProfile()
            let controller = pushViewController(withName: AddFeatureViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? AddFeatureViewC
            controller?.productCategoriesDataModel = model
            controller?.delegate = self
        }
              
    }
    }
