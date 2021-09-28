//
//  ProductListTViewCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/15/21.
//

import UIKit

class ProductListTViewCell: UITableViewCell {
    
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var btnCheckBox: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
