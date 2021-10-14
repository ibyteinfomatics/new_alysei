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
    @IBOutlet weak var maximumSearchedCollectionView: UICollectionView!
    @IBOutlet weak var topSellingCollectionView: UICollectionView!
    @IBOutlet weak var adCollectionView: UICollectionView!
    @IBOutlet weak var kitchenCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var hghtBottomBannerCV: NSLayoutConstraint!
    var isCreateStore = false
    var productCount: Int?
    var storeCreated: Int?
    var maketPlaceHomeScreenData: MaketPlaceHomeScreenModel?
   
    
    
    var marketPlaceOptions = ["marketplace_Store","icons8_wooden_beer_keg_1", "icons8_geography","icons8_sorting","icons8_property_script","icons8_certificate_1","Group 649","hot","icons8_popular"]
    var arrMarketPlace = ["Producer Store","Conservation Method","Italian Regions","Categories","Product Properties","FDA Certified","My Favourite","Most Popular","Promotions"]
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        // headerView.addShadow()
        self.tabBarController?.tabBar.isHidden = true
        subheaderView.addShadow()
        callCheckIfStoredCreated()
        callMarketPlaceHomeApi()
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
    @IBAction func viewAllRegion(_ sender: UIButton){
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceRegionViewController") as? MarketPlaceRegionViewController else {return}
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
extension MarketPlaceHomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollectionView{
            return maketPlaceHomeScreenData?.top_banners?.count ?? 0
        }else if collectionView == recentlyAddedCollectionView{
            return maketPlaceHomeScreenData?.recently_added_product?.count ?? 0
        }else if collectionView == newlyyAddedStoreCollectionView{
            return 9
        }else if collectionView == adCollectionView{
            return maketPlaceHomeScreenData?.bottom_banners?.count ?? 0
        }else{
            return 9
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imageCollectionView{
            guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketplaceHomeImageCVC", for: indexPath) as? MarketplaceHomeImageCVC else {return UICollectionViewCell()}
            let imgUrl = (kImageBaseUrl + (self.maketPlaceHomeScreenData?.top_banners?[indexPath.row].attachment?.attachmentURL ?? ""))
            print("imgUrl---------------------------------------",imgUrl)
            cell.image.setImage(withString: imgUrl)
            return cell
        }else if collectionView == recentlyAddedCollectionView{
            guard let cell = recentlyAddedCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketplaceHomeRecentlyAddedCVC", for: indexPath) as? MarketplaceHomeRecentlyAddedCVC else {return UICollectionViewCell()}
            cell.configCell(self.maketPlaceHomeScreenData?.recently_added_product?[indexPath.row] ?? MyStoreProductDetail(with: [:]))
            return cell
        }else if collectionView == newlyyAddedStoreCollectionView{
            guard let cell = newlyyAddedStoreCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketplaceNewlyAddedStoreHomeImageCVC", for: indexPath) as? MarketplaceNewlyAddedStoreHomeImageCVC else {return UICollectionViewCell()}
            let imgUrl = (kImageBaseUrl + (self.maketPlaceHomeScreenData?.newly_added_sore?[indexPath.row].logoId?.attachmentURL ?? ""))
            cell.image.setImage(withString: imgUrl)
            cell.lblStoreName.text = self.maketPlaceHomeScreenData?.newly_added_sore?[indexPath.row].storeName
            cell.lblStoreLoaction.text = self.maketPlaceHomeScreenData?.newly_added_sore?[indexPath.row].location
            return cell
        }else if collectionView == regionCollectionView{
            guard let cell = regionCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketPlaceHomeRegionCViewCell", for: indexPath) as? MarketPlaceHomeRegionCViewCell  else {return UICollectionViewCell()}
            cell.lblRegionName.text = self.maketPlaceHomeScreenData?.regions?[indexPath.row].name
            return cell
        }else if collectionView == maximumSearchedCollectionView{
            guard let cell = maximumSearchedCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketPlaceHomeMaximumSearchedCVC", for: indexPath) as? MarketPlaceHomeMaximumSearchedCVC  else {return UICollectionViewCell()}
            return cell
        }else if collectionView == topSellingCollectionView{
            guard let cell = topSellingCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketPlaceHomeTopSearchedCVC", for: indexPath) as? MarketPlaceHomeTopSearchedCVC  else {return UICollectionViewCell()}
            return cell
        }else if collectionView == adCollectionView{
            guard let cell = adCollectionView.dequeueReusableCell(withReuseIdentifier: "AdCollectionVC", for: indexPath) as? AdCollectionVC  else {return UICollectionViewCell()}
            let imgUrl = (kImageBaseUrl + (self.maketPlaceHomeScreenData?.bottom_banners?[indexPath.row].attachment?.attachmentURL ?? ""))
            print("imgUrl---------------------------------------",imgUrl)
            cell.imgBanner.setImage(withString: imgUrl)
            return cell
        }else if collectionView == kitchenCollectionView{
            guard let cell = kitchenCollectionView.dequeueReusableCell(withReuseIdentifier: "KitchenCollectionVC", for: indexPath) as? KitchenCollectionVC  else {return UICollectionViewCell()}
            return cell
        }
        else{
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
            return CGSize(width: imageCollectionView.frame.width / 1.5 , height: 180)
        }else if collectionView == recentlyAddedCollectionView{
            return CGSize(width: recentlyAddedCollectionView.frame.width / 2 , height: 200)
        }else if collectionView == adCollectionView{
            return CGSize(width: adCollectionView.frame.width / 2 , height: 200)
        }else if collectionView == regionCollectionView{
            return CGSize(width: regionCollectionView.frame.width / 3 , height: 100)
        }else if (collectionView == newlyyAddedStoreCollectionView) || (collectionView == maximumSearchedCollectionView) || (collectionView == topSellingCollectionView) || (collectionView == kitchenCollectionView){
            return CGSize(width: collectionView.frame.width / 2 , height: 200)
        }else{
            return CGSize(width: collectionView.frame.width / 3, height: 120)
        }
    }

    
    
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == imageCollectionView{
            print("Check")
        }else if collectionView == newlyyAddedStoreCollectionView{
            print("Check")
        }else if collectionView == recentlyAddedCollectionView {
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ProductDetailVC") as? ProductDetailVC else {return}
            nextVC.marketplaceProductId = "\( maketPlaceHomeScreenData?.recently_added_product?[indexPath.row].marketplace_product_id ?? 0)"
            self.navigationController?.pushViewController(nextVC, animated: true)
        }else if collectionView == regionCollectionView {
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceProductListViewController") as? MarketPlaceProductListViewController else {return}
            nextVC.pushedFromVC = .region
            nextVC.keywordSearch = self.maketPlaceHomeScreenData?.regions?[indexPath.row].name
            nextVC.optionId = self.maketPlaceHomeScreenData?.regions?[indexPath.row].id
            self.navigationController?.pushViewController(nextVC, animated: true)
        }else if collectionView == maximumSearchedCollectionView {
           print("Check")
        }else if collectionView == topSellingCollectionView {
            print("Check")
         }else if collectionView == adCollectionView {
            print("Check")
         }else if collectionView == kitchenCollectionView {
            print("Check")
         }else if collectionView == collectionView{
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

extension MarketPlaceHomeVC{
    func callMarketPlaceHomeApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kMarketPlaceHome, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let response = dictResponse as? [String:Any]
            if let data = response?["data"] as? [String:Any]{
                self.maketPlaceHomeScreenData = MaketPlaceHomeScreenModel.init(with: data)
            }
            self.tableView.reloadData()
            self.imageCollectionView.reloadData()
            self.recentlyAddedCollectionView.reloadData()
            self.adCollectionView.reloadData()
            self.regionCollectionView.reloadData()
            self.hghtBottomBannerCV.constant = 400
        }
        
}
}

class MarketplaceHomeImageCVC: UICollectionViewCell{
    @IBOutlet weak  var image: UIImageView!
}
class MarketplaceNewlyAddedStoreHomeImageCVC: UICollectionViewCell{
    @IBOutlet weak  var image: UIImageView!
    @IBOutlet weak var lblStoreLoaction: UILabel!
    @IBOutlet weak var lblStoreName: UILabel!
}
class MarketPlaceHomeRegionCViewCell: UICollectionViewCell{
    @IBOutlet weak var vwRegion: UIView!
    @IBOutlet weak var lblRegionName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vwRegion.layer.cornerRadius = self.vwRegion.frame.height / 2
        vwRegion.layer.masksToBounds = true
        vwRegion.addShadow()
        vwRegion.layer.borderWidth = 0.5
        vwRegion.layer.borderColor = UIColor.black.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

    }
}

class MarketPlaceHomeMaximumSearchedCVC: UICollectionViewCell{
    
}
class MarketPlaceHomeTopSearchedCVC: UICollectionViewCell{
    
}

class AdCollectionVC: UICollectionViewCell{
    @IBOutlet weak var imgBanner: UIImageView!
}
class KitchenCollectionVC: UICollectionViewCell{
    
}

 
