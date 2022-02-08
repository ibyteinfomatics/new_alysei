//
//  MarketplaceHomePageVC.swift
//  Alysei
//
//  Created by Gitesh Dang on 1/6/22.
//

import UIKit
import CoreAudio

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
    @IBOutlet weak var headerView: UIView!
    
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
    
    @IBOutlet weak var walk1ViewTitle: UILabel!
    @IBOutlet weak var walk1ViewDesc: UILabel!
    @IBOutlet weak var walk1SubTitle: UILabel!
    @IBOutlet weak var walk1SubDesc: UILabel!
    @IBOutlet weak var walk1DescImage: UIImageView!
    
    var arrList: [ProductSearchListModel]?
    var arrListAppData = [ProductSearchListModel]()
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
    
    
    var arrMarketPlace = ["Producer Store","Conservation Method","Italian Regions","Categories","Product Properties","FDA Certified","My Favourite","Most Popular","Promotions"]
    private var isBottomSheetShown = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        subheaderView.drawBottomShadow()
        callCheckIfStoredCreated()
        //self.callIsStoreReviewApi()
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
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(openPost))
        self.postView.addGestureRecognizer(tap)
        
        let searchTap = UITapGestureRecognizer(target: self, action: #selector(openSearchView))
        self.viewSearch.addGestureRecognizer(searchTap)
        
        let tapRecipe = UITapGestureRecognizer(target: self, action: #selector(openRecipes))
        self.recipesView.addGestureRecognizer(tapRecipe)
        
        let tapNotification = UITapGestureRecognizer(target: self, action: #selector(openNotification))
        self.tapNotificationVw.addGestureRecognizer(tapNotification)
        
        openednewCount.layer.cornerRadius = 10
        openednewCount.layer.masksToBounds = true
        openednewCount.textColor = UIColor.white
        
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
        self.tableView.alpha = 1
        self.headerView.alpha = 1
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
        if (isStoreReviewed == 1 || isStoreReviewed == 2) {
            self.btnCreateStore.setTitle("Go to my store", for: .normal)
        }else if  (self.storeCreated == 1) && (self.productCount ?? 0 >= 1){
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
    
    @objc func showWalkthroughView() {
        let slideVC = MarketplaceWalkScreenViewController()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self

        self.present(slideVC, animated: true, completion: nil)


    }

    func animate1View(){
        self.headerView.isUserInteractionEnabled = false
        self.tableView.isUserInteractionEnabled = false
        self.tableView.alpha = 0.5
        self.headerView.alpha = 0.5
        self.walkView1.isHidden = false
        self.vwwWalkContainer1.isHidden = false
        self.vwwWalkContainer2.isHidden = true
        walk1ViewTitle.text = "Start promoting your products"
        walk1ViewDesc.text = "Here is some tips to help you promote with confidence"
        walk1SubTitle.text = "Post in english"
        walk1SubDesc.text = "Write in English language to create your store and list your products"
        walk1DescImage.image = UIImage(named: "edit_icon_white")
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
        walkView2SubTitle.text = "When you create a listing, buyers will interact with you"
        walkView2Img.image = UIImage(named: "Group 1096")
        
       
        walkSubView1Img.image = UIImage(named: "icons8_reply")
        walkSubView1Title.text = "Reply to inquiry"
        walkSubView1SubTitle.text = "Being responsive will help you to build trust with Buyers"
        walkSubView2Img.image = UIImage(named: "icons8_sell")
        walkSubView2Title.text = "Report suspicious behaviour"
        walkSubView2SubTitle.text = "Let us know if something does not feel right"
        
      
        
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
        walkView2SubTitle.text = "Adding relevant and accurate info helps buyers to learn more about what you are selling."
       
        walkSubView1Img.image = UIImage(named: "icons8_xlarge_icons")
        walkSubView1Title.text = "Add clear photos"
        walkSubView1SubTitle.text = "Photos should have a good resolution and lighting,and should only show what you are listing"
        
        walkSubView2Img.image = UIImage(named: "icons8_sell")
        walkSubView2Title.text = "Offer a fare price"
        walkSubView2SubTitle.text = "Make sure you are offering prices appropriate to a competitive market like the US"
        
        walkSubView3Img.image = UIImage(named: "icons8_rocket")
        walkSubView3Title.text = "Boost your listing"
        walkSubView3SubTitle.text = "You can boost your listing to expand you reach and increase buyers engagement"
        
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
            self.tableView.isUserInteractionEnabled = true
            self.tableView.alpha = 1
            self.tableView.alpha = 1
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
                self.tableView.isUserInteractionEnabled = true
                self.tableView.alpha = 1
                self.tableView.alpha = 1
               // _ = pushViewController(withName: SelectMemberShipVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)
                _ = pushViewController(withName: SelectMultiMemberShipVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)
        }
    }
    
    @IBAction func btnGotoStores(_ sender: UIButton){
        //self.callCheckIfStoredCreated()
        //if kSharedUserDefaults.loggedInUserModal.isStoreCreated == "0"{
        if (self.isStoreReviewed == 1 || isStoreReviewed == 2) {
            _ = pushViewController(withName: MyStoreVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? MyStoreVC
        }else if self.storeCreated == 0{
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
//    @IBAction func viewAllRegion(_ sender: UIButton){
//        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceRegionViewController") as? MarketPlaceRegionViewController else {return}
//
//        self.navigationController?.pushViewController(nextVC, animated: true)
//    }
    
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
extension MarketplaceHomePageVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketPlaceHomeHeaderTableVC", for: indexPath) as? MarketPlaceHomeHeaderTableVC else{return UITableViewCell()}
            cell.selectionStyle = .none
            cell.callback = { index in
                switch index{
                case 0:
                    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ProductStoreVC") as? ProductStoreVC else {return}
                    nextVC.listType = 1
                    nextVC.keywordSearch = self.arrMarketPlace[0]
                    self.navigationController?.pushViewController(nextVC, animated: true)
                case 2:
                    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceRegionViewController") as? MarketPlaceRegionViewController else {return}
                    nextVC.listIndex = index + 1
                    self.navigationController?.pushViewController(nextVC, animated: true)
                case 5, 6 , 7:
                    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceProductListViewController") as? MarketPlaceProductListViewController else {return}
                    switch index {
                    case 5:
                        nextVC.pushedFromVC = .fdaCertified
                    default:
                        
                        nextVC.pushedFromVC = .myFav
                    }
                    nextVC.listType = index + 1
                    nextVC.keywordSearch = self.arrMarketPlace[index]
                    self.navigationController?.pushViewController(nextVC, animated: true)
                case 8:
                    self.showAlert(withMessage: "Coming Soon....")
                    
                default:
                    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceOptionViewController") as? MarketPlaceOptionViewController else {return}
                    nextVC.listIndex = index + 1
                    nextVC.passHeading = self.arrMarketPlace[index]
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
            }
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
                cell.callback = { productid in
                    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ProductDetailVC") as? ProductDetailVC else {return}
                    nextVC.marketplaceProductId = "\(productid)"
                    self.navigationController?.pushViewController(nextVC, animated: true)
                    
                }
                cell.viewAllcallback = { tag in
                    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceProductListViewController") as? MarketPlaceProductListViewController else {return}
                    nextVC.pushedFromVC = .viewAllEntities
                    nextVC.optionId = 0
                    nextVC.entityIndex = tag
                    nextVC.keywordSearch = "Recently Added Products"
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
                return cell
            }else if indexPath.row == 3{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketplaceNewlyAddedTableVCell", for: indexPath) as? MarketplaceNewlyAddedTableVCell else{return UITableViewCell()}
                cell.selectionStyle = .none
                cell.configData(self.maketPlaceHomeScreenData?.newly_added_store ?? [MyStoreProductDetail]())
                cell.callback = { id in
                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "StoreDescrptnViewController") as? StoreDescrptnViewController else{return}
                nextVC.passStoreId = "\(id)"
                self.navigationController?.pushViewController(nextVC, animated: true)
                }
                cell.viewAllcallback = { tag in
                    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ProductStoreVC") as? ProductStoreVC else {return}
                    nextVC.pushedFromVC = .viewAllEntities
                    nextVC.keywordSearch = "Newly Added Stores"
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
                return cell
                
            }else if indexPath.row == 4{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketplaceRegionTableVCell", for: indexPath) as? MarketplaceRegionTableVCell else{return UITableViewCell()}
                cell.selectionStyle = .none
                cell.configData(self.maketPlaceHomeScreenData?.regions ?? [MyStoreProductDetail]())
                cell.callback = { id, rname in
                    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceProductListViewController") as? MarketPlaceProductListViewController else {return}
                    nextVC.pushedFromVC = .region
                    nextVC.keywordSearch = rname
                    nextVC.optionId = id
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
                cell.viewAllcallback = { tag in
                    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceRegionViewController") as? MarketPlaceRegionViewController else {return}
                    nextVC.listIndex = 3
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
                return cell
            }else if indexPath.row == 5{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketPlaceTopRatedTableVCell", for: indexPath) as? MarketPlaceTopRatedTableVCell else{return UITableViewCell()}
                cell.selectionStyle = .none
                cell.configData(self.maketPlaceHomeScreenData?.top_rated_products ?? [MyStoreProductDetail]())
                cell.callback = { id in
                    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ProductDetailVC") as? ProductDetailVC else {return}
                    nextVC.marketplaceProductId = "\(id)"
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
                cell.viewAllcallback = { tag in
                    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceProductListViewController") as? MarketPlaceProductListViewController else {return}
                    nextVC.pushedFromVC = .viewAllEntities
                    nextVC.optionId = 0
                    nextVC.entityIndex = tag
                    nextVC.keywordSearch = "Top Rated Products"
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
                return cell
            }else if indexPath.row == 6 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketplaceHomeTopFavTableVC", for: indexPath) as? MarketplaceHomeTopFavTableVC else {return UITableViewCell()}
                cell.callback = { id in
                    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ProductDetailVC") as? ProductDetailVC else {return}
                    nextVC.marketplaceProductId = "\(id)"
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
                
                return (3 * (self.view.frame.width / 3) - 12)
            }else if indexPath.row == 1{
                return 200
            }else if indexPath.row == 2{
                return 310
            }else if indexPath.row == 3{
                return 270
            }else if indexPath.row == 4{
                return 185
            }else if indexPath.row == 5{
                return 310
            }else if indexPath.row == 6 {
                
                if self.maketPlaceHomeScreenData?.top_favourite_products?.count == 0 {
                    return 0
                }  else if (self.maketPlaceHomeScreenData?.top_favourite_products?.count ?? 0) % 2 == 0{
                    return CGFloat(328 * ((self.maketPlaceHomeScreenData?.top_favourite_products?.count ?? 0) / 2))
                } else {
                    return CGFloat(328 * ((self.maketPlaceHomeScreenData?.top_favourite_products?.count ?? 0) / 2) + 328)
                }
                
            }else{
                return 400
            }
        }
    }
    extension MarketplaceHomePageVC{
        func callCheckIfStoredCreated(){
            TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kCheckIfStored, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errortype, statuscode) in
                let response = dictResponse as? [String:Any]
                
                self.storeCreated = response?["is_store_created"] as? Int
                self.productCount = response?["product_count"] as? Int
                self.callIsStoreReviewApi()
                
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
//                if self.isVisitedMarketplace == 0 {
//                    self.movetoWalkthrough()
//                }else{
//                    print("Nothing")
//                }
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
                self.setUI()
                
            }
        }
        
    }
    
    
extension MarketplaceHomePageVC: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentingWalkVC(presentedViewController: presented, presenting: presenting)
    }
}
