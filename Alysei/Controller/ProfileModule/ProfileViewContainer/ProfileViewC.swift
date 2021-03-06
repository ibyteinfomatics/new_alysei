//
//  ProfileViewC.swift
//  Alysie
//
//  Created by Alendra Kumar on 18/01/21.
//f

import UIKit
import SVProgressHUD
import Instructions

var check = "";
var profileTabImage: UIImage?

var imgPUrl: String?
class ProfileViewC: AlysieBaseViewC{
    
    //MARK: - IBOutlet -
    
    // blank data view
    @IBOutlet weak var blankReviewText: UILabel!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var viewBlankHeading: UIView!
    @IBOutlet weak var blankdataView: UIView!
    
    @IBOutlet weak var collectionViewAddProduct: UICollectionView!
    @IBOutlet weak var tabsCollectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnPosts: UIButton!
    @IBOutlet weak var btnAbout: UIButton!
    @IBOutlet weak var btnContact: UIButton!
    @IBOutlet weak var viewSeparator: UIView!
    @IBOutlet weak var tblViewPosts: UITableView!
    @IBOutlet weak var imgViewCover: UIImageView!
    @IBOutlet weak var lblDisplayNameNavigation: UILabel!
    
    @IBOutlet weak var featuredListingTitleLabel: UILabel!
    @IBOutlet weak var imgViewProfileNavigation: UIImageViewExtended!
    @IBOutlet weak var imgViewProfile: UIImageViewExtended!
    @IBOutlet weak var lblDisplayName: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var lbladdproduct: UILabel!
    @IBOutlet weak var btnEditProfile: UIButtonExtended!
    
    @IBOutlet weak var postcount: UILabel!
    @IBOutlet weak var connectioncount: UILabel!
    @IBOutlet weak var followercount: UILabel!
    @IBOutlet weak var featureUIview: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblProgress: UILabel!
    @IBOutlet weak var addbtn: NSLayoutConstraint!
    @IBOutlet weak var addimg: NSLayoutConstraint!
    @IBOutlet weak var addtext: NSLayoutConstraint!
    
    //ProfileCompletionView
    
    @IBOutlet weak var tblViewProfileCompletion: UITableView!
    @IBOutlet weak var progressbar: UIProgressView!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var percentageSlider: UISlider!
    
    @IBOutlet weak var menuButton: UIButtonExtended!
    @IBOutlet weak var respondeButton: UIButtonExtended!
    @IBOutlet weak var messageButton: UIButtonExtended!
    @IBOutlet weak var connectButton: UIButtonExtended!
    @IBOutlet weak var backButton: UIButtonExtended!
    @IBOutlet weak var lblPercentage: UILabel!
    @IBOutlet weak var followerstext: UILabel!
    @IBOutlet weak var iconAddProduct: UIImageView!
    @IBOutlet weak var btnConnectHght: NSLayoutConstraint!
    
    @IBOutlet weak var viewFeature: UIView!
    @IBOutlet weak var lblUpdateProfile: UILabel!
    @IBOutlet weak var btnLogout: UIButton!
    
    @IBOutlet weak var lblPosts: UILabel!
    @IBOutlet weak var lblConnections: UILabel!
    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    // @IBOutlet weak var featureCollectionView: UICollectionView!
    
    var userPercentage: Int?
    //MARK: - Properties -
    var fromRecipe: String? = ""
    var percentage: String?
    var picker = UIImagePickerController()
    var contactDetail = [ContactDetail.view.tableCellModel]()
    //  var contactDetilViewModel: ContactDetail.Contact.Response!
    var contactDetilViewModel: UserProfile.contactTab!
    var signUpViewModel: SignUpViewModel!
    var userLevel: UserLevel = .own
    var userID: Int!
    var userType: UserRoles!
    var visitorUserType: UserRoles!
    var aboutViewModel: AboutView.viewModel!
    
    var userProfileModel: UserProfile.profileTopSectionModel!
    
    var tabload = true
    var connectionFlagValue: Int?
    var progressUserData: UserData?
    //var profileCompletion
    var currentIndex: Int = 0
    var tabposition: Int = 1
    //var imgPUrl: String?
    var someHeight: Int = 1
    var shownumber = 50
    
    var profileCompletionModel: [ProfileCompletionModel]?
    var userProducts: [ProductCategoriesDataModel]?
    //MARK: GetFeature Listing Data
    var featureListingId: String?
    var currentProductTitle: String?
    var isLoadingAnimation = true
    let coachMarksController = CoachMarksController()
    var fromVC : PushedFrom?
    //MARK: - Properties -
    
    private var editProfileViewCon: EditProfileViewC!
    
    private var currentChild: UIViewController {
        return self.children.last!
        
    }
    
