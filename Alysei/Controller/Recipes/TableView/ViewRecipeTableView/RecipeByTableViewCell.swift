//
//  RecipeByTableViewCell.swift
//  New Recipe module
//
//  Created by mac on 19/08/21.
//

import UIKit

class RecipeByTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewProfileButton: UIButton!
    @IBOutlet weak var leaveACommentButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUi()
        // Initialization code
    }
    func setUi(){ viewProfileButton.layer.borderWidth = 1
            viewProfileButton.layer.cornerRadius = 16
            viewProfileButton.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor
    
            leaveACommentButton.layer.borderWidth = 1
            leaveACommentButton.layer.cornerRadius = 20
            leaveACommentButton.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func viewProfileButton(_ sender: Any) {
    }
    @IBAction func leaveACommentTapped(_ sender: UIButton) {
    }
    
    

}
