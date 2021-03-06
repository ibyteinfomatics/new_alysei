//
//  PostsViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 4/26/21.
//

import UIKit
import CoreData
import Firebase
import FirebaseDatabase
import SVProgressHUD
import Instructions
import Zoomy

struct PostCommentsUserData {
    var userID: Int
    var postID: Int
}

var checkHavingPreferences : Int? = 0
var isRefreshing = false
var isprofileComplete : Bool?
var loadTypeCell: LoadCell?
class PostsViewController: AlysieBaseViewC  {
    
    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var marketplaceView: UIView!
    @IBOutlet weak var recipesView: UIView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var headerStack: UIView!
    @IBOutlet weak var tableviewheight: NSLayoutConstraint!
    @IBOutlet weak var btnNewpost: UIButton!
    @IBOutlet weak var lblNotificationCount: UILabel!
    @IBOutlet weak var vwNotification: UIView!
    
    @IBOutlet weak var lblHeading1: UILabel!
    @IBOutlet weak var lblHeading2: UILabel!
    @IBOutlet weak var lblHeading3: UILabel!
    @IBOutlet weak var lblHeading4: UILabel!
    @IBOutlet weak var vwNewPost: UIView!
    var getUser:[userClass]?
    //@IBOutlet weak var postView: UIView!
    var userType: UserRoles!
    var postLike:[PostClass]?
    
    var scrollCallBack: (() -> Void)? = nil
    var newFeedModel: NewFeedSearchModel?
    var arrNewFeedDataModel = [NewFeedSearchDataModel]()
    var arrDiscoverDataModel = [NewDiscoverDataModel]()
    var selectedPostId: Int?
    var likeUnlike: Int?
    var indexOfPageToRequest = 1
    var role: String?
    var isExpand = false
    let coachMarksController = CoachMarksController()
    
    
    var overlay: UIView = {
        let view = UIView(frame: UIScreen.main.bounds);
        
        view.alpha = 0
        view.backgroundColor = .black
        
        return view
    }()
    
    let refreshControl = UIRefreshControl()
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.coachMarksController.stop(immediately: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblHeading1.text = AppConstants.kPosts
        lblHeading2.text = AppConstants.kTitleMarketplace
        lblHeading3.text = MarketPlaceConstant.kRecipe
        lblHeading4.text = MarketPlaceConstant.kNotifications
        vwNotification.layer.cornerRadius = self.vwNotification.frame.height / 2
        vwNotification.layer.masksToBounds = true
        let data = kSharedUserDefaults.getLoggedInUserDetails()
        if Int.getInt(data["alysei_review"]) == 1 {
            postRequestToGetProgressPrfile()

        }
       
        
        let skipView = CoachMarkSkipDefaultView()
        skipView.setTitle(RecipeConstants.kSkip, for: .normal)
        self.coachMarksController.skipView = skipView
        
        self.tabBarController?.selectedIndex = 0
        // self.tabBarController?.tabBar.isHidden = false
        // hidesBottomBarWhenPushed = false
        // callNewFeedApi(pageNo)
        self.coachMarksController.dataSource = self
        self.coachMarksController.delegate = self
        
        btnNewpost.layer.cornerRadius = btnNewpost.frame.height / 2
        vwNewPost.layer.cornerRadius = vwNewPost.frame.height / 2
        fromMenuTab = "PostViewController"
        self.role = kSharedUserDefaults.loggedInUserModal.memberRoleId
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(openMarketPlace))
        self.marketplaceView.addGestureRecognizer(tap)
        
        let tapRecipe = UITapGestureRecognizer(target: self, action: #selector(openRecipes))
        self.recipesView.addGestureRecognizer(tapRecipe)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(openNotificationPlace))
        self.notificationView.addGestureRecognizer(tap1)
        
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        postTableView.addSubview(refreshControl)
        
        receivePostLike()
        getUsersData()
        //        let urlP = URL(string: "\(( kSharedUserDefaults.loggedInUserModal.UserAvatar_id?.baseUrl  ?? "") + "\( kSharedUserDefaults.loggedInUserModal.UserAvatar_id?.attachment_url  ?? "")")")
        //        self.downloadImage(from: urlP ?? URL(fileURLWithPath: ""))
        //
        