    private lazy var postsViewC: UserPostsViewController = {
        
        let postsViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: UserPostsViewController.id()) as! UserPostsViewController
        postsViewC.visitorId = self.userID != nil ? String.getString(self.userID) : ""
        return postsViewC
    }()
    
    private lazy var photosViewcontroller: UserPhotosGridViewController = {
        
        let view = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: "UserPhotosGridViewController") as! UserPhotosGridViewController
        view.visitorId = self.userID != nil ? String.getString(self.userID) : ""
        return view
    }()
    
    
    private lazy var aboutViewC: AboutViewC = {
        
        let aboutViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: AboutViewC.id()) as! AboutViewC
        return aboutViewC
    }()
    private lazy var blogViewC: BlogsViewController = {
        
        let blogViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: BlogsViewController.id()) as! BlogsViewController
        blogViewC.userId = String.getString(userID)
        return blogViewC
    }()
    
    private lazy var eventViewC: EventsView = {
        
        let eventViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: EventsView.id()) as! EventsView
        eventViewC.userId = String.getString(userID)
        eventViewC.hostname = self.lblDisplayName.text
        eventViewC.location = self.contactDetail[2].value
        eventViewC.website = self.contactDetail[3].value
        self.tblViewPosts.isUserInteractionEnabled = true
        return eventViewC
    }()
    
    private lazy var tripViewC: TripsViewController = {
        
        let tripViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: TripsViewController.id()) as! TripsViewController
        tripViewC.userId = String.getString(userID)
        tripViewC.agencyname = self.lblDisplayName.text
        tripViewC.website = self.contactDetail[3].value

        return tripViewC
    }()
    private lazy var contactViewC: ContactViewC = {
        
        let contactViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: ContactViewC.id()) as! ContactViewC
       
        contactViewC.userLevel = userLevel
        contactViewC.openUrlCallBack = { url in
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
       
        return contactViewC
    }()
    
    private lazy var awardViewC: AwardsViewController = {
        
        let awardViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: AwardsViewController.id()) as! AwardsViewController
        awardViewC.userId = String.getString(userID)
        
        return awardViewC
    }()
    
    
    //MARK: - ViewLifeCycle Methods -
    
    override func viewWillDisappear(_ animated: Bool) {
    
        super.viewWillDisappear(animated)
        self.coachMarksController.stop(immediately: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        lblPosts.text = AppConstants.kPosts
        lblAbout.text = ProfileCompletion.About
        lblConnections.text = AppConstants.Connections
        lblProgress.text = AppConstants.kYourProgress
        lblUpdateProfile.text = AppConstants.kUpdateProfile
        btnLogout.setTitle(TourGuideConstants.kLogoutProfile, for: .normal)
        let skipView = CoachMarkSkipDefaultView()
        skipView.setTitle(RecipeConstants.kSkip, for: .normal)
        self.coachMarksController.skipView = skipView
        logout.setTitle(TourGuideConstants.kLogoutProfile, for: .normal)
        
        self.btnEditProfile.layer.cornerRadius = 5
        self.btnEditProfile.layer.masksToBounds = true
        self.btnEditProfile.layer.borderWidth = 1
        self.btnEditProfile.layer.borderColor = UIColor.gray.cgColor
        self.viewSeparator.alpha = 0.0
        //Mark: Check Condition(Shalini)
        self.featureUIview.constant = 0
        self.viewFeature.isHidden = true
        self.iconAddProduct.isHidden = true
        //Mark: End
        
        
        if let selfUserTypeString = kSharedUserDefaults.loggedInUserModal.memberRoleId {
            if let selfUserType: UserRoles = UserRoles(rawValue: (Int(selfUserTypeString) ?? 10))  {
                self.userType = selfUserType
            }
        }
      
      
        self.btnPosts.isSelected = true
        self.tblViewProfileCompletion.isHidden = true
        self.headerView.isHidden = true
        self.tblViewPosts.isHidden = true
        self.currentIndex = 0
        
        self.coachMarksController.dataSource = self
        self.coachMarksController.delegate = self
        self.tblViewPosts.contentInsetAdjustmentBehavior = .never
        //tblViewPosts.style = .grouped
        self.tabsCollectionView.dataSource = self
        self.tabsCollectionView.delegate = self
        self.tabsCollectionView.allowsSelection = true
        self.tabsCollectionView.allowsMultipleSelection = false
        
        self.btnEditProfile.isHidden = true
        self.messageButton.isHidden = true
        self.respondeButton.isHidden = true
        self.connectButton.isHidden = true
        
        
        let topMargin = (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
        let tableHeaderViewHeight = (UIApplication.shared.windows.first?.frame.height ?? self.view.frame.height) - (self.tabBarController?.tabBar.frame.height ?? 0.0) - topMargin
        
        someHeight = Int((self.tblViewPosts.tableHeaderView?.frame.height ?? 0) + tableHeaderViewHeight - 50.0)
        
        self.btnBack.isHidden = userLevel == .other ? false : true
        switch self.userLevel {
        case .own:
            print("own")
            self.btnEditProfile.isHidden = false
            self.backButton.isHidden = true
            self.btnEditProfile.isUserInteractionEnabled = true
          if kSharedUserDefaults.getProfileCompletion() == false{
            self.postRequestToGetProgress()
            }
            
            if self.userType == .voyagers {
                self.featureUIview.constant = 0
                self.iconAddProduct.isHidden = true
                self.viewFeature.isHidden = true
            } else {
                self.featureUIview.constant = 140
                self.iconAddProduct.isHidden = false
                self.viewFeature.isHidden = false
            }
            if kSharedUserDefaults.loggedInUserModal.memberRoleId == "10"{
                followerstext.text = AppConstants.kFollowing
            } else {
                followerstext.text = AppConstants.Followers
            }
            
        case .other:
            
            self.addbtn.constant = 0
            self.addimg.constant = 0
            self.addtext.constant = 0
            
            self.connectButton.isHidden = false
            self.connectButton.isUserInteractionEnabled = true
        }
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftRightGesturePerformed(_:)))
        swipeLeftGesture.direction = .left
        self.view.addGestureRecognizer(swipeLeftGesture)
        
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftRightGesturePerformed(_:)))
        swipeRightGesture.direction = .right
        self.view.addGestureRecognizer(swipeRightGesture)
        
        self.collectionView(self.tabsCollectionView, didSelectItemAt: IndexPath(item: 1, section: 0))
        self.tabsCollectionView.selectItem(at: IndexPath(item: 1, section: 0), animated: true, scrollPosition: .top)
        
        //MARK: SelectTab
        //        self.collectionView(self.tabsCollectionView, didSelectItemAt: IndexPath(item: currentSelectedIndexPath, section: 0))
        //        self.tabsCollectionView.selectItem(at: IndexPath(item: currentSelectedIndexPath, section: 0), animated: true, scrollPosition: .top)
        
        
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        let data = kSharedUserDefaults.getLoggedInUserDetails()
        if Int.getInt(data["alysei_review"]) == 1 {
            if isprofileComplete == false{
                
                if !AppManager.getUserSeenAppInstructionProfile() {
                    Thread.sleep(forTimeInterval: 1.0)
                    self.coachMarksController.start(in: .viewController(self))
                    
                    self.tabBarController?.tabBar.backgroundColor = .darkGray
                    self.tabBarController?.tabBar.alpha = 0.9
                    self.tabBarController?.tabBar.isUserInteractionEnabled = false
                    
                }
                else{
                    self.tabBarController?.tabBar.backgroundColor = .white
                    self.tabBarController?.tabBar.alpha = 1.0
                    self.tabBarController?.tabBar.isUserInteractionEnabled = true
                    
                }
                
                
            }
            else{
                self.tabBarController?.tabBar.backgroundColor = .white
                self.tabBarController?.tabBar.alpha = 1.0
                self.tabBarController?.tabBar.isUserInteractionEnabled = true
                
            }
        }
        else{
            self.tabBarController?.tabBar.backgroundColor = .white
            self.tabBarController?.tabBar.alpha = 1.0
            self.tabBarController?.tabBar.isUserInteractionEnabled = true
            
        }
        
        if userLevel == .other && fromVC == .storeDesc{
            self.tabBarController?.tabBar.isHidden = true
            self.hidesBottomBarWhenPushed = true
        }else{
            self.tabBarController?.tabBar.isHidden = false
            self.hidesBottomBarWhenPushed = false
        }
    }
    
    func inviteApi(id: Int, type: Int){
        
        let params: [String:Any] = [:]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kotherAcceptReject+"visitor_profile_id="+String.getString(userID)+"&accept_or_reject="+String.getString(type), requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            //self.fetchVisiterProfileDetails(self.userID)
            
            if statusCode == 200 {
                networkcurrentIndex = 1
                let controller = self.pushViewController(withName: NetworkViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? NetworkViewC
                
            }
            
        }
        
    }
    
    @objc func swipeLeftRightGesturePerformed(_ gesture: UISwipeGestureRecognizer) {
        
        //  print("\(gesture.direction)")
        // print("self.tabsCollectionView.indexPathsForSelectedItems?.last?.row ",self.tabsCollectionView.indexPathsForSelectedItems?.last?.row )
        let totalRows = ProfileTabRows().noOfRows(self.userType)
        
        if gesture.direction == .right {
            if (self.tabsCollectionView.indexPathsForSelectedItems?.last?.row ?? 0) >= totalRows{
                print("invalid")
                return
            }
            if ((self.tabsCollectionView.indexPathsForSelectedItems?.last?.row ?? 0) > 0)  {
                let row = self.tabsCollectionView.indexPathsForSelectedItems?.last?.row ?? 0
                
                self.collectionView(self.tabsCollectionView, didDeselectItemAt: IndexPath(item: row, section: 0))
                self.collectionView(self.tabsCollectionView, didSelectItemAt: IndexPath(item: row - 1, section: 0))
                self.tabsCollectionView.selectItem(at: IndexPath(item: row - 1, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            }else{
                print("Invalid case")
            }
            
        } else if gesture.direction == .left {
            if (self.tabsCollectionView.indexPathsForSelectedItems?.last?.row ?? 0) == totalRows - 1{
                print("invalid")
                return
            }
            if (self.tabsCollectionView.indexPathsForSelectedItems?.last?.row ?? 0) < totalRows {
                let row = self.tabsCollectionView.indexPathsForSelectedItems?.last?.row ?? 0
                self.collectionView(self.tabsCollectionView, didDeselectItemAt: IndexPath(item: row, section: 0))
                self.collectionView(self.tabsCollectionView, didSelectItemAt: IndexPath(item: row + 1, section: 0))
                self.tabsCollectionView.selectItem(at: IndexPath(item: row + 1, section: 0), animated: true, scrollPosition: .centeredHorizontally)
                //tapContact(UIButton())
            }
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  self.tblViewPosts.isUserInteractionEnabled = false
        lblPosts.text = AppConstants.kPosts
        lblAbout.text = ProfileCompletion.About
        lblConnections.text = AppConstants.Connections
        lblProgress.text = AppConstants.kYourProgress
        lblUpdateProfile.text = AppConstants.kUpdateProfile
        btnLogout.setTitle(TourGuideConstants.kLogoutProfile, for: .normal)
        btnEditProfile.setTitle(AppConstants.EditProfile, for: .normal)  
        let skipView = CoachMarkSkipDefaultView()
        skipView.setTitle(RecipeConstants.kSkip, for: .normal)
        self.coachMarksController.skipView = skipView
        logout.setTitle(TourGuideConstants.kLogoutProfile, for: .normal)
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "10"{
            followerstext.text = AppConstants.kFollowing
        } else {
            followerstext.text = AppConstants.Followers
        }
        
        if let selfUserTypeString = kSharedUserDefaults.loggedInUserModal.memberRoleId {
            if let selfUserType: UserRoles = UserRoles(rawValue: (Int(selfUserTypeString) ?? 10))  {
                self.userType = selfUserType
            }
        }
        
        isLoadingAnimation = true
        setNeedsStatusBarAppearanceUpdate()
        if fromRecipe == ""{
            self.tabBarController?.tabBar.isHidden = false
        }
       
        //MARK: check Api calling
//        if kSharedUserDefaults.getProfileCompletion() == false{
//        self.postRequestToGetProgress()
//         }
        let data = kSharedUserDefaults.getLoggedInUserDetails()
        let role = Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId)
        
        if role != 10 {
            
            //            if Int.getInt(data["alysei_review"]) == 0 {
            //                blankdataView.isHidden = false
            //            } else if Int.getInt(data["alysei_review"]) == 1{
            
            if Int.getInt(data["alysei_review"]) == 0 {
                blankdataView.isHidden = false
                blankReviewText.text = AppConstants.kYourProfileNotReviewed
            } else if Int.getInt(data["alysei_review"]) == 1 {
                
                blankdataView.isHidden = true
                // self.postRequestToGetFields()
                // self.fetchContactDetail()
                // self.fetchProfileDetails()
                self.currentIndex = 0
                if kSharedUserDefaults.getProfileCompletion() == false {
                self.postRequestToGetProgress()
                }
                //       self.postRequestToGetFields()
                if check == "" {
                    if self.userLevel == .own {
                        self.menuButton.isHidden = false
                        self.tabBarController?.selectedIndex = 4
                        
                        self.fetchProfileDetails()

                        //                        let data = kSharedUserDefaults.getLoggedInUserDetails()
                        //                          if Int.getInt(data["alysei_review"]) == 1 {
                        //                            if isprofileComplete == false{
                        //                                if !AppManager.getUserSeenAppInstructionProfile() {
                        ////                                    self.coachMarksController.start(in: .viewController(self))
                        //                                    self.tabBarController?.tabBar.backgroundColor = .darkGray
                        //                                    self.tabBarController?.tabBar.alpha = 0.9
                        //                                    self.tabBarController?.tabBar.isUserInteractionEnabled = false
                        //
                        //                                }
                        //                                else{
                        //                                    self.tabBarController?.tabBar.backgroundColor = .white
                        //                                    self.tabBarController?.tabBar.alpha = 1.0
                        //                                    self.tabBarController?.tabBar.isUserInteractionEnabled = true
                        //
                        //                                }
                        //                            }
                        //                            else{
                        //                                self.tabBarController?.tabBar.backgroundColor = .white
                        //                                self.tabBarController?.tabBar.alpha = 1.0
                        //                                self.tabBarController?.tabBar.isUserInteractionEnabled = true
                        //
                        //                            }
                        //                        }
                        //                        else{
                        //                            self.tabBarController?.tabBar.backgroundColor = .white
                        //                            self.tabBarController?.tabBar.alpha = 1.0
                        //                            self.tabBarController?.tabBar.isUserInteractionEnabled = true
                        //
                        //                        }
                        
                    } else {
                        if self.userID != nil {
                            self.menuButton.isHidden = true
                            self.fetchVisiterProfileDetails(self.userID)
                        }
                    }
                }
            }
            
        } else {
            blankdataView.isHidden = true
            // self.postRequestToGetFields()
            // self.fetchContactDetail()
            // self.fetchProfileDetails()
            self.currentIndex = 0
            if kSharedUserDefaults.getProfileCompletion() == false {
            self.postRequestToGetProgress()
            }
            if check == "" {
                if self.userLevel == .own {
                    self.menuButton.isHidden = false
                    if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.voyagers.rawValue)"{
                    self.fetchProfileDetails()
                    }
                } else {
                    if self.userID != nil {
                        self.menuButton.isHidden = true
                        self.fetchVisiterProfileDetails(self.userID)
                        
                    }
                }
            }
            
        }
        
        UIView.animate(withDuration: 0.01) {
            self.tabsCollectionView.reloadData()
            
        } completion: { bool in
            if let cell = self.tabsCollectionView.cellForItem(at: IndexPath(row: 1, section: 0)) as? TabCollectionViewCell {
                cell.isUnderlineBorderVisible(true)
                // cell.imageView.tintColor = UIColor(named: "blueberryColor")
            }
        }
        
        
        // Scroll update show
        let line = self.aboutLabel.calculateMaxLines()
        
        
        if line == 5 {
            shownumber = 80
        } else if line == 4 {
            shownumber = 90
        } else if line == 3 {
            shownumber = 150
        } else if line == 2 {
            shownumber = 130
        } else if line == 1 {
            shownumber = 150
        }
        
        
        self.tblViewPosts.tableHeaderView?.setHeight(CGFloat(someHeight) - CGFloat(shownumber))
        
        self.tblViewPosts.contentInsetAdjustmentBehavior = .always
        
    }
    
    
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //
    //        let offset = scrollView.contentOffset.y
    //        if(offset > 50){
    //            self.viewFeature.frame = CGRect(x: 0, y: offset - 2350, width: self.view.bounds.size.width, height: 100)
    //        }else{
    //            self.viewFeature.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 100)
    //        }
    //    }
    
    //MARK: - IBAction -
    
    @IBAction func tapLogout(_ sender: UIButton) {
        kSharedAppDelegate.callLogoutApi()
    }
    
    override func viewDidLayoutSubviews(){
        
        super.viewDidLayoutSubviews()
        self.viewSeparator.translatesAutoresizingMaskIntoConstraints = false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        .darkContent
    }
    //MARK: - IBAction -
    
    @IBAction func btnLogout(_ sender: UIButton){
        kSharedAppDelegate.callLogoutApi()
    }
    
    @IBAction func tapSideMenu(_ sender: UIButton) {
       
        let vc = pushViewController(withName: SettingsScreenVC.id(), fromStoryboard: StoryBoardConstants.kHome) as? SettingsScreenVC
      //  vc?.imgPUrl = imgPUrl
        vc!.userId = String.getString(userID)
    }
    
    @IBAction func tapPosts(_ sender: UIButton) {
        self.viewSeparator.center.x = self.btnPosts.center.x
        self.btnPosts.isSelected = true
        self.btnAbout.isSelected = false
        self.btnContact.isSelected = false
        self.btnPosts.setTitleColor(UIColor.black, for: .normal)
        self.btnAbout.setTitleColor(AppColors.liteGray.color, for: .normal)
        self.btnContact.setTitleColor(AppColors.liteGray.color, for: .normal)
        self.moveToNew(childViewController: postsViewC, fromController: self.currentChild)
    }
    
    func tapPhotos(_ sender: UIButton) {
        if (self.userPercentage == ProfilePercentage.percent100.rawValue || self.userPercentage == nil) {
            self.moveToNew(childViewController: self.photosViewcontroller, fromController: self.currentChild)
            
        }
    }
    
    @IBAction func tapTrip(_ sender: UIButton) {
        
        self.moveToNew(childViewController: tripViewC, fromController: self.currentChild)
        
    }
    
    @IBAction func tapEvent(_ sender: UIButton) {
        
        self.moveToNew(childViewController: eventViewC, fromController: self.currentChild)
        
    }
    
    @IBAction func tapBlog(_ sender: UIButton) {
        
        self.moveToNew(childViewController: blogViewC, fromController: self.currentChild)
        
    }
    
    @IBAction func tapAbout(_ sender: UIButton) {
        self.viewSeparator.center.x = self.btnAbout.center.x
        self.btnPosts.isSelected = false
        self.btnAbout.isSelected = true
        self.btnContact.isSelected = false
        self.btnPosts.setTitleColor(AppColors.liteGray.color, for: .normal)
        self.btnAbout.setTitleColor(UIColor.black, for: .normal)
        self.btnContact.setTitleColor(AppColors.liteGray.color, for: .normal)
        self.moveToNew(childViewController: aboutViewC, fromController: self.currentChild)
        
        self.aboutViewC.viewModel = self.aboutViewModel
        if let aboutModel = self.userProfileModel?.data?.aboutTab {
            self.aboutViewC.aboutTabModel = aboutModel
        }
        
    }
    
    @IBAction func tapContact(_ sender: UIButton) {
        self.viewSeparator.center.x = self.btnContact.center.x
        self.btnPosts.isSelected = false
        self.btnAbout.isSelected = false
        self.btnContact.isSelected = true
        self.btnPosts.setTitleColor(AppColors.liteGray.color, for: .normal)
        self.btnAbout.setTitleColor(AppColors.liteGray.color, for: .normal)
        self.btnContact.setTitleColor(UIColor.black, for: .normal)
        self.moveToNew(childViewController: contactViewC, fromController: self.currentChild)
        self.contactViewC.delegate = self
        self.contactViewC.tableData = self.contactDetail
        if self.userLevel == .other {
        }
        self.contactViewC.view.bringSubviewToFront(self.contactViewC.editContactDetailButton)
    }
    
    fileprivate func initiateEditProfileViewController() {
        let controller = pushViewController(withName: EditProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? EditProfileViewC
        controller?.signUpViewModel = self.signUpViewModel
        controller?.userType = self.userType ?? .voyagers
        self.editProfileViewCon = controller
    }
    
    @IBAction func tapEditProfile(_ sender: UIButton) {
       
        initiateEditProfileViewController()
        
    }
    @IBAction func tapAward(_ sender: UIButton) {
        self.moveToNew(childViewController: awardViewC, fromController: self.currentChild)
    }
    @IBAction func addFeaturedProductButtonTapped(_ sender: UIButton) {
        
        let productCategoriesDataModel = self.signUpViewModel?.arrProductCategories.first
        
        let controller = pushViewController(withName: AddFeatureViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? AddFeatureViewC
        controller?.productCategoriesDataModel = productCategoriesDataModel
        controller?.delegate = self
        if userLevel == .other {
            controller?.passRoleID = "\(self.visitorUserType.rawValue )"
        }else{
            controller?.passRoleID = kSharedUserDefaults.loggedInUserModal.memberRoleId
        }
        
    }
    
    @IBAction func respondButtonTapped(_ sender: UIButton) {
        self.respondButtonTapped()
    }
    
    @IBAction func connectButtonTapped(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        if  percentage != nil {
            self.tabBarController?.selectedIndex = 4
        }
        else{
            //mark:- Producer to importert
            if (kSharedUserDefaults.loggedInUserModal.memberRoleId == String.getString(UserRoles.producer.rawValue)) && (self.visitorUserType == .distributer1 || self.visitorUserType == .distributer2 || self.visitorUserType == .distributer3) {
                
                //  if percentage == "100" || percentage == nil{
               
                self.connectButtonTapped()
                sender.isUserInteractionEnabled = true
                //  } else {
                
                //  }
                
                return
                // Mark: - producer to other user
            } else if (kSharedUserDefaults.loggedInUserModal.memberRoleId == String.getString(UserRoles.producer.rawValue)) && (self.visitorUserType == .restaurant || self.visitorUserType == .travelAgencies || self.visitorUserType == .voiceExperts || self.visitorUserType == .producer){
               
                self.segueToCompleteConnectionFlow()
                sender.isUserInteractionEnabled = true
                
                
            } else if (kSharedUserDefaults.loggedInUserModal.memberRoleId == String.getString(UserRoles.voiceExperts.rawValue)) {
                
                self.segueToCompleteConnectionFlow()
                sender.isUserInteractionEnabled = true
                
            }else if (kSharedUserDefaults.loggedInUserModal.memberRoleId == String.getString(UserRoles.distributer1.rawValue)) || (kSharedUserDefaults.loggedInUserModal.memberRoleId == String.getString(UserRoles.distributer2.rawValue)) || (kSharedUserDefaults.loggedInUserModal.memberRoleId == String.getString(UserRoles.distributer3.rawValue)){
                sender.isUserInteractionEnabled = true
                self.segueToCompleteConnectionFlow()
                
                
            } else if (kSharedUserDefaults.loggedInUserModal.memberRoleId == String.getString(UserRoles.restaurant.rawValue)) {
                
                self.segueToCompleteConnectionFlow()
                sender.isUserInteractionEnabled = true
                
                
            } else if (kSharedUserDefaults.loggedInUserModal.memberRoleId == String.getString(UserRoles.travelAgencies.rawValue)) {
                
                self.segueToCompleteConnectionFlow()
                sender.isUserInteractionEnabled = true
                
            } else {
                if self.percentage == "\(ProfilePercentage.percent100.rawValue)" || percentage == nil{
                    let profileID = (self.userProfileModel.data?.userData?.userID) ?? (self.userID) ?? 1
                    
                    if self.connectButton.titleLabel?.text == "Follow" {
                       
                        followUnfollow(id: profileID, type: 1)
                        sender.isUserInteractionEnabled = true
                    } else if self.connectButton.titleLabel?.text == "Unfollow" {
                        
                        followUnfollow(id: profileID, type: 0)
                        sender.isUserInteractionEnabled = true
                    } else {
                        self.connectButtonTapped()
                        sender.isUserInteractionEnabled = true
                    }
                } else {
                    self.tabBarController?.selectedIndex = 4
                    self.segueToCompleteConnectionFlow()
                    sender.isUserInteractionEnabled = true
                }
            }
        }
    }
    func sendConnectionRequest(_ model: BasicConnectFlow.Connection.request) {
        do {
            let urlString = APIUrl.Connection.sendRequest
            
            let body = try JSONEncoder().encode(model)
            
            guard var request = WebServices.shared.buildURLRequest(urlString, method: .POST) else {
                return
            }
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = model.urlEncoded()
            
            //            request.httpBody = body
            
            WebServices.shared.request(request) { data, URLResponse, statusCode, error in
                
                
                
                if statusCode == 200 {
                    print("Success---------------------------Successssss")
                    self.fetchVisiterProfileDetails(self.userID)
                } else if statusCode == 409{
                    self.showAlert(withMessage: AppConstants.kYouAreNotAuthorizedUser)
                } else {
                    self.showAlert(withMessage: AppConstants.kSomethingWentWrong)
                }
                
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func segueToCompleteConnectionFlow() {
        
        let connectionStatus = self.userProfileModel.data?.userData?.connectionFlag ?? 0
        if self.userType == .voyagers && self.visitorUserType == .voyagers && connectionStatus == 0{
            let requestModel = BasicConnectFlow.Connection.request(userID: self.userID ?? 0,reason: "",selectProductId: "")
            sendConnectionRequest(requestModel)
            
        }else{
            
            if connectionStatus == 0 {
                let controller = pushViewController(withName: BasicConnectFlowViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as? BasicConnectFlowViewController
                
                var username = ""
                var pusername = ""
                
                if self.userProfileModel.data?.userData?.roleID == UserRoles.restaurant.rawValue{
                    pusername = self.userProfileModel.data?.userData?.restaurantName ?? ""
                }else if self.userProfileModel.data?.userData?.roleID == UserRoles.voiceExperts.rawValue || self.userProfileModel.data?.userData?.roleID == UserRoles.voyagers.rawValue{
                    pusername = self.userProfileModel.data?.userData?.firstName ?? ""
                }else{
                    pusername = self.userProfileModel.data?.userData?.companyName ?? ""
                }
                
                controller?.userName = pusername
                controller?.userID = self.userID
                
            } else if connectionStatus == 2 {
                let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
                let cancelConnectionRequestAction = UIAlertAction(title: AppConstants.kCancelRequest, style: .default) { action in
                    self.cancelConnectionRequest()
                }
                cancelConnectionRequestAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
                
                var title = AppConstants.Block
                if self.userProfileModel.data?.userData?.blockFlag ?? 0 == 0 {
                    title = AppConstants.Block
                } else {
                    title = AppConstants.UnBlock
                }
                
                let blockUserAction = UIAlertAction(title: title, style: .destructive) { action in
                    self.blockUserFromConnectionRequest(ProfileScreenModels.BlockConnectRequest(userID: self.userID))
                }
                blockUserAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
                
                
                let cancelAction = UIAlertAction(title: MarketPlaceConstant.kCancel, style: .cancel, handler: nil)
                cancelAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
                
                alertController.addAction(cancelConnectionRequestAction)
                alertController.addAction(blockUserAction)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
            } else if connectionStatus == 1 {
                
                
                let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
                let cancelConnectionRequestAction = UIAlertAction(title: AppConstants.RemoveConnection, style: .default) { action in
                    self.cancelConnectionRequest()
                }
                cancelConnectionRequestAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
                
                var title = AppConstants.Block
                if self.userProfileModel.data?.userData?.blockFlag ?? 0 == 0 {
                    title = AppConstants.Block
                    
                } else {
                    title = AppConstants.UnBlock
                    
                }
                
                let blockUserAction = UIAlertAction(title: title, style: .destructive) { action in
                    self.blockUserFromConnectionRequest(ProfileScreenModels.BlockConnectRequest(userID: self.userID))
                }
                blockUserAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
                
                
                let cancelAction = UIAlertAction(title: MarketPlaceConstant.kCancel, style: .cancel, handler: nil)
                cancelAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
                
                alertController.addAction(cancelConnectionRequestAction)
                alertController.addAction(blockUserAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                
            }
        }
    }
    
    func udpateConnectionButtonForVisitorProfile(_ visitorType: UserRoles) {
        let availableToFollow = (self.userProfileModel.data?.userData?.availableToFollow ?? 1)
        let availableToConnect = (self.userProfileModel.data?.userData?.availableToConnect ?? 1)
        let connectionFlag = self.userProfileModel.data?.userData?.connectionFlag ?? 0
        self.connectionFlagValue = connectionFlag
        guard (availableToFollow == 1) || (availableToConnect == 1) || (connectionFlag > 0) else {
            self.connectButton.isHidden = true
            return
        }
        if connectionFlag == 3 {
            self.connectButton.isHidden = true
            self.respondeButton.isHidden = false
        }
        if self.connectButton.isHidden == false{
            if self.userType != .voyagers {
                var title = AppConstants.Connect
                switch connectionFlag {
                case 0:
                    title = AppConstants.Connect
                case 1:
                    title = AppConstants.Connected
                case 2:
                    title = AppConstants.kPending
                default:
                    title = AppConstants.Connect
                }
                self.connectButton.setTitle("\(title)", for: .normal)
            } else if self.userType == .voyagers {
                
                if self.visitorUserType == .voyagers {
                    //let title = (self.userProfileModel.data?.userData?.connectionFlag ?? 0) == 1 ? "Connected" : "Pending"
                    //self.connectButton.setTitle("\(title)", for: .normal)
                    var title = AppConstants.Connect
                    switch connectionFlag {
                    case 0:
                        title = AppConstants.Connect
                    case 1:
                        title = AppConstants.Connected
                    case 2:
                        title = AppConstants.kPending
                    default:
                        title = AppConstants.Connect
                    }
                    self.connectButton.setTitle("\(title)", for: .normal)
                    
                } else {
                    let title = (self.userProfileModel.data?.userData?.followFlag ?? 0) == 1 ? AppConstants.Unfollow : AppConstants.Follow
                    self.connectButton.setTitle("\(title)", for: .normal)
                }
            }
        }  else {
        }
    }
    @IBAction func btnback(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func messageButtonTapped(_ sender: UIButton) {
        self.messageButtonTapped()
    }
    func setUI(){
        
        let trackRect =  self.percentageSlider.trackRect(forBounds: self.percentageSlider.bounds)
        let thumbRect = self.percentageSlider.thumbRect(forBounds: self.percentageSlider.bounds, trackRect: trackRect, value: self.percentageSlider.value)
        self.lblPercentage.transform = CGAffineTransform(translationX: thumbRect.origin.x + self.percentageSlider.frame.origin.x - 9, y: self.percentageSlider.frame.origin.y + 35)
    }
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                
                profileTabImage = UIImage(data: data)
                
                self?.tabBarController?.addSubviewToLastTabItem(profileTabImage ?? UIImage())
            }
        }
    }
    
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    private func initialSetUp(_ profileImage: String , _ coverImage: String, baseUrl: String) -> Void{
        
        self.imgViewCover.image = UIImage(named: "coverPhoto")
        self.imgViewProfile.image = UIImage(named: "profile_icon")
        let imgUrl = (baseUrl + coverImage)
        
        self.imgViewCover.setImage(withString: imgUrl)
        imgPUrl = (baseUrl + profileImage)
        
        
        if imgPUrl != "" {
            self.imgViewProfile.setImage(withString: imgPUrl ?? "")
            self.imgViewProfile.layer.cornerRadius = (self.imgViewProfile.frame.width / 2.0)
            self.imgViewProfile.layer.borderWidth = 5.0
            
            switch self.userType {
            case .distributer1, .distributer2, .distributer3:
                self.lbladdproduct.text = MarketPlaceConstant.kAddProduct
                self.imgViewProfile.layer.borderColor = UIColor.init(hexString: RolesBorderColor.distributer1.rawValue).cgColor
            case .producer:
                self.lbladdproduct.text = MarketPlaceConstant.kAddProduct
                self.imgViewProfile.layer.borderColor = UIColor.init(hexString: RolesBorderColor.producer.rawValue).cgColor
            case .travelAgencies:
                self.lbladdproduct.text = MarketPlaceConstant.kAddPackage
                self.imgViewProfile.layer.borderColor = UIColor.init(hexString: RolesBorderColor.travelAgencies.rawValue).cgColor
            case .voiceExperts:
                self.lbladdproduct.text = MarketPlaceConstant.kAddFeatured
                self.imgViewProfile.layer.borderColor = UIColor.init(hexString: RolesBorderColor.voiceExperts.rawValue).cgColor
            case .voyagers:
                self.imgViewProfile.layer.borderColor = UIColor.init(hexString: RolesBorderColor.voyagers.rawValue).cgColor
            case .restaurant :
                self.lbladdproduct.text = MarketPlaceConstant.KAddMenu
                self.imgViewProfile.layer.borderColor = UIColor.init(hexString: RolesBorderColor.restaurant.rawValue).cgColor
            default:
                self.imgViewProfile.layer.borderColor = UIColor.white.cgColor
            }
            
            self.imgViewProfile.layer.masksToBounds = true
        }else{
            self.imgViewProfile.layer.cornerRadius = (self.imgViewProfile.frame.width / 2.0)
            self.imgViewProfile.layer.borderWidth = 5.0
            self.imgViewProfile.layer.borderColor = UIColor.white.cgColor
        }
        
        
    }
    
    private func getFeaturedProductCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
        
        let productCategoryDataModel = self.signUpViewModel?.arrProductCategories.first
        let product = productCategoryDataModel?.arrAllProducts[indexPath.row]
        let featuredProductCollectionCell = collectionViewAddProduct.dequeueReusableCell(withReuseIdentifier: FeaturedProductCollectionCell.identifier(), for: indexPath) as! FeaturedProductCollectionCell
        featuredProductCollectionCell.configure(withAllProductsDataModel: product,pushedFrom: 1)
        //      featuredProductCollectionCell.delegate = self
        //        if self.signUpViewModel != nil {
        //            featuredProductCollectionCell.configureData(withProductCategoriesDataModel: self.signUpViewModel.arrProductCategories[indexPath.section])
        //        }
      
        
        return featuredProductCollectionCell
    }
    
    private func getTabCollectionViewCell(_ indexPath: IndexPath, isSelected: Bool = false) -> UICollectionViewCell {
        guard let cell = self.tabsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TabCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let imageName = ProfileTabRows().imageName(self.userType)[indexPath.row]
        
        let title = ProfileTabRows().rowsTitle(self.userType)[indexPath.row]
        cell.imageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        //cell.imageView.tintColor = UIColor(named: "grey2")
        cell.titleLabel.text = title
        return cell
        
    }
    
    private func moveToNew(childViewController newVC: UIViewController,fromController oldVC: UIViewController, completion:((() ->Void)? ) = nil){
        
        if  oldVC == newVC {
            completion?()
            return
        }
        DispatchQueue.main.async {
            self.addChild(newVC)
            newVC.view.frame = self.containerView.bounds
            oldVC.willMove(toParent: nil)
            
            self.transition(from: oldVC, to: newVC, duration: 0.25, options: UIView.AnimationOptions(rawValue: 0), animations:{
                
            })
            { (_) in
                
                oldVC.removeFromParent()
                newVC.didMove(toParent: self)
            //    self.view.isUserInteractionEnabled = true
                completion?()
            }
        }
    }
    //
    //    Featured Product (Producer & Importer)
    //    Featured Recipe (Restaurant)
    //    Featured Trips (Travel Agencies)
    //    Featured Blogs (Voice of experts)
    private func updateListingTitle() {
        if userLevel == .other {
            switch self.visitorUserType {
            case .distributer1, .distributer2, .distributer3, .producer:
                self.featuredListingTitleLabel.text = MarketPlaceConstant.kFeaturedProduct
            case .restaurant:
                self.featuredListingTitleLabel.text = MarketPlaceConstant.kFeaturedMenu
            case .travelAgencies:
                self.featuredListingTitleLabel.text = MarketPlaceConstant.kFeaturedPackage
                
            case .voiceExperts:
                self.featuredListingTitleLabel.text = MarketPlaceConstant.kFeatured
                
            default:
                
                print("no user role found")
            }
        }else{
            switch self.userType {
            case .distributer1, .distributer2, .distributer3, .producer:
                self.featuredListingTitleLabel.text =  MarketPlaceConstant.kFeaturedProduct
            case .restaurant:
                self.featuredListingTitleLabel.text = MarketPlaceConstant.kFeaturedMenu
            case .travelAgencies:
                self.featuredListingTitleLabel.text = MarketPlaceConstant.kFeaturedPackage
            case .voiceExperts:
                self.featuredListingTitleLabel.text = MarketPlaceConstant.kFeatured
            default:
                print("no user role found")
            }
        }
    }
    
    //MARK:  - WebService Methods -
    func reloadFields() {
        self.postRequestToGetFields()
    }
    
    private func fetchProfileDetails() {
       
        SVProgressHUD.show()
        guard let urlRequest = WebServices.shared.buildURLRequest("\(APIUrl.Profile.userProfile)", method: .GET) else { return }
        WebServices.shared.request(urlRequest) { (data, response, statusCode, error)  in
            SVProgressHUD.dismiss()
            if statusCode == 401 {
                let token = kSharedUserDefaults.getDeviceToken()
                //   kSharedUserDefaults.clearAllData()
                kSharedUserDefaults.setDeviceToken(deviceToken: token)
            }
            guard let data = data else { return }
            do {
                
                let responseModel = try JSONDecoder().decode(UserProfile.profileTopSectionModel.self, from: data)
                print(responseModel)
                
                self.userProfileModel = responseModel
                self.postRequestToGetFields()
                self.postcount.text = String.getString(responseModel.data?.postCount)
                self.connectioncount.text = String.getString(responseModel.data?.connectionCount)
                
                
                if kSharedUserDefaults.loggedInUserModal.memberRoleId == "10"{
                    self.followercount.text = String.getString(responseModel.data?.followingcount)
                } else {
                    self.followercount.text = String.getString(responseModel.data?.followerCount)
                }
                
                if let username = responseModel.data?.userData?.username {
                    self.usernameLabel.text = "@\(username)".lowercased()
                }
                self.aboutLabel.text = "\(responseModel.data?.about ?? "")"
                
                if self.aboutLabel.calculateMaxLines() > 5 {
                    self.aboutLabel.numberOfLines = 5
                }
                
                let roleID = UserRoles(rawValue: responseModel.data?.userData?.roleID ?? 0) ?? .voyagers
                self.userType = roleID
                
                self.updateListingTitle()
                
                UIView.animate(withDuration: 0.01) {
                    self.tabsCollectionView.reloadData()
                } completion: { bool in
                    
                    
                    //MARK: SelectTab
                    if let cell = self.tabsCollectionView.cellForItem(at: IndexPath(row: 1, section: 0)) as? TabCollectionViewCell {
                        cell.isSelected = true
                    }
                    self.collectionView(self.tabsCollectionView, didSelectItemAt: IndexPath(item: 1, section: 0))
                    self.tabsCollectionView.selectItem(at: IndexPath(item: 1, section: 0), animated: true, scrollPosition: .top)
                }
                self.editProfileViewCon?.userType = self.userType
                
                self.collectionViewAddProduct.reloadData()
                var name = ""
                switch roleID {
                case .distributer1, .distributer2, .distributer3, .producer, .travelAgencies :
                    name = "\(responseModel.data?.userData?.companyName ?? "")"
                case .restaurant :
                    name = "\(responseModel.data?.userData?.restaurantName ?? "")"
                default:
                    name = "\(responseModel.data?.userData?.firstName ?? "") \(responseModel.data?.userData?.lastName ?? "")"
                }
                
                self.lblDisplayName.text = "\(name)".capitalized
                self.lblDisplayNameNavigation.text = "\(name)".capitalized
                self.userPercentage = responseModel.data?.userData?.profilePercentage ?? 0
                if ((self.userPercentage == ProfilePercentage.percent100.rawValue) || (self.userPercentage == nil)) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                        self.tblViewProfileCompletion.isHidden = true
                        self.headerView.isHidden = false
                        self.tblViewPosts.isHidden = false
                        isprofileComplete = true
                    }
                }else{
                    isprofileComplete = false
                    self.tblViewProfileCompletion.isHidden = false
                    self.headerView.isHidden = true
                    self.tblViewPosts.isHidden = true
                    
                }
                
                
                kSharedUserDefaults.loggedInUserModal.firstName = responseModel.data?.userData?.firstName
                kSharedUserDefaults.loggedInUserModal.lastName = responseModel.data?.userData?.lastName
                kSharedUserDefaults.loggedInUserModal.avatar?.imageURL = responseModel.data?.userData?.avatar?.imageURL
                kSharedUserDefaults.synchronize()
                //                let baseUrl = (responseModel.data?.userData?.avatar?.base_url ?? "")
                //                let urlP = URL(string: "\(baseUrl + "\(responseModel.data?.userData?.avatar?.imageURL ?? "")")")
                print("CountryCode-----------------------\(responseModel.data?.contactTab?.country_code ?? "")")
                let urlP = URL(string: kSharedUserDefaults.loggedInUserModal.avatar?.imageURL ?? "")
                self.downloadImage(from: urlP ?? URL(fileURLWithPath: ""))
                
                self.initialSetUp(responseModel.data?.userData?.avatar?.imageURL ?? "", responseModel.data?.userData?.cover?.imageURL ?? "",baseUrl: (responseModel.data?.userData?.avatar?.base_url ?? ""))
                
                //MARK: For self Contact Detail
                self.contactDetilViewModel = responseModel.data?.contactTab
                self.contactDetail.removeAll()
                self.contactDetail.append(ContactDetail.view.tableCellModel(imageName: "contact_email",
                                                                            title: "Email", value: responseModel.data?.contactTab?.email ?? ""))
                if let phone = responseModel.data?.contactTab?.phone {
                    let countryCode = ((responseModel.data?.contactTab?.country_code?.count ?? 0) > 0) ? "+\(responseModel.data?.contactTab?.country_code ?? "") " : ""
                    
                    self.contactDetail.append(ContactDetail.view.tableCellModel(imageName: "contact_call",
                                                                                title: "Phone", value: "\(countryCode)\(phone)"))
                }
                if let address = responseModel.data?.contactTab?.address {
                    self.contactDetail.append(ContactDetail.view.tableCellModel(imageName: "contact_pin",
                                                                                title: "Address", value: address))
                }
                if let website = responseModel.data?.contactTab?.website {
                    self.contactDetail.append(ContactDetail.view.tableCellModel(imageName: "contact_world-wide-web",
                                                                                title: "Website", value: website))
                }
                if let facebook = responseModel.data?.contactTab?.fbLink {
                    self.contactDetail.append(ContactDetail.view.tableCellModel(imageName: "contact_facebook",
                                                                                title: "Facebook", value: facebook))
                }
              //  self.stopSkeletableAnimation()
                
                
            } catch {
                print(error.localizedDescription)
            }
            if (error != nil) { print(error.debugDescription) }
        }
        
    }
    func setPercentageUI(_ userPercentage: String){
        //let userPercentage = responseModel.data?.userData?.profilePercentage ?? 0
        self.percentageLabel.text = "\(userPercentage )%" + AppConstants.kcompleted
        self.lblPercentage.text = "\(userPercentage )%"
        
        let floatPercentage = Float(userPercentage )
        self.progressbar.setProgress(((floatPercentage ?? 0)/100), animated: false)
        self.percentageSlider.setValue(floatPercentage ?? 0, animated: true)
    }
    
    func fetchVisiterProfileDetails(_ userID: Int) {
        SVProgressHUD.show()
        
        guard let urlRequest = WebServices.shared.buildURLRequest("\(APIUrl.Profile.visiterProfile)\(userID)", method: .GET) else { return }
        WebServices.shared.request(urlRequest) { (data, response, statusCode, error)  in
            SVProgressHUD.dismiss()
            
            guard let data = data else { return }
            do {
                
                let responseModel = try JSONDecoder().decode(UserProfile.profileTopSectionModel.self, from: data)
                // let dicResult = kSharedInstance.getDictionary(data)
                //let dicData = kSharedInstance.getDictionary(dicResult[APIConstants.kData])
                
                print(responseModel)
                self.userProfileModel = responseModel
                
                self.postRequestToGetFields()
                self.postcount.text = String.getString(responseModel.data?.postCount)
                self.connectioncount.text = String.getString(responseModel.data?.connectionCount)
                
                
                if kSharedUserDefaults.loggedInUserModal.memberRoleId == "10"{
                    self.followercount.text = String.getString(responseModel.data?.followingcount)
                } else {
                    self.followercount.text = String.getString(responseModel.data?.followerCount)
                }
                
                //self.postcount.text = String.getString(responseModel.data?.postCount)
                //self.followercount.text = String.getString(responseModel.data?.followerCount)
                
                
                // if kSharedUserDefaults.loggedInUserModal.memberRoleId == "10"{
                //  let productCategoryDataModel = self.signUpViewModel?.arrProductCategories.first
                
                if (self.userProfileModel.data?.userData?.roleID == 10){
                    //self.featureUIview.constant = 0
                    self.followercount.text = String.getString(responseModel.data?.followingcount)
                } else {
                    // self.featureUIview.constant = 140
                    self.followercount.text = String.getString(responseModel.data?.followerCount)
                }
                
                if let username = responseModel.data?.userData?.username {
                    self.usernameLabel.text = "@\(username)".lowercased()
                }
                self.aboutLabel.text = "\(responseModel.data?.about ?? "")"
                
                if self.aboutLabel.calculateMaxLines() > 5 {
                    self.aboutLabel.numberOfLines = 5
                }
                
                let roleID = UserRoles(rawValue: responseModel.data?.userData?.roleID ?? 0) ?? .voyagers
                self.visitorUserType = roleID
                self.udpateConnectionButtonForVisitorProfile(roleID)
                self.updateListingTitle()
                
                //self.collectionViewAddProduct.reloadData()
                if self.userProfileModel.data?.userData?.roleID == 10 {
                    self.followerstext.text = AppConstants.kFollowing
                } else {
                    self.followerstext.text = AppConstants.Followers
                }
                if self.userProfileModel.data?.userData?.connectionFlag == 1 || self.userProfileModel.data?.userData?.followFlag == 1 ||  self.userProfileModel.data?.userData?.whoCanViewProfile == "anyone"{
                    self.tabsCollectionView.reloadData()
                    self.tabsCollectionView.isHidden = false
                    self.containerView.isHidden = false
                } else {
                    //self.tabsCollectionView.isHidden = true
                   // self.containerView.isHidden = true
                    self.tabsCollectionView.isHidden = false
                    self.containerView.isHidden = false
                }
                
                var name = ""
                switch roleID {
                case .distributer1, .distributer2, .distributer3, .producer, .travelAgencies :
                    name = "\(responseModel.data?.userData?.companyName ?? "")"
                    self.btnConnectHght.constant = 44
                    
                case .restaurant :
                    name = "\(responseModel.data?.userData?.restaurantName ?? "")"
                    self.btnConnectHght.constant = 44
                    
                case .voiceExperts:
                    name = "\(responseModel.data?.userData?.firstName ?? "") \(responseModel.data?.userData?.lastName ?? "")"
                    self.btnConnectHght.constant = 44
                    
                default:
                    name = "\(responseModel.data?.userData?.firstName ?? "") \(responseModel.data?.userData?.lastName ?? "")"
                    if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.voyagers.rawValue)"{
                        self.btnConnectHght.constant = 44
                    }else{
                        self.btnConnectHght.constant = 0
                    }
                    
                }
                
                self.userType = roleID
                self.lblDisplayName.text = "\(name)".capitalized
                self.lblDisplayNameNavigation.text = "\(name)".capitalized
                self.headerView.isHidden = true
                self.tblViewPosts.isHidden = false
                self.initialSetUp(responseModel.data?.userData?.avatar?.imageURL ?? "", responseModel.data?.userData?.cover?.imageURL ?? "", baseUrl: (responseModel.data?.userData?.avatar?.base_url ?? ""))
                self.btnEditProfile.isHidden = true
                self.messageButton.isHidden = true
                self.respondeButton.isHidden = true
                self.connectButton.isHidden = true
                
                //MARk:- For Visitor Contact
                self.contactDetilViewModel = responseModel.data?.contactTab
                self.contactDetail.removeAll()
                self.contactDetail.append(ContactDetail.view.tableCellModel(imageName: "contact_email",
                                                                            title: "Email", value: responseModel.data?.contactTab?.email ?? ""))
                if let phone = responseModel.data?.contactTab?.phone {
                    let countryCode = ((responseModel.data?.contactTab?.country_code?.count ?? 0) > 0) ? "+\(responseModel.data?.contactTab?.country_code ?? "") " : ""
                    
                    self.contactDetail.append(ContactDetail.view.tableCellModel(imageName: "contact_call",
                                                                                title: "Phone", value: "\(countryCode)\(phone)"))
                }
                if let address = responseModel.data?.contactTab?.address {
                    self.contactDetail.append(ContactDetail.view.tableCellModel(imageName: "contact_pin",
                                                                                title: "Address", value: address))
                }
                if let website = responseModel.data?.contactTab?.website {
                    self.contactDetail.append(ContactDetail.view.tableCellModel(imageName: "contact_world-wide-web",
                                                                                title: "Website", value: website))
                }
                if let facebook = responseModel.data?.contactTab?.fbLink {
                    self.contactDetail.append(ContactDetail.view.tableCellModel(imageName: "contact_facebook",
                                                                                title: "Facebook", value: facebook))
                }
                
                switch self.userLevel {
                case .own:
                    print("own")
                    self.btnEditProfile.isHidden = false
                    self.btnEditProfile.isUserInteractionEnabled = true
                    
                case .other:
                    if self.connectionFlagValue == 3{
                        self.messageButton.isHidden = true
                        self.respondeButton.isHidden = false
                        self.respondeButton.isUserInteractionEnabled = true
                        self.connectButton.isHidden = true
                        self.connectButton.isUserInteractionEnabled = false
                    }else{
                        self.messageButton.isHidden = true
                        self.respondeButton.isHidden = true
                        self.respondeButton.isUserInteractionEnabled = false
                        self.connectButton.isHidden = false
                        self.connectButton.isUserInteractionEnabled = true
                    }
                }
                
                
            } catch {
                print(error.localizedDescription)
            }
            if (error != nil) { print(error.debugDescription) }
        }
    }
    func fetchContactData(_ data: [String:Any]){
        
    }
    
    //MARK:  - Private Methods -
    
    private func getProfileCompletionTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tblViewProfileCompletion.dequeueReusableCell(withIdentifier: ProfileCompletionTableViewCell.identifier()) as! ProfileCompletionTableViewCell
        // cell.delegate = self
        
        cell.lbleTitle.text = profileCompletionModel?[indexPath.row].title
        cell.lblDescription.text = profileCompletionModel?[indexPath.row].description
        cell.configure(indexPath, currentIndex: self.currentIndex)
        cell.configCell(profileCompletionModel?[indexPath.row] ?? ProfileCompletionModel(with: [:]),cell, indexPath.row)
        cell.viewLine.isHidden = (indexPath.row == ((profileCompletionModel?.count ?? 0) - 1)) ? true : false
        cell.tag = indexPath.row
        self.animateViews(indexPath.row, cell: cell)
        //        cell.animationCallback = { currentIndex, cell in
        //        self.animateViews(indexPath.row , cell: cell)
        //        }
        
        
        return cell
    }
    
    private func postRequestToGetFields() -> Void{
        
       
       // if kSharedUserDefaults.getProfileCompletion() == false {
        if userLevel == .own{
            CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kUserSubmittedFields, method: .GET, controller: self, type: 0, param: [:], btnTapped: UIButton())
        }else{
            CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kUserSubmittedFields+"/"+String.getString(userID), method: .GET, controller: self, type: 0, param: [:], btnTapped: UIButton())
       // }
        }
    }
    //MARK:- HandleViewTap
    
    @objc func handleTap(_ sender: UITapGestureRecognizer){
        guard let controller = self.storyboard?.instantiateViewController(identifier: "ProfileCompletionViewController") as? ProfileCompletionViewController else {return}
        controller.percentage = String.getString(percentage)
        controller.signUpViewModel = self.signUpViewModel
        controller.userType = self.userType ?? .voyagers
        self.navigationController?.pushViewController(controller, animated: true)
        
        
        
    }
    //MARK:  - WebService Methods -
    
    func followUnfollow(id: Int, type: Int){
        
        let params: [String:Any] = [
            "follow_user_id": id,
            "follow_or_unfollow": type]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kFollowUnfollow, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictRespnose, error, errorType, statusCode) in
            
            if self.connectButton.titleLabel?.text == AppConstants.Follow {
                
                self.connectButton.setTitle(AppConstants.Unfollow, for: .normal)
            } else if self.connectButton.titleLabel?.text == AppConstants.Unfollow {
                self.connectButton.setTitle(AppConstants.Follow, for: .normal)
            }
        }
        
    }
    
    private func postRequestToGetProgress() -> Void{
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kProfileProgress, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictRespnose, error, errorType, statusCode) in
            let response = dictRespnose as? [String:Any]
            
            if let data = response?["data_progress"] as? [[String:Any]]{
                let profileArray = kSharedInstance.getArray(withDictionary: data)
                self.profileCompletionModel = profileArray.map{ProfileCompletionModel(with: $0)}
                
            }
            
            if let perData = response?["data"] as? [String:Any]{
                
                self.percentage = String.getString(perData["profile_percentage"]) //as? String
                if self.percentage != "\(ProfilePercentage.percent100.rawValue)" && self.percentage != nil {
                    self.tblViewProfileCompletion.isHidden = false
                    self.setPercentageUI(self.percentage ?? "0")
                self.progressUserData = UserData.init(with: perData)
                if let progUserData = perData["user_details"] as? [String:Any]{
                    self.progressUserData = UserData.init(with: progUserData)
                }
                }else{
                    self.tblViewProfileCompletion.isHidden = true
                   // self.tblViewPosts.isHidden = false
                    kSharedUserDefaults.setProfileCompletion(completed: true)
                   // self.fetchProfileDetails()
                   
                    //self.tblViewPosts.reloadData()
                }
            }
            
            
            self.tblViewProfileCompletion.reloadData()
        }
    }
    
}

