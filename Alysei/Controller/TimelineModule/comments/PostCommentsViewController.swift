//
//  PostCommentsViewController.swift
//  Alysei
//
//  Created by Shivani Vohra Gandhi on 11/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PostCommentsDisplayLogic: class {
    func loadComments(_ response: PostComments.Comment.Response)
}

class PostCommentsViewController: AlysieBaseViewC, PostCommentsDisplayLogic {
    var interactor: PostCommentsBusinessLogic?
    var router: (NSObjectProtocol & PostCommentsRoutingLogic & PostCommentsDataPassing)?

    // MARK:- Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    var commentmessages:[CommentClass]?
    var countLikeComment:[PostClass]?

    var postCommentsUserDataModel: PostCommentsUserData!
    var model: PostComments.Comment.Response!
    var postOwnerID: Int!
    var commentID: Int! // this is to be used when user taps on reply button.
    
    var like = 0,comment = 0 , postid = 0
    var commentId = 0
    var replyTap = false

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        
    }
    
    func receiveComment() {
        
        kChatharedInstance.receivce_Comment(postId: String.getString(self.postid)) { (message) in
            
            self.commentmessages?.removeAll()
            self.commentmessages = message
            self.tableView.reloadData()
            self.scrollToLTopRow()
            
            if self.commentmessages?.count ?? 0 == 0{
                self.vwBlank.isHidden = false
            }else{
                self.vwBlank.isHidden = true
            }
            
        }
        
            
    }
        
    

    // MARK:- Setup

    private func setup() {
        let viewController = self
        let interactor = PostCommentsInteractor()
        let presenter = PostCommentsPresenter()
        let router = PostCommentsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      self.viewNavigation.drawBottomShadow()
       // self.tableView.drawBottomShadow()
    }

    // MARK:- View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.tableView.register(UINib(nibName: "PostCommentsCell", bundle: nil), forCellReuseIdentifier: "cell")

        self.tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //self.tableView.allowsSelection = false

        self.commentTextfield.delegate = self
        
        
        if postid > 0 {
            self.interactor?.fetchComments(self.postid)
        } else {
            self.interactor?.fetchComments(self.postCommentsUserDataModel.postID)
        }

        
        self.profilePhotoButton.layer.cornerRadius = self.profilePhotoButton.frame.width / 2.0
        self.profilePhotoButton.layer.masksToBounds = true

        if let profilePhoto = LocalStorage.shared.fetchImage(UserDetailBasedElements().coverPhoto) {
            self.profilePhotoButton.setImage(profilePhoto, for: .normal)
//
        } else {
            let profilePhoto = UIImage(named: "profile_icon")
            self.profilePhotoButton.setImage(profilePhoto, for: .normal)
            
        }
        
        for i in 0..<(self.commentmessages?.count ?? 0){
            self.commentmessages?[i].isSelected = false
        }
