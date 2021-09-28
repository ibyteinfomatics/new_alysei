//
//  ReviewScreenTableViewCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/9/21.
//

import UIKit

class ReviewScreenTableViewCell: UITableViewCell {
   
    @IBOutlet weak var lblName: UILabel!
    //@IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserReview: UILabel!
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    @IBOutlet weak var imgUser: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgUser.layer.cornerRadius = 30
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