//MARK: - CollectionView Methods -

extension ProfileViewC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.tabsCollectionView {
            if self.userType == nil {
                return 0
            }
            return ProfileTabRows().noOfRows(self.userType)
        }
        
        
        let productCategoryDataModel = self.signUpViewModel?.arrProductCategories.first
        return productCategoryDataModel?.arrAllProducts.count ?? 0
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.tabsCollectionView {
            if let cell = self.getTabCollectionViewCell(indexPath) as? TabCollectionViewCell {
                cell.backgroundColor = .clear
                
                
                if indexPath.row == 1 {
                    cell.isUnderlineBorderVisible(true)
                } else {
                    cell.isUnderlineBorderVisible(false)
                }
                
                return cell
            }
        }
        
        
        return self.getFeaturedProductCollectionCell(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> Void {
        self.tabsCollectionView.isUserInteractionEnabled = false
        let totalRows = ProfileTabRows().noOfRows(self.userType)
        
        //        if currentSelectedIndexPath != indexPath.row {
        //            currentSelectedIndexPath = indexPath.row
        //        }
        if totalRows > indexPath.row{
            if collectionView == self.tabsCollectionView {
                let totalRows = ProfileTabRows().noOfRows(self.userType)
                
                let title = ProfileTabRows().rowsTitle(self.userType)[indexPath.row]
                if indexPath.row ==  0 {
                    self.tapPosts(UIButton())
                } else if indexPath.row == 1 {
                    self.tapPhotos(UIButton())
                } else if indexPath.row == 2 {
                    self.tapAbout(UIButton())
                } else if indexPath.row == 3 {
                    self.tapContact(UIButton())
                    
                }else if indexPath.row == 4{
                    self.tapAward(UIButton())
                }else if indexPath.row == 5 {
                    
                    if title == "Blogs" {
                        self.tapBlog(UIButton())
                    } else if title == "Trips" {
                        self.tapTrip(UIButton())
                    } else if title == "Events" {
                        self.tapEvent(UIButton())
                    }
                    
                    
                }
                
                if let cell = self.tabsCollectionView.cellForItem(at: indexPath) as? TabCollectionViewCell {
                    cell.isUnderlineBorderVisible(true)
                    //cell.imageView.tintColor = UIColor(named: "blueberryColor")
                    
                    self.tabsCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
                    self.tabsCollectionView.isUserInteractionEnabled = true
                    
                    
                }
                
                //            let sIndexPath = IndexPath(item: currentSelectedIndexPath, section: 0)
                //            if let cell = self.tabsCollectionView.cellForItem(at: sIndexPath) as? TabCollectionViewCell {
                //                cell.isUnderlineBorderVisible(true)
                //                cell.imageView.tintColor = UIColor(named: "blueberryColor")
                //
                //                self.tabsCollectionView.selectItem(at: sIndexPath, animated: true, scrollPosition: .centeredHorizontally)
                //
                //            }
                
            }
        }
        if collectionView == collectionViewAddProduct {
            let productCategoryDataModel = self.signUpViewModel?.arrProductCategories.first
            let product = productCategoryDataModel?.arrAllProducts[indexPath.row]
            self.postRequestToGetFeatureListing(product?.featuredListingId ?? "", navigationTitle: MarketPlaceConstant.kFeaturedProduct)
        }
        else{
            print("Invalid data")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("inside didDeSelect")
        if collectionView == self.tabsCollectionView {
            if let cell = self.tabsCollectionView.cellForItem(at: indexPath) as? TabCollectionViewCell {
                cell.isUnderlineBorderVisible(false)
                //cell.imageView.tintColor = UIColor(named: "grey2")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Mark: Latest Code Rinku Sir
        if collectionView == tabsCollectionView{
            return CGSize(width: self.tabsCollectionView.frame.width / 3, height: 48.0)
        }else{
            
            return CGSize(width: 65, height: 100.0)
        }
    }
    
}

//MARK:  - TableViewMethods -

extension ProfileViewC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileCompletionModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return self.getProfileCompletionTableCell(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == self.tblViewPosts {
            //            let height = (500.0 + (self.view.frame.height * 0.75) + ((UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0) * 4.0))
            //            return height
            return 150
        }
        return UITableView.automaticDimension
    }
    
}

extension ProfileViewC: AnimationProfileCallBack{
    
    func animateViews(_ indexPath: Int, cell: ProfileCompletionTableViewCell) {
        
        switch indexPath {
        case 0:
            self.currentIndex = 1
            if  profileCompletionModel?[indexPath].status == true {
                cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion1")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    cell.viewLine.layer.backgroundColor = UIColor.init(hexString: "#ccccff").cgColor
                }
            }else {
                cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
                }
            }
            // self.tblViewProfileCompletion.reloadData()
        case 1:
            self.currentIndex = 2
            if  profileCompletionModel?[indexPath].status == true {
                cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion2")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    cell.viewLine.layer.backgroundColor = UIColor.init(hexString: "#9999ff").cgColor
                }
            }else {
                cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
                }
            }
            //  self.tblViewProfileCompletion.reloadData()
        case 2:
            self.currentIndex = 3
            if  profileCompletionModel?[indexPath].status == true {
                cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion3")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    cell.viewLine.layer.backgroundColor = UIColor.init(hexString: "#7f7fff").cgColor
                }
            }else {
                cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
                }
            }
            // self.tblViewProfileCompletion.reloadData()
        case 3:
            self.currentIndex = 4
            if  profileCompletionModel?[indexPath].status == true {
                cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion4")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    cell.viewLine.layer.backgroundColor = UIColor.init(hexString: "#00cc00").cgColor
                }
            }else {
                cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
                }
            }
            //  self.tblViewProfileCompletion.reloadData()
        case 4:
            self.currentIndex = 5
            if  profileCompletionModel?[indexPath].status == true {
                cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion5")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    cell.viewLine.layer.backgroundColor = UIColor.init(hexString: "#00b300").cgColor
                }
            }else {
                cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
                }
            }
            //  self.tblViewProfileCompletion.reloadData()
        case 5:
            self.currentIndex = 6
            if  profileCompletionModel?[indexPath].status == true {
                cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion6")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    cell.viewLine.layer.backgroundColor = UIColor.init(hexString: "#00b300").cgColor
                }
            }else {
                cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
                }
            }
            //  self.tblViewProfileCompletion.reloadData()
        case 6:
            self.currentIndex = 7
            if  profileCompletionModel?[indexPath].status == true {
                cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion6")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    cell.viewLine.layer.backgroundColor = UIColor.init(hexString: "#00b300").cgColor
                }
            }else {
                cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
                }
            }
            //  self.tblViewProfileCompletion.reloadData()
            
        default:
            cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
            }
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch profileCompletionModel?[indexPath.row].title{
        case ProfileCompletion.HubSelection :
            if profileCompletionModel?[indexPath.row].status == true{
                let nextVC = ConfirmSelectionVC()
                nextVC.isEditHub = true
                editHubValue = "2"
                self.navigationController?.pushViewController(nextVC, animated: true)
            }else{
                let nextVC = CountryListVC()
                nextVC.isEditHub = true
                editHubValue = "1"
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        case ProfileCompletion.ContactInfo:
            print("Contact")
            contactFromVC = .profileCompletion
            self.performSegue(withIdentifier: "segueProfileTabToContactDetail", sender: self)
            
        case ProfileCompletion.FeaturedProducts, ProfileCompletion.FeaturedRecipe, ProfileCompletion.FeaturedPackages:
            self.addFeaturedProductButtonTapped(UIButton())
            
        case ProfileCompletion.ProfilePicture, ProfileCompletion.CoverImage:
            
            
            let storyboard1 = UIStoryboard(name: StoryBoardConstants.kUpdateProfile, bundle: nil)
            guard let nextVC = storyboard1.instantiateViewController(identifier:  UpdateProfileCoverImgVC.id()) as?  UpdateProfileCoverImgVC else{return}
            nextVC.passprofilePicUrl = self.progressUserData?.avatarid?.attachmenturl
            nextVC.passImagebaseUrl = self.progressUserData?.avatarid?.baseUrl
            nextVC.passCoverPicUrl = self.progressUserData?.coverid?.attachmenturl
            nextVC.passCoverbaseUrl = self.progressUserData?.coverid?.baseUrl
            self.viewWillAppear(true)
            nextVC.imagePickerCallback = {
                self.postRequestToGetProgress()
            }
            self.navigationController?.present(nextVC, animated: true, completion: nil)
            
        case ProfileCompletion.Ourtrips, ProfileCompletion.OurProducts, ProfileCompletion.About, ProfileCompletion.OurMenu, ProfileCompletion.Ourtours :
            
            let storyboard1 = UIStoryboard(name: StoryBoardConstants.kUpdateProfile, bundle: nil)
            guard let nextVC = storyboard1.instantiateViewController(identifier:  UpdateProfileDescVC.id()) as? UpdateProfileDescVC else{return}
            nextVC.passUserFieldId = profileCompletionModel?[indexPath.row].user_field_id
            nextVC.passheaderTitle =  profileCompletionModel?[indexPath.row].title
            self.navigationController?.pushViewController(nextVC, animated: true)
        default:
            guard let controller = self.storyboard?.instantiateViewController(identifier: "EditProfileViewC") as? EditProfileViewC else {return}
            controller.signUpViewModel = self.signUpViewModel
            controller.userType = self.userType ?? .voyagers
            controller.fromProfileCompletion = true
            if profileCompletionModel?[indexPath.row].title == ProfileCompletion.ProfilePicture {
                controller.forProfileCompletionProfile = true
                controller.forProfileCompletionCover = false
            }else if profileCompletionModel?[indexPath.row].title == ProfileCompletion.CoverImage {
                controller.forProfileCompletionCover = true
                controller.forProfileCompletionProfile = false
            }
            
            self.editProfileViewCon = controller
            
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
    }
}



