//
//  PhotosPost.swift
//  Alysei
//
//  Created by Gitesh Dang on 25/10/21.
//

import UIKit

class PhotosPost: AlysieBaseViewC {
    
    @IBOutlet weak var userPost: UITableView!
    
    var pageNumber = 1
    var visitorId = ""
    var position = 0
    //TODO: pagination is pending
    var count = 100
    var postId = ""
    var fromvc: FromVC?
   // var postData = [PostList.innerData]()
    var postData = [NewFeedSearchDataModel]()
    var singlePostData : SinglePostDataModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.userPost.rowHeight = UITableView.automaticDimension
        self.userPost.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if postId == "" {
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
            let response = dictResponse as? [String:Any]
            
            if let data = response?["data"]  as? [String:Any]{
                
                self.singlePostData = SinglePostDataModel.init(with: data)
                self.updatePostList()
                
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
                cell.likeImage.image = data.likeFlag == 0 ? UIImage(named: "like_icon") : UIImage(named: "liked_icon")
                
                
                
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

            cell.commentCallback = { postCommentsUserData in
                let vc = self.pushViewController(withName: PostCommentsViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as? PostCommentsViewController
                vc?.postid = data.postID ?? 0
            }
            
            
        } else {
            
            
            let data = self.singlePostData
            //cell.sizeToFit()
            
            if data?.subjectId?.roleId == UserRoles.producer.rawValue{
                cell.userName.text = data?.subjectId?.companyName?.capitalized
                cell.userNickName.text = data?.subjectId?.email?.lowercased()
            }else if data?.subjectId?.roleId == UserRoles.restaurant.rawValue{
                cell.userName.text = data?.subjectId?.restaurantName?.capitalized
                cell.userNickName.text = data?.subjectId?.email?.lowercased()
            }else if(data?.subjectId?.roleId == UserRoles.voyagers.rawValue) || (data?.subjectId?.roleId == UserRoles.voiceExperts.rawValue)  {
                cell.userName.text = "\(data?.subjectId?.firstName?.capitalized ?? "") \(data?.subjectId?.lastName?.capitalized ?? "")"
                cell.userNickName.text = data?.subjectId?.email?.lowercased()
            }else{
                cell.userName.text = data?.subjectId?.companyName?.capitalized
                cell.userNickName.text = data?.subjectId?.email?.lowercased()
            }
            
            cell.lblPostDesc.text = data?.body
            cell.lblPostLikeCount.text = "\(data?.likeCount ?? 0)"
            cell.lblPostCommentCount.text = "\(data?.commentCount ?? 0)"
            cell.lblPostTime.text = data?.posted_at
            //islike = data.likeFlag
            if data?.attachmentCount == 0 {
                cell.imageHeightCVConstant.constant = 0
    //            imagePostCollectionView.alpha = 0.0
            }else{
                if data?.attachments?.first?.attachmentLink?.height == data?.attachments?.first?.attachmentLink?.width {
                    cell.imageHeightCVConstant.constant = 250
                }else{
                    cell.imageHeightCVConstant.constant = 400
                }
    //            imagePostCollectionView.alpha = 1.0
            }
            cell.userImage.layer.borderWidth = 0.5
            cell.userImage.layer.borderColor = UIColor.lightGray.cgColor
            print("ImageUrl--------------------------------\(String.getString(data?.subjectId?.avatarId?.attachmentUrl) )")
            if String.getString(data?.subjectId?.avatarId?.attachmentUrl) == ""{
                cell.userImage.image = UIImage(named: "profile_icon")
            }else{
                cell.userImage.setImage(withString: kImageBaseUrl + String.getString(data?.subjectId?.avatarId?.attachmentUrl))
            }
            cell.likeImage.image = data?.likeFlag == 0 ? UIImage(named: "like_icon") : UIImage(named: "liked_icon")
            
            cell.likeCallback = { index in
                //self.postTableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .automatic)
                cell.lblPostLikeCount.text = "\(data?.likeCount ?? 0)"
                cell.likeImage.image = data?.likeFlag == 0 ? UIImage(named: "like_icon") : UIImage(named: "liked_icon")
                
            }
            
            
            cell.imagePostCollectionView.isPagingEnabled = true

            cell.imagePostCollectionView.showsHorizontalScrollIndicator = false
            

            cell.imageArray.removeAll()
            if (data?.attachments?.isEmpty == true) || (data?.attachments?.count == 0){
                print("No Data")
            }else{
                for i in  0..<(data?.attachmentCount ?? 0) {
                    cell.imageArray.append(data?.attachments?[i].attachmentLink?.attachmentUrl ?? "")
                }
            }

            if cell.imageArray.count <= 0 {
                cell.pageControl.alpha = 0
            } else {
                cell.pageControl.alpha = 1
                cell.pageControl.numberOfPages = cell.imageArray.count
            }
            let  wordContains = data?.body?.count ?? 0
            //let lblSize = lblPostDesc.numberOfLines
            //print("lableSize?>>>>>>>>>>>>>>>>>>>>>>>>>>>>",lblSize)
            if wordContains <= 60 {
    //            btnMoreLess.isHidden = true
            }else{
               // btnMoreLess.isHidden = false
            }
           
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
