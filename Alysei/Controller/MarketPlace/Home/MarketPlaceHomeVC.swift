//
//  MarketPlaceHomeVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/31/21.
//

import UIKit

class MarketPlaceHomeVC: AlysieBaseViewC {
    
//    @IBOutlet weak var collectnMainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var view1: NSLayoutConstraint!
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
  //  @IBOutlet weak var maximumSearchedCollectionView: UICollectionView!
    @IBOutlet weak var topSellingCollectionView: UICollectionView!
 //   @IBOutlet weak var adCollectionView: UICollectionView!
    //@IBOutlet weak var kitchenCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
  //  @IBOutlet weak var hghtBottomBannerCV: NSLayoutConstraint!
    @IBOutlet weak var tapNotificationVw: UIView!
    
    //
    @IBOutlet weak var walkView1: UIView!
    @IBOutlet weak var vwwWalkContainer1: UIView!
    @IBOutlet weak var vwwWalkContainer2: UIView!

    @IBOutlet weak var walkView2Img: UIImageView!
    @IBOutlet weak var walkView2Tilte:UILabel!
    @IBOutlet weak var walkView2SubTitle: UILabel!
    
    @IBOutlet weak var walkView1Leading: NSLayoutConstraint!
    @IBOutlet weak var walkView1Trailing: NSLayoutConstraint!
    @IBOutlet weak var walkView1Top: NSLayoutConstraint!
    @IBOutlet weak var walkView1Bottom: NSLayoutConstraint!
    @IBOutlet weak var walkView1height: NSLayoutConstraint!
    @IBOutlet weak var pageControl1: UIView!
    @IBOutlet weak var pageControl2: UIView!
    @IBOutlet weak var pageControl3: UIView!
    @IBOutlet weak var pageControl4: UIView!
    @IBOutlet weak var pageControl5: UIView!
    @IBOutlet weak var pageControl6: UIView!
    @IBOutlet weak var pageContrl1Width: NSLayoutConstraint!
    @IBOutlet weak var pageContrl2Width: NSLayoutConstraint!
    @IBOutlet weak var pageContrl3Width: NSLayoutConstraint!
    
    @IBOutlet weak var pageContrl4Width: NSLayoutConstraint!
    @IBOutlet weak var pageContrl5Width: NSLayoutConstraint!
    @IBOutlet weak var pageContrl6Width: NSLayoutConstraint!
    
    @IBOutlet weak var walkSubView1: UIView!
    @IBOutlet weak var walkSubView2: UIView!
    @IBOutlet weak var walkSubView3: UIView!
    
    @IBOutlet weak var walkSubView1Img: UIImageView!
    @IBOutlet weak var walkSubView1Title: UILabel!
    @IBOutlet weak var walkSubView1SubTitle: UILabel!
    
    @IBOutlet weak var walkSubView2Img: UIImageView!
    @IBOutlet weak var walkSubView2Title: UILabel!
    @IBOutlet weak var walkSubView2SubTitle: UILabel!
    
    @IBOutlet weak var walkSubView3Img: UIImageView!
    @IBOutlet weak var walkSubView3Title: UILabel!
    @IBOutlet weak var walkSubView3SubTitle: UILabel!
    @IBOutlet weak var vwwWalkContainer2BgImg: UIImageView!
    @IBOutlet weak var walkSubView3Height: NSLayoutConstraint!
    @IBOutlet weak var walknextBtn: UIButton!
    @IBOutlet weak var openednewCount: UILabel!
    var arrList: [ProductSearchListModel]?
    var arrListAppData = [ProductSearchListModel]()

  
    @IBOutlet weak var topSellingCollHeight: NSLayoutConstraint!
    
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
    
    
    //var marketPlaceOptions = ["marketplace_Store","icons8_wooden_beer_keg_1", "icons8_geography","icons8_sorting","icons8_property_script","icons8_certificate_1","Group 649","hot","icons8_popular"]
    
    var marketPlaceOptions = ["pStore", "cnsrvationMtd" , "ItlanRgn" ,"4", "prdctPrprties", "fda", "myFav", "mostPoplr", "promotion"]
    var arrMarketPlace = ["Producer Store","Conservation Method","Italian Regions","Categories","Product Properties","FDA Certified","My Favourite","Most Popular","Promotions"]

