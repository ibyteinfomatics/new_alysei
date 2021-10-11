//
//  EditMissingToolTableViewCell.swift
//  Alysei
//
//  Created by namrata upadhyay on 10/10/21.
//

import UIKit

class EditMissingToolTableViewCell: UITableViewCell {

    @IBOutlet weak var toolitemLabel: UILabel!
    @IBOutlet weak var toolQuantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
