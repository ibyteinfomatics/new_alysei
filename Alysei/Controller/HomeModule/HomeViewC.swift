//
//  HomeViewC.swift
//  Alysie
//
//  Created by CodeAegis on 23/01/21.
//

import UIKit
import Instructions

class HomeViewC: AlysieBaseViewC  {
  
  //MARK: - IBOutlet -
   
    private var coversationView: ConversationViewController!
  
    @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imgReview: UIImageView!
    var progressmodel:ProgressModel?
    
    // memebership view
    @IBOutlet weak var tblViewMembership: UITableView!
    @IBOutlet weak var viewBlueHeading: UIView!
   // @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var membershipView: UIView!
    @IBOutlet weak var gotoprofile: UIButtonExtended!
    var currentIndex: Int = 0
    
    var unread: Int = 0
    
    // blank data view
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var viewBlankHeading: UIView!
    @IBOutlet weak var blankdataView: UIView!
    @IBOutlet weak var countshow: UIButton!

  var fullScreenImageView = UIImageView()
    var progressUserData: UserData?
    var ResentUser:[RecentUser]?
    
   
//    let coachMarksController = CoachMarksController()
  //MARK: - Properties -

   // var fullScreenImageView = UIImageView()
  
    private lazy var membershipViewC: MembershipViewC = {

          let membershipViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: MembershipViewC.id()) as! MembershipViewC
          return membershipViewC
      
    }()
      
     
    private lazy var postViewC: PostsViewController = {

      let postViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: PostsViewController.id()) as! PostsViewController
      return postViewC
        
    }()
    
  
  //MARK: -  ViewLifeCycle Methods -
  
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
//        self.coachMarksController.start(in: .viewController(self))
       