        // Do any additional setup after loading the view.
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh table view
        isRefreshing = true
        indexOfPageToRequest = 1
        callNewFeedApi(1)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.isUserInteractionEnabled = true
        lblHeading1.text = AppConstants.kPosts
        lblHeading2.text = AppConstants.kTitleMarketplace
        lblHeading3.text = MarketPlaceConstant.kRecipe
        lblHeading4.text = MarketPlaceConstant.kNotifications
        btnNewpost.setTitle(AppConstants.NewPost, for: .normal)
        self.tabBarController?.tabBar.isHidden = false
        hidesBottomBarWhenPushed = false
        self.tabBarController?.selectedIndex = 0
        postRequestToGetProgressPrfile()
        if self.role == "10" {
            if let viewController2 = self.tabBarController?.viewControllers?[1] {
                
                //viewController2.tabBarItem.image = UIImage(named: "b2btab1_icon")
                viewController2.tabBarItem.title = AppConstants.kHubs
                // viewController2.tabBarItem.isEnabled = false
                //viewController2.tabBarItem.selectedImage = UIImage(named: "turnoff_comments_icon")
                
            }
        }else{
            if let viewController2 = self.tabBarController?.viewControllers?[1] {
                
                //viewController2.tabBarItem.image = UIImage(named: "b2b_normal")
                viewController2.tabBarItem.title = AppConstants.kB2B
                // viewController2.tabBarItem.isEnabled = true
                // viewController2.tabBarItem.selectedImage = UIImage(named: "b2b_active")
                
            }
        }
        //arrNewFeedDataModel.removeAll()
        arrNewFeedDataModel = [NewFeedSearchDataModel]()
        self.postTableView.separatorStyle = .singleLine
        headerStack.isHidden = true
        postTableView.isHidden = true
        self.indexOfPageToRequest = 1
        callNewFeedApi(1)
        //        let urlP = URL(string: "\(( kSharedUserDefaults.loggedInUserModal.UserAvatar_id?.baseUrl  ?? "") + "\( kSharedUserDefaults.loggedInUserModal.UserAvatar_id?.attachment_url  ?? "")")")
        //               self.downloadImage(from: urlP ?? URL(fileURLWithPath: ""))
        //
        
        
    }
    
    @IBAction func btnNewPOst(_ sender: UIButton){
        self.btnNewpost.isHidden = true
        self.vwNewPost.isHidden = true
        self.indexOfPageToRequest = 1
        callNewFeedApi(1)
    }
    
    //MARK:- segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguePostsToComment" {
            if let model = sender as? PostCommentsUserData {
                if let viewCon = segue.destination as? PostCommentsViewController {
                    viewCon.postCommentsUserDataModel = model
                }
            }
        }
        
        if segue.identifier == "seguePostsToSharePost" {
            if let dataModel = sender as? SharePost.PostData.post {
                if let viewCon = segue.destination as? SharePostViewController {
                    viewCon.postDataModel = dataModel
                }
            }
        }
        
        if segue.identifier == "seguePostsToEditPost" {
            if let dataModel = sender as? EditPost.EditData.edit {
                if let viewCon = segue.destination as? EditPostViewController {
                    viewCon.postDataModel = dataModel
                }
            }
        }
        
        if segue.identifier == "showStory" {
            _ = segue.destination as! StoryViewController
        }
        
    }
    @objc func openNotificationPlace(){
        guard let vc = UIStoryboard(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(identifier: "NotificationList") as? NotificationList else {return}
        self.navigationController?.pushViewController(vc, animated: true)
        self.hidesBottomBarWhenPushed = true
        
    }
    
    @objc func openMarketPlace(){
        self.view.isUserInteractionEnabled = false
        callMarketPlaceHomeApi()
        
        //self.tabBarController?.tabBar.bounds.height = 0
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
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height - (self.view.frame.height * 2) {
            if indexOfPageToRequest > newFeedModel?.lastPage ?? 0{
                print("No Data")
            }else{
                // increments the number of the page to request
                indexOfPageToRequest += 1
                self.btnNewpost.isHidden = true
                self.vwNewPost.isHidden = true
                // call your API for more data
                callNewFeedApi(indexOfPageToRequest)
                
                // tell the table view to reload with the new data
                self.postTableView.reloadData()
            }
        }
    }
    
    func showCommentScreen(_ model: PostCommentsUserData) {
        self.performSegue(withIdentifier: "seguePostsToComment", sender: model)
    }
}


