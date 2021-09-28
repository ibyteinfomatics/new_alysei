//
//  MarketPlaceHomeCollectionVCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/13/21.
//

import UIKit

class MarketPlaceHomeCollectionVCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblOption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.addShadow()
    }
    
}