//        self.tabBarController?.tabBar.layer.backgroundColor = UIColor.gray.cgColor
//        
//        self.tabBarController?.tabBar.alpha = 0.7
//        self.tabBarController?.tabBar.isUserInteractionEnabled = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
       
    }
  override func viewDidLoad() {
    super.viewDidLoad()
   // _ = membershipViewC
//      self.coachMarksController.dataSource = self
//      self.coachMarksController.delegate = self
      
      
     
    fullScreenImageView.alpha = 0.0
    fullScreenImageView.isUserInteractionEnabled = false
    self.view.addSubview(fullScreenImageView)
     

    countshow.layer.cornerRadius = 10
   
//    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//        _ = self.postViewC
//    }
      
      self.gotoprofile.layer.cornerRadius = 5
      self.gotoprofile.layer.masksToBounds = true
      self.gotoprofile.layer.borderWidth = 2
      self.gotoprofile.layer.borderColor = UIColor.init(red: 17/255, green: 76/255, blue: 119/255, alpha: 1).cgColor
    
  }
    
   
    
   
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = false
        
        self.viewBlankHeading.makeCornerRadius(radius: 5.0)
        //postRequestToGetProgress()
        membershipView.isHidden = true
        blankdataView.isHidden = true
        
        let data = kSharedUserDefaults.getLoggedInUserDetails()
        
        let role = Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId)
        
        if role == 10 {
            postRequestToGetProgressPrfile()
        } else {
           // if Int.getInt(data["alysei_review"]) == 0 {
            if Int.getInt(data["alysei_review"]) == 0  {
                postRequestToGetProgress()
                
               
            } else if Int.getInt(data["alysei_review"]) == 1 {
                postRequestToGetProgressPrfile()
                
            }
        }
        
        
        
        self.countshow.isHidden = true
        receiveUsers()
        
    
    }
    
    
    
    func receiveUsers() {
        
        kChatharedInstance.receiveResentUsers(userid:String.getString(kSharedUserDefaults.loggedInUserModal.userId)) { (users) in
            self.ResentUser?.removeAll()
            self.ResentUser = users
            
            self.unread = 0
            for i in 0..<(self.ResentUser?.count ?? 0){
                
                if self.ResentUser![i].readCount != 0 {
                    self.unread = self.unread + 1
                    
                }
                
            }
            
            print("unread count ",self.unread)
            
            if self.unread == 0 {
                self.countshow.isHidden = true
            } else {
                self.countshow.isHidden = false
            }
            
            self.countshow.setTitle("\(self.unread)", for: .normal)
            
        }
        
    }
    
    @IBAction func tapLogout(_ sender: UIButton) {
        kSharedAppDelegate.callLogoutApi()
     // kSharedUserDefaults.clearAllData()
    }
    
    @IBAction func tapProfile(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 4
    }
   
    
    private func getMembershipTableCell(_ indexPath: Int) -> UITableViewCell{
      
      let membershipTableCell = tblViewMembership.dequeueReusableCell(withIdentifier: MembershipTableCell.identifier()) as! MembershipTableCell
      membershipTableCell.delegate = self
        imgReview.image = UIImage(named: "")
      //membershipTableCell.configure(indexPath, currentIndex: self.currentIndex)
      membershipTableCell.lbleTitle.text = progressmodel?.alyseiProgress?[indexPath].title
      membershipTableCell.lblDescription.text = progressmodel?.alyseiProgress?[indexPath].alyseiProgressDescription
      membershipTableCell.viewLine.isHidden = (indexPath == 3) ? true : false
      
      if indexPath == 0{
         
      } else if indexPath == 1 {
          
      } else if indexPath == 2 {
          
      } else if indexPath == 3 {
          
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {

          if indexPath == self.currentIndex{
              membershipTableCell.delegate?.animateViews(self.currentIndex, cell: membershipTableCell)
        }
      }
      
      
      return membershipTableCell
      
    }
    
    
    private func postRequestToGetProgress() -> Void{
      
        membershipView.isHidden = true
        blankdataView.isHidden = true
        disableWindowInteraction()
    
      TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetProgress, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
          let dictResponse = dictResponse as? [String:Any]
          
          self.progressmodel = ProgressModel.init(with: dictResponse)
          
          if self.progressmodel?.data?.alyseiReview == "1"  {
              
              UserDefaults.standard.set(1, forKey: "alyseiCertification")
              kSharedUserDefaults.alyseiReview = 1
              isprofileComplete = false

              self.membershipView.isHidden = true
            self.blankdataView.isHidden = false
            self.imgReview.image = UIImage(named: "ProfileCompletion")
            self.text.text = "Complete your profile in order to start Posting"
        
            
              //_ = self.postViewC
            
              
          } else {
            self.membershipView.isHidden = false
            self.tblViewMembership.reloadData()
          }
          
          
      }
      
    }
    
    private func postRequestToGetProgressPrfile() -> Void{

        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kProfileProgress, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictRespnose, error, errorType, statusCode) in
            let response = dictRespnose as? [String:Any]
            if let data = response?["data"] as? [String:Any]{
                
                print("profile_percentage--- ",data["profile_percentage"]!)
                
                if String.getString(data["profile_percentage"])  != "100" {
                    isprofileComplete = false
                    self.membershipView.isHidden = true
                    self.blankdataView.isHidden = false
                    self.imgReview.image = UIImage(named: "ProfileCompletion")
                    self.text.text = "Complete your profile in order to start Posting"
                } else {
                    isprofileComplete = true
                    self.membershipView.isHidden = true
                    self.blankdataView.isHidden = true
                    self.imgReview.image = UIImage(named: "")
                }
                
                if let progUserData = data["user_details"] as? [String:Any]{
                    self.progressUserData = UserData.init(with: progUserData)
                    let urlP = URL(string: "\((self.progressUserData?.avatarid?.baseUrl  ?? "") + "\(self.progressUserData?.avatarid?.attachmenturl  ?? "")")")
                    kSharedUserDefaults.setProfilePic(profile: "\((self.progressUserData?.avatarid?.baseUrl  ?? "") + "\(self.progressUserData?.avatarid?.attachmenturl  ?? "")")")
                    self.downloadImage(from: urlP ?? URL(fileURLWithPath: ""))
                }
            }
            
        }
    }
 
  //MARK:  - IBAction -
    
    @IBAction func tapSearch(_ sender: Any) {
        
        _ = pushViewController(withName: UniversalSearchViewController.id(), fromStoryboard: StoryBoardConstants.kHome)
    }
  
  @IBAction func tapNotification(_ sender: UIButton) {
    
    //if Int.getInt(kSharedUserDefaults.loggedInUserModal.alysei_review) == 0 {
        
        
    //} else {
        _ = pushViewController(withName: NotificationViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
  //  }
    
  
  }
    
   
    
}

extension HomeViewC{
  
  override func didUserGetData(from result: Any, type: Int) {
    

  }
}

extension HomeViewC: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if section == 0{
      return progressmodel?.alyseiProgress?.count ?? 0
      }
      return 1
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if indexPath.section == 0 {
      return self.getMembershipTableCell(indexPath.row)
      }else{
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "BottomViewCell", for: indexPath) as? BottomViewCell else {return UITableViewCell()}
          return cell
      }
    }
      
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      if indexPath.section == 0{
        if indexPath.row == (progressmodel?.alyseiProgress?.count ?? 0) - 1  {
            if MobileDeviceType.IS_IPHONE_6 == true {
                return 100
            }
            else{
                return 180
            }
        }
      return 100
      }
      return 110
    }
    
}

extension HomeViewC: AnimationCallBack{
  