    var originalPosition: CGPoint?
      var currentPositionTouched: CGPoint?
    override func viewDidLoad() {
        super.viewDidLoad()
        // headerView.addShadow()
        // movetoWalkthrough()
        self.tabBarController?.tabBar.isHidden = true
        subheaderView.drawBottomShadow()
        callCheckIfStoredCreated()
        callIsStoreReviewApi()
        callMarketPlaceHomeApi()
        setBottomUI()
        walknextBtn.setTitle("Next", for: .normal)
       
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
        
        openednewCount.layer.cornerRadius = 10
        openednewCount.layer.masksToBounds = true
        openednewCount.textColor = UIColor.white
        
        let tapNotification = UITapGestureRecognizer(target: self, action: #selector(openNotification))
        self.tapNotificationVw.addGestureRecognizer(tapNotification)
      // let  panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        //view.addGestureRecognizer(panGestureRecognizer)
    }
    
    func setBottomUI() {
        walkView1.layer.maskedCorners = [.layerMaxXMinYCorner]
        walkView1.clipsToBounds = true
        pageControl1.layer.cornerRadius = self.pageControl1.frame.height / 2
        pageControl2.layer.cornerRadius = self.pageControl2.frame.height / 2
        pageControl3.layer.cornerRadius = self.pageControl3.frame.height / 2
        pageControl2.layer.borderWidth = 0.5
        pageControl2.layer.borderColor = UIColor.white.cgColor
        pageControl3.layer.borderWidth = 0.5
        pageControl3.layer.borderColor = UIColor.white.cgColor
        pageControl1.layer.backgroundColor = UIColor.white.cgColor
        pageContrl1Width.constant = 25
        pageContrl2Width.constant = 10
        pageContrl3Width.constant = 10
        vwwWalkContainer1.isHidden = false
        vwwWalkContainer2.isHidden = true
        
    }
    
    func movetoWalkthrough(){
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceFirstTiimeVC") as? MarketPlaceFirstTiimeVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        //self.walkView1Trailing.constant = self.view.frame.width
        self.walkView1Top.constant = self.view.frame.height
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.nextWalkCount = 0
        self.walkView1.isHidden = true
        self.vwwWalkContainer1.isHidden = true
        self.vwwWalkContainer2.isHidden = true
        
        openednewCount.isHidden = true
        newInquiryCount(child: "New")
        openedInquiryCount(child: "Opened")
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
            if self.newunread == 0 &&  self.openedunread == 0 {
                self.openednewCount.isHidden = true
            } else {
                self.openednewCount.isHidden = false
            }
            
            self.openednewCount.text = String.getString(self.openedunread+self.newunread)
            
        })
        
        
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
    
