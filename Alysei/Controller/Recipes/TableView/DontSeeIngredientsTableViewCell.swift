//
//  DontSeeIngredientsTableViewCell.swift
//  Preferences
//
//  Created by mac on 26/08/21.
//

import UIKit

class DontSeeIngredientsTableViewCell: UITableViewCell {
    @IBOutlet weak var searchNameLabel: UILabel!
    @IBOutlet weak var searchAddButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func addNewIngridient(_ sender: Any) {
    }
    
}
