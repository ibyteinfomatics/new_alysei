//
//  TrendingCollectionViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 26/08/21.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var trendingImgVw: UIImageView!
    
    @IBOutlet weak var recipeNameLbl: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var servingLabel: UILabel!
    @IBOutlet weak var outerView: UIView!
    
    @IBOutlet weak var typeLabel: UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        outerView.layer.cornerRadius = 10.0
//
//    // border
//        outerView.layer.borderColor = UIColor.lightGray.cgColor
//        outerView.layer.borderWidth = 1.0
//
//    // drop shadow
//        outerView.layer.shadowColor = UIColor.lightGray.cgColor
//        outerView.layer.shadowOpacity = 0.8
//        outerView.layer.shadowRadius = 3.0
//        outerView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//        outerView.layer.masksToBounds = false
        
        

    // border
//        self.layer.borderColor = UIColor.lightGray.cgColor
//        self.layer.borderWidth = 1.0

    // drop shadow
        self.layer.cornerRadius = 10.0
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.masksToBounds = true
        // Initialization code
    }

    @IBAction func tapLikeButton(_ sender: Any) {
        
    }
}
