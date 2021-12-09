//
//  MembershipViewC.swift
//  ScreenBuild
//
//  Created by Alendra Kumar on 20/01/21.
//

import UIKit

class MembershipViewC: AlysieBaseViewC {
    
  //MARK: - IBOutlet -
    
  @IBOutlet weak var tblViewMembership: UITableView!
  @IBOutlet weak var viewBlueHeading: UIView!
    @IBOutlet weak var viewBottom: UIView!
  @IBOutlet weak var tableviewheight: NSLayoutConstraint!
  var progressmodel:ProgressModel?
    @IBOutlet weak var backbutton: UIButton!
  //MARK: - Properties -
  var from = ""
  var currentIndex: Int = 0
    var fromvc: FromVC?
    
    private lazy var postViewC: PostsViewController = {

      let postViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: PostsViewController.id()) as! PostsViewController
      return postViewC
    }()
    

  //MARK:  - ViewLifeCycle Methods -
    
  override func viewDidLoad() {
    
    super.viewDidLoad()
      
      if MobileDeviceType.IS_IPHONE_X || MobileDeviceType.IS_IPHONE_X_MAX {
          tblViewMembership.isScrollEnabled = false
      } else {
          tblViewMembership.isScrollEnabled = true
      }
    
    let topTapbarPosition = self.tabBarController?.tabBar.frame.size.height ?? 0
    
  }
    
    override func viewWillAppear(_ animated: Bool) {
        tblViewMembership.isHidden = true
        self.viewBottom.isHidden = true
        //self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
        self.postRequestToGetProgress()
    }
  
  override func viewDidLayoutSubviews(){
    super.viewDidLayoutSubviews()
    
    self.viewBlueHeading.makeCornerRadius(radius: 5.0)
  }

  //MARK:  - IBAction -
  
  @IBAction func tapBack(_ sender: UIButton) {
    
    if fromvc == .Notification {
        kSharedAppDelegate.pushToTabBarViewC()
    } else {
        self.navigationController?.popViewController(animated: true)
    }
    
  }
  
  //MARK:  - Private Methods -
  
  private func getMembershipTableCell(_ indexPath: Int) -> UITableViewCell{
    
    let membershipTableCell = tblViewMembership.dequeueReusableCell(withIdentifier: MembershipTableCell.identifier()) as! MembershipTableCell
    membershipTableCell.delegate = self
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
  
  //MARK:  - WebService Methods -
  
  private func postRequestToGetProgress() -> Void{
    
    disableWindowInteraction()
  
    TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetProgress, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
        
        let dictResponse = dictResponse as? [String:Any]
        
        self.progressmodel = ProgressModel.init(with: dictResponse)
        
        if self.progressmodel?.data?.alyseiReview == "1"  {
            
            UserDefaults.standard.set(1, forKey: "alyseiCertification")
            kSharedUserDefaults.alyseiReview = 1
            
            _ = self.postViewC
            
        }
        
        self.viewBottom.isHidden = false
        self.tblViewMembership.isHidden = false
        self.tblViewMembership.reloadData()
    }
    
  }
    
    
    
    
}




//MARK:  - TableViewMethods -

extension MembershipViewC: UITableViewDataSource, UITableViewDelegate{
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return progressmodel?.alyseiProgress?.count ?? 0
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return self.getMembershipTableCell(indexPath.row)
  }
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
  }
    
}

extension MembershipViewC: AnimationCallBack{
  
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

extension MembershipViewC{
  
  override func didUserGetData(from result: Any, type: Int) {
    
  }
  
}
