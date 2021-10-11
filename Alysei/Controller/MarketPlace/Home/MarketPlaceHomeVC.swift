//
//  MarketPlaceHomeVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/31/21.
//

import UIKit

class MarketPlaceHomeVC: AlysieBaseViewC {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var btnCreateStore: UIButton!
    @IBOutlet weak var marketplaceView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var subheaderView: UIView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblDiscover: UILabel!
    @IBOutlet weak var recipesView: UIView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var recentlyAddedCollectionView: UICollectionView!
    @IBOutlet weak var newlyyAddedStoreCollectionView: UICollectionView!
    @IBOutlet weak var regionCollectionView: UICollectionView!
    
    
    var isCreateStore = false
    var productCount: Int?
    var storeCreated: Int?
    
    var marketPlaceOptions = ["marketplace_Store","icons8_wooden_beer_keg_1", "icons8_geography","icons8_sorting","icons8_property_script","icons8_certificate_1","Group 649","hot","icons8_popular"]
    var arrMarketPlace = ["Producer Store","Conservation Method","Italian Regions","Categories","Product Properties","FDA Certified","My Favourite","Most Popular","Promotions"]
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        // headerView.addShadow()
        self.tabBarController?.tabBar.isHidden = true
        subheaderView.addShadow()
        callCheckIfStoredCreated()
        print("kSharedUserDefaults.loggedInUserModal.isStoreCreated----------------\(kSharedUserDefaults.loggedInUserModal.isStoreCreated ?? "")")
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.producer.rawValue)"{
            self.btnCreateStore.isHidden = false
            self.lblDiscover.isHidden = true
        }else{
            self.btnCreateStore.isHidden = true
            self.lblDiscover.isHidden = false
        }
        self.btnCreateStore.setTitleColor(UIColor.init(hexString: "#4BB3FD"), for: .normal)
        marketplaceView.backgroundColor = UIColor.init(hexString: "#4BB3FD")
        let tap = UITapGestureRecognizer(target: self, action: #selector(openPost))
        self.postView.addGestureRecognizer(tap)
        
        let searchTap = UITapGestureRecognizer(target: self, action: #selector(openSearchView))
        self.viewSearch.addGestureRecognizer(searchTap)
        
        
        let tapRecipe = UITapGestureRecognizer(target: self, action: #selector(openRecipes))
        self.recipesView.addGestureRecognizer(tapRecipe)
    }
    func setUI(){
        if  (self.storeCreated == 1) && (self.productCount ?? 0 >= 1){
            self.btnCreateStore.setTitle("Go to My Store", for: .normal)
        }else{
            self.btnCreateStore.setTitle("Create your Store", for: .normal)
            
        }
    }
    @objc func openSearchView(){
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SearchProductVC") as? SearchProductVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        let vc = UIStoryboard(name: StoryBoardConstants.kMarketplace, bundle: nil).instantiateViewController(withIdentifier: "MarketPlaceHomeVC") as! MarketPlaceHomeVC
    //
    //        vc.view.frame = self.containerView.bounds
    //        self.addChild(vc)
    //        self.containerView.addSubview(vc.view)
    //        vc.didMove(toParent: self)
    //    }
    @objc func openPost(){
        // self.navigationController?.popViewController(animated: true)
        
        _ = pushViewController(withName: HomeViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? HomeViewC
        
        /*for controller in self.navigationController!.viewControllers as Array {
         if controller.isKind(of: HomeViewC.self) {
         self.navigationController!.popToViewController(controller, animated: true)
         break
         }
         }*/
        
    }
    @objc func openRecipes(){
        
        guard let vc = UIStoryboard(name: StoryBoardConstants.kRecipesSelection, bundle: nil).instantiateViewController(identifier: "CuisinePageControlViewController") as? CuisinePageControlViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
        self.hidesBottomBarWhenPushed = true
    }
    
    
    @IBAction func btnGotoStores(_ sender: UIButton){
        //self.callCheckIfStoredCreated()
        //if kSharedUserDefaults.loggedInUserModal.isStoreCreated == "0"{
        if self.storeCreated == 0{
            let vc = UIStoryboard(name: StoryBoardConstants.kMarketplace, bundle: nil).instantiateViewController(withIdentifier: "MarketPlaceWalkthroughVC") as! MarketPlaceWalkthroughVC
            
            vc.view.frame = self.containerView.bounds
            self.addChild(vc)
            self.containerView.addSubview(vc.view)
            vc.didMove(toParent: self)
        }else if self.storeCreated == 1 && self.productCount == 0{
            _ = pushViewController(withName: AddProductMarketplaceVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? AddProductMarketplaceVC
        }else{
            _ = pushViewController(withName: MyStoreVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? MyStoreVC
        }
        //  _ = pushViewController(withName: MyStoreVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? MyStoreVC
    }
    
}
extension MarketPlaceHomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollectionView{
            return 9
        }else if collectionView == recentlyAddedCollectionView{
            return 9
        }else if collectionView == newlyyAddedStoreCollectionView{
            return 9
        }else{
            return 9
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imageCollectionView{
            guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketplaceHomeImageCVC", for: indexPath) as? MarketplaceHomeImageCVC else {return UICollectionViewCell()}
            return cell
        }else if collectionView == recentlyAddedCollectionView{
            guard let cell = recentlyAddedCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketplaceHomeRecentlyAddedCVC", for: indexPath) as? MarketplaceHomeRecentlyAddedCVC else {return UICollectionViewCell()}
            return cell
        }else if collectionView == newlyyAddedStoreCollectionView{
            guard let cell = newlyyAddedStoreCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketplaceNewlyAddedStoreHomeImageCVC", for: indexPath) as? MarketplaceNewlyAddedStoreHomeImageCVC else {return UICollectionViewCell()}
            return cell
        }else if collectionView == regionCollectionView{
            guard let cell = regionCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketPlaceHomeRegionCViewCell", for: indexPath) as? MarketPlaceHomeRegionCViewCell  else {return UICollectionViewCell()}
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketPlaceHomeCollectionVCell", for: indexPath) as? MarketPlaceHomeCollectionVCell else {return UICollectionViewCell()}
            cell.imgView.image = UIImage(named: marketPlaceOptions[indexPath.row])
            
            let firstWord = arrMarketPlace[indexPath.row].components(separatedBy: " ")
            if firstWord.first == firstWord.last{
                cell.lblOption.text = (firstWord.first ?? "")
            }else{
                cell.lblOption.text = (firstWord.first ?? "") + "\n" + (firstWord.last ?? "")
            }
            //cell.lblOption.text = ("\u{00a0}\(arrMarketPlace[indexPath.row])")
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imageCollectionView{
            return CGSize(width: imageCollectionView.frame.width / 1.5 , height: 150)
        }else if collectionView == recentlyAddedCollectionView{
            return CGSize(width: recentlyAddedCollectionView.frame.width / 2 , height: 200)
        }else if collectionView == newlyyAddedStoreCollectionView{
            return CGSize(width: newlyyAddedStoreCollectionView.frame.width / 2 , height: 200)
        }else{
            return CGSize(width: collectionView.frame.width / 3, height: 120)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == imageCollectionView{
            print("Check")
        }else if collectionView == newlyyAddedStoreCollectionView{
            print("Check")
        }else{
            if indexPath.row == 0{
                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ProductStoreVC") as? ProductStoreVC else {return}
                nextVC.listType = 1
                nextVC.keywordSearch = arrMarketPlace[indexPath.row]
                self.navigationController?.pushViewController(nextVC, animated: true)
            }else if indexPath.row == 2 {
                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceRegionViewController") as? MarketPlaceRegionViewController else {return}
                
                self.navigationController?.pushViewController(nextVC, animated: true)
            }else if indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7{
                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceProductListViewController") as? MarketPlaceProductListViewController else {return}
                switch indexPath.row {
                case 5:
                    nextVC.pushedFromVC = .fdaCertified
                default:
                    
                    nextVC.pushedFromVC = .myFav
                }
                nextVC.listType = indexPath.row + 1
                nextVC.keywordSearch = arrMarketPlace[indexPath.row]
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            else{
                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceOptionViewController") as? MarketPlaceOptionViewController else {return}
                nextVC.listIndex = indexPath.row + 1
                nextVC.passHeading = arrMarketPlace[indexPath.row]
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
}
extension MarketPlaceHomeVC{
    func callCheckIfStoredCreated(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kCheckIfStored, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errortype, statuscode) in
            let response = dictResponse as? [String:Any]
            
            self.storeCreated = response?["is_store_created"] as? Int
            self.productCount = response?["product_count"] as? Int
            self.setUI()
        }
    }
}

class MarketplaceHomeImageCVC: UICollectionViewCell{
    @IBOutlet weak  var image: UIImageView!
}
class MarketplaceNewlyAddedStoreHomeImageCVC: UICollectionViewCell{
    @IBOutlet weak  var image: UIImageView!
}
class MarketPlaceHomeRegionCViewCell: UICollectionViewCell{
    
}
