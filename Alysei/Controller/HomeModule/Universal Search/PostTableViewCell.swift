//
//  PostTableViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 18/11/21.
//

import UIKit
import ScrollingPageControl

protocol EditMenuProtocol {
    func menuBttonTapped(_ postID: Int?, userID: Int)
}
class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userNickName: UILabel!
    @IBOutlet weak var lblPostDesc: UILabel!
    @IBOutlet weak var lblPostLikeCount: UILabel!
    @IBOutlet weak var lblPostCommentCount: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var viewLike: UIView!
    @IBOutlet weak var viewShare: UIView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var commentImage: UIView!
    @IBOutlet weak var lblPostTime: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgPost: UIImageView!
    
    @IBOutlet var vwpageControl: ScrollingPageControl!
    
    @IBOutlet weak var noItemLabel: UILabel!
    var data: NewFeedSearchDataModel?
    var likeCallback:((Int) -> Void)? = nil
    var shareCallback:(()->())?
    var commentCallback:((PostCommentsUserData) -> Void)? = nil
    var islike: Int?
    var index: Int?
    var imageArray = [String]()
    var menuDelegate: EditMenuProtocol!
    var isExpand = false
    var previousIndex: Int?
    var currentIndex: Int?
    var reloadCallBack: ((Int?,Int?) -> Void)? = nil
    var relaodSection : Int?
    
    var btnLikeCallback:((Int) -> Void)? = nil
    var pages = 0
    let stackView = UIStackView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
         lblPostDesc.numberOfLines = 2
        userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.layer.masksToBounds = true
        self.vwpageControl.selectedPage = pages
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(likeAction))
        tap.numberOfTouchesRequired = 1
        self.viewLike.addGestureRecognizer(tap)
        

        let tap2 = UITapGestureRecognizer(target: self, action: #selector(likeAction))
        tap2.numberOfTapsRequired = 2
        self.imgPost.addGestureRecognizer(tap2)

        let showSharesGesture = UITapGestureRecognizer(target: self, action: #selector(self.showShareScreen))
        showSharesGesture.numberOfTouchesRequired = 1
        self.viewShare.addGestureRecognizer(showSharesGesture)
        
        let showCommentsGesture = UITapGestureRecognizer(target: self, action: #selector(self.showCommentsScreen))
        showCommentsGesture.numberOfTouchesRequired = 1
        self.commentImage.addGestureRecognizer(showCommentsGesture)
        
        self.menuButton?.imageView?.contentMode = .scaleAspectFit
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func menuButtonTapped(_ sender: UIButton) {
        self.menuDelegate.menuBttonTapped(self.data?.postID, userID: self.data?.subjectId?.userId ?? 0)
        
    }
   
   
    @objc func showShareScreen(_ tap: UITapGestureRecognizer) {
        self.shareCallback?()
    }
    
    func configCell(_ modelData: NewFeedSearchDataModel, _ index: Int) {
        
//        let selfID = Int(kSharedUserDefaults.loggedInUserModal.userId ?? "-1") ?? 0
        
        
        self.viewLike.tag = index
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(likeAction))
        self.viewLike.addGestureRecognizer(tap)
        
        self.data = modelData
        self.index = index
        self.index = self.data?.postID ?? 0
        if modelData.subjectId?.roleId == UserRoles.producer.rawValue{
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.restaurant.rawValue{
            userName.text = modelData.subjectId?.restaurantName?.capitalized
            userNickName.text = modelData.subjectId?.email?.lowercased()
        }else if(modelData.subjectId?.roleId == UserRoles.voyagers.rawValue) || (modelData.subjectId?.roleId == UserRoles.voiceExperts.rawValue)  {
            userName.text = "\(modelData.subjectId?.firstName?.capitalized ?? "") \(modelData.subjectId?.lastName?.capitalized ?? "")"
            userNickName.text = modelData.subjectId?.email?.lowercased()
        }else{
            
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = modelData.subjectId?.email?.lowercased()
        }
        lblPostDesc.text = modelData.body
        lblPostLikeCount.text = "\(modelData.likeCount ?? 0)"
        lblPostCommentCount.text = "\(modelData.commentCount ?? 0)"
        lblPostTime.text = modelData.posted_at

        self.userImage.layer.borderWidth = 0.5
        self.userImage.layer.borderColor = UIColor.lightGray.cgColor
        print("ImageUrl--------------------------------\(String.getString(modelData.subjectId?.avatarId?.attachmentUrl) )")
        if String.getString(modelData.subjectId?.avatarId?.attachmentUrl) == ""{
            self.userImage.image = UIImage(named: "profile_icon")
        }else{
            self.userImage.setImage(withString: kImageBaseUrl + String.getString(modelData.subjectId?.avatarId?.attachmentUrl))
        }
        likeImage.image = modelData.likeFlag == 0 ? UIImage(named: "icons8_heart") : UIImage(named: "liked_icon")
    
        self.imgPost.setImage(withString: kImageBaseUrl + String.getString(imageArray.first))

        self.imageArray.removeAll()
        if (modelData.attachments?.isEmpty == true) || (modelData.attachments?.count == 0){
            print("No Data")
        }else{
            for i in  0..<(modelData.attachments?.count ?? 0) {
                self.imageArray.append(modelData.attachments?[i].attachmentLink?.attachmentUrl ?? "")
            }
        }
        
       
    }
    
    @objc func likeAction(_ tap: UITapGestureRecognizer){
        if self.data?.likeFlag == 0 {
            islike = 1
           
        }else{
            islike = 0
        }

//        if (islike ?? 0) == 0 {
        callLikeUnlikeApi(self.islike, self.data?.activityActionId, self.index)
          
//         }
        
    
    }
    
    @objc func showCommentsScreen() {
        let model = PostCommentsUserData(userID: self.data?.subjectId?.userId ?? -1,
                                         postID: self.data?.postID ?? 0)
        self.commentCallback?(model)
    }
    
    
}

extension PostTableViewCell {

    func callLikeUnlikeApi(_ isLike: Int?, _ postId: Int? ,_ indexPath: Int?){
        let selfID = Int(kSharedUserDefaults.loggedInUserModal.userId ?? "-1") ?? 0

        let params: [String:Any] = [
            "post_id": postId ?? 0,
            "like_or_unlike": isLike ?? 0,
            "user_id": selfID

        ]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kLikeApi, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            self.data?.likeFlag = isLike
            if isLike == 0{
                self.data?.likeCount = ((self.data?.likeCount ?? 1) - 1)
            }else{
                self.data?.likeCount = ((self.data?.likeCount ?? 1) + 1)
            }
            self.likeCallback?(indexPath ?? 0)

        }
    }

    func viewForDot(at index: Int) -> UIView? {
        guard index == 0 else { return nil }
        let view = TriangleView()
        view.isOpaque = false
        return view
    }

}

