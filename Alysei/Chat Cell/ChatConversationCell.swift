//
//  ChatConversationCell.swift
//  RippleApp
//
//  Created by Mohd Aslam on 28/04/20.
//  Copyright © 2020 Fluper. All rights reserved.
//

import UIKit

class ChatConversationCell: UITableViewCell {

    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var messageLblLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewChatCount: UIView!
    @IBOutlet weak var lblChatCount: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
