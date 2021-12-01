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
       // bgView.layer.backgroundColor = UIColor.darkGray.withAlphaComponent(0.2).cgColor
        bgView.layer.cornerRadius = 10
//        bgView.addShadow()
        // drop shadow
        bgView.layer.shadowColor = UIColor.init(red: 154/255, green: 154/255, blue: 154/255, alpha: 1).cgColor
        bgView.layer.shadowOpacity = 0.8
        bgView.layer.shadowRadius = 3.0
        bgView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    }
    
}
