//
//  MyRecipeCollectionViewCell.swift
//  Preferences
//
//  Created by mac on 27/08/21.
//

import UIKit

class MyRecipeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var editRecipeButton: UIButton!
    @IBOutlet weak var deaftButton: UIButton!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var recipeImageView: UIImageView!
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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        editRecipeButton.layer.cornerRadius = 18
        deaftButton.layer.cornerRadius = 18
        
//        // drop shadow
//        outerView.layer.cornerRadius = 10.0
//        outerView.layer.shadowColor = UIColor.black.cgColor
//        outerView.layer.shadowOpacity = 0.8
//        outerView.layer.shadowRadius = 3.0
//        outerView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//        outerView.layer.masksToBounds = true
        // drop shadow
        self.layer.cornerRadius = 10.0
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.masksToBounds = true
        
        
    }

}
