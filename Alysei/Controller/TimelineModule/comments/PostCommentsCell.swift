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
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var viewReplyButton: UIButton!
    @IBOutlet var replyBtn: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewconstraint: NSLayoutConstraint!
    @IBOutlet var viewReplyButtonconstraint: NSLayoutConstraint!
   

    var commentReplyDelegate: CommnentReplyProtocol!
    var model: PostComments.Comment.Response!
    
    var position = 0
    var commentmessages:[ReplyDetailsClass]?
    
    var btnViewReplyCallback:((Int) -> Void)? = nil
    var btnReplyCallback:((Int) -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.isHidden = false
        self.tableView.register(UINib(nibName: "PostCommentsCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.userImageView.layer.cornerRadius = self.userImageView.frame.width / 2.0
        loadReplytable()
    }
    
    func setReply(_ commentmessages: [ReplyDetailsClass]) {
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

    @IBAction func viewreplyButtonTapped(_ sender: UIButton) {
        //self.commentReplyDelegate.addReplyToComment(self.viewReplyButton.tag)
        btnViewReplyCallback?(sender.tag)
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
        //cell.viewReplyButtonconstraint.constant = 0
        cell.viewReplyButton.isHidden = true
        
        let time = getcurrentdateWithTime(datetime: self.commentmessages?[indexPath.row].created_at)
        
        cell.descriptionLabel.text = self.commentmessages?[indexPath.row].body
        cell.userNameLabel.text = self.commentmessages?[indexPath.row].data?.restaurant_name//"\(name)"
        cell.timeLabel.text = "\(time)"
        cell.userImageView.setImage(withString: imageDomain+"/"+String.getString(self.commentmessages?[indexPath.row].data?.data?.attachment_url), placeholder: UIImage(named: "image_placeholder"))
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
