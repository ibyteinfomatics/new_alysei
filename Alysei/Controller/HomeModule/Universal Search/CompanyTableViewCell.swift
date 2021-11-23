//
//  CompanyTableViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 18/11/21.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {

    @IBOutlet weak var labelUserType: UILabel!
    @IBOutlet weak var labelPeopleName: UILabel!
    @IBOutlet weak var labelPeopleDetail: UILabel!
    @IBOutlet weak var peopleImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