extension ProfileViewC{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueProfileTabToContactDetail" {
            if let viewCon = segue.destination as? ContactDetailViewController {
                viewCon.userType = self.userType
                //  viewCon.countryId = progressUserData?.country?.id
                viewCon.phoneCode = progressUserData?.country?.countryPhonecode
                viewCon.Countryname = progressUserData?.country?.name
                viewCon.viewModel = UserProfile.contactTab(website: self.contactDetilViewModel.website, address: self.contactDetilViewModel.address, email: self.contactDetilViewModel.email, country_code: self.contactDetilViewModel.country_code, phone: self.contactDetilViewModel.phone, roleID: self.contactDetilViewModel.roleID, userID: self.contactDetilViewModel.roleID, fbLink: self.contactDetilViewModel.fbLink)
                //   viewCon.viewModel = ContactDetail.Contact.ViewModel(response: self.contactDetilViewModel)
            }
        }
        
        if segue.identifier == "segueProfileTabToBasicConnection" {
            if let viewCon = segue.destination as? BasicConnectFlowViewController {
                var username = ""
                
                if self.userProfileModel.data?.userData?.firstName == nil && self.userProfileModel.data?.userData?.companyName == nil{
                    
                    username = self.userProfileModel.data?.userData?.restaurantName ?? ""
                    
                } else if self.userProfileModel.data?.userData?.firstName == nil && self.userProfileModel.data?.userData?.restaurantName == nil{
                    
                    username = self.userProfileModel.data?.userData?.companyName ?? ""
                    
                } else if self.userProfileModel.data?.userData?.restaurantName == nil && self.userProfileModel.data?.userData?.companyName == nil{
                    
                    username = self.userProfileModel.data?.userData?.firstName ?? ""
                    
                }
                
                let profileID = (self.userProfileModel.data?.userData?.userID) ?? (self.userID) ?? 1
                viewCon.userModel = BasicConnectFlow.userDataModel(userID: profileID,
                                                                   username: username)
            }
        }
    }
    
    override func didUserGetData(from result: Any, type: Int) {
        
        switch  type {
        case 2:
            
            var arrSelectedFields: [ProductFieldsDataModel] = []
            let dicResult = kSharedInstance.getDictionary(result)
            let dicData = kSharedInstance.getDictionary(dicResult[APIConstants.kData])
            if let fields = dicData[APIConstants.kFields] as? ArrayOfDictionary{
                arrSelectedFields = fields.map({ProductFieldsDataModel(withDictionary: $0)})
            }
            
            //self.postRequestToUpdateUserProfile()
            let controller = self.pushViewController(withName: AddFeatureViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? AddFeatureViewC
            controller?.userLevel = self.userLevel
            controller?.arrSelectedFields = arrSelectedFields
            controller?.featureListingId = self.featureListingId
            controller?.currentNavigationTitle = self.currentProductTitle
            if userLevel == .other{
                controller?.passRoleID = "\(self.visitorUserType.rawValue ?? 0)"
            }else{
                controller?.passRoleID = kSharedUserDefaults.loggedInUserModal.memberRoleId
            }
            // controller?.delegate = self
        default:
            self.tblViewPosts.isUserInteractionEnabled = true
            if editProfileViewCon == nil {
                //            self.initiateEditProfileViewController()
            }
            
            let dicResult = kSharedInstance.getDictionary(result)
            let dicData = kSharedInstance.getDictionary(dicResult[APIConstants.kData])
            self.signUpViewModel = SignUpViewModel(dicData, roleId: nil)
            editProfileViewCon?.signUpViewModel = self.signUpViewModel
            if ((self.signUpViewModel.arrProductCategories.first?.arrAllProducts.count == 0) && (userLevel == .other)) || (self.userProfileModel.data?.userData?.roleID) == 10 {
                self.featureUIview.constant = 0
                self.viewFeature.isHidden = true
            } else {
                self.featureUIview.constant = 140
                self.viewFeature.isHidden = false
            }
            self.collectionViewAddProduct.reloadData()
            editProfileViewCon?.userType = self.userType ?? .voyagers
            editProfileViewCon?.tableViewEditProfile?.reloadData()
            print("Some")
            
        }
        
    }
    
    
}
extension ProfileViewC: ContactViewEditProtocol {
    func editContactDetail() {
        self.performSegue(withIdentifier: "segueProfileTabToContactDetail", sender: self)
    }
}

