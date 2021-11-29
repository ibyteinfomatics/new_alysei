//
//  ProfileViewC.swift
//  Alysie
//
//  Created by Alendra Kumar on 18/01/21.
//

import UIKit
import SVProgressHUD

var check = "";


class ProfileViewC: AlysieBaseViewC{
    
    //MARK: - IBOutlet -
    
    // blank data view
    @IBOutlet weak var text: UILabel!
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
    
   // @IBOutlet weak var featureCollectionView: UICollectionView!
    
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
    
    var someHeight: Int = 1
    var shownumber = 50
    
    var profileCompletionModel: [ProfileCompletionModel]?
    
    //MARK: GetFeature Listing Data
    var featureListingId: String?
    var currentProductTitle: String?
    
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
        return contactViewC
    }()
    
    private lazy var awardViewC: AwardsViewController = {
        
        let awardViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: AwardsViewController.id()) as! AwardsViewController
        awardViewC.userId = String.getString(userID)
        return awardViewC
    }()
    //MARK: - ViewLifeCycle Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnEditProfile.layer.cornerRadius = 0.0
        self.viewSeparator.alpha = 0.0
        
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "10"{
            followerstext.text = "Following"
        } else {
            followerstext.text = "Followers"
        }
      
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
        
        
        self.tblViewPosts.contentInsetAdjustmentBehavior = .never
        
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
        
        //self.btnBack.isHidden = userLevel == .other ? false : true
        switch self.userLevel {
        case .own:
            print("own")
            self.btnEditProfile.isHidden = false
            self.backButton.isHidden = true
            self.btnEditProfile.isUserInteractionEnabled = true
            self.postRequestToGetProgress()
            if self.userType == .voyagers {
                self.featureUIview.constant = 0
            } else {
                self.featureUIview.constant = 140
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
    
    func inviteApi(id: Int, type: Int){
        
        let params: [String:Any] = [:]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kotherAcceptReject+"visitor_profile_id="+String.getString(userID)+"&accept_or_reject="+String.getString(type), requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            self.fetchVisiterProfileDetails(self.userID)
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
        
       
        setNeedsStatusBarAppearanceUpdate()
        if fromRecipe == ""{
        self.tabBarController?.tabBar.isHidden = false
        }
        let data = kSharedUserDefaults.getLoggedInUserDetails()
        
        
        let role = Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId)
        
        if role != 10 {
            
            if Int.getInt(data["alysei_review"]) == 0 {
                blankdataView.isHidden = false
            } else if Int.getInt(data["alysei_review"]) == 1{
                
                blankdataView.isHidden = true
                self.postRequestToGetFields()
               // self.fetchContactDetail()
               // self.fetchProfileDetails()
                self.currentIndex = 0
                self.postRequestToGetProgress()
                if check == "" {
                    if self.userLevel == .own {
                        self.menuButton.isHidden = false
                        self.fetchProfileDetails()
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
            self.postRequestToGetFields()
           // self.fetchContactDetail()
           // self.fetchProfileDetails()
            self.currentIndex = 0
            self.postRequestToGetProgress()
            if check == "" {
                if self.userLevel == .own {
                    self.menuButton.isHidden = false
                    self.fetchProfileDetails()
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
                cell.imageView.tintColor = UIColor(named: "blueberryColor")
            }
        }

        
        // Scroll update show
        let line = self.aboutLabel.calculateMaxLines()
        
        
        if line == 5 {
            shownumber = 50
        } else if line == 4 {
            shownumber = 90
        } else if line == 3 {
            shownumber = 110
        } else if line == 2 {
            shownumber = 130
        } else if line == 1 {
            shownumber = 150
        }
        
        
        self.tblViewPosts.tableHeaderView?.setHeight(CGFloat(someHeight) - CGFloat(shownumber))
        
        self.tblViewPosts.contentInsetAdjustmentBehavior = .always
        
    }
    
    
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
        self.moveToNew(childViewController: self.photosViewcontroller, fromController: self.currentChild)
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
        
    }
    
    @IBAction func respondButtonTapped(_ sender: UIButton) {
        self.respondButtonTapped()
    }
    
    @IBAction func connectButtonTapped(_ sender: UIButton) {
        //mark:- Producer to importert
        if (kSharedUserDefaults.loggedInUserModal.memberRoleId == String.getString(UserRoles.producer.rawValue)) && (self.visitorUserType == .distributer1 || self.visitorUserType == .distributer2 || self.visitorUserType == .distributer3) {
            
            if percentage == "100" || percentage == nil{
                self.connectButtonTapped()
            } else {
                self.tabBarController?.selectedIndex = 4
            }
            
            return
            // Mark: - producer to other user
        } else if (kSharedUserDefaults.loggedInUserModal.memberRoleId == String.getString(UserRoles.producer.rawValue)) && (self.visitorUserType == .restaurant || self.visitorUserType == .travelAgencies || self.visitorUserType == .voiceExperts || self.visitorUserType == .producer){
            
            self.segueToCompleteConnectionFlow()
            
            
        } else if (kSharedUserDefaults.loggedInUserModal.memberRoleId == String.getString(UserRoles.voiceExperts.rawValue)) {
           
            self.segueToCompleteConnectionFlow()
            
        }else if (kSharedUserDefaults.loggedInUserModal.memberRoleId == String.getString(UserRoles.distributer1.rawValue)) || (kSharedUserDefaults.loggedInUserModal.memberRoleId == String.getString(UserRoles.distributer2.rawValue)) || (kSharedUserDefaults.loggedInUserModal.memberRoleId == String.getString(UserRoles.distributer3.rawValue)){
            
            self.segueToCompleteConnectionFlow()
            
            
        } else if (kSharedUserDefaults.loggedInUserModal.memberRoleId == String.getString(UserRoles.restaurant.rawValue)) {
            self.segueToCompleteConnectionFlow()
            
            
        } else if (kSharedUserDefaults.loggedInUserModal.memberRoleId == String.getString(UserRoles.travelAgencies.rawValue)) {
            self.segueToCompleteConnectionFlow()
            
            
        } else {
            if percentage == "100" || percentage == nil{
                let profileID = (self.userProfileModel.data?.userData?.userID) ?? (self.userID) ?? 1
                
                if self.connectButton.titleLabel?.text == "Follow" {
                    followUnfollow(id: profileID, type: 1)
                } else if self.connectButton.titleLabel?.text == "Unfollow" {
                    followUnfollow(id: profileID, type: 0)
                } else {
                    self.connectButtonTapped()
                }
            } else {
                self.tabBarController?.selectedIndex = 4
                self.segueToCompleteConnectionFlow()
            }
        }
    }
    
    private func segueToCompleteConnectionFlow() {
       
        let connectionStatus = self.userProfileModel.data?.userData?.connectionFlag ?? 0
        
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
            
            let cancelConnectionRequestAction = UIAlertAction(title: "Cancel Request", style: .default) { action in
                self.cancelConnectionRequest()
            }
            cancelConnectionRequestAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            var title = "Block"
            if self.userProfileModel.data?.userData?.blockFlag ?? 0 == 0 {
                title = "Block"
            } else {
                title = "UnBlock"
            }
            
            let blockUserAction = UIAlertAction(title: title, style: .destructive) { action in
                self.blockUserFromConnectionRequest(ProfileScreenModels.BlockConnectRequest(userID: self.userID))
            }
            blockUserAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            cancelAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            alertController.addAction(cancelConnectionRequestAction)
            alertController.addAction(blockUserAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else if connectionStatus == 1 {
            
            
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let cancelConnectionRequestAction = UIAlertAction(title: "Remove Connection", style: .default) { action in
                self.cancelConnectionRequest()
            }
            cancelConnectionRequestAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            var title = "Block"
            if self.userProfileModel.data?.userData?.blockFlag ?? 0 == 0 {
                title = "Block"
            } else {
                title = "UnBlock"
            }
            
            let blockUserAction = UIAlertAction(title: title, style: .destructive) { action in
                self.blockUserFromConnectionRequest(ProfileScreenModels.BlockConnectRequest(userID: self.userID))
            }
            blockUserAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            cancelAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            alertController.addAction(cancelConnectionRequestAction)
            alertController.addAction(blockUserAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            
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
                var title = "Connect"
                switch connectionFlag {
                case 0:
                    title = "Connect"
                case 1:
                    title = "Connected"
                case 2:
                    title = "Pending"
                default:
                    title = "Connect"
                }
                self.connectButton.setTitle("\(title)", for: .normal)
            } else if self.userType == .voyagers {
                
                if self.visitorUserType == .voyagers {
                                    //let title = (self.userProfileModel.data?.userData?.connectionFlag ?? 0) == 1 ? "Connected" : "Pending"
                                    //self.connectButton.setTitle("\(title)", for: .normal)
                                    var title = "Connect"
                                    switch connectionFlag {
                                    case 0:
                                        title = "Connect"
                                    case 1:
                                        title = "Connected"
                                    case 2:
                                        title = "Pending"
                                    default:
                                        title = "Connect"
                                    }
                                    self.connectButton.setTitle("\(title)", for: .normal)
                                    
                                } else {
                                    let title = (self.userProfileModel.data?.userData?.followFlag ?? 0) == 1 ? "Unfollow" : "Follow"
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
    private func initialSetUp(_ profileImage: String , _ coverImage: String) -> Void{
        
        self.imgViewCover.image = UIImage(named: "coverPhoto")
        self.imgViewProfile.image = UIImage(named: "profile_icon")
        let imgUrl = (kImageBaseUrl + coverImage)
        self.imgViewCover.setImage(withString: imgUrl)
        let imgPUrl = (kImageBaseUrl + profileImage)
        if imgPUrl != "" {
            self.imgViewProfile.setImage(withString: imgPUrl)
            self.imgViewProfile.layer.cornerRadius = (self.imgViewProfile.frame.width / 2.0)
            self.imgViewProfile.layer.borderWidth = 5.0
            
            switch self.userType {
            case .distributer1, .distributer2, .distributer3:
                self.lbladdproduct.text = "Add Product"
                self.imgViewProfile.layer.borderColor = UIColor.init(hexString: RolesBorderColor.distributer1.rawValue).cgColor
            case .producer:
                self.lbladdproduct.text = "Add Product"
                self.imgViewProfile.layer.borderColor = UIColor.init(hexString: RolesBorderColor.producer.rawValue).cgColor
            case .travelAgencies:
                self.lbladdproduct.text = "Add Package"
                self.imgViewProfile.layer.borderColor = UIColor.init(hexString: RolesBorderColor.travelAgencies.rawValue).cgColor
            case .voiceExperts:
                self.lbladdproduct.text = "Add Featured"
                self.imgViewProfile.layer.borderColor = UIColor.init(hexString: RolesBorderColor.voiceExperts.rawValue).cgColor
            case .voyagers:
                self.imgViewProfile.layer.borderColor = UIColor.init(hexString: RolesBorderColor.voyagers.rawValue).cgColor
            case .restaurant :
                self.lbladdproduct.text = "Add Menu"
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
        cell.imageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        cell.imageView.tintColor = UIColor(named: "grey2")
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
                self.view.isUserInteractionEnabled = true
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
        switch self.userType {
        case .distributer1, .distributer2, .distributer3, .producer:
            self.featuredListingTitleLabel.text = "Featured Product"
        case .restaurant:
            self.featuredListingTitleLabel.text = "Featured Menu"
        case .travelAgencies:
            self.featuredListingTitleLabel.text = "Featured Packages"
        case .voiceExperts:
            self.featuredListingTitleLabel.text = "Featured"
        default:
            print("no user role found")
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
                let userPercentage = responseModel.data?.userData?.profilePercentage ?? 0
                if (userPercentage == ProfilePercentage.percent100.rawValue) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                        self.tblViewProfileCompletion.isHidden = true
                        self.headerView.isHidden = false
                        self.tblViewPosts.isHidden = false
                    }
                }else{
                    self.tblViewProfileCompletion.isHidden = false
                    self.headerView.isHidden = true
                    self.tblViewPosts.isHidden = true
                
                }
                
                kSharedUserDefaults.loggedInUserModal.firstName = responseModel.data?.userData?.firstName
                kSharedUserDefaults.loggedInUserModal.lastName = responseModel.data?.userData?.lastName
                
                kSharedUserDefaults.synchronize()
                self.initialSetUp(responseModel.data?.userData?.avatar?.imageURL ?? "", responseModel.data?.userData?.cover?.imageURL ?? "")
                
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
                
                
            } catch {
                print(error.localizedDescription)
            }
            if (error != nil) { print(error.debugDescription) }
        }
        
    }
    func setPercentageUI(_ userPercentage: String ){
        //let userPercentage = responseModel.data?.userData?.profilePercentage ?? 0
        self.percentageLabel.text = "\(userPercentage )% completed"
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
                print(responseModel)
                self.userProfileModel = responseModel
                
                self.postcount.text = String.getString(responseModel.data?.postCount)
                                self.connectioncount.text = String.getString(responseModel.data?.connectionCount)
                                
                                
                                if kSharedUserDefaults.loggedInUserModal.memberRoleId == "10"{
                                    self.followercount.text = String.getString(responseModel.data?.followingcount)
                                } else {
                                    self.followercount.text = String.getString(responseModel.data?.followerCount)
                                }
                
                //self.postcount.text = String.getString(responseModel.data?.postCount)
                //self.followercount.text = String.getString(responseModel.data?.followerCount)
                
                if kSharedUserDefaults.loggedInUserModal.memberRoleId == "10"{
                    self.featureUIview.constant = 0
                    self.followercount.text = String.getString(responseModel.data?.followingcount)
                } else {
                    self.featureUIview.constant = 140
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
                
                if self.userProfileModel.data?.userData?.connectionFlag == 1 || self.userProfileModel.data?.userData?.followFlag == 1 ||  self.userProfileModel.data?.userData?.whoCanViewProfile == "anyone"{
                                    self.tabsCollectionView.reloadData()
                                    self.tabsCollectionView.isHidden = false
                                    self.containerView.isHidden = false
                                } else {
                                    self.tabsCollectionView.isHidden = true
                                    self.containerView.isHidden = true
                                }
                
                var name = ""
                switch roleID {
                case .distributer1, .distributer2, .distributer3, .producer, .travelAgencies :
                    name = "\(responseModel.data?.userData?.companyName ?? "")"
                case .restaurant :
                    name = "\(responseModel.data?.userData?.restaurantName ?? "")"
                default:
                    name = "\(responseModel.data?.userData?.firstName ?? "") \(responseModel.data?.userData?.lastName ?? "")"
                }
                
                self.userType = roleID
                self.lblDisplayName.text = "\(name)".capitalized
                self.lblDisplayNameNavigation.text = "\(name)".capitalized
                self.headerView.isHidden = true
                self.tblViewPosts.isHidden = false
                self.initialSetUp(responseModel.data?.userData?.avatar?.imageURL ?? "", responseModel.data?.userData?.cover?.imageURL ?? "")
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
                        self.messageButton.isHidden = false
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
        //cell.delegate = self
        cell.configure(indexPath, currentIndex: self.currentIndex)
        cell.lbleTitle.text = profileCompletionModel?[indexPath.row].title
        cell.viewLine.isHidden = (indexPath.row == ((profileCompletionModel?.count ?? 0) - 1)) ? true : false
        cell.animationCallback = { currentIndex, cell in
        self.animateViews(indexPath.row , cell: cell)
        }
        return cell
    }

    private func postRequestToGetFields() -> Void{
        
        disableWindowInteraction()
        CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kUserSubmittedFields+"/"+String.getString(userID), method: .GET, controller: self, type: 0, param: [:], btnTapped: UIButton())
    }
    //MARK:- HandleViewTap
    
    @objc func handleTap(_ sender: UITapGestureRecognizer){
        guard let controller = self.storyboard?.instantiateViewController(identifier: "ProfileCompletionViewController") as? ProfileCompletionViewController else {return}
        controller.percentage = percentage
        controller.signUpViewModel = self.signUpViewModel
        controller.userType = self.userType ?? .voyagers
        self.navigationController?.pushViewController(controller, animated: true)
        
        
        
    }
    //MARK:  - WebService Methods -
    
    func followUnfollow(id: Int, type: Int){
        
        let params: [String:Any] = [
            "follow_user_id": id,
            "follow_or_unfollow": type]
        
        disableWindowInteraction()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kFollowUnfollow, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictRespnose, error, errorType, statusCode) in
            
            if self.connectButton.titleLabel?.text == "Follow" {
                
                self.connectButton.setTitle("Unfollow", for: .normal)
            } else if self.connectButton.titleLabel?.text == "Unfollow" {
                self.connectButton.setTitle("Follow", for: .normal)
            }
        }
        
    }
    
    private func postRequestToGetProgress() -> Void{
        
        disableWindowInteraction()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kProfileProgress, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictRespnose, error, errorType, statusCode) in
            let response = dictRespnose as? [String:Any]
            
            if let data = response?["data_progress"] as? [[String:Any]]{
                let profileArray = kSharedInstance.getArray(withDictionary: data)
                self.profileCompletionModel = profileArray.map{ProfileCompletionModel(with: $0)}
                
            }
        
            if let perData = response?["data"] as? [String:Any]{
                self.percentage = perData["profile_percentage"] as? String
                self.setPercentageUI(self.percentage ?? "0")
                self.progressUserData = UserData.init(with: perData)
                
                if let progUserData = perData["user_details"] as? [String:Any]{
                    self.progressUserData = UserData.init(with: progUserData)
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
                cell.imageView.tintColor = UIColor(named: "blueberryColor")

                self.tabsCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
                

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
            self.postRequestToGetFeatureListing(product?.featuredListingId ?? "", navigationTitle: "Featured Product")
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
                cell.imageView.tintColor = UIColor(named: "grey2")
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
            let height = (500.0 + (self.view.frame.height * 0.75) + ((UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0) * 4.0))
            return height
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
            self.tblViewProfileCompletion.reloadData()
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
            self.tblViewProfileCompletion.reloadData()
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
            self.tblViewProfileCompletion.reloadData()
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
            self.tblViewProfileCompletion.reloadData()
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
            self.tblViewProfileCompletion.reloadData()
        case 5:
            self.currentIndex = 6
            if  profileCompletionModel?[indexPath].status == true {
                    cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion6")
            }else {
                    cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
                    }
            }
            self.tblViewProfileCompletion.reloadData()
        case 6:
            self.currentIndex = 7
            if  profileCompletionModel?[indexPath].status == true {
                    cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion6")
            }else {
                    cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
                    }
            }
            self.tblViewProfileCompletion.reloadData()
        default:
            print("Invalid Cell")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch profileCompletionModel?[indexPath.row].title{
        case ProfileCompletion.HubSelection :
            if profileCompletionModel?[indexPath.row].status == true{
                let nextVC = ConfirmSelectionVC()
                nextVC.isEditHub = true
                self.navigationController?.pushViewController(nextVC, animated: true)
            }else{
                let nextVC = CountryListVC()
                nextVC.isEditHub = true
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        case ProfileCompletion.ContactInfo:
            print("Contact")
            self.performSegue(withIdentifier: "segueProfileTabToContactDetail", sender: self)
        case ProfileCompletion.FeaturedProducts, ProfileCompletion.FeaturedRecipe, ProfileCompletion.FeaturedPackages:
            self.addFeaturedProductButtonTapped(UIButton())
            
        case ProfileCompletion.ProfilePicture, ProfileCompletion.CoverImage:
            
            
            let storyboard1 = UIStoryboard(name: StoryBoardConstants.kUpdateProfile, bundle: nil)
            guard let nextVC = storyboard1.instantiateViewController(identifier:  UpdateProfileCoverImgVC.id()) as?  UpdateProfileCoverImgVC else{return}
            nextVC.passprofilePicUrl = self.progressUserData?.avatarid?.attachmenturl
            nextVC.passCoverPicUrl = self.progressUserData?.coverid?.attachmenturl
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
           // controller?.delegate = self
        default:
            
            if editProfileViewCon == nil {
                //            self.initiateEditProfileViewController()
            }
            
            let dicResult = kSharedInstance.getDictionary(result)
            let dicData = kSharedInstance.getDictionary(dicResult[APIConstants.kData])
            self.signUpViewModel = SignUpViewModel(dicData, roleId: nil)
            editProfileViewCon?.signUpViewModel = self.signUpViewModel
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
                
                let cancelConnectionRequestAction = UIAlertAction(title: "Cancel Request", style: .default) { action in
                    self.cancelConnectionRequest()
                }
                cancelConnectionRequestAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
                
                var title = "Block"
                if self.userProfileModel.data?.userData?.blockFlag ?? 0 == 0 {
                    title = "Block"
                } else {
                    title = "UnBlock"
                }
                
                let blockUserAction = UIAlertAction(title: title, style: .destructive) { action in
                    self.blockUserFromConnectionRequest(ProfileScreenModels.BlockConnectRequest(userID: self.userID))
                }
                blockUserAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
                
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                cancelAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
                
                alertController.addAction(cancelConnectionRequestAction)
                alertController.addAction(blockUserAction)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
            }else if connectionStatus == 1 {
                print("Check")
            }
            return
        } else if self.userType == .voyagers { //&& self.visitorUserType != .voyagers {
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
        let urlString = "\(APIUrl.Connection.cancelConnectionRequest)\(self.userID ?? -1)&accept_or_reject=2"
        guard var request = WebServices.shared.buildURLRequest(urlString, method: .POST) else {
            return
        }
        
        WebServices.shared.request(request) { data, URLResponse, statusCode, error in
            print("Success---------------------------Successssss")
            self.fetchVisiterProfileDetails(self.userID)
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
        let acceptAction = UIAlertAction(title: "Accept Request",
                                         style: UIAlertAction.Style.default) { (action) in
            
            self.inviteApi(id: self.userID, type: 1)
            
        }
        let checkMarkImage = UIImage(named: "Group 382")?.withRenderingMode(.alwaysOriginal)
        acceptAction.setValue(checkMarkImage, forKey: "image")
        acceptAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        // deleteAction
        let deleteAction = UIAlertAction(title: "Delete Request",
                                         style: UIAlertAction.Style.default) { (action) in
            self.inviteApi(id: self.userID, type: 2)
        }
        let deleteImage = UIImage(named: "Group 636")?.withRenderingMode(.alwaysOriginal)
        deleteAction.setValue(deleteImage, forKey: "image")
        deleteAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        // blockAction
        let blockAction = UIAlertAction(title: "Block",
                                        style: UIAlertAction.Style.default) { (action) in
            print("\(AlertMessage.kCancel) tapped")
        }
        let blockImage = UIImage(named: "block_icon")?.withRenderingMode(.alwaysOriginal)
        blockAction.setValue(blockImage, forKey: "image")
        blockAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")

        // cancelAction
        let cancelAction = UIAlertAction(title: "Cancel",
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

        disableWindowInteraction()
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
        }
        else{
            self.postRequestToGetFeatureListing(String.getString(featureListingId), navigationTitle: String.getString(model.title))
        }
    }
    }


