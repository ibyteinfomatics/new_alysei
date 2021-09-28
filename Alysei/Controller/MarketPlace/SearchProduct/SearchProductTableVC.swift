//
//  SearchProductTableVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 7/28/21.
//

import UIKit

class SearchProductTableVC: UITableViewCell {
    
    @IBOutlet weak var lblSearchText: UILabel!
    @IBOutlet weak var lblProductCategoryName : UILabel!
    @IBOutlet weak var imgLeftSide: UIImageView!
    @IBOutlet weak var imgRightSide: UIImageView!
   
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
