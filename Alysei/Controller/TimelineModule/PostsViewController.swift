//
//  PostsViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 4/26/21.
//

import UIKit

struct PostCommentsUserData {
    var userID: Int
    var postID: Int
}

var checkHavingPreferences : Int? = 0

class PostsViewController: AlysieBaseViewC {
    
    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var marketplaceView: UIView!
    @IBOutlet weak var recipesView: UIView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var headerStack: UIView!
    @IBOutlet weak var tableviewheight: NSLayoutConstraint!
   
    //@IBOutlet weak var postView: UIView!
    
    var scrollCallBack: (() -> Void)? = nil
    var newFeedModel: NewFeedSearchModel?
    var arrNewFeedDataModel = [NewFeedSearchDataModel]()
    var arrDiscoverDataModel = [NewDiscoverDataModel]()
    var selectedPostId: Int?
    var likeUnlike: Int?
    var indexOfPageToRequest = 1
    var role: String?
    var isExpand = false
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.tabBarController?.tabBar.isHidden = false
       // hidesBottomBarWhenPushed = false
       // callNewFeedApi(pageNo)
        self.role = kSharedUserDefaults.loggedInUserModal.memberRoleId
            
        let tap = UITapGestureRecognizer(target: self, action: #selector(openMarketPlace))
        self.marketplaceView.addGestureRecognizer(tap)
        
        let tapRecipe = UITapGestureRecognizer(target: self, action: #selector(openRecipes))
        self.recipesView.addGestureRecognizer(tapRecipe)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(openNotificationPlace))
        self.notificationView.addGestureRecognizer(tap1)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        hidesBottomBarWhenPushed = false
        if self.role == "10" {
        if let viewController2 = self.tabBarController?.viewControllers?[1] {

            //viewController2.tabBarItem.image = UIImage(named: "b2btab1_icon")
            viewController2.tabBarItem.title = "Hubs"
           // viewController2.tabBarItem.isEnabled = false
            //viewController2.tabBarItem.selectedImage = UIImage(named: "turnoff_comments_icon")

        }
        }else{
            if let viewController2 = self.tabBarController?.viewControllers?[1] {

                //viewController2.tabBarItem.image = UIImage(named: "b2b_normal")
                viewController2.tabBarItem.title = "B2B"
               // viewController2.tabBarItem.isEnabled = true
               // viewController2.tabBarItem.selectedImage = UIImage(named: "b2b_active")
                
            }
        }
        //arrNewFeedDataModel.removeAll()
        arrNewFeedDataModel = [NewFeedSearchDataModel]()
        self.postTableView.separatorStyle = .singleLine
        headerStack.isHidden = true
        postTableView.isHidden = true
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
    }
    @objc func openNotificationPlace(){
        guard let vc = UIStoryboard(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(identifier: "NotificationList") as? NotificationList else {return}
        self.navigationController?.pushViewController(vc, animated: true)
        self.hidesBottomBarWhenPushed = true
        
    }
    
    @objc func openMarketPlace(){
       // let vc = pushViewController(withName: MarketPlaceHomeVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)
        guard let vc = UIStoryboard(name: StoryBoardConstants.kMarketplace, bundle: nil).instantiateViewController(identifier: "MarketPlaceHomeVC") as? MarketPlaceHomeVC else {return}
        self.navigationController?.pushViewController(vc, animated: true)
        self.hidesBottomBarWhenPushed = true
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
            cell.configCell(arrDiscoverDataModel)
            cell.pushCallback = { index in
                switch self.arrDiscoverDataModel[index].discover_alysei_id {
                case 1:
                    let controller = self.pushViewController(withName: EventDiscover.id(), fromStoryboard: StoryBoardConstants.kHome) as? EventDiscover
                    controller?.eventId = "events"
                case 2:
                    let controller = self.pushViewController(withName: TripDiscover.id(), fromStoryboard: StoryBoardConstants.kHome) as? TripDiscover
                   controller?.tripId = "trips"
                case 3:
                    let controller = self.pushViewController(withName: BlogDiscover.id(), fromStoryboard: StoryBoardConstants.kHome) as? BlogDiscover
                    controller?.blogId = "blogs"
                case 4:
                    let controller = self.pushViewController(withName: RestaurantDiscover.id(), fromStoryboard: StoryBoardConstants.kHome) as? RestaurantDiscover
                    controller?.restId = "restaurants"
                default:
                    print("Invalid")
                }
            }
            cell.selectionStyle = .none
        return cell
        }else{
            if arrNewFeedDataModel.count == 0 {
                print("No data")
            }else if (arrNewFeedDataModel[indexPath.row].sharedPostData != nil) {
                guard let cell = postTableView.dequeueReusableCell(withIdentifier: "SharePostDescTableViewCell") as? SharePostDescTableViewCell else{return UITableViewCell()}
                cell.selectionStyle = .none
                if arrNewFeedDataModel.count > indexPath.row {
                    cell.configCell(arrNewFeedDataModel[indexPath.row] , indexPath.row)
                    let data = arrNewFeedDataModel[indexPath.row]
                    cell.menuDelegate = self
                    
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
            guard let cell = postTableView.dequeueReusableCell(withIdentifier: "PostDescTableViewCell") as? PostDescTableViewCell else{return UITableViewCell()}
            cell.selectionStyle = .none
            //TODO: this needs to be discussed with Shalini.
            if arrNewFeedDataModel.count > indexPath.row {
                cell.configCell(arrNewFeedDataModel[indexPath.row] , indexPath.row)
                let data = arrNewFeedDataModel[indexPath.row]
                cell.btnMoreLess.tag = indexPath.row
                cell.relaodSection = indexPath.section
                
                if data.isExpand == true{
                    cell.lblPostDesc.numberOfLines = 0
                    cell.btnMoreLess.setTitle("....less", for: .normal)
                }else{
                    cell.lblPostDesc.numberOfLines = 2
                    cell.btnMoreLess.setTitle("....more", for: .normal)
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
            }
                return cell
            }
           
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
        return 150
        }else{
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
    func menuBttonTapped(_ postID: Int?, userID: Int) {
        
        guard let postID = postID else {
            return
        }
        let actionSheet = UIAlertController(style: .actionSheet)

        let shareAction = UIAlertAction(title: "Share Post", style: .default) { action in
            self.sharePost(postID)
        }

        let editPostAction = UIAlertAction(title: "Edit Post", style: .default) { action in
            self.editPost(postID)
        }

        let deletePost = UIAlertAction(title: "Delete Post", style: .destructive) { action in
            self.deletePost(postID)
        }

       // let f = UIAlertAction(title: "Change Privacy", style: .default) { action in
         //   self.editPost(postID)
        //}

        let reportAction = UIAlertAction(title: "Report Action", style: .destructive) { action in
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in

        }



        if let loggedInUserID = kSharedUserDefaults.loggedInUserModal.userId {
            if Int(loggedInUserID) == userID {
                actionSheet.addAction(shareAction)
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
                if (statusCode ?? 0) >= 400 {
                    self.showAlert(withMessage: "Some error occured")
                } else {
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
                                                             postID: postID)
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


extension PostsViewController {
    func callNewFeedApi(_ pageNo: Int?){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetFeed + "\(pageNo ?? 1)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newFeedModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 { self.arrNewFeedDataModel.removeAll() }
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
            //DispatchQueue.main.async { self.postTableView.reloadData()}
            
        }
    }
   
}
 
