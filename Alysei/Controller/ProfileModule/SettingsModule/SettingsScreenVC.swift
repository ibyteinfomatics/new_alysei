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
    var userId: String?
    var signUpViewModel: SignUpViewModel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("modelRoleID--------------------------------\(kSharedUserDefaults.loggedInUserModal.memberRoleId ?? "")")
        self.viewShadow.drawBottomShadow()
    }
  
    private func getSettingCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
        
        guard let settingsTableCell = settingCollectionView.dequeueReusableCell(withReuseIdentifier: SettingsScreenCollectionVC.identifier(), for: indexPath) as? SettingsScreenCollectionVC else{return UICollectionViewCell()}
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
                _ = pushViewController(withName: EditSetingTypeViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! EditSetingTypeViewController
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
            case 9:
              _ = pushViewController(withName: YourDataViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
            case 8:
              
                let token = kSharedUserDefaults.getDeviceToken()
                let retriveArrayData = kSharedUserDefaults.stringArray(forKey:  "SavedWalkthrough") ?? [String]()
               // kSharedUserDefaults.clearAllData()
                kSharedUserDefaults.setValue(retriveArrayData, forKey: "SavedWalkthrough")
                
                kSharedUserDefaults.setDeviceToken(deviceToken: token)
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
        case 4:
          _ = pushViewController(withName: MembershipViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 7:
          _ = pushViewController(withName: YourDataViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 6:
            let token = kSharedUserDefaults.getDeviceToken()
            let retriveArrayData = kSharedUserDefaults.stringArray(forKey:  "SavedWalkthrough") ?? [String]()
            //kSharedUserDefaults.clearAllData()
            kSharedUserDefaults.setValue(retriveArrayData, forKey: "SavedWalkthrough")
            kSharedUserDefaults.setDeviceToken(deviceToken: token)
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
        case 9:
          _ = pushViewController(withName: YourDataViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 8:
            let token = kSharedUserDefaults.getDeviceToken()
            let retriveArrayData = kSharedUserDefaults.stringArray(forKey:  "SavedWalkthrough") ?? [String]()
            //kSharedUserDefaults.clearAllData()
            kSharedUserDefaults.setValue(retriveArrayData, forKey: "SavedWalkthrough")
            kSharedUserDefaults.setDeviceToken(deviceToken: token)
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
        case 9:
          _ = pushViewController(withName: YourDataViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 8:
            let token = kSharedUserDefaults.getDeviceToken()
            let retriveArrayData = kSharedUserDefaults.stringArray(forKey:  "SavedWalkthrough") ?? [String]()
          //  kSharedUserDefaults.clearAllData()
            kSharedUserDefaults.setValue(retriveArrayData, forKey: "SavedWalkthrough")
            kSharedUserDefaults.setDeviceToken(deviceToken: token)
           // kSharedUserDefaults.clearAllData()
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
        case 7:
          _ = pushViewController(withName: YourDataViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 8:
            let token = kSharedUserDefaults.getDeviceToken()
            let retriveArrayData = kSharedUserDefaults.stringArray(forKey:  "SavedWalkthrough") ?? [String]()
           // kSharedUserDefaults.clearAllData()
            kSharedUserDefaults.setValue(retriveArrayData, forKey: "SavedWalkthrough")
            kSharedUserDefaults.setDeviceToken(deviceToken: token)
            kSharedAppDelegate.callLogoutApi()
          //  kSharedUserDefaults.clearAllData()
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
        case 7:
          _ = pushViewController(withName: YourDataViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
        case 8:
            let token = kSharedUserDefaults.getDeviceToken()
            let retriveArrayData = kSharedUserDefaults.stringArray(forKey:  "SavedWalkthrough") ?? [String]()
           // kSharedUserDefaults.clearAllData()
            kSharedUserDefaults.setValue(retriveArrayData, forKey: "SavedWalkthrough")
            kSharedUserDefaults.setDeviceToken(deviceToken: token)
            kSharedAppDelegate.callLogoutApi()
          //  kSharedUserDefaults.clearAllData()
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
            return CGSize(width: Int((view.bounds.width - 40)/3), height: 75)
        }else{
            return CGSize(width: Int((view.bounds.width - 40)/3), height: 76)
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
