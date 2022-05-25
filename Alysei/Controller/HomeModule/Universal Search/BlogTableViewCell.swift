//
//  BlogsTableViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 18/11/21.
//

import UIKit

class BlogTableViewCell: UITableViewCell {

    @IBOutlet weak var blogImage: UIImageView!
    @IBOutlet weak var blogTitle: UILabel!
    @IBOutlet weak var blogDescription: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var noItemLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var mainVw: UIView!
    @IBOutlet weak var lblAuthorName: UILabel!
    var btnReadMoreCallback:((Int) -> Void)? = nil
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.userImage.layer.cornerRadius = self.userImage.frame.height/2
        mainVw.layer.shadowColor = UIColor.darkGray.withAlphaComponent(0.8).cgColor
        mainVw.layer.shadowRadius = 2
        mainVw.layer.shadowOpacity = 0.8
        mainVw.layer.shadowOffset = .zero
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func btnReadMoreAction(_ sender: UIButton){
        btnReadMoreCallback?(sender.tag)
    }
    
    
}

