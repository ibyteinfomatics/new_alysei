//
//  AwardCollectionViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 18/11/21.
//

import UIKit

class AwardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var rewardImage: UIImageView!
    @IBOutlet weak var competitionName: UILabel!
    @IBOutlet weak var winningproduct: UILabel!
    
    @IBOutlet weak var awardimg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(withAllProductsDataModel model: AllProductsDataModel?,pushedFrom: Int = 0) -> Void{

      
    }

}