extension PostsViewController: UITableViewDelegate,UITableViewDataSource{
    
    func getUsersData() {
        
        kChatharedInstance.receivce_user_data(userID: String.getString(kSharedUserDefaults.loggedInUserModal.userId)) { (users) in
            self.getUser?.removeAll()
            self.getUser = users
            
            if self.getUser![0].notification ?? 0 > 10 {
                self.vwNotification.isHidden = false
                self.lblNotificationCount.text = "10+"
            }else if self.getUser![0].notification ?? 0 > 0 && self.getUser![0].notification ?? 0 <= 10 {
                self.vwNotification.isHidden = false
                self.lblNotificationCount.text = String.getString(self.getUser![0].notification)
            } else {
                self.vwNotification.isHidden = true
            }
            
        }
        
    }
    
    func receivePostLike() {
        
        kChatharedInstance.receivce_Post_like(postId: "") { (message) in
            
            self.postLike?.removeAll()
            self.postLike = message
            // self.tableView.reloadData()
            //self.scrollToLTopRow()
            //print(self.postLike?[0].likeCount)
            print("checking",self.postLike?.count)
            
            let postsize = self.postLike?.count ?? 0
            
           /* if self.arrNewFeedDataModel.count > 0 {
                if self.postLike?.last?.postId != self.arrNewFeedDataModel[0].postID {
                    self.btnNewpost.isHidden = false
                } else {
                    self.postTableView.reloadData()
                }
            }*/
            
            
            if self.arrNewFeedDataModel.count > 5 {
                if self.postLike?.last?.postId != self.arrNewFeedDataModel[0].postID &&
                    self.postLike?.last?.postId != self.arrNewFeedDataModel[1].postID && self.postLike?.last?.postId != self.arrNewFeedDataModel[2].postID && self.postLike?.last?.postId != self.arrNewFeedDataModel[3].postID && self.postLike?.last?.postId != self.arrNewFeedDataModel[4].postID && self.postLike?.last?.postId != self.arrNewFeedDataModel[5].postID{
                    self.btnNewpost.isHidden = false
                    self.vwNewPost.isHidden = false
                } else {
                    self.postTableView.reloadData()
                }
            }
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return arrNewFeedDataModel.count
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            guard let cell = postTableView.dequeueReusableCell(withIdentifier: "DiscoverTableViewCell") as? DiscoverTableViewCell else{return UITableViewCell()}
            cell.lblSubTitle.text = AppConstants.kDiscoveryAlysei
            cell.configCell(arrDiscoverDataModel)
            
            cell.pushCallback = { index in
                switch self.arrDiscoverDataModel[index].discover_alysei_id {
                case 1:
                    let controller = self.pushViewController(withName: EventDiscover.id(), fromStoryboard: StoryBoardConstants.kHome) as? EventDiscover
                    self.tabBarController?.tabBar.isHidden = true
                    controller?.eventId = "events"
                case 2:
                    let controller = self.pushViewController(withName: TripDiscover.id(), fromStoryboard: StoryBoardConstants.kHome) as? TripDiscover
                    self.tabBarController?.tabBar.isHidden = true
                    controller?.tripId = "trips"
                case 3:
                    let controller = self.pushViewController(withName: BlogDiscover.id(), fromStoryboard: StoryBoardConstants.kHome) as? BlogDiscover
                    self.tabBarController?.tabBar.isHidden = true
                    controller?.blogId = "blogs"
                case 4:
                    let controller = self.pushViewController(withName: RestaurantDiscover.id(), fromStoryboard: StoryBoardConstants.kHome) as? RestaurantDiscover
                    self.tabBarController?.tabBar.isHidden = true
                    controller?.restId = "restaurants"
                case 5:
                    //self.performSegue(withIdentifier: "showStory", sender: self)
                   _ = self.pushViewController(withName: StoryViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as? StoryViewController
                    
                default:
                    print("Invalid")
                }
            }
            cell.selectionStyle = .none
            return cell
        }else{
            if arrNewFeedDataModel.count == 0 {
                print("No data")
            }else if (arrNewFeedDataModel[indexPath.row].sharedPostData != nil) && (arrNewFeedDataModel[indexPath.row].shared_post_deleted == false) {
                guard let cell = postTableView.dequeueReusableCell(withIdentifier: "SharePostDescTableViewCell") as? SharePostDescTableViewCell else{return UITableViewCell()}
                cell.selectionStyle = .none
                loadTypeCell = .sharePost
                let data = arrNewFeedDataModel[indexPath.row]
                if data.sharedPostData?.attachments?.first?.attachmentLink?.width == 0 || data.sharedPostData?.attachments?.first?.attachmentLink?.height == 0 || data.sharedPostData?.attachments?.first?.attachmentLink?.width == nil || data.sharedPostData?.attachments?.first?.attachmentLink?.height == nil{
                    print("error")
                    cell.newHeightCllctn = 0
                    cell.imageHeightCVConstant.constant = 0
                }else{
                    var ratio = CGFloat((data.sharedPostData?.attachments?.first?.attachmentLink?.width ?? 0 ) / (data.sharedPostData?.attachments?.first?.attachmentLink?.height ?? 0  ))
                    if (data.sharedPostData?.attachments?.first?.attachmentLink?.width ?? 0) > (data.sharedPostData?.attachments?.first?.attachmentLink?.height ?? 0) {
                        let newHeight = 320 / ratio
                        // cell.imageConstant.constant = newHeight
                        cell.newHeightCllctn = Int(newHeight - 50)
                        cell.imageHeightCVConstant.constant = CGFloat(newHeight) - 50
                    } else{
                        var newWidth = 430
                        if ratio == 0.0 {
                            ratio = 1
                            newWidth = 550
                        }
                        newWidth = newWidth * Int(ratio)
                       //cell.imageConstant.constant = newWidth
                        cell.newHeightCllctn = Int(newWidth)
                        cell.imageHeightCVConstant.constant = CGFloat(newWidth)
                    }
                }
                if arrNewFeedDataModel.count > indexPath.row {
                    cell.configCell(arrNewFeedDataModel[indexPath.row] , indexPath.row)
                    let data = arrNewFeedDataModel[indexPath.row]
                    cell.menuDelegate = self
                    
                    cell.profileCallback = {
                        //print("ids  ",data.subjectId?.userId)
                        let controller = self.pushViewController(withName: ProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? ProfileViewC
                        if data.subjectId?.userId == Int(kSharedUserDefaults.loggedInUserModal.userId ?? ""){
                            controller?.userLevel = .own
                            controller?.userID = data.subjectId?.userId ?? 0
                        }
                        else{
                            controller?.userLevel = .other
                            controller?.userID = data.subjectId?.userId ?? 0
                        }
                        if controller?.userLevel == .own{
                            self.navigationController?.popViewController(animated: true)
                        }
                        
                    }
                    cell.sharedProfileCallback = {
                        let controller = self.pushViewController(withName: ProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? ProfileViewC
                        if data.sharedPostData?.subjectId?.userId == Int(kSharedUserDefaults.loggedInUserModal.userId ?? ""){
                            controller?.userLevel = .own
                            controller?.userID = data.sharedPostData?.subjectId?.userId ?? 0
                        }
                        else{
                            controller?.userLevel = .other
                            controller?.userID = data.sharedPostData?.subjectId?.userId ?? 0
                        }
                    }
                    
                    cell.shareCallback = {
                        
                        //self.sharePost(data.postID ?? 0)
                        
                    }
                    
                    cell.likeCallback = { index in
                        //self.postTableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .automatic)
                        cell.lblPostLikeCount.text = "\(data.likeCount ?? 0)"
                        cell.likeImage.image = data.likeFlag == 0 ? UIImage(named: "icons8_heart") : UIImage(named: "liked_icon")
                        
                        
                        
                    }
                    
                    cell.commentCallback = { postCommentsUserData in
                        self.showCommentScreen(postCommentsUserData)
                    }
                }
                return cell
                
            }else{
                if (arrNewFeedDataModel[indexPath.row].shared_post_deleted == false) {
                guard let cell = postTableView.dequeueReusableCell(withIdentifier: "PostDescTableViewCell") as? PostDescTableViewCell else{return UITableViewCell()}
                cell.selectionStyle = .none
                //TODO: this needs to be discussed with Shalini.
                if arrNewFeedDataModel.count > indexPath.row {
                    //addZoombehavior(for: cell.imagePostCollectionView)
                    cell.configCell(arrNewFeedDataModel[indexPath.row], postlike: postLike ?? [] , indexPath.row)
                    let data = arrNewFeedDataModel[indexPath.row]
                    cell.btnMoreLess.tag = indexPath.row
                    cell.relaodSection = indexPath.section
                    //  guard (parent?.view) != nil else { return UITableViewCell() }
                    //                cell.passImageTabCallBack = { imageZoom in
                    //
                    //
                    //                    self.addZoombehavior(for: imageZoom,
                    //                                    settings: Settings.instaZoomSettings.with(actionOnTapOverlay: Action.dismissOverlay))
                    //                }
                    
                    /*if data.isExpand == true{
                     cell.lblPostDesc.numberOfLines = 0
                     cell.btnMoreLess.setTitle("....less", for: .normal)
                     }else{
                     cell.lblPostDesc.numberOfLines = 2
                     cell.btnMoreLess.setTitle("....more", for: .normal)
                     }*/
                    
                    cell.profileCallback = {
                        //print("ids  ",data.subjectId?.userId)
                        let controller = self.pushViewController(withName: ProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? ProfileViewC
                        if data.subjectId?.userId == Int(kSharedUserDefaults.loggedInUserModal.userId ?? ""){
                            controller?.userLevel = .own
                            controller?.userID = data.subjectId?.userId ?? 0
                        }
                        else{
                            controller?.userLevel = .other
                            controller?.userID = data.subjectId?.userId ?? 0
                        }
                        if controller?.userLevel == .own{
                            self.navigationController?.popViewController(animated: true)
                        }
                        
                    }
                    
                    cell.shareCallback = {
                        
                        self.sharePost(data.postID ?? 0)
                        
                    }
                    
                    cell.likeCallback = { index in
                        //self.postTableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .automatic)
                        cell.lblPostLikeCount.text = "\(data.likeCount ?? 0)"
                        cell.likeImage.image = data.likeFlag == 0 ? UIImage(named: "icons8_heart") : UIImage(named: "liked_icon")
                        
                        
                        
                    }
                    cell.reloadCallBack = { tag, section in
                        let data = self.arrNewFeedDataModel[tag ?? -1]
                        
                        if data.isExpand == false{
                            data.isExpand = true
                        }else{
                            data.isExpand = false
                        }
                        //self.postTableView.reloadData()
                        let indexPath = IndexPath(row: tag ?? -1, section: indexPath.section)
                        self.postTableView.reloadRows(at: [indexPath], with: .automatic)
                        self.postTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                        
                    }
                    
                    cell.menuDelegate = self
                    
                    cell.commentCallback = { postCommentsUserData in
                        self.showCommentScreen(postCommentsUserData)
                    }
                    if data.attachments?.first?.attachmentLink?.width == 0 || data.attachments?.first?.attachmentLink?.height == 0 || data.attachments?.first?.attachmentLink?.width == nil || data.attachments?.first?.attachmentLink?.height == nil{
                        print("error")
                        cell.newHeightCllctn = 0
                        cell.imageHeightCVConstant.constant = 0
                    }else{
                        var ratio = CGFloat((data.attachments?.first?.attachmentLink?.width ?? 0 ) / (data.attachments?.first?.attachmentLink?.height ?? 0  ))
                        if (data.attachments?.first?.attachmentLink?.width ?? 0) > (data.attachments?.first?.attachmentLink?.height ?? 0) {
                            let newHeight = 320 / ratio
                            // cell.imageConstant.constant = newHeight
                            cell.newHeightCllctn = Int(newHeight - 50)
                            cell.imageHeightCVConstant.constant = CGFloat(newHeight) - 50
                        } else{
                            var newWidth = 430
                            if ratio == 0.0 {
                                ratio = 1
                                newWidth = 550
                            }
                            newWidth = newWidth * Int(ratio)
                           //cell.imageConstant.constant = newWidth
                            cell.newHeightCllctn = Int(newWidth)
                            cell.imageHeightCVConstant.constant = CGFloat(newWidth)
                        }
                    }
                }
                
                return cell
                }
            }
            
        }
        return UITableViewCell()
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 150
        }else{
            if arrNewFeedDataModel[indexPath.row].shared_post_deleted == true{
                return 0
            }
            return UITableView.automaticDimension
        }
    }
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        if indexPath.row + 1 == newFeedModel?.data?.count {
    //            print("do something")
    //            pageNo = pageNo + 1
    //            self.callNewFeedApi(pageNo)
    //        }
    //    }
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        if indexPath.section == 1 &&
    //            indexPath.row == (arrNewFeedDataModel.count - 1) {
    //            // Notify interested parties that end has been reached
    //            print("do something")
    //             pageNo = pageNo + 1
    //             self.callNewFeedApi(pageNo)
    //        }
    //    }
    
}

extension PostsViewController: ShareEditMenuProtocol {
    func menuBttonTapped(postID: Int?, userID: Int?) {
        
        guard let postID = postID else {
            return
        }
        let actionSheet = UIAlertController(style: .actionSheet)
        
        let shareAction = UIAlertAction(title: AppConstants.kSharePost, style: .default) { action in
            self.sharePost(postID)
        }
        
        let editPostAction = UIAlertAction(title: AppConstants.kEditPost, style: .default) { action in
            self.editPost(postID)
        }
        
        let deletePost = UIAlertAction(title:AppConstants.kDeletePost, style: .destructive) { action in
            self.deletePost(postID)
        }
        
        // let f = UIAlertAction(title: "Change Privacy", style: .default) { action in
        //   self.editPost(postID)
        //}
        
        let reportAction = UIAlertAction(title:AppConstants.kReportAction, style: .destructive) { action in
        }
        
        let cancelAction = UIAlertAction(title: MarketPlaceConstant.kCancel, style: .cancel) { action in
            
        }
        
        
        
        if let loggedInUserID = kSharedUserDefaults.loggedInUserModal.userId {
            if Int(loggedInUserID) == userID {
                //actionSheet.addAction(shareAction)
                actionSheet.addAction(editPostAction)
                // actionSheet.addAction(changePrivacyAction)
                actionSheet.addAction(deletePost)
            } else {
                actionSheet.addAction(shareAction)
                actionSheet.addAction(reportAction)
            }
        }
        
        actionSheet.addAction(cancelAction)
        
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    
    func deletePost(_ postID: Int) {
        
        let url = APIUrl.Posts.deletePost
        guard var urlRequest = WebServices.shared.buildURLRequest(url, method: .POST) else {
            return
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let model = Post.delete(postID: postID)
            let body = try JSONEncoder().encode(model)
            
            urlRequest.httpBody = body
            WebServices.shared.request(urlRequest) { data, urlResponse, statusCode, error in
                if (statusCode ?? 0) != 200 {
                    self.showAlert(withMessage: MarketPlaceConstant.kSomeErrorOccured)
                } else {
                    kChatharedInstance.deletePost(postId: "\(postID)")
                    self.indexOfPageToRequest = 1
                    self.callNewFeedApi(1)
                }
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func editPost(_ postID: Int) {
        let data = arrNewFeedDataModel.filter({ $0.postID == postID })
        if let editData = data.first {
            let editPostDataModel = EditPost.EditData.edit(attachments: editData.attachments,
                                                           postOwnerDetail: editData.subjectId,
                                                           postDescription: "\(editData.body ?? "")",
                                                           postID: postID,
                                                           privacy: editData.privacy)
            self.performSegue(withIdentifier: "seguePostsToEditPost", sender: editPostDataModel)
        }
    }
    
    func sharePost(_ postID: Int) {
        let data = arrNewFeedDataModel.filter({ $0.postID == postID })
        if let searchDataModel = data.first {
            let sharePostDataModel = SharePost.PostData.post(attachments: searchDataModel.attachments,
                                                             postOwnerDetail: searchDataModel.subjectId,
                                                             postDescription: "\(searchDataModel.body ?? "")",
                                                             postID: postID)
            self.performSegue(withIdentifier: "seguePostsToSharePost", sender: sharePostDataModel)
        }
    }
    
}

extension PostsViewController{
    
    func callMarketPlaceHomeApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kMarketPlaceHome, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
            let response = dictResponse as? [String:Any]
          
            let isVisitedMarketplace = response?["is_visited_marketplace"] as? Int
            if isVisitedMarketplace == 0 {
                _ = self.pushViewController(withName: MarketPlaceFirstTiimeVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)
               
            }else{
                _ = self.pushViewController(withName: MarketplaceHomePageVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)
            
              
            }
        }
        
    }
}

extension PostsViewController {
    
    func callNewFeedApi(_ pageNo: Int?){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetFeed + "\(pageNo ?? 1)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newFeedModel = NewFeedSearchModel.init(with: data)
                if pageNo == 1 { self.arrNewFeedDataModel.removeAll() }
                self.arrNewFeedDataModel.append(contentsOf: self.newFeedModel?.data ?? [NewFeedSearchDataModel(with: [:])])
                
            }
            
            if let discover_alysei = dictResponse?["discover_alysei"] as? [[String:Any]]{
                self.arrDiscoverDataModel = discover_alysei.map({NewDiscoverDataModel.init(with: $0)})
            }
            
            
            if let havingPreferences = dictResponse?["having_preferences"] as? Int{
                checkHavingPreferences = havingPreferences
            }
            self.headerStack.isHidden = false
            self.postTableView.isHidden = false
            print("CountDiscover -------------------\(self.arrDiscoverDataModel.count)")
            print("Count -------------------\(self.arrNewFeedDataModel.count)")
            self.postTableView.reloadData()
            self.refreshControl.endRefreshing()
            
            if pageNo == 1 {
                self.postTableView.scrollToTopWithoutAnimation()
            }
            
            //DispatchQueue.main.async { self.postTableView.reloadData()}
            
        }
    }
    
    
    private func postRequestToGetProgressPrfile() -> Void{
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kProfileProgress, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictRespnose, error, errorType, statusCode) in
            let response = dictRespnose as? [String:Any]
            if let data = response?["data"] as? [String:Any]{
                
                print("profile_percentage--- ",data["profile_percentage"]!)
                let data1 = kSharedUserDefaults.getLoggedInUserDetails()
                if Int.getInt(data1["alysei_review"]) == 1 {
                    if String.getString(data["profile_percentage"])  != "100" {
                        isprofileComplete = false
                        
                        self.tabBarController?.tabBar.backgroundColor = .white
                        self.tabBarController?.tabBar.alpha = 1.0
                        self.tabBarController?.tabBar.isUserInteractionEnabled = true
                        
                        let parent = self.parent as? HomeViewC
                        parent?.headerView.isUserInteractionEnabled = true
                        parent?.headerView.alpha = 1.0
                        parent?.headerView.backgroundColor = .white
                        
                    }
                    else {
                        isprofileComplete = true
                        
                        if !AppManager.getUserSeenAppInstructionPost() {
                            
                            self.coachMarksController.start(in: .viewController(self))
                            let parent = self.parent as? HomeViewC
                            parent?.headerView.isUserInteractionEnabled = false
                            parent?.headerView.alpha = 0.8
                            parent?.headerView.backgroundColor = .black //#colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 0.75)
                            
                          
                           
                            self.tabBarController?.tabBar.backgroundColor = UIColor.darkGray 
                            self.tabBarController?.tabBar.alpha = 0.9
                            self.tabBarController?.tabBar.isUserInteractionEnabled = false
                            
                            // #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 0.75)
                        }
                        else{
                            self.tabBarController?.tabBar.backgroundColor = .white
                            self.tabBarController?.tabBar.alpha = 1.0
                            self.tabBarController?.tabBar.isUserInteractionEnabled = true
                            
                            let parent = self.parent as? HomeViewC
                            parent?.headerView.isUserInteractionEnabled = true
                            parent?.headerView.alpha = 1.0
                            parent?.headerView.backgroundColor = .white
                            
                        }
                        
                    }
                }
                else{
                    
                    self.tabBarController?.tabBar.backgroundColor = .white
                    self.tabBarController?.tabBar.alpha = 1.0
                    self.tabBarController?.tabBar.isUserInteractionEnabled = true
                    
                    let parent = self.parent as? HomeViewC
                    parent?.headerView.isUserInteractionEnabled = true
                    parent?.headerView.alpha = 1.0
                    parent?.headerView.backgroundColor = .white
                    
                }
                
            }
            
        }
    }
    
}

extension PostsViewController{
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

//extension PostsViewController: UIGestureRecognizerDelegate {
//  
//    // That method make it works
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//    
//    @objc func handleZoom(_ gesture: UIPinchGestureRecognizer) {
//        switch gesture.state {
//        case .began, .changed:
//            
//            // Only zoom in, not out
//            if gesture.scale >= 1 {
//              
//                // Get the scale from the gesture passed in the function
//                let scale = gesture.scale
//              
//                // use CGAffineTransform to transform the imageView
//                gesture.view!.transform = CGAffineTransform(scaleX: scale, y: scale)
//            }
//          
//
//            // Show the overlay
//            UIView.animate(withDuration: 0.2) {
//                self.overlay.alpha = 0.8
//            }
//            break;
//        default:
//            // If the gesture has cancelled/terminated/failed or everything else that's not performing
//            // Smoothly restore the transform to the "original"
//            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
//              gesture.view!.transform = .identity
//            }) { _ in
//              // Hide the overlay
//              UIView.animate(withDuration: 0.2) {
//                self.overlay.alpha = 0
//              }
//            }
//        }
//    }
//    
//    @objc func handlePan(_ gesture: UIPanGestureRecognizer,_ imageView: UIImageView) {
//        switch gesture.state {
//        case .began, .changed:
//            // Get the touch position
//            let translation = gesture.translation(in: imageView)
//            
//            // Edit the center of the target by adding the gesture position
//            gesture.view!.center = CGPoint(x: imageView.center.x + translation.x, y: imageView.center.y + translation.y)
//            gesture.setTranslation(.zero, in: imageView)
//
//            // Show the overlay
//            UIView.animate(withDuration: 0.2) {
//                self.overlay.alpha = 0.8
//            }
//            break;
//        default:
//            // If the gesture has cancelled/terminated/failed or everything else that's not performing
//            // Smoothly restore the transform to the "original"
//            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
//                gesture.view!.center = self.view.center
//                gesture.setTranslation(.zero, in: self.background)
//            }) { _ in
//              // Hide the overaly
//              UIView.animate(withDuration: 0.2) {
//                self.overlay.alpha = 0
//              }
//            }
//            break
//        }
//    }
//}

extension PostsViewController : CoachMarksControllerDataSource, CoachMarksControllerDelegate{
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 4
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
        
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
       
        switch index {
        case 0:
            switch kSharedUserDefaults.loggedInUserModal.memberRoleId{
            case "3", "4", "5", "6", "7", "9":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kProdImpDistRestVoiceExprtMarketPlace
                
            case "8", "10":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kTravelAgenciesVoygersMarketPlace
            default: break
                
            }
            coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
        case 1:
            coachViews.bodyView.hintLabel.text = TourGuideConstants.kForAllRecipe
            coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
        case 2:
            switch kSharedUserDefaults.loggedInUserModal.memberRoleId{
            case "3", "4", "5", "6", "7", "8", "9":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kForEveryMemberB2B
                
            case "10":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kForVoyagersB2B
            default: break
                
            }
            
            coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
            
        case 3:
            coachViews.bodyView.hintLabel.text = TourGuideConstants.kForAllPost
            coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
            
            
            
        default: break
        }
        
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController,
                              coachMarkAt index: Int) -> CoachMark {
        
        let b2bTab = tabBarController?.tabBar.items?[1].value(forKey: "view") as? UIView
        let addPostTab = tabBarController?.tabBar.items?[2].value(forKey: "view") as? UIView
        
        switch index {
        case 0: return coachMarksController.helper.makeCoachMark(for: marketplaceView)
        case 1: return coachMarksController.helper.makeCoachMark(for: recipesView)
        case 2:
            return coachMarksController.helper.makeCoachMark(for: b2bTab)
        case 3:
            return coachMarksController.helper.makeCoachMark(for: addPostTab)
            
        default:
            return coachMarksController.helper.makeCoachMark()
        }
    }
    
    
    func coachMarksController(_ coachMarksController: CoachMarksController, didEndShowingBySkipping skipped: Bool) {
        AppManager.setUserSeenAppInstructionPost()
        
        self.tabBarController?.tabBar.backgroundColor = .white
        self.tabBarController?.tabBar.alpha = 1.0
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
        
        let parent = self.parent as? HomeViewC
        parent?.headerView.isUserInteractionEnabled = true
        parent?.headerView.alpha = 1.0
        parent?.headerView.backgroundColor = .white
        
    }
    
}

