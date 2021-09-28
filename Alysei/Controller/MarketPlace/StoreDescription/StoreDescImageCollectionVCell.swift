//
//  StoreDescImageCollectionVCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/9/21.
//

import UIKit

class StoreDescImageCollectionVCell: UICollectionViewCell {
    
    @IBOutlet weak var imgStore: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgStore.layer.cornerRadius = 10
    }
}
