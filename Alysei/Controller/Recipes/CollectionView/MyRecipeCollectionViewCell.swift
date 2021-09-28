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
