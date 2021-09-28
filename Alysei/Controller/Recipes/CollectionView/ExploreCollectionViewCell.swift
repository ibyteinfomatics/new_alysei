//
//  ExploreCollectionViewCell.swift
//  Alysei
//
//  Created by Mohit on 11/08/21.
//

import UIKit

class ExploreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var itemImgVw: UIImageView!
    
    @IBOutlet weak var itemNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        itemImgVw.layer.masksToBounds = false
//        itemImgVw.layer.borderColor = UIColor.white.cgColor
//        itemImgVw.layer.cornerRadius = itemImgVw.frame.size.width / 2
//        itemImgVw.clipsToBounds = true
    }

}
