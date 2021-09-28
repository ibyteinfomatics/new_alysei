//
//  LikeRecipeCollectionViewCell.swift
//  New Recipe module
//
//  Created by mac on 19/08/21.
//

import UIKit

class LikeRecipeCollectionViewCell: UICollectionViewCell {
    
   

          
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var UsernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var servingLabel: UILabel!
    @IBOutlet weak var cousineTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            likeView.layer.cornerRadius = 10.0

        // border
        likeView.layer.borderColor = UIColor.lightGray.cgColor
        likeView.layer.borderWidth = 1.0

        // drop shadow
        likeView.layer.shadowColor = UIColor.lightGray.cgColor
        likeView.layer.shadowOpacity = 0.8
        likeView.layer.shadowRadius = 3.0
        likeView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        likeView.layer.masksToBounds = false
    }
    
}