    func newInquiryCount(child: String) {
        
        kChatharedInstance.inquiry_receiveResentUsers(userid:String.getString(kSharedUserDefaults.loggedInUserModal.userId), child: child) { (users) in
           
            self.NewResentUser?.removeAll()
            self.NewResentUser = users
            
            self.newunread = 0
            for i in 0..<(self.NewResentUser?.count ?? 0){
                
                if self.NewResentUser![i].readCount != 0 {
                    self.newunread = self.newunread + 1
                    
                }
                
            }
            
            print("unread count ",self.newunread)
            
            
        }
        
    }
    
    
    func openedInquiryCount(child: String) {
        
        kChatharedInstance.inquiry_receiveResentUsers(userid:String.getString(kSharedUserDefaults.loggedInUserModal.userId), child: child) { (users) in
           
            self.OpenedResentUser?.removeAll()
            self.OpenedResentUser = users
            
            self.openedunread = 0
            for i in 0..<(self.OpenedResentUser?.count ?? 0){
                
                if self.OpenedResentUser![i].readCount != 0 {
                    self.openedunread = self.openedunread + 1
                    
                }
                
            }
            
            print("unread count ",self.openedunread)
     
            
        }
        
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        let vc = UIStoryboard(name: StoryBoardConstants.kMarketplace, bundle: nil).instantiateViewController(withIdentifier: "MarketPlaceHomeVC") as! MarketPlaceHomeVC
    //
    //        vc.view.frame = self.containerView.bounds
    //        self.addChild(vc)
    //        self.containerView.addSubview(vc.view)
    //        vc.didMove(toParent: self)
    //    }
    @objc func showWalkthroughView() {
        let slideVC = MarketplaceWalkScreenViewController()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self

        self.present(slideVC, animated: true, completion: nil)


    }

    func animate1View(){
        self.headerView.isUserInteractionEnabled = false
        self.containerView.isUserInteractionEnabled = false
        self.containerView.alpha = 0.5
        self.headerView.alpha = 0.5
        self.walkView1.isHidden = false
        self.vwwWalkContainer1.isHidden = false
        self.vwwWalkContainer2.isHidden = true
        UIView.animate(withDuration: 0.5) {
            self.walkView1height.constant = 485
            self.walkView1Top.constant = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.isBottomSheetShown = true
            UIView.animate(withDuration: 0.5) {
                self.walkView1height.constant = 470
                self.view.layoutIfNeeded()
            } completion: { _ in
               // print("Completion")
            }
        }
    }
    func animateView3(){
        self.vwwWalkContainer1.isHidden = true
        self.vwwWalkContainer2.isHidden = false
        self.walkSubView3.isHidden = true
        self.walkSubView3Height.constant = 0
        vwwWalkContainer2BgImg.image = UIImage(named: "Layer 3")
        walkView2Tilte.text = "Connect with buyers"
        walkView2SubTitle.text = "When you create a listing,buyers will be able to contact you on social alysei."
        walkView2Img.image = UIImage(named: "Group 1096")
        
       
        walkSubView1Img.image = UIImage(named: "icons8_reply")
        walkSubView1Title.text = "Reply to inquiry"
        walkSubView1SubTitle.text = "Being responsive can help you build trust with buyers"
        walkSubView2Img.image = UIImage(named: "icons8_sell")
        walkSubView2Title.text = "Report Suspicious behaviour"
        walkSubView2SubTitle.text = "If something doesn't feel right, you can report the conversation to us."
        
      
        
        pageControl4.layer.cornerRadius = self.pageControl1.frame.height / 2
        pageControl5.layer.cornerRadius = self.pageControl2.frame.height / 2
        pageControl6.layer.cornerRadius = self.pageControl3.frame.height / 2
        pageContrl4Width.constant = 10
        pageContrl5Width.constant = 10
        pageContrl6Width.constant = 25
        pageControl4.layer.borderWidth = 0.5
        pageControl4.layer.borderColor = UIColor.white.cgColor
        pageControl5.layer.borderWidth = 0.5
        pageControl5.layer.borderColor = UIColor.white.cgColor
        pageControl5.layer.backgroundColor = UIColor.clear.cgColor
        pageControl6.layer.backgroundColor = UIColor.white.cgColor
        UIView.animate(withDuration: 0.5) {
            self.vwwWalkContainer2.isHidden = false
            self.walkView1height.constant = self.view.frame.height / 2 + 260
            self.walkView1Trailing.constant = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.isBottomSheetShown = true
            UIView.animate(withDuration: 0.5) {
                    self.walkView1height.constant = self.view.frame.height / 2 + 240
                    self.view.layoutIfNeeded()
            } completion: { _ in
               // print("Completion")
            }
        }
       
    }
    func animate2View(){
        //self.view.isUserInteractionEnabled = false
        self.vwwWalkContainer1.isHidden = true
        self.vwwWalkContainer2.isHidden = false
        self.walkSubView3.isHidden = false
       vwwWalkContainer2BgImg.image = UIImage(named: "Layer 2")
        self.walkSubView3Height.constant = 55
        walkView2Img.image = UIImage(named: "Group 1091")
        walkView2Tilte.text = "Create your store"
        walkView2SubTitle.text = "Adding relevant and accurate info helps buyers learn more about what you're selling."
       
        walkSubView1Img.image = UIImage(named: "icons8_xlarge_icons")
        walkSubView1Title.text = "Add clear photos"
        walkSubView1SubTitle.text = "Photos should have a good resolution and lighting,and should only show what you're listing"
        
        walkSubView2Img.image = UIImage(named: "icons8_sell")
        walkSubView2Title.text = "Offer a fire price"
        walkSubView2SubTitle.text = "Use similiar listings as a guide for choosing your price"
        
        walkSubView3Img.image = UIImage(named: "icons8_rocket")
        walkSubView3Title.text = "Boost your listing"
        walkSubView3SubTitle.text = "You can boost your listing so that it reaches more people on Alysei"
        
//        walkSubView3Img.image = UIImage(named: "icons8_rocket")
//        walkSubView2Title.text = "Boost your listing"
//        walkSubView2SubTitle.text = "You can boost your listing so that it reaches more people on Alysei"
        
        
        pageControl4.layer.cornerRadius = self.pageControl1.frame.height / 2
        pageControl5.layer.cornerRadius = self.pageControl2.frame.height / 2
        pageControl6.layer.cornerRadius = self.pageControl3.frame.height / 2
        pageContrl4Width.constant = 10
        pageContrl5Width.constant = 25
        pageContrl6Width.constant = 10
        pageControl4.layer.borderWidth = 0.5
        pageControl4.layer.borderColor = UIColor.white.cgColor
        pageControl6.layer.borderWidth = 0.5
        pageControl6.layer.borderColor = UIColor.white.cgColor
        pageControl5.layer.backgroundColor = UIColor.white.cgColor
        pageControl6.layer.backgroundColor = UIColor.clear.cgColor
        UIView.animate(withDuration: 0.5) {
            self.vwwWalkContainer2.isHidden = false
            self.walkView1height.constant = self.view.frame.height / 2 + 320
            self.walkView1Trailing.constant = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.isBottomSheetShown = true
            UIView.animate(withDuration: 0.5) {
                    self.walkView1height.constant = self.view.frame.height / 2 + 300
                    self.view.layoutIfNeeded()
            } completion: { _ in
               // print("Completion")
            }
        }
        }
    
    @IBAction func messageAction(_ sender: UIButton){
        _ = self.pushViewController(withName: InquiryChatVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? InquiryChatVC
    }
    
    @IBAction func backAction(_ sender: UIButton){
        if nextWalkCount == 2{
            nextWalkCount = 1
            self.walknextBtn.setTitle("Next", for: .normal)
            vwwWalkContainer1.isHidden = true
            vwwWalkContainer1.isHidden = false
            animate2View()
           
        }else if nextWalkCount == 1 {
            nextWalkCount = 0
            vwwWalkContainer1.isHidden = false
            vwwWalkContainer1.isHidden = true
            animate1View()
        }else{
            self.headerView.isUserInteractionEnabled = true
            self.containerView.isUserInteractionEnabled = true
            self.containerView.alpha = 1
            self.headerView.alpha = 1
            self.walkView1.isHidden = true
            
        }
    }
    @IBAction func nextAction(_ sender: UIButton){
        
        if nextWalkCount == 0 {
            self.walknextBtn.setTitle("Next", for: .normal)
            vwwWalkContainer1.isHidden = true
            nextWalkCount = 1
          animate2View()
        }else if nextWalkCount == 1 {
            self.walknextBtn.setTitle("Done", for: .normal)
            animateView3()
            nextWalkCount = 2
           
            }else{
                self.walkView1.isHidden = true
                nextWalkCount = 0
                self.headerView.isUserInteractionEnabled = true
                self.containerView.isUserInteractionEnabled = true
                self.containerView.alpha = 1
                self.headerView.alpha = 1
                _ = pushViewController(withName: SelectMemberShipVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)
        }
    }
    //MARK:- Bottom Sheet Animation
//    func addBottomSheetView() {
//        // 1- Init bottomSheetVC
//        let bottomSheetVC = MarketplaceWalkScreenViewController()
//
//        // 2- Add bottomSheetVC as a child view
//        self.addChild(bottomSheetVC)
//        self.view.addSubview(bottomSheetVC.view)
//        bottomSheetVC.didMove(toParent: self)
//
//        // 3- Adjust bottomSheet frame and initial position.
//        let height = view.frame.height
//        let width  = view.frame.width
//        bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
//    }
   
    
    @objc func openPost(){
        // self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
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
//            let vc = UIStoryboard(name: StoryBoardConstants.kMarketplace, bundle: nil).instantiateViewController(withIdentifier: "MarketPlaceWalkthroughVC") as! MarketPlaceWalkthroughVC
//
//           vc.view.frame = self.containerView.bounds
//            self.addChild(vc)
//            self.containerView.addSubview(vc.view)
//           vc.didMove(toParent: self)
            //showWalkthroughView()
           
            animate1View()
        }else if self.storeCreated == 1 && self.productCount == 0{
            _ = pushViewController(withName: AddProductMarketplaceVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? AddProductMarketplaceVC
        }else if (self.storeCreated == 1 && isStoreReviewed == 0) || (self.storeCreated == 1 && isStoreReviewed == 2){
            _ = pushViewController(withName: MarketPlaceConfirmationVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? MarketPlaceConfirmationVC
        }  else{
            _ = pushViewController(withName: MyStoreVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? MyStoreVC
        }
        //  _ = pushViewController(withName: MyStoreVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? MyStoreVC
    }
    @IBAction func viewAllRegion(_ sender: UIButton){
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceRegionViewController") as? MarketPlaceRegionViewController else {return}
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func viewAll(_ sender: UIButton){
       
        switch sender.tag {
     
        case 1:
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceProductListViewController") as? MarketPlaceProductListViewController else {return}
            nextVC.pushedFromVC = .viewAllEntities
            nextVC.optionId = 0
            nextVC.entityIndex = sender.tag
            nextVC.keywordSearch = "Recently Added Products"
            self.navigationController?.pushViewController(nextVC, animated: true)
        case 2:
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ProductStoreVC") as? ProductStoreVC else {return}
            nextVC.pushedFromVC = .viewAllEntities
            nextVC.keywordSearch = "Newly Added Stores"
            self.navigationController?.pushViewController(nextVC, animated: true)
        default:
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceProductListViewController") as? MarketPlaceProductListViewController else {return}
            nextVC.pushedFromVC = .viewAllEntities
            nextVC.optionId = 0
            nextVC.entityIndex = sender.tag
            nextVC.keywordSearch = "Top Rated Products"
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
       
        
    }
    
}
extension MarketPlaceHomeVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketplaceHomeTopFavTableVC", for: indexPath) as? MarketplaceHomeTopFavTableVC else {return UITableViewCell()}
        cell.callback = {
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ProductDetailVC") as? ProductDetailVC else {return}
            nextVC.marketplaceProductId = "\( self.maketPlaceHomeScreenData?.top_favourite_products?[indexPath.row].marketplace_product_id ?? 0)"
                     self.navigationController?.pushViewController(nextVC, animated: true)
        }
            cell.configCell(maketPlaceHomeScreenData ?? (MaketPlaceHomeScreenModel(with: [:])))
        return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketplaceHomeAdTableVC", for: indexPath) as? MarketplaceHomeAdTableVC else {return UITableViewCell()}
            cell.configCell(self.maketPlaceHomeScreenData ?? (MaketPlaceHomeScreenModel(with: [:])))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
//            if self.maketPlaceHomeScreenData?.top_favourite_products?.count == 2 {
//                return  200
//            }
             if self.maketPlaceHomeScreenData?.top_favourite_products?.count == 0 {
                return 0
            }  else if (self.maketPlaceHomeScreenData?.top_favourite_products?.count ?? 0) % 2 == 0{
                return CGFloat(320 * ((self.maketPlaceHomeScreenData?.top_favourite_products?.count ?? 0) / 2))
            } else {
                return CGFloat(320 * ((self.maketPlaceHomeScreenData?.top_favourite_products?.count ?? 0) / 2) + 320)
            }
//            else{
//            return CGFloat(200 * (self.maketPlaceHomeScreenData?.top_favourite_products?.count ?? 0) + 200)
//        }
        }else{
            return 410
        }
       

    }
    
}
extension MarketPlaceHomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollectionView{
            return maketPlaceHomeScreenData?.top_banners?.count ?? 0
        }else if collectionView == recentlyAddedCollectionView{
            return maketPlaceHomeScreenData?.recently_added_product?.count ?? 0
        }else if collectionView == newlyyAddedStoreCollectionView{
            return  maketPlaceHomeScreenData?.newly_added_store?.count ?? 0
        }
//        else if collectionView == adCollectionView{
//            return maketPlaceHomeScreenData?.bottom_banners?.count ?? 0
//        }
//        else if collectionView == maximumSearchedCollectionView {
//            return maketPlaceHomeScreenData?.top_favourite_products?.count ?? 0
//        }
        else if collectionView == topSellingCollectionView {
           return maketPlaceHomeScreenData?.top_rated_products?.count ?? 0

        }else if collectionView == regionCollectionView{
            return self.maketPlaceHomeScreenData?.regions?.count ?? 0
        }else{
//            collectnMainViewHeight.constant = 370
//                (((self.collectionView.frame.width / 3) * 3) + 60)
            return 9
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imageCollectionView{
            guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketplaceHomeImageCVC", for: indexPath) as? MarketplaceHomeImageCVC else {return UICollectionViewCell()}
            let baseUrl = self.maketPlaceHomeScreenData?.top_banners?[indexPath.row].attachment?.baseUrl ?? ""
            let imgUrl = (baseUrl + (self.maketPlaceHomeScreenData?.top_banners?[indexPath.row].attachment?.attachmentURL ?? ""))
            cell.image.setImage(withString: imgUrl)
            return cell
        }else if collectionView == recentlyAddedCollectionView{
            guard let cell = recentlyAddedCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketplaceHomeRecentlyAddedCVC", for: indexPath) as? MarketplaceHomeRecentlyAddedCVC else {return UICollectionViewCell()}
           // cell.addShadow()
            cell.configCell(self.maketPlaceHomeScreenData?.recently_added_product?[indexPath.row] ?? MyStoreProductDetail(with: [:]))
            return cell
        }
//        else if collectionView == maximumSearchedCollectionView{
//            guard let cell = maximumSearchedCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketPlaceHomeMaximumSearchedCVC", for: indexPath) as? MarketPlaceHomeMaximumSearchedCVC else {return UICollectionViewCell()}
//           // cell.addShadow()
//            cell.configCell(self.maketPlaceHomeScreenData?.top_favourite_products?[indexPath.row] ?? MyStoreProductDetail(with: [:]))
//            return cell
//        }
        else if collectionView == newlyyAddedStoreCollectionView{
            guard let cell = newlyyAddedStoreCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketplaceNewlyAddedStoreHomeImageCVC", for: indexPath) as? MarketplaceNewlyAddedStoreHomeImageCVC else {return UICollectionViewCell()}
            let baseUrl = self.maketPlaceHomeScreenData?.newly_added_store?[indexPath.row].logoId?.baseUrl ?? ""
            let imgUrl = (baseUrl + (self.maketPlaceHomeScreenData?.newly_added_store?[indexPath.row].logoId?.attachmentURL ?? ""))
            cell.image.setImage(withString: imgUrl)
            cell.lblStoreName.text = self.maketPlaceHomeScreenData?.newly_added_store?[indexPath.row].name
            cell.lblStoreLoaction.text = self.maketPlaceHomeScreenData?.newly_added_store?[indexPath.row].location
            return cell
        }else if collectionView == regionCollectionView{
            guard let cell = regionCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketPlaceHomeRegionCViewCell", for: indexPath) as? MarketPlaceHomeRegionCViewCell  else {return UICollectionViewCell()}
            cell.lblRegionName.text = self.maketPlaceHomeScreenData?.regions?[indexPath.row].name
            let baseUrl = self.maketPlaceHomeScreenData?.regions?[indexPath.row].flagId?.baseUrl ?? ""
            let imgUrl = (baseUrl + ( self.maketPlaceHomeScreenData?.regions?[indexPath.row].flagId?.attachmentUrl ?? ""))
            cell.imgRegion.setImage(withString: imgUrl)
            return cell
        }
//        else if collectionView == maximumSearchedCollectionView{
//
//            guard let cell = maximumSearchedCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketPlaceHomeMaximumSearchedCVC", for: indexPath) as? MarketPlaceHomeMaximumSearchedCVC  else {return UICollectionViewCell()}
//            cell.configCell(self.maketPlaceHomeScreenData?.top_favourite_products?[indexPath.row] ?? MyStoreProductDetail(with: [:]))
//            return cell
//        }
        else if collectionView == topSellingCollectionView{
            guard let cell = topSellingCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketPlaceHomeTopSearchedCVC", for: indexPath) as? MarketPlaceHomeTopSearchedCVC  else {return UICollectionViewCell()}
            cell.configCell(self.maketPlaceHomeScreenData?.top_rated_products?[indexPath.row] ?? MyStoreProductDetail(with: [:]))
            return cell
        }
//        else if collectionView == adCollectionView{
//            guard let cell = adCollectionView.dequeueReusableCell(withReuseIdentifier: "AdCollectionVC", for: indexPath) as? AdCollectionVC  else {return UICollectionViewCell()}
//            let imgUrl = (kImageBaseUrl + (self.maketPlaceHomeScreenData?.bottom_banners?[indexPath.row].attachment?.attachmentURL ?? ""))
//            print("imgUrl---------------------------------------",imgUrl)
//            cell.imgBanner.setImage(withString: imgUrl)
//            return cell
//        }
//        else if collectionView == kitchenCollectionView{
//            guard let cell = kitchenCollectionView.dequeueReusableCell(withReuseIdentifier: "KitchenCollectionVC", for: indexPath) as? KitchenCollectionVC  else {return UICollectionViewCell()}
//            return cell
//        }
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
            return CGSize(width: imageCollectionView.frame.width / 1.2 , height: 190)
        }else if collectionView == recentlyAddedCollectionView{
            return CGSize(width: recentlyAddedCollectionView.frame.width / 2 , height: 270)
        }
//        else if collectionView == adCollectionView{
//            return CGSize(width: adCollectionView.frame.width / 2 , height: 200)
//        }
        else if collectionView == regionCollectionView{
            return CGSize(width: regionCollectionView.frame.width / 4 , height: 120)
        }
        else if (collectionView == newlyyAddedStoreCollectionView){
            return CGSize(width: collectionView.frame.width / 2 , height: 220)
        }
        else if (collectionView == newlyyAddedStoreCollectionView) || (collectionView == topSellingCollectionView){
            return CGSize(width: collectionView.frame.width / 2 , height: 280)
        }
        else if (collectionView == self.collectionView){
            
            view1.constant = collectionView.frame.width
            return CGSize(width: collectionView.frame.width / 3 , height: collectionView.frame.width / 3)
        }
        else{
            return CGSize(width: collectionView.frame.width / 3, height: 150)
        }
    }

    
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == imageCollectionView{
            print("Check")
        }else if collectionView == newlyyAddedStoreCollectionView{
           // guard let nextVC = self.storyboard?.instantiateViewController(identifier: "StoreDescViewController") as? StoreDescViewController else{return}
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "StoreDescrptnViewController") as? StoreDescrptnViewController else{return}

            let data = maketPlaceHomeScreenData?.newly_added_store?[indexPath.row]
            nextVC.passStoreId = "\(data?.marketplace_store_id ?? 0)"
            self.navigationController?.pushViewController(nextVC, animated: true)
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
        }
//        else if collectionView == maximumSearchedCollectionView {
//            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ProductDetailVC") as? ProductDetailVC else {return}
//            nextVC.marketplaceProductId = "\( maketPlaceHomeScreenData?.top_favourite_products?[indexPath.row].marketplace_product_id ?? 0)"
//            self.navigationController?.pushViewController(nextVC, animated: true)
//        }
        else if collectionView == topSellingCollectionView {
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ProductDetailVC") as? ProductDetailVC else {return}
            nextVC.marketplaceProductId = "\( maketPlaceHomeScreenData?.top_rated_products?[indexPath.row].marketplace_product_id ?? 0)"
            self.navigationController?.pushViewController(nextVC, animated: true)
         }
//        else if collectionView == adCollectionView {
//            print("Check")
//         }
//         else if collectionView == kitchenCollectionView {
//            print("Check")
//         }
         else if collectionView == collectionView{
            if indexPath.row == 0{
                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ProductStoreVC") as? ProductStoreVC else {return}
                nextVC.listType = 1
                nextVC.keywordSearch = arrMarketPlace[indexPath.row]
                self.navigationController?.pushViewController(nextVC, animated: true)
            }else if indexPath.row == 2 {
                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceRegionViewController") as? MarketPlaceRegionViewController else {return}
                nextVC.listIndex = indexPath.row + 1
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
            }else if indexPath.row == 8{
                self.showAlert(withMessage: "Coming Soon....")
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
            self.imageCollectionView.reloadData()
            self.recentlyAddedCollectionView.reloadData()
         //   self.adCollectionView.reloadData()
            self.regionCollectionView.reloadData()
            self.newlyyAddedStoreCollectionView.reloadData()
            //self.maximumSearchedCollectionView.reloadData()
            self.topSellingCollectionView.reloadData()
            //self.hghtBottomBannerCV.constant = 400
//            if self.maketPlaceHomeScreenData?.top_favourite_products?.count == 2 {
//                return self.topSellingCollHeight.constant = 200
//            }
//            else if (self.maketPlaceHomeScreenData?.top_favourite_products?.count ?? 0) / 2 == 0{
//                return self.topSellingCollHeight.constant = CGFloat(200 * ((self.maketPlaceHomeScreenData?.top_favourite_products?.count ?? 0) / 2))
//            }else {
//                return self.topSellingCollHeight.constant = CGFloat(200 * ((self.maketPlaceHomeScreenData?.top_favourite_products?.count ?? 0) / 2) + 200)
//            }
            
           
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

class MarketplaceHomeImageCVC: UICollectionViewCell{
    @IBOutlet weak  var image: UIImageView!
    
    override func awakeFromNib() {
      //  image.layer.cornerRadius = 27
     //   image.layer.masksToBounds = true
    }
}
class MarketplaceNewlyAddedStoreHomeImageCVC: UICollectionViewCell{
    @IBOutlet weak  var image: UIImageView!
    @IBOutlet weak var lblStoreLoaction: UILabel!
    @IBOutlet weak var lblStoreName: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        image.layer.cornerRadius = 15
        image.layer.masksToBounds = true
    }
   
    
}
class MarketPlaceHomeRegionCViewCell: UICollectionViewCell{
    @IBOutlet weak var vwRegion: UIView!
    @IBOutlet weak var lblRegionName: UILabel!
    @IBOutlet weak var imgRegion: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vwRegion.layer.cornerRadius = self.vwRegion.frame.height / 2
        vwRegion.layer.masksToBounds = true
        vwRegion.addShadow()
        vwRegion.layer.borderWidth = 0.5
        vwRegion.layer.borderColor = UIColor.black.cgColor
        imgRegion.layer.cornerRadius = 15
        imgRegion.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

    }
}

class MarketPlaceHomeMaximumSearchedCVC: UICollectionViewCell{
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblAvgRating: UILabel!
    @IBOutlet weak var lblTotalReview: UILabel!
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configCell(_ data: MyStoreProductDetail){
      //  let baseUrl = data.
        let imgUrl = ((data.base_url ?? "") + (data.logo_id ?? ""))
        imgProduct.setImage(withString: imgUrl)
        imgProduct.layer.cornerRadius = 15
        imgProduct.layer.masksToBounds = true
        
        lblProductName.text = data.title
        lblStoreName.text = data.storeName
        lblTotalReview.text = (data.total_reviews ?? "0") + " reviews"
        lblAvgRating.text = data.avg_rating
        
        if "\(data.avg_rating ?? "")" == "0" || data.avg_rating == "0.0"{
           imgStar1.image = UIImage(named: "icons8_star")
            imgStar2.image = UIImage(named: "icons8_star")
            imgStar3.image = UIImage(named: "icons8_star")
            imgStar4.image = UIImage(named: "icons8_star")
           imgStar5.image = UIImage(named: "icons8_star")
           
        }else if(data.avg_rating ?? "") >= "0.1" && (data.avg_rating ?? "") <= "0.9" {
            imgStar1.image = UIImage(named: "HalfStar")
            imgStar2.image = UIImage(named: "icons8_star")
            imgStar3.image = UIImage(named: "icons8_star")
            imgStar4.image = UIImage(named: "icons8_star")
            imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(data.avg_rating ?? "")" == "1" || data.avg_rating == "1.0"{
            imgStar1.image = UIImage(named: "icons8_christmas_star")
            imgStar2.image = UIImage(named: "icons8_star")
            imgStar3.image = UIImage(named: "icons8_star")
            imgStar4.image = UIImage(named: "icons8_star")
            imgStar5.image = UIImage(named: "icons8_star")
        }else if (data.avg_rating ?? "") >= "1.1"  && (data.avg_rating ?? "") <= "1.9" {
            imgStar1.image = UIImage(named: "icons8_christmas_star")
            imgStar2.image = UIImage(named: "HalfStar")
            imgStar3.image = UIImage(named: "icons8_star")
            imgStar4.image = UIImage(named: "icons8_star")
            imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(data.avg_rating ?? "")" == "2" || data.avg_rating == "2.0" {
            imgStar1.image = UIImage(named: "icons8_christmas_star")
            imgStar2.image = UIImage(named: "icons8_christmas_star")
            imgStar3.image = UIImage(named: "icons8_star")
            imgStar4.image = UIImage(named: "icons8_star")
            imgStar5.image = UIImage(named: "icons8_star")
        }else if (data.avg_rating ?? "") >= "2.1"  && (data.avg_rating ?? "") <= "2.9" {
            imgStar1.image = UIImage(named: "icons8_christmas_star")
            imgStar2.image = UIImage(named: "icons8_christmas_star")
            imgStar3.image = UIImage(named: "HalfStar")
            imgStar4.image = UIImage(named: "icons8_star")
            imgStar5.image = UIImage(named: "icons8_star")
        }else if data.avg_rating == "3.0" || data.avg_rating == "3"{
            imgStar1.image = UIImage(named: "icons8_christmas_star")
            imgStar2.image = UIImage(named: "icons8_christmas_star")
            imgStar3.image = UIImage(named: "icons8_christmas_star")
            imgStar4.image = UIImage(named: "icons8_star")
            imgStar5.image = UIImage(named: "icons8_star")
        }else if (data.avg_rating ?? "") >= "3.1"  && (data.avg_rating ?? "") <= "3.9" {
            imgStar1.image = UIImage(named: "icons8_christmas_star")
            imgStar2.image = UIImage(named: "icons8_christmas_star")
            imgStar3.image = UIImage(named: "icons8_christmas_star")
            imgStar4.image = UIImage(named: "HalfStar")
            imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(data.avg_rating ?? "")" == "4" ||  data.avg_rating == "4.0" {
            imgStar1.image = UIImage(named: "icons8_christmas_star")
            imgStar2.image = UIImage(named: "icons8_christmas_star")
            imgStar3.image = UIImage(named: "icons8_christmas_star")
            imgStar4.image = UIImage(named: "icons8_christmas_star")
            imgStar5.image = UIImage(named: "icons8_star")
        }else if (data.avg_rating ?? "") >= "4.1"  && (data.avg_rating ?? "") <= "4.9" {
            imgStar1.image = UIImage(named: "icons8_christmas_star")
            imgStar2.image = UIImage(named: "icons8_christmas_star")
            imgStar3.image = UIImage(named: "icons8_christmas_star")
            imgStar4.image = UIImage(named: "icons8_christmas_star")
            imgStar5.image = UIImage(named: "HalfStar")
        }else if "\(data.avg_rating ?? "")" == "5" || data.avg_rating == "5.0"{
            imgStar1.image = UIImage(named: "icons8_christmas_star")
            imgStar2.image = UIImage(named: "icons8_christmas_star")
            imgStar3.image = UIImage(named: "icons8_christmas_star")
            imgStar4.image = UIImage(named: "icons8_christmas_star")
            imgStar5.image = UIImage(named: "icons8_christmas_star")
        }
        
        
    }
}
class MarketPlaceHomeTopSearchedCVC: UICollectionViewCell{
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblAvgRating: UILabel!
    @IBOutlet weak var lblTotalReview: UILabel!
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configCell(_ data: MyStoreProductDetail){
        let imgUrl = ((data.base_url ?? "") + (data.logo_id ?? ""))
        imgProduct.setImage(withString: imgUrl)
        imgProduct.layer.cornerRadius = 20
        imgProduct.layer.masksToBounds = true
        lblProductName.text = data.title
        lblStoreName.text = data.storeName
        lblTotalReview.text = (data.total_reviews ?? "0") + " reviews"
        lblAvgRating.text = data.avg_rating
        
        if "\(data.avg_rating ?? "")" == "0" || data.avg_rating == "0.0"{
           imgStar1.image = UIImage(named: "icons8_star")
            imgStar2.image = UIImage(named: "icons8_star")
            imgStar3.image = UIImage(named: "icons8_star")
            imgStar4.image = UIImage(named: "icons8_star")
           imgStar5.image = UIImage(named: "icons8_star")
           
        }else if(data.avg_rating ?? "") >= "0.1" && (data.avg_rating ?? "") <= "0.9" {
            imgStar1.image = UIImage(named: "HalfStar")
            imgStar2.image = UIImage(named: "icons8_star")
            imgStar3.image = UIImage(named: "icons8_star")
            imgStar4.image = UIImage(named: "icons8_star")
            imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(data.avg_rating ?? "")" == "1" || data.avg_rating == "1.0"{
            imgStar1.image = UIImage(named: "icons8_christmas_star")
            imgStar2.image = UIImage(named: "icons8_star")
            imgStar3.image = UIImage(named: "icons8_star")
            imgStar4.image = UIImage(named: "icons8_star")
            imgStar5.image = UIImage(named: "icons8_star")
        }else if (data.avg_rating ?? "") >= "1.1"  && (data.avg_rating ?? "") <= "1.9" {
            imgStar1.image = UIImage(named: "icons8_christmas_star")
            imgStar2.image = UIImage(named: "HalfStar")
            imgStar3.image = UIImage(named: "icons8_star")
            imgStar4.image = UIImage(named: "icons8_star")
            imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(data.avg_rating ?? "")" == "2" || data.avg_rating == "2.0" {
            imgStar1.image = UIImage(named: "icons8_christmas_star")
            imgStar2.image = UIImage(named: "icons8_christmas_star")
            imgStar3.image = UIImage(named: "icons8_star")
            imgStar4.image = UIImage(named: "icons8_star")
            imgStar5.image = UIImage(named: "icons8_star")
        }else if (data.avg_rating ?? "") >= "2.1"  && (data.avg_rating ?? "") <= "2.9" {
            imgStar1.image = UIImage(named: "icons8_christmas_star")
            imgStar2.image = UIImage(named: "icons8_christmas_star")
            imgStar3.image = UIImage(named: "HalfStar")
            imgStar4.image = UIImage(named: "icons8_star")
            imgStar5.image = UIImage(named: "icons8_star")
        }else if data.avg_rating == "3.0" || data.avg_rating == "3"{
            imgStar1.image = UIImage(named: "icons8_christmas_star")
            imgStar2.image = UIImage(named: "icons8_christmas_star")
            imgStar3.image = UIImage(named: "icons8_christmas_star")
            imgStar4.image = UIImage(named: "icons8_star")
            imgStar5.image = UIImage(named: "icons8_star")
        }else if (data.avg_rating ?? "") >= "3.1"  && (data.avg_rating ?? "") <= "3.9" {
            imgStar1.image = UIImage(named: "icons8_christmas_star")
            imgStar2.image = UIImage(named: "icons8_christmas_star")
            imgStar3.image = UIImage(named: "icons8_christmas_star")
            imgStar4.image = UIImage(named: "HalfStar")
            imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(data.avg_rating ?? "")" == "4" ||  data.avg_rating == "4.0" {
            imgStar1.image = UIImage(named: "icons8_christmas_star")
            imgStar2.image = UIImage(named: "icons8_christmas_star")
            imgStar3.image = UIImage(named: "icons8_christmas_star")
            imgStar4.image = UIImage(named: "icons8_christmas_star")
            imgStar5.image = UIImage(named: "icons8_star")
        }else if (data.avg_rating ?? "") >= "4.1"  && (data.avg_rating ?? "") <= "4.9" {
            imgStar1.image = UIImage(named: "icons8_christmas_star")
            imgStar2.image = UIImage(named: "icons8_christmas_star")
            imgStar3.image = UIImage(named: "icons8_christmas_star")
            imgStar4.image = UIImage(named: "icons8_christmas_star")
            imgStar5.image = UIImage(named: "HalfStar")
        }else if "\(data.avg_rating ?? "")" == "5" || data.avg_rating == "5.0"{
            imgStar1.image = UIImage(named: "icons8_christmas_star")
            imgStar2.image = UIImage(named: "icons8_christmas_star")
            imgStar3.image = UIImage(named: "icons8_christmas_star")
            imgStar4.image = UIImage(named: "icons8_christmas_star")
            imgStar5.image = UIImage(named: "icons8_christmas_star")
        }
        
        
    }
}

class AdCollectionVC: UICollectionViewCell{
    @IBOutlet weak var imgBanner: UIImageView!
    
    override func awakeFromNib() {
     
    }
}
class KitchenCollectionVC: UICollectionViewCell{
    
}

 
extension MarketPlaceHomeVC: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentingWalkVC(presentedViewController: presented, presenting: presenting)
    }
}
