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
    @IBOutlet var tableView: UITableView!

    var commentReplyDelegate: CommnentReplyProtocol!
    var model: PostComments.Comment.Response!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImageView.layer.cornerRadius = self.userImageView.frame.width / 2.0
    }

    func loadReplytable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.tableFooterView = UIView()

        self.tableView.reloadData()
    }

    @IBAction func replyButtonTapped() {
        self.commentReplyDelegate.addReplyToComment(self.viewReplyButton.tag)
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
        return model.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SelfPostCommentsCell else {
            return UITableViewCell()
        }
        let commentData = self.model.data[indexPath.row]
        let name = commentData.poster?.name ?? commentData.poster?.restaurantName ?? commentData.poster?.companyName ?? ""
        cell.descriptionLabel.text = "\(commentData.body)"
        cell.userNameLabel.text = "\(name)"
        cell.timeLabel.text = "\(commentData.convertDate())"
        //        cell.userImageView.setImage(withString: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=400")
        cell.userImageView.setImage(withString: "\(imageDomain)/\(commentData.poster?.avatarID?.attachmentUrl ?? "")")
        return cell
    }

}
