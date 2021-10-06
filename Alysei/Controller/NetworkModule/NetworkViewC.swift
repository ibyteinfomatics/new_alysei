//
//  NetworkViewC.swift
//  Alysie
//
//  Created by CodeAegis on 25/01/21.
//

import UIKit

class NetworkViewC: AlysieBaseViewC {
  
  //MARK: - Properties -
  
  var currentIndex: Int = 0
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var collectionViewNetworkCategory: UICollectionView!
  @IBOutlet weak var tblViewNetwork: UITableView!
  @IBOutlet weak var tblViewInviteNetwork: UITableView!
    
    // blank data view
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var viewBlankHeading: UIView!
    @IBOutlet weak var blankdataView: UIView!
    
    var connection:ConnectionTabModel?
  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
   super.viewDidLoad()
    self.tblViewNetwork.tableFooterView = UIView()
    self.tblViewInviteNetwork.tableFooterView = UIView()
    
    tblViewInviteNetwork.isHidden = false
    tblViewNetwork.isHidden = true
    
  }
  
    override func viewWillAppear(_ animated: Bool) {
        let data = kSharedUserDefaults.getLoggedInUserDetails()
        if Int.getInt(data["alysei_review"]) == 0 {
            
            blankdataView.isHidden = false
            
        } else if Int.getInt(data["alysei_review"]) == 1{
            
            blankdataView.isHidden = true
           
        }
        
        callConnectionApi(api: APIUrl.kConnectionTabApi1)
        
    }
    
    func inviteApi(id: Int, type: Int){
        
        let params: [String:Any] = [
            "connection_id": id,
            "accept_or_reject": type]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kinvitationAcceptReject, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            if self.currentIndex == 0 {
                self.callConnectionApi(api: APIUrl.kConnectionTabApi1)
            } else if self.currentIndex == 1{
                self.callConnectionApi(api: APIUrl.kConnectionTabApi)
            }
            
        }
        
    }
    
    func pendingRemoveApi(id: Int){
       
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kPendingRemove+String.getString(id), requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            self.callConnectionApi(api: APIUrl.kConnectionTabApi1)
            
        }
        
    }
    
    func callConnectionApi(api: String){
        
        self.connection?.data?.removeAll()
        self.tblViewNetwork.reloadData()
        self.tblViewInviteNetwork.reloadData()
        TANetworkManager.sharedInstance.requestApi(withServiceName: api, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
           
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [[String:Any]]{
                self.connection = ConnectionTabModel.init(with: dictResponse)
                
            }
            
            if self.currentIndex == 0 {
                self.tblViewInviteNetwork.reloadData()
            } else {
                self.tblViewNetwork.reloadData()
            }
            
            
        }
    }
    
  //MARK: - IBAction -
    
    @IBAction func tapLogout(_ sender: UIButton) {
        let token = kSharedUserDefaults.getDeviceToken()
        kSharedUserDefaults.clearAllData()
        kSharedUserDefaults.setDeviceToken(deviceToken: token)

      //kSharedUserDefaults.clearAllData()
    }
    
  
  @IBAction func tapNotification(_ sender: UIButton) {
    
    _ = pushViewController(withName: NotificationViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
  }
  
  //MARK: - Private Methods -
  
  private func getNetworkCategoryCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
    
    let networkCategoryCollectionCell = collectionViewNetworkCategory.dequeueReusableCell(withReuseIdentifier: NetworkCategoryCollectionCell.identifier(), for: indexPath) as! NetworkCategoryCollectionCell
    
    networkCategoryCollectionCell.lblNetworkCount.isHidden = true
    networkCategoryCollectionCell.configureData(indexPath: indexPath, currentIndex: self.currentIndex)
    return networkCategoryCollectionCell
  }
  
  private func getNetworkTableCell(_ indexPath: IndexPath) -> UITableViewCell{
    
    var networkTableCell = tblViewNetwork.dequeueReusableCell(withIdentifier: NetworkTableCell.identifier()) as! NetworkTableCell
    
    if currentIndex == 0 {
        
        networkTableCell = tblViewInviteNetwork.dequeueReusableCell(withIdentifier: NetworkTableCell.identifier()) as! NetworkTableCell
        
        networkTableCell.email.text = self.connection?.data?[indexPath.row].reasonToConnect
        
        if connection?.data?[indexPath.row].user?.companyName != "" {
            networkTableCell.name.text = connection?.data?[indexPath.row].user?.companyName
        } else if connection?.data?[indexPath.row].user?.firstname != ""{
            networkTableCell.name.text = (connection?.data?[indexPath.row].user!.firstname)!+" "+(connection?.data?[indexPath.row].user!.lastname)!
        } else {
            networkTableCell.name.text = connection?.data?[indexPath.row].user?.restaurantName
        }
        
        if currentIndex == 3 {
            networkTableCell.remove.isHidden = true
        } else if currentIndex == 1{
            networkTableCell.remove.isHidden = false
            networkTableCell.remove.setTitleColor( UIColor.init(red: 75.0/255.0, green: 179.0/255.0, blue: 253.0/255.0, alpha: 1.0), for: .normal)
            networkTableCell.remove.layer.borderColor =  UIColor.init(red: 75.0/255.0, green: 179.0/255.0, blue: 253.0/255.0, alpha: 1.0).cgColor
        } else if currentIndex == 2{
            networkTableCell.remove.isHidden = false
            networkTableCell.remove.setTitleColor(.red, for: .normal)
            networkTableCell.remove.layer.borderColor = UIColor.red.cgColor
        }
        
        networkTableCell.img.layer.masksToBounds = false
        networkTableCell.img.clipsToBounds = true
        networkTableCell.img.layer.borderWidth = 2
        networkTableCell.img.layer.borderColor = UIColor.init(red: 75.0/255.0, green: 179.0/255.0, blue: 253.0/255.0, alpha: 1.0).cgColor
        networkTableCell.img.layer.cornerRadius = networkTableCell.img.frame.width/2
        
        if self.connection?.data?[indexPath.row].user?.avatarID?.attachmentURL != nil {
            networkTableCell.img.setImage(withString: String.getString(kImageBaseUrl+(self.connection?.data?[indexPath.row].user?.avatarID?.attachmentURL)! ?? ""), placeholder: UIImage(named: "image_placeholder"))
        }
        
        
        networkTableCell.btnViewCallback = { tag in
            
            let type = self.connection?.data?[indexPath.row].user?.roleID
            
            switch type {
            case 4,5,6:
                let vc = self.pushViewController(withName: ImporterDashboardViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! ImporterDashboardViewController
                vc.connectionId = String.getString(self.connection?.data?[indexPath.row].connectionID)
            case 3:
                
                let role = Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId)
                
                switch role {
                case 9,7,8:
                    let vc = self.pushViewController(withName: ImporterDashboardViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! ImporterDashboardViewController
                    vc.connectionId = String.getString(self.connection?.data?[indexPath.row].connectionID)
                default:
                    let vc = self.pushViewController(withName: ProducerDashboardViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! ProducerDashboardViewController
                    vc.connectionId = String.getString(self.connection?.data?[indexPath.row].connectionID)
                }
                
                
            case 8:
                let vc = self.pushViewController(withName: TravelAgencyViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! TravelAgencyViewController
                vc.connectionId = String.getString(self.connection?.data?[indexPath.row].connectionID)
            case 9:
                let vc = self.pushViewController(withName: RestaurantViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! RestaurantViewController
                vc.connectionId = String.getString(self.connection?.data?[indexPath.row].connectionID)
            case 7:
                let vc = self.pushViewController(withName: VoiceOfExpertsViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! VoiceOfExpertsViewController
                vc.connectionId = String.getString(self.connection?.data?[indexPath.row].connectionID)
            default:
                break
                //return nil
            }
           
            
        }
        
        networkTableCell.btnAcceptCallback = { tag in
            
            self.inviteApi(id: (self.connection?.data?[indexPath.row].connectionID)!, type: 1)
            
        }
        
        networkTableCell.btnDeclineCallback = { tag in
            self.inviteApi(id: (self.connection?.data?[indexPath.row].connectionID)!, type: 2)
            
        }
        
        
    } else {
        networkTableCell = tblViewNetwork.dequeueReusableCell(withIdentifier: NetworkTableCell.identifier()) as! NetworkTableCell
        //networkTableCell.name.text = self.connection?.data?[indexPath.row].user?.companyName
        networkTableCell.email.text = self.connection?.data?[indexPath.row].user?.email
        
        if connection?.data?[indexPath.row].user?.companyName != "" {
            networkTableCell.name.text = connection?.data?[indexPath.row].user?.companyName
        } else if connection?.data?[indexPath.row].user?.firstname != ""{
            networkTableCell.name.text = (connection?.data?[indexPath.row].user!.firstname)!+" "+(connection?.data?[indexPath.row].user!.lastname)!
        } else {
            networkTableCell.name.text = connection?.data?[indexPath.row].user?.restaurantName
        }
        
        if currentIndex == 3 {
            networkTableCell.remove.isHidden = true
        } else if currentIndex == 1{
            networkTableCell.remove.tag = indexPath.row
            networkTableCell.remove.isHidden = false
            networkTableCell.remove.setTitleColor( UIColor.init(red: 75.0/255.0, green: 179.0/255.0, blue: 253.0/255.0, alpha: 1.0), for: .normal)
            networkTableCell.remove.layer.borderColor =  UIColor.init(red: 75.0/255.0, green: 179.0/255.0, blue: 253.0/255.0, alpha: 1.0).cgColor
            networkTableCell.remove.setTitle("Remove", for: .normal)
            
            networkTableCell.btnRemoveCallback = { tag in
                self.inviteApi(id: (self.connection?.data?[indexPath.row].connectionID)!, type: 2)
                
            }
            
        } else if currentIndex == 2{
            networkTableCell.remove.tag = indexPath.row
            networkTableCell.remove.isHidden = false
            networkTableCell.remove.setTitleColor(.red, for: .normal)
            networkTableCell.remove.layer.borderColor = UIColor.red.cgColor
            networkTableCell.remove.setTitle("Cancel", for: .normal)
            
            networkTableCell.btnRemoveCallback = { tag in
                self.pendingRemoveApi(id: (self.connection?.data?[indexPath.row].userID)!)
                
            }
            
        }
        
        networkTableCell.img.layer.masksToBounds = false
        networkTableCell.img.clipsToBounds = true
        networkTableCell.img.layer.cornerRadius = networkTableCell.img.frame.width/2
        
        if self.connection?.data?[indexPath.row].user?.avatarID?.attachmentURL != nil {
            networkTableCell.img.setImage(withString: String.getString(kImageBaseUrl+(self.connection?.data?[indexPath.row].user?.avatarID?.attachmentURL)! ?? ""), placeholder: UIImage(named: "image_placeholder"))
        }
    }
    
    
    
    
    return networkTableCell
  }
}

//MARK: - CollectionView Methods -

extension NetworkViewC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return StaticArrayData.kNetworkCategoryDict.count
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    return self.getNetworkCategoryCollectionCell(indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> Void {
        
    self.currentIndex = indexPath.item
    self.collectionViewNetworkCategory.reloadData()
    if indexPath.row == 0 {
        tblViewInviteNetwork.isHidden = false
        tblViewNetwork.isHidden = true
        callConnectionApi(api: APIUrl.kConnectionTabApi1)
    } else if indexPath.row == 1 {
        tblViewInviteNetwork.isHidden = true
        tblViewNetwork.isHidden = false
        callConnectionApi(api: APIUrl.kConnectionTabApi)
    } else if indexPath.row == 2 {
        tblViewInviteNetwork.isHidden = true
        tblViewNetwork.isHidden = false
        callConnectionApi(api: APIUrl.kConnectionTabApi3)
    } else if indexPath.row == 3 {
        tblViewInviteNetwork.isHidden = true
        tblViewNetwork.isHidden = false
        callConnectionApi(api: APIUrl.kConnectionTabApi4)
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: kScreenWidth/3.0, height: 45.0)
  }
    
}


//MARK:  - UITableViewMethods -

extension NetworkViewC: UITableViewDataSource, UITableViewDelegate{
    
        
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
//    if currentIndex == 0 {
//        return 8
//    } else {
//
//    }
    return self.connection?.data?.count ?? 0
    
  }
        
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    return self.getNetworkTableCell(indexPath)

  }
        
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    if currentIndex == 0 {
        return 200.0
    } else {
        return 66.0
    }
    
  }
        
}
