//
//  PhotosPost.swift
//  Alysei
//
//  Created by Gitesh Dang on 25/10/21.
//

import UIKit
var postId = ""
var fromMenuTab = String()
class PhotosPost: AlysieBaseViewC {
    
    @IBOutlet weak var userPost: UITableView!
    @IBOutlet weak var uiview: UIView!
    
    var pageNumber = 1
    var visitorId = ""
    var position = 0
    //TODO: pagination is pending
    var count = 100
    
    var fromvc: FromVC?
   // var postData = [PostList.innerData]()
    var postData = [NewFeedSearchDataModel]()
    var singlePostData : SinglePostDataModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        fromMenuTab = "PhotosPost"
        uiview.drawBottomShadow()
        self.userPost.rowHeight = UITableView.automaticDimension
        self.userPost.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userPost.isHidden = true
        if postId == ""{
            self.fetchPostWithPhotsFromServer(pageNumber, visitorId: visitorId)
        } else {
            self.fetchPostParticularFromServer()
        }
        
    }
    

    func updatePostList() {
        self.userPost.reloadData()
    }
    
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
    
    
    
    //MARK: Actions
    @IBAction func tap_BackButton(_ sender: UIButton) {
       
        if fromvc == .Notification {
            kSharedAppDelegate.pushToTabBarViewC()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}

extension PhotosPost {
    func fetchPostWithPhotsFromServer(_ page: Int, count: Int = 30,visitorId: String) {
        let urlString = APIUrl.Profile.postList + "?page=\(page)&per_page=\(count)&visitor_profile_id=\(visitorId)"
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: urlString, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictResponse, error, erroType, statusCode in
            let response = dictResponse as? [String:Any]
            
            if let data = response?["data"]  as? [String:Any]{
                if let subData = data["data"] as? [[String:Any]]{
                    self.postData = subData.map({NewFeedSearchDataModel.init(with: $0)})
                }
                self.userPost.isHidden = false
                self.updatePostList()
                let indexPaths = IndexPath(row: self.position, section: 0)
                //userPost.selectRow(at: indexPaths, animated: false, scrollPosition: .bottom)
                self.userPost.scrollToRow(at: indexPaths, at: .top, animated: false)
            }
        }

    }
    
    
    func fetchPostParticularFromServer() {
        let urlString = APIUrl.Profile.onePost + "\(postId)"
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: urlString, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictResponse, error, erroType, statusCode in
            
            switch statusCode{
            case 200:
            let response = dictResponse as? [String:Any]
            
            if let data = response?["data"]  as? [String:Any]{
                
                self.singlePostData = SinglePostDataModel.init(with: data)
                self.userPost.isHidden = false
                self.updatePostList()
                
            }
            case 409:
                self.showAlert(withMessage: "Post Unavailable") {
                    if self.fromvc == .Notification {
                        kSharedAppDelegate.pushToTabBarViewC()
                    } else {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            default:
                print("invalid")
            }
        }

    }
    
}

extension PhotosPost : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if postId == "" {
            return self.postData.count
        } else {
            return 1
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = userPost.dequeueReusableCell(withIdentifier: "PostDescTableViewCell", for: indexPath) as? PostDescTableViewCell else { return UITableViewCell() }

        if postId == "" {
            
            let data = self.postData[indexPath.row]
            cell.configCell(data, indexPath.row)
            cell.sizeToFit()
            
           // cell.btnMoreLess.tag = indexPath.row
            cell.relaodSection = indexPath.section
            
            cell.btnLikeCallback = { index in
                
                print(indexPath.item)
                
            }
            
    //        if data.isExpand == true{
    //            cell.lblPostDesc.numberOfLines = 0
    //            cell.btnMoreLess.setTitle("....less", for: .normal)
    //        }else{
    //            cell.lblPostDesc.numberOfLines = 2
    //            cell.btnMoreLess.setTitle("....more", for: .normal)
    //        }
            cell.likeCallback = { index in
                //self.postTableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .automatic)
                cell.lblPostLikeCount.text = "\(data.likeCount ?? 0)"
                cell.likeImage.image = data.likeFlag == 0 ? UIImage(named: "icons8_heart") : UIImage(named: "liked_icon")
                
                
                
            }
            if data.attachments?.first?.attachmentLink?.width == 0 || data.attachments?.first?.attachmentLink?.height == 0 || data.attachments?.first?.attachmentLink?.width == nil || data.attachments?.first?.attachmentLink?.height == nil{
                print("error")
    //                    cell.newHeightCllctn = 350
    //                    cell.imageHeightCVConstant.constant = 350
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
                        newWidth = 350
                    }
                    newWidth = newWidth * Int(ratio)
                    
                        
                        //cell.imageConstant.constant = newWidth
                        cell.newHeightCllctn = Int(newWidth)
                        cell.imageHeightCVConstant.constant = CGFloat(newWidth)
                }
        }
            cell.reloadCallBack = { tag, section in
                let data = self.postData[tag ?? -1]
                
                if data.isExpand == false{
                    data.isExpand = true
                }else{
                    data.isExpand = false
                }
                //self.postTableView.reloadData()
                let indexPath = IndexPath(row: tag ?? -1, section: indexPath.section)
                self.userPost.reloadRows(at: [indexPath], with: .automatic)
                self.userPost.scrollToRow(at: indexPath, at: .top, animated: false)

            }
            
           // cell.menuDelegate = self
            
            cell.menuDelegate = self

            cell.commentCallback = { postCommentsUserData in
                let vc = self.pushViewController(withName: PostCommentsViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as? PostCommentsViewController
                vc?.postid = data.postID ?? 0
            }
            
            
            
        } else {
            
            let data = self.singlePostData
//            cell.configCell1(data ?? <#default value#>, indexPath.row)
           
            //cell.sizeToFit()
            
//            if data?.subjectId?.roleId == UserRoles.producer.rawValue{
//                cell.userName.text = data?.subjectId?.companyName?.capitalized
//               // cell.userNickName.text = data?.subjectId?.email?.lowercased()
//            }else if data?.subjectId?.roleId == UserRoles.restaurant.rawValue{
//                cell.userName.text = data?.subjectId?.restaurantName?.capitalized
//                //cell.userNickName.text = data?.subjectId?.email?.lowercased()
//            }else if(data?.subjectId?.roleId == UserRoles.voyagers.rawValue) || (data?.subjectId?.roleId == UserRoles.voiceExperts.rawValue)  {
//                cell.userName.text = "\(data?.subjectId?.firstName?.capitalized ?? "") \(data?.subjectId?.lastName?.capitalized ?? "")"
//               // cell.userNickName.text = data?.subjectId?.email?.lowercased()
//            }else{
//                cell.userName.text = data?.subjectId?.companyName?.capitalized
//               // cell.userNickName.text = data?.subjectId?.email?.lowercased()
//            }
            if data?.subjectId?.roleId == UserRoles.producer.rawValue{
                cell.userName.text = data?.subjectId?.companyName?.capitalized
                cell.userNickName.text = "Producer,"//modelData.subjectId?.email?.lowercased()
            }else if data?.subjectId?.roleId == UserRoles.restaurant.rawValue{
                cell.userName.text = data?.subjectId?.restaurantName?.capitalized
                cell.userNickName.text = "Restaurant,"//modelData.subjectId?.email?.lowercased()
            }else if(data?.subjectId?.roleId == UserRoles.voyagers.rawValue){
                cell.userName.text = "\(data?.subjectId?.firstName?.capitalized ?? "") \(data?.subjectId?.lastName?.capitalized ?? "")"
                cell.userNickName.text = "Voyager"//modelData.subjectId?.email?.lowercased()
                cell.follower.isHidden = true
            }else if data?.subjectId?.roleId == UserRoles.voiceExperts.rawValue{
                cell.userName.text = "\(data?.subjectId?.firstName?.capitalized ?? "") \(data?.subjectId?.lastName?.capitalized ?? "")"
                cell.userNickName.text = "Voice Of Experts,"//modelData.subjectId?.email?.lowercased()
            }else if data?.subjectId?.roleId == UserRoles.distributer1.rawValue {
                cell.userName.text = data?.subjectId?.companyName?.capitalized
                cell.userNickName.text = "Importer,"//modelData.subjectId?.email?.lowercased()
            }else if data?.subjectId?.roleId == UserRoles.distributer2.rawValue{
                cell.userName.text = data?.subjectId?.companyName?.capitalized
                cell.userNickName.text = "Distributer,"//modelData.subjectId?.email?.lowercased()
            }else if data?.subjectId?.roleId == UserRoles.distributer3.rawValue{
                cell.userName.text = data?.subjectId?.companyName?.capitalized
                cell.userNickName.text = "Importer & Distributer,"//modelData.subjectId?.email?.lowercased()
            }else if data?.subjectId?.roleId == UserRoles.travelAgencies.rawValue{
                cell.userName.text = data?.subjectId?.companyName?.capitalized
                cell.userNickName.text = "Travel Agencies,"//modelData.subjectId?.email?.lowercased()
            }
            if(data?.subjectId?.roleId == UserRoles.voyagers.rawValue){
                
                cell.follower.isHidden = true
            } else {
                cell.follower.isHidden = false
                cell.follower.text = "\(data?.follower_count ?? 0) Followers"
            }
            cell.lblPostDesc.text = data?.body
            cell.lblPostLikeCount.text = "\(data?.likeCount ?? 0)"
            cell.lblPostCommentCount.text = "\(data?.commentCount ?? 0)"
            cell.lblPostTime.text = data?.posted_at
            //islike = data.likeFlag
            if data?.attachmentCount == 0 {
               // cell.imageHeightCVConstant.constant = 0
                cell.imagePostCollectionView.isHidden = true
    //            imagePostCollectionView.alpha = 0.0
            }else{
                cell.imagePostCollectionView.isHidden = true
            }
//                if data?.attachments?.first?.attachmentLink?.height == data?.attachments?.first?.attachmentLink?.width {
//                    cell.imageHeightCVConstant.constant = 250
//                }else{
//                    cell.imageHeightCVConstant.constant = 400
//                }
//    //            imagePostCollectionView.alpha = 1.0
//            }
            cell.userImage.layer.borderWidth = 0.5
            cell.userImage.layer.borderColor = UIColor.lightGray.cgColor
            print("ImageUrl--------------------------------\(String.getString(data?.subjectId?.avatarId?.attachmentUrl) )")
            if String.getString(data?.subjectId?.avatarId?.attachmentUrl) == ""{
                cell.userImage.image = UIImage(named: "profile_icon")
            }else{
                cell.userImage.setImage(withString: String.getString(data?.subjectId?.avatarId?.baseUrl) + String.getString(data?.subjectId?.avatarId?.attachmentUrl))
            }
            cell.likeImage.image = data?.likeFlag == 0 ? UIImage(named: "icons8_heart") : UIImage(named: "liked_icon")
            
            cell.likeCallback = { index in
                //self.postTableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .automatic)
                cell.lblPostLikeCount.text = "\(data?.likeCount ?? 0)"
                cell.likeImage.image = data?.likeFlag == 0 ? UIImage(named: "icons8_heart") : UIImage(named: "liked_icon")
                
            }
            
            
            cell.imagePostCollectionView.isPagingEnabled = true

            cell.imagePostCollectionView.showsHorizontalScrollIndicator = false
            

            cell.imageArray.removeAll()
            if (data?.attachments?.isEmpty == true) || (data?.attachments?.count == 0){
                print("No Data")
            }else{
                for i in  0..<(data?.attachmentCount ?? 0) {
                    let baseUrl = data?.attachments?[i].attachmentLink?.baseUrl ?? ""
                    let imageUrl = baseUrl + (data?.attachments?[i].attachmentLink?.attachmentUrl ?? "")
                    cell.imageArray.append(imageUrl)
                }
            }

//            if cell.imageArray.count <= 0 {
//                cell.pageControl.alpha = 0
//            } else {
//                cell.pageControl.alpha = 1
//                cell.pageControl.numberOfPages = cell.imageArray.count
//            }
            cell.pages = cell.imageArray.count
            cell.vwpageControl.pages = cell.pages
            if cell.imageArray.count <= 0 || cell.imageArray.count == 1{
                cell.pageControl.alpha = 0
                cell.vwpageControl.alpha = 0
            } else {
                cell.pageControl.alpha = 1
                cell.pageControl.numberOfPages = cell.imageArray.count
                cell.vwpageControl.alpha = 1
                cell.pages = cell.imageArray.count
                cell.vwpageControl.pages = cell.pages
                
                (0..<(cell.pages )).map { $0 % 2 == 0 ? UIColor.clear : UIColor.clear }.forEach { color in
                    let item = UIView()
                    item.translatesAutoresizingMaskIntoConstraints = false
                    item.backgroundColor = color
                    cell.stackView.addArrangedSubview(item)
                    item.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor).isActive = true
                }
            }
          
            let  wordContains = data?.body?.count ?? 0
            //let lblSize = lblPostDesc.numberOfLines
            //print("lableSize?>>>>>>>>>>>>>>>>>>>>>>>>>>>>",lblSize)
            if wordContains <= 60 {
    //            btnMoreLess.isHidden = true
            }else{
               // btnMoreLess.isHidden = false
            }
            cell.menuDelegate = self
            cell.imagePostCollectionView.reloadData()
            
            cell.commentCallback = { postCommentsUserData in
                let vc = self.pushViewController(withName: PostCommentsViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as? PostCommentsViewController
                vc?.postid = data?.postID ?? 0
            }
            
           
            
        }
        
        
        
        
        return cell
    }
    
    func showCommentScreen(_ model: PostCommentsUserData) {
        self.performSegue(withIdentifier: "seguePostsToComment", sender: model)
    }


//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 400
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension PhotosPost: ShareEditMenuProtocol {
   
    
    func menuBttonTapped(postID: Int?, userID: Int?) {
        
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
                    //self.callNewFeedApi(1)
                    self.fetchPostWithPhotsFromServer(1, visitorId: self.visitorId)
                }
            }

        } catch {
            print(error.localizedDescription)
        }
    }

    func editPost(_ postID: Int) {
        let data = postData.filter({ $0.postID == postID })
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
        let data = postData.filter({ $0.postID == postID })
        if let searchDataModel = data.first {
            let sharePostDataModel = SharePost.PostData.post(attachments: searchDataModel.attachments,
                                                             postOwnerDetail: searchDataModel.subjectId,
                                                             postDescription: "\(searchDataModel.body ?? "")",
                                                             postID: postID)
            self.performSegue(withIdentifier: "seguePostsToSharePost", sender: sharePostDataModel)
        }
    }

}
