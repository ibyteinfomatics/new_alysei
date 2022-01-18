//
//  HomeViewC.swift
//  Alysie
//
//  Created by CodeAegis on 23/01/21.
//

import UIKit

class HomeViewC: AlysieBaseViewC {
  
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
   // _ = membershipViewC
    fullScreenImageView.alpha = 0.0
    fullScreenImageView.isUserInteractionEnabled = false
    self.view.addSubview(fullScreenImageView)
    
    countshow.layer.cornerRadius = 10
   
//    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//        _ = self.postViewC
//    }
    
  }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
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
            if Int.getInt(data["alysei_review"]) == 0 {
                postRequestToGetProgress()
                
               
            } else if Int.getInt(data["alysei_review"]) == 1{
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
                    self.membershipView.isHidden = true
                    self.blankdataView.isHidden = false
                    self.imgReview.image = UIImage(named: "ProfileCompletion")
                    self.text.text = "Complete your profile in order to start Posting"
                } else {
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
    
   // _ = pushViewController(withName: NotificationViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
    if Int.getInt(kSharedUserDefaults.loggedInUserModal.alysei_review) == 0 {
        
        
    } else {
        _ = pushViewController(withName: NotificationViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
    }
    
   // _ = pushViewController(withName: ConversationViewController.id(), fromStoryboard: StoryBoardConstants.kChat)
    
    
  
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
    
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