//        self.commentTextfield.becomeFirstResponder()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if postid == 0 {
           postid = self.postCommentsUserDataModel.postID
        }
        bottomViewForCommentTextField.layer.borderWidth = 1
        bottomViewForCommentTextField.layer.borderColor = UIColor.lightGray.cgColor
        receiveComment()
        
    }

    // MARK:- IBOutlets
    @IBOutlet weak var viewNavigation: UIView!
    @IBOutlet weak var backButton: UIButtonExtended!
    @IBOutlet weak var titleLabel: UILabelExtended!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var bottomViewForCommentTextField: UIView!
    @IBOutlet weak var commentTextfield: UITextFieldBorderWidthAndColor!
    @IBOutlet weak var profilePhotoButton: UIButtonExtended!
    @IBOutlet weak var sendCommentButton: UIButtonExtended!
    @IBOutlet weak var vwBlank: UIView!

    // MARK:- protocol methods
    func loadComments(_ response: PostComments.Comment.Response) {
        self.model = response
        self.commentTextfield.text = ""
        self.tableView.reloadData()
        self.commentTextfield.resignFirstResponder()
//        if !self.commentTextfield.isFirstResponder {
//            self.commentTextfield.becomeFirstResponder()
//        }
    }

    //MARK: custom methods
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func scrollToLTopRow() {
        DispatchQueue.main.async {
            if Int.getInt(self.commentmessages?.count) != 0 {
                let indexPath = IndexPath(row: Int.getInt(self.commentmessages?.count) - 1, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                //self.commentTextfield.becomeFirstResponder()
            }
        }
    }

    func sendComment() {
        
        
        let params: [String:Any] = [
            
            "post_id": self.postid,
            "comment": self.commentTextfield.text,
            "user_id" : Int.getInt(kSharedUserDefaults.loggedInUserModal.userId)
            
        ]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kPostComment, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            
            if let data = dictResponse?["data"] as? [String:Any]{
                
                let core_comment_id = Int.getInt(data["core_comment_id"])
                
                //print("core_comment_id ",core_comment_id)
                
                let date = Date()
                let df = DateFormatter()
                df.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateString = df.string(from: date)
                
                let likecomment = LikeCommentClass()
                likecomment.likeCount = self.like
                likecomment.commentCount = self.comment
                likecomment.postId = self.postid
                
                let comment = CommentClass()
                comment.body = self.commentTextfield.text
                comment.core_comment_id = core_comment_id//self.postCommentsUserDataModel.postID
                comment.created_at = dateString
                
                let poster = PosterClass()
                
                if kSharedUserDefaults.loggedInUserModal.companyName != ""{
                    poster.restaurant_name = kSharedUserDefaults.loggedInUserModal.companyName
                } else if kSharedUserDefaults.loggedInUserModal.restaurantName != ""{
                    poster.restaurant_name = kSharedUserDefaults.loggedInUserModal.restaurantName
                } else if kSharedUserDefaults.loggedInUserModal.firstName != ""{
                    poster.restaurant_name = String.getString(kSharedUserDefaults.loggedInUserModal.firstName)+String.getString(kSharedUserDefaults.loggedInUserModal.lastName)
                }
                
                //poster.restaurant_name = ""
                poster.email = String.getString(kSharedUserDefaults.loggedInUserModal.email)
                poster.name = String.getString(kSharedUserDefaults.loggedInUserModal.userName)
                poster.role_id = Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId)
                poster.user_id = Int.getInt(kSharedUserDefaults.loggedInUserModal.userId)
                
                
                let avatar = CommentAvatarId()
                avatar.attachment_type = "jpg"
                avatar.attachment_url = kSharedUserDefaults.loggedInUserModal.avatar?.imageURL?.replacingOccurrences(of: imageDomain, with: "")
                avatar.poster_created_at = dateString
                avatar.id = Int.getInt(kSharedUserDefaults.loggedInUserModal.userId)
                avatar.updated_at = dateString
                
                kChatharedInstance.send_comment(countDic: likecomment, commentDisc: comment, poster: poster, avtar: avatar, postId: String.getString(self.postid) )
                
                self.commentTextfield.text = ""
                self.commentId = 0
                self.receiveComment()
                self.tableView.reloadData()
                
            }
            
        }
        
    }
    
    func sendReplyComment(comment_id : String) {
       
        let params: [String:Any] = [
            
            "post_id": self.postid,
            "reply": self.commentTextfield.text,
            "user_id" : Int.getInt(kSharedUserDefaults.loggedInUserModal.userId),
            "comment_id":comment_id
            
        ]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kPostReplyComment, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            
            if let data = dictResponse?["data"] as? [String:Any]{
                
                let core_comment_id = Int.getInt(data["core_comment_id"])
                
                //print("core_comment_id ",core_comment_id)
                
                let date = Date()
                let df = DateFormatter()
                df.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateString = df.string(from: date)
                
                let likecomment = LikeCommentClass()
                likecomment.likeCount = self.like
                likecomment.commentCount = self.comment
                likecomment.postId = self.postid
                
                let comment = CommentClass()
                comment.body = self.commentTextfield.text
                comment.core_comment_id = core_comment_id//self.postCommentsUserDataModel.postID
                comment.created_at = dateString
                
                let poster = PosterClass()
                
                if kSharedUserDefaults.loggedInUserModal.companyName != ""{
                    poster.restaurant_name = kSharedUserDefaults.loggedInUserModal.companyName
                } else if kSharedUserDefaults.loggedInUserModal.restaurantName != ""{
                    poster.restaurant_name = kSharedUserDefaults.loggedInUserModal.restaurantName
                } else if kSharedUserDefaults.loggedInUserModal.firstName != ""{
                    poster.restaurant_name = String.getString(kSharedUserDefaults.loggedInUserModal.firstName)+String.getString(kSharedUserDefaults.loggedInUserModal.lastName)
                }
                
                //poster.restaurant_name = ""
                poster.email = String.getString(kSharedUserDefaults.loggedInUserModal.email)
                poster.name = String.getString(kSharedUserDefaults.loggedInUserModal.userName)
                poster.role_id = Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId)
                poster.user_id = Int.getInt(kSharedUserDefaults.loggedInUserModal.userId)
                
                
                let avatar = CommentAvatarId()
                avatar.attachment_type = "jpg"
                avatar.attachment_url = kSharedUserDefaults.loggedInUserModal.avatar?.imageURL?.replacingOccurrences(of: imageDomain, with: "")
                avatar.poster_created_at = dateString
                avatar.id = Int.getInt(kSharedUserDefaults.loggedInUserModal.userId)
                avatar.updated_at = dateString
                
                kChatharedInstance.send_reply_comment(countDic: likecomment, commentDisc: comment, poster: poster, avtar: avatar, postId: String.getString(self.postid), replypostId: comment_id )
                
                self.commentTextfield.text = ""
                self.commentId = 0
                self.receiveComment()
                self.tableView.reloadData()
                
            }
            
        }
        
    }
    
    func getcurrentdateWithTime(datetime :String?) -> String {
        
        //initialize the Date Formatter
         let dateFormatter1 = DateFormatter()

         //specify the date Format
         dateFormatter1.dateFormat="yyyy-MM-dd HH:mm:ss"

         //get date from string
        let dateString = dateFormatter1.date(from: datetime!)

         //get timestamp from Date
        let dateTimeStamp  = dateString!.timeIntervalSince1970
        
        let date = Date(timeIntervalSince1970: dateTimeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "dd MM YYYY"
        dateFormatter.locale =  Locale(identifier:  "en")
        let localDate = dateFormatter.string(from: date)
        
        let units = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second, .weekOfYear])
            let components = Calendar.current.dateComponents(units, from: date, to: Date())

            if components.year! > 0 {
                return "\(components.year!) " + (components.year! > 1 ? "years ago" : "year ago")

            } else if components.month! > 0 {
                return "\(components.month!) " + (components.month! > 1 ? "months ago" : "month ago")

            } else if components.weekOfYear! > 0 {
                return "\(components.weekOfYear!) " + (components.weekOfYear! > 1 ? "weeks ago" : "week ago")

            } else if (components.day! > 0) {
                return (components.day! > 1 ? "\(components.day!) Days" : "Yesterday")

            } else if components.hour! > 0 {
                return "\(components.hour!) " + (components.hour! > 1 ? "hours ago" : "hour ago")

            } else if components.minute! > 0 {
                return "\(components.minute!) " + (components.minute! > 1 ? "minutes ago" : "minute ago")

            } else {
                return "\(components.second!) " + (components.second! > 1 ? "seconds ago" : "second ago")
            }
        
    }

    func sendReply(_ commentID: Int) {
        guard let text = self.commentTextfield.text else {
            showAlert(withMessage: "Comment can't be blank.")
            return
        }

        let selfID = Int(kSharedUserDefaults.loggedInUserModal.userId ?? "-1") ?? 0
        let requestModel = PostComments.Reply.Request(post_owner_id: self.postCommentsUserDataModel.userID,
                                                     user_id: selfID,
                                                     post_id: self.postid,
                                                     comment_id: commentID,
                                                     comment: text)
        self.interactor?.postReply(requestModel)
    }

    // MARK:- IBAction methods
    @IBAction func backButtonTapped(_ sender: UIButtonExtended) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func profilePhotoButtonTapped(_ sender: UIButtonExtended) {

    }

    @IBAction func sendCommentButtonTapped(_ sender: UIButtonExtended) {
        if self.commentTextfield.text == "" {
            //self.sendReply(self.commentID)
            showAlert(withMessage: "Comment can't be blank.")
        } else {
            
            
            if self.commentId != 0 {
                self.sendReplyComment(comment_id: String.getString(self.commentId))
            } else {
                self.sendComment()
            }
            
            //self.commentTextfield.text = ""
        }
    }

}

