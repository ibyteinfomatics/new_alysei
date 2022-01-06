//
//  MarketplaceHomePageVC.swift
//  Alysei
//
//  Created by Gitesh Dang on 1/6/22.
//

import UIKit

class MarketplaceHomePageVC: AlysieBaseViewC {
    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var marketplaceView: UIView!
    @IBOutlet weak var recipesView: UIView!
    @IBOutlet weak var tapNotificationVw: UIView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var btnCreateStore: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subheaderView: UIView!
    @IBOutlet weak var lblDiscover: UILabel!
    
    var newunread: Int = 0
    var openedunread: Int = 0
    var isStoreReviewed: Int?
    var NewResentUser:[InquiryRecentUser]?
    var OpenedResentUser:[InquiryRecentUser]?
    
    var isCreateStore = false
    var productCount: Int?
    var storeCreated: Int?
    var nextWalkCount = 0
    var maketPlaceHomeScreenData: MaketPlaceHomeScreenModel?
    var isVisitedMarketplace: Int?
    
    

   private var isBottomSheetShown = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        subheaderView.drawBottomShadow()
        callCheckIfStoredCreated()
        callIsStoreReviewApi()
        callMarketPlaceHomeApi()
        setBottomUI()
    //    walknextBtn.setTitle("Next", for: .normal)
       
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.producer.rawValue)"{
            self.btnCreateStore.isHidden = false
            self.lblDiscover.isHidden = true
        }else{
            self.btnCreateStore.isHidden = true
            self.lblDiscover.isHidden = false
        }
        self.btnCreateStore.setTitleColor(UIColor.init(hexString: "#4BB3FD"), for: .normal)
        marketplaceView.backgroundColor = UIColor.init(hexString: "#4BB3FD")
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(openPost))
        self.postView.addGestureRecognizer(tap)
        
        let searchTap = UITapGestureRecognizer(target: self, action: #selector(openSearchView))
        self.viewSearch.addGestureRecognizer(searchTap)
        
        let tapRecipe = UITapGestureRecognizer(target: self, action: #selector(openRecipes))
        self.recipesView.addGestureRecognizer(tapRecipe)
        
        let tapNotification = UITapGestureRecognizer(target: self, action: #selector(openNotification))
        self.tapNotificationVw.addGestureRecognizer(tapNotification)
        
    }
   
    func setBottomUI() {
//        walkView1.layer.maskedCorners = [.layerMaxXMinYCorner]
//        walkView1.clipsToBounds = true
//        pageControl1.layer.cornerRadius = self.pageControl1.frame.height / 2
//        pageControl2.layer.cornerRadius = self.pageControl2.frame.height / 2
//        pageControl3.layer.cornerRadius = self.pageControl3.frame.height / 2
//        pageControl2.layer.borderWidth = 0.5
//        pageControl2.layer.borderColor = UIColor.white.cgColor
//        pageControl3.layer.borderWidth = 0.5
//        pageControl3.layer.borderColor = UIColor.white.cgColor
//        pageControl1.layer.backgroundColor = UIColor.white.cgColor
//        pageContrl1Width.constant = 25
//        pageContrl2Width.constant = 10
//        pageContrl3Width.constant = 10
//        vwwWalkContainer1.isHidden = false
//        vwwWalkContainer2.isHidden = true
        
    }
    func movetoWalkthrough(){
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceFirstTiimeVC") as? MarketPlaceFirstTiimeVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func openNotification(){
        guard let vc = UIStoryboard(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(identifier: "NotificationList") as? NotificationList else {return}
        self.navigationController?.pushViewController(vc, animated: true)
        self.hidesBottomBarWhenPushed = true
    }
    func setUI(){
        if  (self.storeCreated == 1) && (self.productCount ?? 0 >= 1){
            self.btnCreateStore.setTitle("Go to my store", for: .normal)
        }else{
            self.btnCreateStore.setTitle("Create your store", for: .normal)

        }
    }
    @objc func openSearchView(){
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SearchProductVC") as? SearchProductVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    @objc func openPost(){
        self.tabBarController?.tabBar.isHidden = false
        _ = pushViewController(withName: HomeViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? HomeViewC
        
    }
    @objc func openRecipes(){
        
        if checkHavingPreferences == 0{
        guard let vc = UIStoryboard(name: StoryBoardConstants.kRecipesSelection, bundle: nil).instantiateViewController(identifier: "CuisinePageControlViewController") as? CuisinePageControlViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
        self.hidesBottomBarWhenPushed = true
       }
       else{
        guard let vc = UIStoryboard(name: StoryBoardConstants.kRecipesSelection, bundle: nil).instantiateViewController(identifier: "DiscoverRecipeViewController") as? DiscoverRecipeViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
        self.hidesBottomBarWhenPushed = true
       }
    }
}
extension MarketplaceHomePageVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketPlaceHomeHeaderTableVC", for: indexPath) as? MarketPlaceHomeHeaderTableVC else{return UITableViewCell()}
            cell.selectionStyle = .none
        return cell
        }else if indexPath.row == 1{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketplaceAdTableVCell", for: indexPath) as? MarketplaceAdTableVCell else{return UITableViewCell()}
            cell.selectionStyle = .none
            cell.configData(maketPlaceHomeScreenData?.top_banners ?? [TopBottomBanners]())
            return cell
        }else if indexPath.row == 2{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketplaceRecentlyTableVCell", for: indexPath) as? MarketplaceRecentlyTableVCell else{return UITableViewCell()}
            cell.selectionStyle = .none
            cell.configData(self.maketPlaceHomeScreenData?.recently_added_product ?? [MyStoreProductDetail]())
            return cell
        }else if indexPath.row == 3{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketplaceNewlyAddedTableVCell", for: indexPath) as? MarketplaceNewlyAddedTableVCell else{return UITableViewCell()}
            cell.selectionStyle = .none
            cell.configData(self.maketPlaceHomeScreenData?.newly_added_store ?? [MyStoreProductDetail]())
            return cell
        }else if indexPath.row == 4{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketplaceRegionTableVCell", for: indexPath) as? MarketplaceRegionTableVCell else{return UITableViewCell()}
            cell.selectionStyle = .none
            cell.configData(self.maketPlaceHomeScreenData?.regions ?? [MyStoreProductDetail]())
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketPlaceTopRatedTableVCell", for: indexPath) as? MarketPlaceTopRatedTableVCell else{return UITableViewCell()}
            cell.selectionStyle = .none
            cell.configData(self.maketPlaceHomeScreenData?.top_rated_products ?? [MyStoreProductDetail]())
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
        return 400
        }else if indexPath.row == 1{
            return 200
        }else if indexPath.row == 2{
            return 310
        }else if indexPath.row == 3{
            return 270
        }else if indexPath.row == 4{
            return 185
        }else{
            return 310
        }
    }
}
extension MarketplaceHomePageVC{
    func callCheckIfStoredCreated(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kCheckIfStored, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errortype, statuscode) in
            let response = dictResponse as? [String:Any]
            
