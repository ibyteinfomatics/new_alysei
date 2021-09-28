//
//  HubListTableViewCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 7/15/21.
//

import UIKit

class HubListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stateName: UILabel!
    @IBOutlet weak var imgFlag: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgFlag.layer.cornerRadius = 20
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(_ data: SignUpOptionsDataModel){
        self.stateName.text = data.title
       // self.imgFlag.setImage(withString: kImageBaseUrl + String.getString(data.imageHub))
    }

}
