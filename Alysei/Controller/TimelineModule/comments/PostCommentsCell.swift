//
//  PostCommentsCell.swift
//  Alysei
//
//  Created by Shivani Vohra Gandhi on 11/07/21.
//

import UIKit


protocol CommnentReplyProtocol {
    func addReplyToComment(_ commentID: Int)
}

class SelfPostCommentsCell: UITableViewCell {

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var view: UIView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var likecount: UILabel!
    @IBOutlet var likeimage: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var viewReplyButton: UIButton!
    @IBOutlet var replyBtn: UIButton!
    @IBOutlet var threedotBtn: UIButton!
    @IBOutlet var threedotImg: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewconstraint: NSLayoutConstraint!
    @IBOutlet var viewReplyButtonconstraint: NSLayoutConstraint!
    @IBOutlet var replyButtonconstraint: NSLayoutConstraint!
   

    var commentReplyDelegate: CommnentReplyProtocol!
    var model: PostComments.Comment.Response!
    
    var postId = ""
    var position = 0
    var commentmessages:[ReplyDetailsClass]?
    
    var btnViewReplyCallback:((Int) -> Void)? = nil
    var btnReplyCallback:((Int) -> Void)? = nil
    var btnThreeDotCallback:((Int) -> Void)? = nil
    var btnLikeCallback:((Int) -> Void)? = nil
    