            self.storeCreated = response?["is_store_created"] as? Int
            self.productCount = response?["product_count"] as? Int
            self.setUI()
        }
    }
}

extension MarketplaceHomePageVC{
    func callMarketPlaceHomeApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kMarketPlaceHome, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let response = dictResponse as? [String:Any]
            self.isVisitedMarketplace = response?["is_visited_marketplace"] as? Int
            if let data = response?["data"] as? [String:Any]{
                self.maketPlaceHomeScreenData = MaketPlaceHomeScreenModel.init(with: data)
            }
            if self.isVisitedMarketplace == 0 {
                self.movetoWalkthrough()
            }else{
                print("Nothing")
            }
            self.tableView.reloadData()
//            self.imageCollectionView.reloadData()
//            self.recentlyAddedCollectionView.reloadData()
//            self.regionCollectionView.reloadData()
//            self.newlyyAddedStoreCollectionView.reloadData()
//            self.topSellingCollectionView.reloadData()
        }
        
}
    
    func callIsStoreReviewApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kIsStoreReview, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictResponse, error, errorType, statusCode in
            
            if let response = dictResponse as? [String:Any]{
                if let data = response["data"] as? Int{
                    if data == 0 {
                        print("Store Pending")
                    }else if data == 1 {
                        print("Store Reviewed")
                    }else{
                        print("Store Decline")
                    }
                    self.isStoreReviewed = data
                }
                
            }
            
        }
    }
    
}


