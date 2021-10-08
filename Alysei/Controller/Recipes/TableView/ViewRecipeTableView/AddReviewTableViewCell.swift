//
//  AddReviewTableViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 08/10/21.
//

import UIKit

class AddReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImg: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelEmailID: UILabel!
    @IBOutlet weak var labelComment: UILabel!
    
    @IBOutlet weak var rateImg1: UIImageView!
    @IBOutlet weak var rateImg2: UIImageView!
    @IBOutlet weak var rateImg3: UIImageView!
    @IBOutlet weak var rateImg4: UIImageView!
    @IBOutlet weak var rateImg5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
