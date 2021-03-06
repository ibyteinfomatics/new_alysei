//
//  NetworkViewC.swift
//  Alysie
//
//  Created by CodeAegis on 25/01/21.
//

import UIKit

var networkcurrentIndex: Int = 0

class NetworkViewC: AlysieBaseViewC {
  
  //MARK: - Properties -
  
  
    var fromvc: FromVC?
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var collectionViewNetworkCategory: UICollectionView!
  @IBOutlet weak var tblViewNetwork: UITableView!
  //@IBOutlet weak var tblViewInviteNetwork: UITableView!
    
  
    // blank data view
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var logout: UIButton!
//    @IBOutlet weak var viewBlankHeading: UIView!
    @IBOutlet weak var blankdataView: UIView!
    @IBOutlet weak var blankdata: UIView!
    @IBOutlet weak var blanktext: UILabel!
    var lastPage: Int?
    
    var connection:ConnectionTabModel?
    var arrConnection =  [Datum]()
    var indexOfPageToRequest = 1
  //MARK: - ViewLifeCycle Methods -
    var kNetworkCategoryDictnry:  [(image: String, name: String)]?
  override func viewDidLoad() {
   super.viewDidLoad()
      
    self.tblViewNetwork.tableFooterView = UIView()
      indexOfPageToRequest = 1
   // self.tblViewInviteNetwork.tableFooterView = UIView()
    
   // tblViewInviteNetwork.isHidden = false
   // tblViewNetwork.isHidden = true
    
  }
  
    override func viewWillAppear(_ animated: Bool) {
        indexOfPageToRequest = 1
        self.tabBarController?.tabBar.isHidden = false
        
        let data = kSharedUserDefaults.getLoggedInUserDetails()
        
        let role = Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId)
        
        if role != 10 {
            if Int.getInt(data["alysei_review"]) == 0 {
                
                blankdataView.isHidden = false
                
            } else if Int.getInt(data["alysei_review"]) == 1{
                
                blankdataView.isHidden = true
               
            }
        } else {
            blankdataView.isHidden = true
        }
        
        
        if networkcurrentIndex == 0 {
            callConnectionApi(api: APIUrl.kConnectionTabApi1 + "&page=\( indexOfPageToRequest)")
        } else if networkcurrentIndex == 1 {
            callConnectionApi(api: APIUrl.kConnectionTabApi + "&page=\(indexOfPageToRequest)")
        } else if networkcurrentIndex == 2 {
            callConnectionApi(api: APIUrl.kConnectionTabApi3 + "&page=\(indexOfPageToRequest)")
        } else if networkcurrentIndex == 3 {
            callConnectionApi(api: APIUrl.kConnectionTabApi4 + "&page=\(indexOfPageToRequest)")
        }
        
        //callConnectionApi(api: APIUrl.kConnectionTabApi1)
         kNetworkCategoryDictnry = [(image: "invitations", name: AppConstants.kInvitations),
                                          (image: "connections", name: AppConstants.kConnections),
                                          (image: "pending", name: AppConstants.kPending),
                                          kSharedUserDefaults.loggedInUserModal.memberRoleId == "10" ? (image: "following", name: AppConstants.kFollowing) : (image: "followers", name: AppConstants.Followers)]
       