  func animateViews(_ indexPath: Int, cell: MembershipTableCell) {
  
//    UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
//      cell.imgViewCircle.layer.backgroundColor = UIColor.white.cgColor
//      cell.imgViewCircle.layer.borderWidth = 1.0
//      cell.imgViewCircle.makeCornerRadius(radius: 15.0)
//      cell.imgViewCircle.layer.borderColor = AppColors.blue.color.cgColor
//    })
    
    
    switch indexPath {
    
    case 0:
    
        if progressmodel?.alyseiProgress?[indexPath].status == true {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
              cell.viewLine.layer.backgroundColor = AppColors.blue.color.cgColor
            }
            
            self.currentIndex = 1
            UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
              
              
            cell.imgViewCircle.image = UIImage.init(named: "icon_bubble1")
            })
        }
        
     
      //self.tblViewMembership.reloadData()
    case 1:
        
        if progressmodel?.alyseiProgress?[indexPath].status == true {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
              cell.viewLine.layer.backgroundColor = AppColors.blue.color.cgColor
            }
            
            self.currentIndex = 2
            UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
            cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion3")
            })
        }
        
      
      //self.tblViewMembership.reloadData()
    case 2:
        
        if progressmodel?.alyseiProgress?[indexPath].status == true {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
              cell.viewLine.layer.backgroundColor = AppColors.blue.color.cgColor
            }
            
            self.currentIndex = 3
            UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
            cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion4")
            })
        }
      
      //self.tblViewMembership.reloadData()
    case 3:
        
        if progressmodel?.alyseiProgress?[indexPath].status == true {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
              cell.viewLine.layer.backgroundColor = AppColors.blue.color.cgColor
            }
            
            self.currentIndex = -1
            UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
            cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion5")
            })
        }
      
      //self.tblViewMembership.reloadData()
    default:
      print("")
        
    }
  }
}

extension HomeViewC{
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                
                profileTabImage = UIImage(data: data)
                if profileTabImage == UIImage() || profileTabImage == nil {
                    self?.tabBarController?.addSubviewToLastTabItem(UIImage(named: "profile_icon") ?? UIImage())
                }else{
                self?.tabBarController?.addSubviewToLastTabItem(profileTabImage ?? UIImage())
                }
            }
        }
    }
    
    func setloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                
                profileTabImage = UIImage(data: data)
                if profileTabImage == UIImage() || profileTabImage == nil {
                    self?.tabBarController?.addSubviewToLastTabItem(UIImage(named: "profile_icon") ?? UIImage())
                }else{
                self?.tabBarController?.addSubviewToLastTabItem(profileTabImage ?? UIImage())
                }
            }
        }
    }
    
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

//extension HomeViewC : CoachMarksControllerDataSource, CoachMarksControllerDelegate{
//
//    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
//        return 4
//    }
//
//    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
//
//        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
//
//        switch index {
//        case 0:
//            switch kSharedUserDefaults.loggedInUserModal.memberRoleId{
//            case "3", "4", "5", "6", "7", "9":
//                coachViews.bodyView.hintLabel.text = TourGuideConstants.kProdImpDistRestVoiceExprtMarketPlace
//
//            case "8", "10":
//                coachViews.bodyView.hintLabel.text = TourGuideConstants.kTravelAgenciesVoygersMarketPlace
//            default: break
//
//            }
//            coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
//        case 1:
//            coachViews.bodyView.hintLabel.text = TourGuideConstants.kForAllRecipe
//            coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
//        case 2:
//            switch kSharedUserDefaults.loggedInUserModal.memberRoleId{
//            case "3", "4", "5", "6", "7", "8", "9":
//                coachViews.bodyView.hintLabel.text = TourGuideConstants.kForEveryMemberB2B
//
//            case "10":
//                coachViews.bodyView.hintLabel.text = TourGuideConstants.kForVoyagersB2B
//            default: break
//
//            }
//
//            coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
//
//        case 3:
//            coachViews.bodyView.hintLabel.text = TourGuideConstants.kForAllPost
//            coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
//
//
//
//        default: break
//        }
//
//        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
//    }
//
//    func coachMarksController(_ coachMarksController: CoachMarksController,
//                              coachMarkAt index: Int) -> CoachMark {
//
//        let b2bTab = tabBarController?.tabBar.items?[1].value(forKey: "view") as? UIView
//
//        let addPostTab = tabBarController?.tabBar.items?[2].value(forKey: "view") as? UIView
//        let child = self.parent as? PostsViewController
//        switch index {
//        case 0: return coachMarksController.helper.makeCoachMark(for: child?.marketplaceView)
//        case 1: return coachMarksController.helper.makeCoachMark(for: child?.recipesView)
//        case 2:
//            return coachMarksController.helper.makeCoachMark(for: b2bTab)
//        case 3:
//            return coachMarksController.helper.makeCoachMark(for: addPostTab)
//
//        default:
//            return coachMarksController.helper.makeCoachMark()
//        }
//    }
//
//
//    func coachMarksController(_ coachMarksController: CoachMarksController, didEndShowingBySkipping skipped: Bool) {
//        AppManager.setUserSeenAppInstructionPost()
//
//        self.tabBarController?.tabBar.backgroundColor = .white
//        self.tabBarController?.tabBar.alpha = 1.0
//        self.tabBarController?.tabBar.isUserInteractionEnabled = true
//
//
//    }
//
//}