    var replyEditCallback:((_ editmessage : String, _ precommentId : Int, _ commentid : Int) -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 5
        tableView.isHidden = false
        //threedotBtn.isHidden = true
        self.tableView.register(UINib(nibName: "PostCommentsCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.userImageView.layer.cornerRadius = self.userImageView.frame.width / 2.0
        loadReplytable()
    }
    
    func setReply(_ commentmessages: [ReplyDetailsClass], postid : String) {
        //ReplyDetailsClass.init(commentId: commentId)
        postId = postid
        print("test ",postid)
        self.commentmessages = commentmessages
       
        
        self.tableViewconstraint.constant = CGFloat((140 * (self.commentmessages?.count ?? 0)))
        tableView.reloadData()
    }

    func loadReplytable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self

        //self.tableView.tableFooterView = UIView()

        self.tableView.reloadData()
    }
    
    @IBAction func replyButtonTapped(_ sender: UIButton) {
        //self.commentReplyDelegate.addReplyToComment(self.viewReplyButton.tag)
        btnReplyCallback?(sender.tag)
    }
    
    @IBAction func threedotButtonTapped(_ sender: UIButton) {
       
        btnThreeDotCallback?(sender.tag)
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
       
        btnLikeCallback?(sender.tag)
    }

    @IBAction func viewreplyButtonTapped(_ sender: UIButton) {
        //self.commentReplyDelegate.addReplyToComment(self.viewReplyButton.tag)
        btnViewReplyCallback?(sender.tag)
    }
    
    func callLikeUnlikeApi(_ isLike: Int?, _ postId: Int?, _ commentId: Int? , _ previouscommentId: Int? ,_ indexPath: Int?){
        let selfID = Int(kSharedUserDefaults.loggedInUserModal.userId ?? "-1") ?? 0
        
        let params: [String:Any] = [
            "post_id": postId ?? 0,
            "like_or_unlike": isLike ?? 0,
            "user_id": selfID,
            "comment_id": commentId ?? 0
        ]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kCommentLikeApi, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            if statusCode == 200 {
                
                let response = dictResponse as? [String:Any]
                let total_like = response?["total_likes"] as? Int
                let like_id = response?["like_id"] as? Int
                
                self.commentmessages?[indexPath ?? 0].comment_like_count = ((self.commentmessages?[indexPath ?? 0].comment_like_count ?? 0) + 1)
                
                if response?["message"] as! String == "You like this comment" {
                    
                    let likecomment = Comment_Like_Class()
                    likecomment.user_id = Int.getInt(kSharedUserDefaults.loggedInUserModal.userId)
                    likecomment.comment_id = commentId ?? 0
                    likecomment.like_id = like_id
                    
                    kChatharedInstance.send_comment_like(commentlike: likecomment, postid:  String.getString(postId))
                    
                } else {
                    kChatharedInstance.deleteParticularCommentLike(like_id: String.getString(like_id), post_id: String.getString(postId))
                }
                
                
                
               // kChatharedInstance.update_comment_Like_count(likecount: total_like ?? 0, postId: postId ?? 0, commentId: commentId ?? 0)
                
                kChatharedInstance.update_replycomment_Like_count(likecount: total_like ?? 0, postId: postId ?? 0, commentId: previouscommentId ?? 0, replycommentId: commentId ?? 0)
                
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
}

class OtherUserPostCommentsCell: SelfPostCommentsCell {
    @IBOutlet var replyButton: UIButton!
    @IBOutlet var likeButton: UIButton!
}

class PostCommentWithReplyCell: SelfPostCommentsCell {
//    @IBOutlet var replyTableView: UITableView!

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//
//        if self.model.data.count > 0 {
//            self.tableView.reloadData()
//        }
//    }
}

extension SelfPostCommentsCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return commentmessages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SelfPostCommentsCell else {
            return UITableViewCell()
        }
        cell.tableViewconstraint.constant = 0
        cell.viewReplyButtonconstraint.constant = 0
        cell.viewReplyButton.isHidden = true
        cell.replyButtonconstraint.constant = 0
        cell.replyBtn.isHidden = true
        let time = getcurrentdateWithTime(datetime: self.commentmessages?[indexPath.row].created_at)
        
        cell.likecount.text = String.getString(self.commentmessages?[indexPath.row].comment_like_count)
        cell.descriptionLabel.text = self.commentmessages?[indexPath.row].body
        cell.userNameLabel.text = self.commentmessages?[indexPath.row].data?.restaurant_name//"\(name)"
        cell.timeLabel.text = "\(time)"
        cell.userImageView.setImage(withString:String.getString(self.commentmessages?[indexPath.row].data?.data?.attachment_url), placeholder: UIImage(named: "image_placeholder"))
        cell.likeimage.image = self.commentmessages?[indexPath.row].isLike == false ? UIImage(named: "icons8_heart") : UIImage(named: "liked_icon")
        
        let selfID = Int(kSharedUserDefaults.loggedInUserModal.userId ?? "-1") ?? 0
        if self.commentmessages?[indexPath.row].data?.user_id == selfID {
            cell.threedotBtn.isHidden = false
            cell.threedotImg.isHidden = false
        } else {
            cell.threedotImg.isHidden = true
            cell.threedotBtn.isHidden = true
        }
        
        cell.btnLikeCallback = {tag in
            
            let commentid = self.commentmessages?[indexPath.row].core_comment_id ?? 0
            let prevuioscommentid = self.commentmessages?[indexPath.row].previous_comment_id ?? 0
            let like = self.commentmessages?[indexPath.row].isLike == false ? 1 : 0
            
            self.callLikeUnlikeApi(like, Int.getInt(self.postId), commentid, prevuioscommentid, indexPath.row)
            
        }
        
        cell.btnThreeDotCallback = {tag in
            print("kjsdfh ",self.commentmessages?[indexPath.row].previous_comment_id ?? 0)
            let actionSheet = UIAlertController(style: .actionSheet)
            
            let edit = UIAlertAction(title: "Edit", style: .default) { action in
                
                self.replyEditCallback?(self.commentmessages?[indexPath.row].body ?? "", self.commentmessages?[indexPath.row].previous_comment_id ?? 0, self.commentmessages?[indexPath.row].core_comment_id ?? 0)
                
            }
            
            let delete = UIAlertAction(title: "Delete", style: .destructive) { action in
                
               // let postId = String.getString(self.postid)
                let previoscommentId = String.getString(self.commentmessages?[indexPath.row].previous_comment_id)
                let commentId = String.getString(self.commentmessages?[indexPath.row].core_comment_id)
                
               // let postId = String.getString(self.postid)
               // let commentId = String.getString(self.commentmessages?[indexPath.row].core_comment_id)
                
                let params: [String:Any] = [
                    
                    "comment_id": self.self.commentmessages?[indexPath.row].core_comment_id ?? 0,
                    "post_id" : self.postId
                    
                ]
                
                TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kDeleteComment, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
                    
                    if statusCode == 200 {
                        kChatharedInstance.deleteParticularCommentLike(comment_id: previoscommentId, post_id: self.postId, replycomment_id: commentId)
                    }
                    
                }
                
                
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in

            }
            
            actionSheet.addAction(edit)
            actionSheet.addAction(delete)
            actionSheet.addAction(cancelAction)
            
            self.parentViewController?.parent?.present(actionSheet, animated: true, completion: nil)
            //self.showAlert()
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
