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
  }
  
    override func viewWillAppear(_ animated: Bool) {
        let data = kSharedUserDefaults.getLoggedInUserDetails()
        if Int.getInt(data["alysei_review"]) == 0 {
            
            blankdataView.isHidden = false
            
           
        } else if Int.getInt(data["alysei_review"]) == 1{
            
            blankdataView.isHidden = true
           
            
        }
    }
    
    func callConnectionApi(api: String){
        TANetworkManager.sharedInstance.requestApi(withServiceName: api, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
           
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [[String:Any]]{
                self.connection = ConnectionTabModel.init(with: dictResponse)
                
            }
            
            self.tblViewNetwork.reloadData()
        }
    }
    
  //MARK: - IBAction -
    
    @IBAction func tapLogout(_ sender: UIButton) {

      kSharedUserDefaults.clearAllData()
    }
    
  
  @IBAction func tapNotification(_ sender: UIButton) {
    
    _ = pushViewController(withName: NotificationViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
  }
  
  //MARK: - Private Methods -
  
  private func getNetworkCategoryCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
    
    let networkCategoryCollectionCell = collectionViewNetworkCategory.dequeueReusableCell(withReuseIdentifier: NetworkCategoryCollectionCell.identifier(), for: indexPath) as! NetworkCategoryCollectionCell
    
    
    networkCategoryCollectionCell.configureData(indexPath: indexPath, currentIndex: self.currentIndex)
    return networkCategoryCollectionCell
  }
  
  private func getNetworkTableCell(_ indexPath: IndexPath) -> UITableViewCell{
    
    let networkTableCell = tblViewNetwork.dequeueReusableCell(withIdentifier: NetworkTableCell.identifier()) as! NetworkTableCell
    
    //networkTableCell.name.text = self.connection?.data?[indexPath.row].user?.companyName
    networkTableCell.email.text = self.connection?.data?[indexPath.row].user?.email
    
    if connection?.data?[indexPath.row].user?.companyName != "" {
        networkTableCell.name.text = connection?.data?[indexPath.row].user?.companyName
    } else if connection?.data?[indexPath.row].user?.firstname != ""{
        networkTableCell.name.text = (connection?.data?[indexPath.row].user!.firstname)!+" "+(connection?.data?[indexPath.row].user!.lastname)!
    } else {
        networkTableCell.name.text = connection?.data?[indexPath.row].user?.restaurantName
    }
    
    networkTableCell.img.layer.masksToBounds = false
    networkTableCell.img.clipsToBounds = true
    networkTableCell.img.layer.cornerRadius = networkTableCell.img.frame.width/2
    
    networkTableCell.img.setImage(withString: String.getString(kImageBaseUrl+(self.connection?.data?[indexPath.row].user?.avatarID?.attachmentURL)! ?? ""), placeholder: UIImage(named: "image_placeholder"))
    
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
    
    if indexPath.row == 1 {
        callConnectionApi(api: APIUrl.kConnectionTabApi)
    } else if indexPath.row == 2 {
        callConnectionApi(api: "get/connection/tabs?tab=4")
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: kScreenWidth/3.0, height: 45.0)
  }
    
}


//MARK:  - UITableViewMethods -

extension NetworkViewC: UITableViewDataSource, UITableViewDelegate{
        
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return self.connection?.data?.count ?? 0
  }
        
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    return self.getNetworkTableCell(indexPath)

  }
        
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 66.0
  }
        
}
