//
//  MyRecipeTableViewCell.swift
//  Alysei
//
//  Created by namrata upadhyay on 05/10/21.
//

import UIKit
var tableviewHeight = CGFloat()
class MyRecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var editRecipeButton: UIButton!
    @IBOutlet weak var deaftButton: UIButton!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var recipeImageView: ImageLoader!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var servingLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var rating1ImgVw: UIImageView!
    @IBOutlet weak var rating2ImgVw: UIImageView!
    @IBOutlet weak var rating3ImgVw: UIImageView!
    @IBOutlet weak var rating4ImgvW: UIImageView!
    @IBOutlet weak var rating5ImgVw: UIImageView!
   
    var btnEditCallback:((Int) -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        editRecipeButton.layer.cornerRadius = 18
        deaftButton.layer.cornerRadius = 18
        
        outerView.addShadow()
        
//        self.layer.cornerRadius = 10.0
//        self.layer.shadowColor = UIColor.lightGray.cgColor
//        self.layer.shadowOpacity = 0.8
//        self.layer.shadowRadius = 3.0
//        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//        self.layer.masksToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapForEdit(_ sender: UIButton) {
        btnEditCallback?(sender.tag)
    }
    
}
