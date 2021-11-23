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
    
    @IBOutlet weak var mainVw: UIView!
    var btnReadMoreCallback:((Int) -> Void)? = nil
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
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