        collectionViewNetworkCategory.reloadData()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
       override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           self.tabBarController?.tabBar.isHidden = false
           self.hidesBottomBarWhenPushed = false
       }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height - (self.view.frame.height * 2) {
            if indexOfPageToRequest > lastPage ?? 0{
                print("No Data")
            }else{
            // increments the number of the page to request
                self.indexOfPageToRequest += 1

            // call your API for more data
                if networkcurrentIndex == 0 {
                    callConnectionApi(api: APIUrl.kConnectionTabApi1 + "&page=\( indexOfPageToRequest)")
                } else if networkcurrentIndex == 1 {
                    callConnectionApi(api: APIUrl.kConnectionTabApi + "&page=\(indexOfPageToRequest)")
                } else if networkcurrentIndex == 2 {
                    callConnectionApi(api: APIUrl.kConnectionTabApi3 + "&page=\(indexOfPageToRequest)")
                } else if networkcurrentIndex == 3 {
                    callConnectionApi(api: APIUrl.kConnectionTabApi4 + "&page=\(indexOfPageToRequest)")
                }

            // tell the table view to reload with the new data
            self.tblViewNetwork.reloadData()
            }
        }
    }
    func inviteApi(id: Int, type: Int){
        
        let params: [String:Any] = [
            "connection_id": String.getString(id),
            "accept_or_reject": type]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kinvitationAcceptReject, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            if networkcurrentIndex == 0 {
                self.callConnectionApi(api: APIUrl.kConnectionTabApi1 + "&page=\(1)")
            } else if networkcurrentIndex == 1{
                self.callConnectionApi(api: APIUrl.kConnectionTabApi + "&page=\(1)")
            } else if networkcurrentIndex == 2{
                self.callConnectionApi(api: APIUrl.kConnectionTabApi3 + "&page=\(1)")
            }
            
        }
        
    }
    
    func pendingRemoveApi(id: Int){
       
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kPendingRemove+String.getString(id), requestMethod: .POST, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            self.callConnectionApi(api: APIUrl.kConnectionTabApi1)
            self.tblViewNetwork.reloadData()
            
        }
        
    }
    
    func callConnectionApi(api: String){
        
        blankdata.isHidden = true
        if indexOfPageToRequest == 1 {
            self.arrConnection.removeAll()
        }
        
        if networkcurrentIndex == 0 {
            blanktext.text = AppConstants.kYouHaveNoInvitationsRightNow
        } else if networkcurrentIndex == 1 {
            blanktext.text = AppConstants.kYouHaveNoConnectionsRightNow
        } else if networkcurrentIndex == 2 {
            blanktext.text = AppConstants.kYouHaveNoPendingInvitiesRightNow
        } else if networkcurrentIndex == 3 {
            blanktext.text = AppConstants.kYouHaveNoFollowersRightNow
        }
       
       // self.arrConnection.removeAll()
        
        self.tblViewNetwork.reloadData()
        //self.tblViewInviteNetwork.reloadData()
        TANetworkManager.sharedInstance.requestApi(withServiceName: api, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
           
            let dictResponse = dictResponse as? [String:Any]
           // let response = dictResponse["data"] as? [String:Any]
           
            if let data = dictResponse?["data"] as? [String:Any]{
                self.lastPage = data["last_page"] as? Int
                self.connection = ConnectionTabModel.init(with: data)
                if self.indexOfPageToRequest == 1 {self.arrConnection.removeAll()}
                self.arrConnection.append(contentsOf: self.connection?.data ?? [Datum(with: [:])])
            }
           
            if self.arrConnection.count > 0 {
                self.blankdata.isHidden = true
            } else {
                self.blankdata.isHidden = false
                self.text.text = AppConstants.kYourProfileNotReviewed
                self.logout.setTitle(TourGuideConstants.kLogoutProfile, for: .normal)
            }
            
//            if self.networkcurrentIndex == 0 {
//                self.tblViewInviteNetwork.reloadData()
//            } else {
                self.tblViewNetwork.reloadData()
           // }
            
            
        }
    }
    
  //MARK: - IBAction -
    
    @IBAction func tapLogout(_ sender: UIButton) {
       kSharedAppDelegate.callLogoutApi()

      //kSharedUserDefaults.clearAllData()
    }
    
  
  @IBAction func tapNotification(_ sender: UIButton) {
    
    _ = pushViewController(withName: NotificationViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
  }
  
  //MARK: - Private Methods -
  
  private func getNetworkCategoryCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
    
    let networkCategoryCollectionCell = collectionViewNetworkCategory.dequeueReusableCell(withReuseIdentifier: NetworkCategoryCollectionCell.identifier(), for: indexPath) as! NetworkCategoryCollectionCell
    networkCategoryCollectionCell.viewNetwork.layer.cornerRadius = networkCategoryCollectionCell.viewNetwork.frame.height / 2
    networkCategoryCollectionCell.lblNetworkCount.isHidden = true
      networkCategoryCollectionCell.kNetworkCategoryDictnry = self.kNetworkCategoryDictnry
    networkCategoryCollectionCell.configureData(indexPath: indexPath, currentIndex: networkcurrentIndex)
    return networkCategoryCollectionCell
  }
    
    private func getNetworkTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        if networkcurrentIndex == 0{
            guard  let networkCTableCell = tblViewNetwork.dequeueReusableCell(withIdentifier: NetworkConnectionTableViewCell.identifier()) as? NetworkConnectionTableViewCell else{return UITableViewCell()}
            networkCTableCell.img.layer.masksToBounds = false
            networkCTableCell.lblFollowerCount.text = "\(arrConnection[indexPath.row].user?.followers_count ?? 0)" +  " " + AppConstants.Followers
            networkCTableCell.img.clipsToBounds = true
            networkCTableCell.img.layer.borderWidth = 2
            networkCTableCell.img.layer.borderColor = UIColor.init(red: 75.0/255.0, green: 179.0/255.0, blue: 253.0/255.0, alpha: 1.0).cgColor
            networkCTableCell.img.layer.cornerRadius = networkCTableCell.img.frame.width/2
            networkCTableCell.email.text = 
            self.arrConnection[indexPath.row].reasonToConnect?.stringByTrimmingWhiteSpaceAndNewLine().stringByTrimmingWhiteSpace()
            
           // if arrConnection[indexPath.row].user?.companyName != "" {
            if arrConnection[indexPath.row].user?.companyName != "" {
                //networkCTableCell.name.text = arrConnection[indexPath.row].user?.companyName
                    networkCTableCell.name.text = arrConnection[indexPath.row].user?.companyName
            //} else if arrConnection[indexPath.row].user?.firstname != ""{
            } else if arrConnection[indexPath.row].user?.firstname != ""{
               // networkCTableCell.name.text = (arrConnection[indexPath.row].user!.firstname)!+" "+(arrConnection[indexPath.row].user!.lastname)!
                networkCTableCell.name.text = (arrConnection[indexPath.row].user!.firstname)+" "+(arrConnection[indexPath.row].user!.lastname)
            } else {
               // networkCTableCell.name.text = arrConnection[indexPath.row].user?.restaurantName
                networkCTableCell.name.text = arrConnection[indexPath.row].user?.restaurantName
            }
            
           // if self.arrConnection[indexPath.row].user?.avatarID?.attachmentURL != nil {
                if self.arrConnection[indexPath.row].user?.avatarID?.attachmentURL != nil {
                //let baseUrl = self.arrConnection[indexPath.row].user?.avatarID?.baseUrl ?? ""
                    let baseUrl = self.arrConnection[indexPath.row].user?.avatarID?.baseUrl ?? ""
               // networkCTableCell.img.setImage(withString: String.getString(baseUrl+(self.arrConnection[indexPath.row].user?.avatarID?.attachmentURL ?? "")), placeholder: UIImage(named: "image_placeholder"))
                    networkCTableCell.img.setImage(withString: String.getString(baseUrl+(self.arrConnection[indexPath.row].user?.avatarID?.attachmentURL ?? "")), placeholder: UIImage(named: "image_placeholder"))
            }
            networkCTableCell.btnAcceptCallback = { tag in
                
               // self.inviteApi(id: (self.arrConnection[indexPath.row].connectionID)!, type: 1)
                self.inviteApi(id: (self.arrConnection[indexPath.row].connectionID)!, type: 1)
                
            }
            
            networkCTableCell.btnDeclineCallback = { tag in
               // self.inviteApi(id: (self.arrConnection[indexPath.row].connectionID)!, type: 2)
                //self.inviteApi(id: (self.arrConnection[indexPath.row].connectionID)!, type: 2)
                
                let vc = self.pushViewController(withName: DeclineRequest.id(), fromStoryboard: StoryBoardConstants.kHome) as! DeclineRequest
                vc.visitordId = self.arrConnection[indexPath.row].user?.userID
                
            }
            
            networkCTableCell.btnViewCallback = { tag in
                
              //  let type = self.arrConnection[indexPath.row].user?.roleID
                let type = self.arrConnection[indexPath.row].user?.roleID
                
                switch type {
                case 4,5,6:
                    let vc = self.pushViewController(withName: ImporterDashboardViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! ImporterDashboardViewController
                    vc.role = type!
                    vc.visitordId = String.getString(self.arrConnection[indexPath.row].user?.userID)
                    vc.connectionId = String.getString(self.arrConnection[indexPath.row].connectionID)
                case 3:
                    
                    let role = Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId)
                    
                    switch role {
                    case 9,7,8,3:
                        let vc = self.pushViewController(withName: ImporterDashboardViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! ImporterDashboardViewController
                        vc.role = type!
                        vc.visitordId = String.getString(self.arrConnection[indexPath.row].user?.userID)
                        vc.connectionId = String.getString(self.arrConnection[indexPath.row].connectionID)
                    default:
                        let vc = self.pushViewController(withName: ProducerDashboardViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! ProducerDashboardViewController
                       //vc.connectionId = String.getString(self.arrConnection[indexPath.row].connectionID)
                        vc.visitordId = String.getString(self.arrConnection[indexPath.row].user?.userID)
                        vc.connectionId = String.getString(self.arrConnection[indexPath.row].connectionID)
                    }
                    
                    
                case 8:
                    let vc = self.pushViewController(withName: TravelAgencyViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! TravelAgencyViewController
                    //vc.connectionId = String.getString(self.arrConnection[indexPath.row].connectionID)
                    vc.visitordId = String.getString(self.arrConnection[indexPath.row].user?.userID)
                    vc.connectionId = String.getString(self.arrConnection[indexPath.row].connectionID)
                case 9:
                    let vc = self.pushViewController(withName: RestaurantViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! RestaurantViewController
                    vc.visitordId = String.getString(self.arrConnection[indexPath.row].user?.userID)
                    vc.connectionId = String.getString(self.arrConnection[indexPath.row].connectionID)
                case 7:
                    let vc = self.pushViewController(withName: VoiceOfExpertsViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! VoiceOfExpertsViewController
                    vc.visitordId = String.getString(self.arrConnection[indexPath.row].user?.userID)
                    vc.connectionId = String.getString(self.arrConnection[indexPath.row].connectionID)
                case 10:
                    let controller = self.pushViewController(withName: ProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? ProfileViewC
                    controller?.userLevel = .other
                    //controller?.userID = self.arrConnection[indexPath.row].user?.userID
                    controller?.userID = self.arrConnection[indexPath.row].user?.userID
                default:
                    print("Not valid user")
                    break
                    //return nil
                }
                
            }
            return networkCTableCell
        }else {
            guard let networkTableCell = tblViewNetwork.dequeueReusableCell(withIdentifier: NetworkTableCell.identifier()) as? NetworkTableCell else{return UITableViewCell()}
            if networkcurrentIndex == 3 {
                networkTableCell.remove.isHidden = true
            }else if networkcurrentIndex == 1{
                networkTableCell.remove.isHidden = false
                networkTableCell.remove.setTitleColor( UIColor.init(red: 75.0/255.0, green: 179.0/255.0, blue: 253.0/255.0, alpha: 1.0), for: .normal)
                networkTableCell.remove.layer.borderColor =  UIColor.init(red: 75.0/255.0, green: 179.0/255.0, blue: 253.0/255.0, alpha: 1.0).cgColor
            }else if networkcurrentIndex == 2{
                networkTableCell.remove.isHidden = false
                networkTableCell.remove.setTitleColor(.red, for: .normal)
                networkTableCell.remove.layer.borderColor = UIColor.red.cgColor
            }
            networkTableCell.lblFolloweCount.text = "\(arrConnection[indexPath.row].user?.followers_count ?? 0)" + " " + AppConstants.Followers
            networkTableCell.img.layer.masksToBounds = false
            networkTableCell.img.clipsToBounds = true
            networkTableCell.img.layer.borderWidth = 2
            networkTableCell.img.layer.borderColor = UIColor.init(red: 75.0/255.0, green: 179.0/255.0, blue: 253.0/255.0, alpha: 1.0).cgColor
            networkTableCell.img.layer.cornerRadius = networkTableCell.img.frame.width/2
            
            //if self.arrConnection[indexPath.row].user?.avatarID?.attachmentURL != nil {
                if self.arrConnection[indexPath.row].user?.avatarID?.attachmentURL != nil {
               // networkTableCell.img.setImage(withString: String.getString((self.arrConnection[indexPath.row].user?.avatarID?.baseUrl ?? "") + (self.arrConnection[indexPath.row].user?.avatarID?.attachmentURL ?? "") ), placeholder: UIImage(named: "image_placeholder"))
                    networkTableCell.img.setImage(withString: String.getString((self.arrConnection[indexPath.row].user?.avatarID?.baseUrl ?? "") + (self.arrConnection[indexPath.row].user?.avatarID?.attachmentURL ?? "") ), placeholder: UIImage(named: "image_placeholder"))
    
                //networkTableCell.email.text = self.arrConnection[indexPath.row].user?.email
                   // networkTableCell.email.text = self.arrConnection[indexPath.row].user?.email
                    if self.arrConnection[indexPath.row].user?.roleID == UserRoles.producer.rawValue{
                        networkTableCell.email.text =  AppConstants.kProducer + ","
                        
                    }else if arrConnection[indexPath.row].user?.roleID == UserRoles.restaurant.rawValue{
                        networkTableCell.email.text  =  AppConstants.kRestaurant + ","
                    }else if arrConnection[indexPath.row].user?.roleID == UserRoles.voyagers.rawValue {
                        networkTableCell.email.text =  AppConstants.kVoyager + ","
                    }else if arrConnection[indexPath.row].user?.roleID == UserRoles.voiceExperts.rawValue{
                        networkTableCell.email.text =  AppConstants.kVoiceOfExpert + ","
                    }else if self.arrConnection[indexPath.row].user?.roleID  == UserRoles.distributer1.rawValue {
                        networkTableCell.email.text =  AppConstants.kImporter + ","
                        
                    }else if arrConnection[indexPath.row].user?.roleID == UserRoles.distributer2.rawValue{
                     networkTableCell.email.text  = AppConstants.kDistributer + ","
                    }else if arrConnection[indexPath.row].user?.roleID == UserRoles.distributer3.rawValue{
                    networkTableCell.email.text =  AppConstants.kImporterDistributer + ","
                    }else if arrConnection[indexPath.row].user?.roleID == UserRoles.travelAgencies.rawValue{
                        networkTableCell.email.text =  AppConstants.kTravelAgency + ","
                    }

                if arrConnection[indexPath.row].user?.companyName != "" {
                    networkTableCell.name.text = arrConnection[indexPath.row].user?.companyName
                } else if arrConnection[indexPath.row].user?.firstname != ""{
                    networkTableCell.name.text = ((arrConnection[indexPath.row].user!.firstname) + " " + (arrConnection[indexPath.row].user!.lastname))
                } else {
                    networkTableCell.name.text = arrConnection[indexPath.row].user?.restaurantName
                }

                if networkcurrentIndex == 3 {
                    networkTableCell.remove.isHidden = true
                } else if networkcurrentIndex == 1{
                    networkTableCell.remove.tag = indexPath.row
                    networkTableCell.remove.isHidden = false
                    networkTableCell.remove.setTitleColor( UIColor.init(red: 75.0/255.0, green: 179.0/255.0, blue: 253.0/255.0, alpha: 1.0), for: .normal)
                    networkTableCell.remove.layer.borderColor =  UIColor.init(red: 75.0/255.0, green: 179.0/255.0, blue: 253.0/255.0, alpha: 1.0).cgColor
                    networkTableCell.remove.setTitle("Remove", for: .normal)

                    networkTableCell.btnRemoveCallback = { tag in
                        self.inviteApi(id: (self.arrConnection[indexPath.row].connectionID)!, type: 2)

                    }

                } else if networkcurrentIndex == 2{
                    networkTableCell.remove.tag = indexPath.row
                    networkTableCell.remove.isHidden = false
                    networkTableCell.remove.setTitleColor(.red, for: .normal)
                    networkTableCell.remove.layer.borderColor = UIColor.red.cgColor
                    networkTableCell.remove.setTitle(MarketPlaceConstant.kCancel, for: .normal)

                    networkTableCell.btnRemoveCallback = { tag in
                        //self.pendingRemoveApi(id: (self.arrConnection[indexPath.row].userID)!)
                        self.inviteApi(id: (self.arrConnection[indexPath.row].connectionID)!, type: 2)

                    }

                }

                networkTableCell.img.layer.masksToBounds = false
                networkTableCell.img.clipsToBounds = true
                networkTableCell.img.layer.cornerRadius = networkTableCell.img.frame.width/2

                if self.arrConnection[indexPath.row].user?.avatarID?.attachmentURL != nil {
                    networkTableCell.img.setImage(withString: String.getString((self.arrConnection[indexPath.row].user?.avatarID?.baseUrl ?? "") +  (self.arrConnection[indexPath.row].user?.avatarID?.attachmentURL ?? "") ), placeholder: UIImage(named: "image_placeholder"))
                }
            }
            return networkTableCell
        }
        
    }

}

//MARK: - CollectionView Methods -

extension NetworkViewC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
      return self.kNetworkCategoryDictnry?.count ?? 0
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    return self.getNetworkCategoryCollectionCell(indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> Void {
        
    networkcurrentIndex = indexPath.item
    self.collectionViewNetworkCategory.reloadData()
    collectionViewNetworkCategory.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      self.indexOfPageToRequest = 1
      self.arrConnection.removeAll()
    if indexPath.row == 0 {
        callConnectionApi(api: APIUrl.kConnectionTabApi1 + "&page=1")
    } else if indexPath.row == 1 {
        callConnectionApi(api: APIUrl.kConnectionTabApi + "&page=1")
    } else if indexPath.row == 2 {
        callConnectionApi(api: APIUrl.kConnectionTabApi3 + "&page=1")
    } else if indexPath.row == 3 {
        callConnectionApi(api: APIUrl.kConnectionTabApi4 + "&page=1")
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
//    return CGSize(width: kScreenWidth/3.0, height: 45.0)

     if indexPath.item == 1{
        return CGSize(width: 150 , height: 55.0)
    }
    else if indexPath.item == 2{
        return CGSize(width: 130 , height: 55.0)
    }
    else{
        return CGSize(width: 135 , height: 55.0)
    }
    
  }
    
}


//MARK:  - UITableViewMethods -

extension NetworkViewC: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = pushViewController(withName: ProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? ProfileViewC
        controller?.userLevel = .other
        controller?.userID = self.arrConnection[indexPath.row].user?.userID
    }
        
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return self.arrConnection.count ?? 0
    
  }
        
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    return self.getNetworkTableCell(indexPath)

  }
        
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    if networkcurrentIndex == 0 {
        var height = 200

        if self.arrConnection[indexPath.row].reasonToConnect == "" {
            height = 140
        } else if String.getString(self.arrConnection[indexPath.row].reasonToConnect).count < 50 {

            let tok =  String.getString(self.arrConnection[indexPath.row].reasonToConnect).components(separatedBy:"\n")


            height = 140 + ((tok.count-1)*20)
        } else if String.getString(self.arrConnection[indexPath.row].reasonToConnect).count >= 50{ //&& //String.getString(self.arrConnection[indexPath.row].reasonToConnect).count < 100{

            let tok =  String.getString(self.arrConnection[indexPath.row].reasonToConnect).components(separatedBy:"\n")


            height = 170 + ((tok.count-1)*20)
            //height = 170
        }
        
        return CGFloat(height)
      //  return UITableView.automaticDimension
    } else {
        return 66.0
    }
    
  }
        
}
