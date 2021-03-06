//
//  HubsViewC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/25/21.
//

import UIKit

class HubsViewC: AlysieBaseViewC {
    
    @IBOutlet weak var detailCollectionView: UICollectionView!
    @IBOutlet weak var hubName: UILabel!
    @IBOutlet weak var hubLocation: UILabel!
    @IBOutlet weak var lblSubHeading: UILabel!
    @IBOutlet weak var btnSubscribe: UIButton!
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var imgHub: UIImageView!
    @IBOutlet weak var lblHeading: UILabel!
   // @IBOutlet weak var imgHub: UIImageView!
    
    var arruserCount : [UserRoleCount]?
    var passHubId: String?
    var passHubName: String?
    var passHubLocation: String?
    var passHubImageUrl: String?
    var passBaseUrl: String?
    var getRoleViewModel: GetRoleViewModel!
    var isHubSubscribed: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblHeading.text = AppConstants.kHubs
        vwHeader.drawBottomShadow()
        hubName.text = passHubName
        hubLocation.text = passHubLocation
        self.imgHub.setImage(withString: (passBaseUrl ?? "") + String.getString(passHubImageUrl))
        lblSubHeading.text = (MarketPlaceConstant.JoinThe + " " + "\(passHubName ?? "")" + " " + MarketPlaceConstant.ToExpandYourNetworkAndAccess)
        callUserCountApi()
        // Do any additional setup after loading the view.
    }
    func setData(){
        if self.isHubSubscribed == 0 {
            self.btnSubscribe.setTitle(AppConstants.kSubscribe, for: .normal)
        }else{
            self.btnSubscribe.setTitle(AppConstants.kUnsubscribe, for: .normal)
        }
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubscribe(_ sender: UIButton){
        if self.isHubSubscribed == 0{
            self.isHubSubscribed = 1
        }else{
            self.isHubSubscribed = 0
        }
        callSubscribeNUnsubscribeApi()
    }

}

extension HubsViewC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arruserCount?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "HubCollectionViewCell", for: indexPath) as? HubCollectionViewCell else {return UICollectionViewCell()}
        cell.configData(indexPath.row, arruserCount?[indexPath.row] ?? UserRoleCount(with: [:]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
      let width = (kScreenWidth - 70.0)/3
      return CGSize(width: width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = pushViewController(withName: HubUserListVC.id(), fromStoryboard: StoryBoardConstants.kHome) as? HubUserListVC
        controller?.passHubId = self.passHubId
        controller?.passRoleId = "\(arruserCount?[indexPath.row].role_id ?? 0)"
        controller?.passUserTitle = arruserCount?[indexPath.row].name
        if arruserCount?[indexPath.row].role_id == UserRoles.restaurant.rawValue{
            controller?.currentIndex = B2BSearch.Restaurant.rawValue
        }else if arruserCount?[indexPath.row].role_id == UserRoles.producer.rawValue{
            controller?.currentIndex = B2BSearch.Producer.rawValue
            controller?.identifyUserForProduct = .productProducer
        }else if arruserCount?[indexPath.row].role_id == UserRoles.distributer1.rawValue || arruserCount?[indexPath.row].role_id == UserRoles.distributer2.rawValue || arruserCount?[indexPath.row].role_id == UserRoles.distributer3.rawValue{
            controller?.currentIndex = B2BSearch.Importer.rawValue
            controller?.identifyUserForProduct = .productImporter
        }else if arruserCount?[indexPath.row].role_id == UserRoles.voiceExperts.rawValue{
            controller?.currentIndex =  B2BSearch.Expert.rawValue
        }else if arruserCount?[indexPath.row].role_id == UserRoles.travelAgencies.rawValue{
            controller?.currentIndex =  B2BSearch.TravelAgencies.rawValue
        }else if arruserCount?[indexPath.row].role_id == UserRoles.voyagers.rawValue{
            controller?.currentIndex = B2BSearch.Voyager.rawValue
        }
//        else if arruserCount?[indexPath.row].role_id == UserRoles.voyagers.rawValue{
//            controller?.currentIndex =  B2BSearch.Voyager.rawValue
//        }
        
    
    }
}

extension HubsViewC{
    func callUserCountApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetRolesUserCount + "\(passHubId ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errtype, statusCode) in
            let response = dictResponse as? [String:Any]
            self.isHubSubscribed = response?["is_subscribed_with_hub"] as? Int
            print("HUbSubscribed ----------------------\(self.isHubSubscribed ?? 0)")
            if let data =  response?["data"] as? [[String:Any]]{
                self.arruserCount = data.map({UserRoleCount.init(with: $0)})
            }
            self.setData()
            self.detailCollectionView.reloadData()
        }
    }
    
    func callSubscribeNUnsubscribeApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kHubSubscribeUnscribe + "\(self.passHubId ?? "")" + "&subscription_type=" + "\(self.isHubSubscribed ?? 0)", requestMethod: .POST, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statuscode) in
            
            self.setData()
        }
    }
}

