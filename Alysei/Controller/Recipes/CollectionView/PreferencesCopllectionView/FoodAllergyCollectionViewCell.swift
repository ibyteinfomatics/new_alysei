//
//  FoodAllergyCollectionViewCell.swift
//  Preferences
//
//  Created by mac on 25/08/21.
//

import UIKit


class FoodAllergyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewOfImage: UIView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var image2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewOfImage.layer.cornerRadius = viewOfImage.bounds.width/2
        viewOfImage.layer.borderWidth = 4
        // Initialization code
    }
    
    
    
    
    
}
