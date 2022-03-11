//
//  ToolsTableViewCell.swift
//  New Recipe module
//
//  Created by mac on 23/08/21.
//

import UIKit

class ToolsTableViewCell: UITableViewCell {
    

    @IBOutlet weak var lblToolUsed: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblToolUsed.text = RecipeConstants.kToolsUsed
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
