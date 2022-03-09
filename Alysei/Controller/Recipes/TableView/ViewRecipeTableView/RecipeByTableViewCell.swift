//
//  RecipeByTableViewCell.swift
//  New Recipe module
//
//  Created by mac on 19/08/21.
//

import UIKit

class RecipeByTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewProfileButton: UIButton!
    @IBOutlet weak var recipeByLabel: UILabel!
    //    @IBOutlet weak var leaveACommentButton: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    
//    @IBOutlet weak var profileImgComment: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    
//    @IBOutlet weak var latestCommentImg: UIImageView!
//    @IBOutlet weak var latestCommentUserName: UILabel!
//    @IBOutlet weak var latestCommentDate: UILabel!
//    @IBOutlet weak var latestCommentTextView: UILabel!
//
//    @IBOutlet weak var rateImg1: UIImageView!
//    @IBOutlet weak var rateImg2: UIImageView!
//    @IBOutlet weak var rateImg3: UIImageView!
//    @IBOutlet weak var rateImg4: UIImageView!
//    @IBOutlet weak var rateImg5: UIImageView!
    
    var btnViewProfileCallback:(() -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recipeByLabel.text = RecipeConstants.kRecipeBy
        
        setUi()
        // Initialization code
    }
    func setUi(){ viewProfileButton.layer.borderWidth = 1
            viewProfileButton.layer.cornerRadius = 16
            viewProfileButton.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor

    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func viewProfileButton(_ sender: Any) {
        btnViewProfileCallback?()
    }
    
    
    

}
