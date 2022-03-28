//
//  EditSetingTypeViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 07/04/21.
//

import UIKit

class EditSetingTypeViewController: AlysieBaseViewC {

    //MARK: @IBOutlet
    @IBOutlet weak var settingTypeCollectionView: UICollectionView!
    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var reviewSelectedHubs : [ReviewSelectedHub]?
    var notificationStatus: Int?
    var updateNotification: Int?
    var imgPUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = AppConstants.EditSettings
        getNotificationStatusApi()
        self.viewShadow.drawBottomShadow()
    }
  
//    private func getSettingCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
//
//        guard let settingsTableCell = settingTypeCollectionView.dequeueReusableCell(withReuseIdentifier: EditSettingTypeCollectionViewCell.identifier(), for: indexPath) as? EditSettingTypeCollectionViewCell else {return UICollectionViewCell()}
//        settingsTableCell.configure(indexPath)
//      return settingsTableCell
//    }
    private func getSettingTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        guard let settingsTableCell = settingTableView.dequeueReusableCell(withIdentifier: EditSettingTypeTableViewCell.identifier(), for: indexPath) as? EditSettingTypeTableViewCell else {return UITableViewCell()}
        settingsTableCell.selectionStyle = .none
        settingsTableCell.configure(indexPath)
      return settingsTableCell
    }
    private func getNotificationTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        guard let notificationTableCell = settingTableView.dequeueReusableCell(withIdentifier: EditSettingTypeNotificationTableVC.identifier(), for: indexPath) as? EditSettingTypeNotificationTableVC else {return UITableViewCell()}
        notificationTableCell.selectionStyle = .none
        if notificationStatus == 0 {
            notificationTableCell.btnSwitch.isOn = false
        }else{
            notificationTableCell.btnSwitch.isOn = true
        }
        notificationTableCell.notificationCallback = {
            self.UpdateNotificationApi()
        }
      return notificationTableCell
    }
    @IBAction func tapBack(_ sender: UIButton) {
      
      self.navigationController?.popViewController(animated: true)
    }


}
//extension EditSetingTypeViewController: UICollectionViewDataSource, UICollectionViewDelegate{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        //let roleID =  UserRoles(rawValue: "\(kSharedUserDefaults.loggedInUserModal.memberRoleId ?? "0")") ?? .voyagers
//        let roleID = UserRoles(rawValue: Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId ?? 0)) ?? .voyagers
//        if roleID == .voyagers {
//        return StaticArrayData.kEditSettingVoyColScreenDict.count
//        }else {
//            return StaticArrayData.kEditSettingUserColScreenDict.count
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return self.getSettingCollectionCell(indexPath)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            switch indexPath.row {
//            case 0:
//                _ = pushViewController(withName: EditUserSettingsViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as! EditUserSettingsViewC
//            default:
//                print("HubSelection")
//                let nextVC = CountryListVC()
//                nextVC.hasCome = .showCountry
//                nextVC.isEditHub = true
//                nextVC.selectedHubs = []
//                self.navigationController?.pushViewController(nextVC, animated: true)
//            }
//       }
//}
//
//
//extension EditSetingTypeViewController: CHTCollectionViewDelegateWaterfallLayout {
//
//    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
//        if indexPath.item == 1 {
//            return CGSize(width: Int((view.bounds.width - 40)/3), height: 75)
//        }else{
//            return CGSize(width: Int((view.bounds.width - 40)/3), height: 76)
//        }
//
//    }
//}

//MARK: UITableViewCell
extension EditSetingTypeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let roleID = UserRoles(rawValue: Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId ?? 0)) ?? .voyagers
        if roleID == .voyagers {
        return (StaticArrayData.kEditSettingVoyColScreenDict.count +  1)
        }else {
            return (StaticArrayData.kEditSettingUserColScreenDict.count +  1)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let roleID = UserRoles(rawValue: Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId ?? 0)) ?? .voyagers
        if roleID == .voyagers {
            if indexPath.row == StaticArrayData.kEditSettingVoyColScreenDict.count{
                return self.getNotificationTableCell(indexPath)
            }else{
                return self.getSettingTableCell(indexPath)
            }
        }else{
        if indexPath.row == StaticArrayData.kEditSettingUserColScreenDict.count{
            return self.getNotificationTableCell(indexPath)
       
        }else{
            return self.getSettingTableCell(indexPath)
        }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = pushViewController(withName: EditUserSettingsViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as! EditUserSettingsViewC
            vc.imgPUrl = self.imgPUrl
        case 1:
            print("HubSelection")
//            let nextVC = CountryListVC()
//            nextVC.hasCome = .showCountry
//            nextVC.isEditHub = true
//            nextVC.selectedHubs = []
//            self.tabBarController?.tabBar.isHidden = true
//
//            self.navigationController?.pushViewController(nextVC, animated: true)
            self.callReviewHubApi()
        default:
            print("Nothing")
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
class EditSettingTypeNotificationTableVC: UITableViewCell{
    @IBOutlet weak var btnSwitch: UISwitch!
    @IBOutlet weak var lblOption: UILabel!
    var notificationCallback: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblOption.text = AppConstants.Notification
    }
    
    @IBAction func btnSwitchAction(_ sender: UISwitch){
        notificationCallback?()
    }
}
class EditSettingTypeTableViewCell: UITableViewCell{
  
    @IBOutlet weak var txtLabel: UILabel!
   // @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imgViewSettings: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       // viewContainer.layer.cornerRadius = 10

    }
//    
    public func configure(_ indexPath: IndexPath){
       
    if kSharedUserDefaults.loggedInUserModal.memberRoleId == "10"{
            imgViewSettings.image = UIImage.init(named: StaticArrayData.kEditSettingVoyColScreenDict[indexPath.item].image)
        txtLabel.text = StaticArrayData.kEditSettingVoyColScreenDict[indexPath.item].name
    }else{
        imgViewSettings.image = UIImage.init(named: StaticArrayData.kEditSettingUserColScreenDict[indexPath.item].image)
        txtLabel.text = StaticArrayData.kEditSettingUserColScreenDict[indexPath.item].name
    }
}
}
extension EditSetingTypeViewController {
    func callReviewHubApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: "\(APIUrl.kReviewHub)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errortype, statuscode) in
            print("success")
            let response = dictResponse as? [String:Any]
            if let data = response?["data"] as? [[String:Any]]{
                
                let hubsArray = kSharedInstance.getArray(withDictionary: data)
                self.reviewSelectedHubs = hubsArray.map{ReviewSelectedHub(with: $0)}
                
            }
            print("wertyuihgfdszxcvbnm,nbcvxvbnm,---------\(self.reviewSelectedHubs ?? [ReviewSelectedHub]())")
            if self.reviewSelectedHubs?.count == 0 {
                let nextVC = CountryListVC()
                nextVC.isEditHub = true
                nextVC.selectedHubs = []
                self.hidesBottomBarWhenPushed = true
            
                self.navigationController?.pushViewController(nextVC, animated: true)
            }else{
                let nextVC = ConfirmSelectionVC()
                nextVC.isEditHub = true
                nextVC.selectedHubs = []
                self.hidesBottomBarWhenPushed = true
            
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            
        }
    }
    
    func getNotificationStatusApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetNotificationStatusApi, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictResponse, error, errorType, statusCode in
            if let response = dictResponse as? [String:Any]{
                if let data = response["data"] as? Int{
                    if data == 0 {
                        print("Notification off")
                    }else if data == 1 {
                        print("Notification ON")
                    }
                    self.notificationStatus = data
                }
                let indexpath = IndexPath(row: 2, section: 0)
                self.settingTableView.reloadRows(at: [indexpath], with: .automatic)
            }
            
        }
    }
    
    func UpdateNotificationApi(){
        if notificationStatus == 0  {
             updateNotification = 1
        }else{
            updateNotification = 0
        }
        let params:[String:Any] = [ "notification_status": updateNotification ?? 0]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kPostNotifictionEnableDisableApi, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { dictResponse, error, errorType, statusCode in
            if let response = dictResponse as? [String:Any]{
                self.getNotificationStatusApi()
            }
        }
    }
}
