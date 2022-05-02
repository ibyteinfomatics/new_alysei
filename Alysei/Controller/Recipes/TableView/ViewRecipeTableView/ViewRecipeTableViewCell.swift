//
//  ViewRecipeTableViewCell.swift
//  New Recipe module
//
//  Created by mac on 12/08/21.
//

import UIKit

class ViewRecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientImageView: UIImageView!
    @IBOutlet weak var ingredientNameLabel: UILabel!
    @IBOutlet weak var ingredientQuantityLabel: UILabel!
    @IBOutlet weak var vwImage : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vwImage.layer.cornerRadius = self.vwImage.frame.height / 2
        vwImage.layer.borderWidth = 0.5
        vwImage.layer.borderColor = UIColor.lightGray.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
}