//extension ProfileViewC: AddFeaturedProductCallBack {
//    func productAdded() {
//    }
//
//}

//MARK:- connection request module
extension ProfileViewC {
    func connectButtonTapped() {
        
        if self.userType != .voyagers {
            let connectionStatus = self.userProfileModel.data?.userData?.connectionFlag ?? 0
            if connectionStatus == 0 {
                // self.performSegue(withIdentifier: "segueProfileTabToBasicConnection", sender: nil)
                let controller = pushViewController(withName: ConnectionProductTypeViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as? ConnectionProductTypeViewController
                var pusername = ""
                if self.userProfileModel.data?.userData?.roleID == UserRoles.restaurant.rawValue{
                    pusername = self.userProfileModel.data?.userData?.restaurantName ?? ""
                }else if self.userProfileModel.data?.userData?.roleID == UserRoles.voiceExperts.rawValue || self.userProfileModel.data?.userData?.roleID == UserRoles.voyagers.rawValue{
                    pusername = self.userProfileModel.data?.userData?.firstName ?? ""
                }else{
                    pusername = self.userProfileModel.data?.userData?.companyName ?? ""
                }
                
                controller?.userName = pusername
                controller?.userID = self.userID
            } else if connectionStatus == 2 {
                let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
                let cancelConnectionRequestAction = UIAlertAction(title: AppConstants.kCancelRequest, style: .default) { action in
                    self.cancelConnectionRequest()
                }
                cancelConnectionRequestAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
                
                var title = AppConstants.Block
                if self.userProfileModel.data?.userData?.blockFlag ?? 0 == 0 {
                    title = AppConstants.Block
                } else {
                    title = AppConstants.UnBlock
                }
                
                let blockUserAction = UIAlertAction(title: title, style: .destructive) { action in
                    self.blockUserFromConnectionRequest(ProfileScreenModels.BlockConnectRequest(userID: self.userID))
                }
                blockUserAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
                
                
                let cancelAction = UIAlertAction(title: MarketPlaceConstant.kCancel, style: .cancel, handler: nil)
                cancelAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
                
                alertController.addAction(cancelConnectionRequestAction)
                alertController.addAction(blockUserAction)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
            }else if connectionStatus == 1 {
                // print("Check")
                let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
                let cancelConnectionRequestAction = UIAlertAction(title: AppConstants.RemoveConnection, style: .default) { action in
                    self.cancelConnectionRequest()
                }
                cancelConnectionRequestAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
                
                var title = AppConstants.Block
                if self.userProfileModel.data?.userData?.blockFlag ?? 0 == 0 {
                    title = AppConstants.Block
                } else {
                    title = AppConstants.UnBlock
                }
                
                let blockUserAction = UIAlertAction(title: title, style: .destructive) { action in
                    self.blockUserFromConnectionRequest(ProfileScreenModels.BlockConnectRequest(userID: self.userID))
                }
                blockUserAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
                
                
                let cancelAction = UIAlertAction(title: MarketPlaceConstant.kCancel, style: .cancel, handler: nil)
                cancelAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
                
                alertController.addAction(cancelConnectionRequestAction)
                alertController.addAction(blockUserAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
            return
        } else if  self.userType == .voyagers && self.visitorUserType == .voyagers{
            self.segueToCompleteConnectionFlow()
        }else if self.userType == .voyagers { //&& self.visitorUserType != .voyagers {
            let followStatus = (self.userProfileModel.data?.userData?.followFlag ?? 0) == 1 ? 0 : 1
            let model = ProfileScreenModels.VoyagersConnectRequest(userID: self.userID, followStatus: followStatus)
            self.voyagersFollwUnFollowRequest(model)
        }
    }
    
    func voyagersFollwUnFollowRequest(_ model: ProfileScreenModels.VoyagersConnectRequest) {
        do {
            let urlString = APIUrl.Connection.sendFollowRequest
            guard var request = WebServices.shared.buildURLRequest(urlString, method: .POST) else {
                return
            }
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = model.urlEncoded()
            
            WebServices.shared.request(request) { data, URLResponse, statusCode, error in
                
                
                if statusCode == 200 {
                    print("Success---------------------------Successssss")
                    self.fetchVisiterProfileDetails(self.userID)
                } else if statusCode == 409 {
                    
                    do {
                        //create json object from data
                        if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any] {
                            print(json)
                        }
                    } catch let error {
                        print(error.localizedDescription)
                    }
                    
                    
                    self.showAlert(withMessage: "Error")
                }
                
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func cancelConnectionRequest() {
        
        let params: [String:Any] = [:]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kotherAcceptReject+"visitor_profile_id="+String.getString(self.userID ?? -1)+"&accept_or_reject=3", requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            if statusCode == 200 {
                self.fetchVisiterProfileDetails(self.userID)
            }
            
        }
    }
    
    func blockUserFromConnectionRequest(_ model: ProfileScreenModels.BlockConnectRequest) {
        let urlString = "\(APIUrl.Connection.blockConnectionRequest)"
        guard var request = WebServices.shared.buildURLRequest(urlString, method: .POST) else {
            return
        }
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = model.urlEncoded()
        
        WebServices.shared.request(request) { data, URLResponse, statusCode, error in
            print("Success---------------------------Successssss")
            self.fetchVisiterProfileDetails(self.userID)
        }
    }
    
    func respondButtonTapped() {
        
        let alert:UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        // acceptAction
        let acceptAction = UIAlertAction(title: MarketPlaceConstant.kAcceptRequest,
                                         style: UIAlertAction.Style.default) { (action) in
            
            self.inviteApi(id: self.userID, type: 1)
            
        }
        let checkMarkImage = UIImage(named: "Group 382")?.withRenderingMode(.alwaysOriginal)
        acceptAction.setValue(checkMarkImage, forKey: "image")
        acceptAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        // declineAction
        let deleteAction = UIAlertAction(title: AppConstants.kDeclineRequest,
                                         style: UIAlertAction.Style.default) { (action) in
            // self.inviteApi(id: self.userID, type: 2)
            
            let vc = self.pushViewController(withName: DeclineRequest.id(), fromStoryboard: StoryBoardConstants.kHome) as! DeclineRequest
            vc.visitordId = self.userID
            
            
        }
        let deleteImage = UIImage(named: "Group 636")?.withRenderingMode(.alwaysOriginal)
        deleteAction.setValue(deleteImage, forKey: "image")
        deleteAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        // blockAction
        let blockAction = UIAlertAction(title: AppConstants.Block,
                                        style: UIAlertAction.Style.default) { (action) in
            print("\(AlertMessage.kCancel) tapped")
        }
        let blockImage = UIImage(named: "block_icon")?.withRenderingMode(.alwaysOriginal)
        blockAction.setValue(blockImage, forKey: "image")
        blockAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        // cancelAction
        let cancelAction = UIAlertAction(title: MarketPlaceConstant.kCancel,
                                         style: UIAlertAction.Style.cancel) { (action) in
            print("\(AlertMessage.kCancel) tapped")
        }
        
        alert.addAction(acceptAction)
        alert.addAction(deleteAction)
        alert.addAction(blockAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func messageButtonTapped() {
        showAlert(withMessage: "Message functionality will be implemented here")
    }
}
extension ProfileViewC {
    private func postRequestToGetFeatureListing(_ featureListingId: String,navigationTitle: String) -> Void{
        
        self.featureListingId = featureListingId
        self.currentProductTitle = navigationTitle
        
        CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kGetFeatureListing + featureListingId, method: .GET, controller: self, type: 2, param: [:], btnTapped: UIButton())
    }
}
extension ProfileViewC: AddFeaturedProductCallBack {
    func productAdded() {
        print("Push------")
    }
    
    
    func tappedAddProduct(withProductCategoriesDataModel model: ProductCategoriesDataModel, featureListingId: String?) {
        if featureListingId == nil{
            //self.postRequestToUpdateUserProfile()
            let controller = pushViewController(withName: AddFeatureViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? AddFeatureViewC
            controller?.productCategoriesDataModel = model
            controller?.delegate = self
            if userLevel == .other {
                controller?.passRoleID = "\(self.visitorUserType.rawValue ?? 0)"
            }else{
                controller?.passRoleID = kSharedUserDefaults.loggedInUserModal.memberRoleId
            }
        }
        else{
            self.postRequestToGetFeatureListing(String.getString(featureListingId), navigationTitle: String.getString(model.title))
        }
    }
}


extension UITabBarController {
    
    func addSubviewToLastTabItem(_ image: UIImage) {
        
        if let lastTabBarButton = self.tabBar.subviews.last, let tabItemImageView = lastTabBarButton.subviews.first {
            if let accountTabBarItem = self.tabBar.items?.last {
                accountTabBarItem.selectedImage = nil
                accountTabBarItem.image = nil
            }
            let imgView = UIImageView()
            imgView.frame = tabItemImageView.frame
            imgView.layer.cornerRadius = tabItemImageView.frame.height/2
            imgView.layer.masksToBounds = true
            imgView.contentMode = .scaleAspectFill
            imgView.clipsToBounds = true
            imgView.image = image
            self.tabBar.subviews.last?.addSubview(imgView)
        }
    }
}

extension ProfileViewC : CoachMarksControllerDataSource, CoachMarksControllerDelegate{
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.voiceExperts.rawValue)" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.voyagers  .rawValue)"{
            return 3
        }else{
        return 5
        }
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
        
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        
        switch index {
            
        case 0:
            switch kSharedUserDefaults.loggedInUserModal.memberRoleId{
            case "3", "4", "5", "6":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kProducerImpDistPic
            case "7":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kVoiceofExpertsPic
            case "8":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kTravelAgenciesPic
            case "9":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kRestaurantPic
                
            case "10":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kVoyagersPic
            default: break
                
            }
            coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
        case 1:
            switch kSharedUserDefaults.loggedInUserModal.memberRoleId{
            case "3", "4", "5", "6":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kProducerImpDistCover
            case "7":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kVoiceofExpertsCover
            case "8":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kTravelAgenciesCover
            case "9":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kRestaurantCover
                
            case "10":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kVoyagersCover
            default: break
                
            }
            coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
        case 2:
            switch kSharedUserDefaults.loggedInUserModal.memberRoleId{
            case "3", "4", "5", "6":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kProducerImporterDistributor
            case "7":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kVoiceofExperts
            case "8":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kTravelAgencies
            case "9":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kRestaurant
                
            case "10":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kVoyagers
            default: break
            }
            coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
        case 3:
            switch kSharedUserDefaults.loggedInUserModal.memberRoleId {
            case "3":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kProducerField
            case "4","5","6":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kImporterDistField
            case "8":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kTravelAgenciesField
            case "9":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kRestaurantField
            default:
                break
                
            }
            
           
            coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
            
        case 4:
            switch kSharedUserDefaults.loggedInUserModal.memberRoleId {
            case "3","4","5","6":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kProducerImpDistFeatured
           // case "7":
            //    coachViews.bodyView.hintLabel.text = TourGuideConstants.kVoiceofExpertsFeatured
            case "8":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kTravelAgenciesFeatured
            case "9":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kRestaurantFeatured
            default:
                break
                
            }
            coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
            
        default: break
        }
        
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController,
                              coachMarkAt index: Int) -> CoachMark {
        
        switch index {
            
        case 0: return coachMarksController.helper.makeCoachMark(for: self.tblViewProfileCompletion.cellForRow(at: IndexPath(row: 1, section: 0)))
        case 1:
            return coachMarksController.helper.makeCoachMark(for: self.tblViewProfileCompletion.cellForRow(at: IndexPath(row: 2, section: 0)))
        case 2:
            
            
            if MobileDeviceType.IS_IPHONE_6 == true {
                let IndexP = IndexPath(row: 4, section: 0)
                tblViewProfileCompletion.scrollToRow(at: IndexP, at: .none, animated: true)
                return coachMarksController.helper.makeCoachMark(for: self.tblViewProfileCompletion.cellForRow(at: IndexPath(row: 2, section: 0)))
            }
            else{
                return coachMarksController.helper.makeCoachMark(for: self.tblViewProfileCompletion.cellForRow(at: IndexPath(row: 3, section: 0)))
            }
            
        case 3:
            
            if MobileDeviceType.IS_IPHONE_6 == true {
                let IndexP = IndexPath(row: ((profileCompletionModel?.count ?? 1) - 1), section: 0)
                tblViewProfileCompletion.scrollToRow(at: IndexP, at: .none, animated: true)
                return coachMarksController.helper.makeCoachMark(for: self.tblViewProfileCompletion.cellForRow(at: IndexPath(row: 2, section: 0)))
            }else{
                if (profileCompletionModel?.count ?? 0) > 5 {
                let IndexP = IndexPath(row: 3, section: 0)
                
                if let theCell = tblViewProfileCompletion.cellForRow(at: IndexP) as? ProfileCompletionTableViewCell {
                       var tableViewCenter:CGPoint = tblViewProfileCompletion.contentOffset
                       tableViewCenter.y += tblViewProfileCompletion.frame.size.height/2

                    tblViewProfileCompletion.contentOffset = CGPoint(x: 0, y: theCell.center.y-55)
                    tblViewProfileCompletion.reloadData()
                   }
                }
                return coachMarksController.helper.makeCoachMark(for: self.tblViewProfileCompletion.cellForRow(at: IndexPath(row: Int(4), section: 0)))
            }
            
        case 4:
                    
            return coachMarksController.helper.makeCoachMark(for: self.tblViewProfileCompletion.cellForRow(at: IndexPath(row: ( (profileCompletionModel?.count ?? 1) - 1), section: 0)))
        default:
            return coachMarksController.helper.makeCoachMark()
        }
    }
    
    
    func coachMarksController(_ coachMarksController: CoachMarksController, didEndShowingBySkipping skipped: Bool) {
        AppManager.setUserSeenAppInstructionProfile()
        self.tabBarController?.tabBar.backgroundColor = .white
        self.tabBarController?.tabBar.alpha = 1.0
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
    }
    
}