extension PostCommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentmessages?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SelfPostCommentsCell else {
            return UITableViewCell()
        }
        cell.commentReplyDelegate = self
        
        let data = self.commentmessages?[indexPath.row]
        if data?.isSelected == true {
            cell.setReply(self.commentmessages?[indexPath.row].reply ?? [])
        } else {
            cell.setReply([])
        }
        //cell.replyBtn.tag = indexPath.row
        cell.btnReplyCallback = {tag in
           // self.replyTap = true
            self.commentId = self.commentmessages?[indexPath.row].core_comment_id ?? 0
            self.commentTextfield.becomeFirstResponder()
            self.commentTextfield.placeholder = "Leave a Reply"
        }
        cell.btnViewReplyCallback = {tag in
            
            if data?.isSelected == true {
                data?.isSelected = false
                cell.setReply([])
                self.tableView.reloadRows(at: [indexPath], with: .none)
            } else {
                
                data?.isSelected = true
                cell.setReply(self.commentmessages?[indexPath.row].reply ?? [])
                self.tableView.reloadRows(at: [indexPath], with: .none)
            }

            
        }
        
        if self.commentmessages?[indexPath.row].reply.count ?? 0 > 0 {
            //cell.viewReplyButtonconstraint.constant = 20
            cell.viewReplyButton.isHidden = false
            cell.viewReplyButton.setTitle("---- View \(self.commentmessages?[indexPath.row].reply.count ?? 0) Reply", for: .normal)
        } else {
            
            //cell.viewReplyButtonconstraint.constant = 0
            cell.viewReplyButton.isHidden = true
        }
        
        let time = getcurrentdateWithTime(datetime: self.commentmessages?[indexPath.row].created_at)
        
        cell.descriptionLabel.text = self.commentmessages?[indexPath.row].body
        cell.userNameLabel.text = self.commentmessages?[indexPath.row].data?.restaurant_name//"\(name)"
        cell.timeLabel.text = "\(time)"
        cell.userImageView.setImage(withString: imageDomain+"/"+String.getString(self.commentmessages?[indexPath.row].data?.data?.attachment_url), placeholder: UIImage(named: "image_placeholder"))
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.commentmessages?[indexPath.row].body)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}


extension PostCommentsViewController: CommnentReplyProtocol {
    func addReplyToComment(_ commentID: Int) {
        
        self.commentID = commentID
        self.commentTextfield.placeholder = "Add a reply to comment"
        self.commentTextfield.becomeFirstResponder()
    }

}

extension PostCommentsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        //self.commentTextfield.placeholder = "Leave a comment"
        self.commentId = 0
    }
}
