//
//  DiscoverRecipeHomeCollectionViewCell.swift
//  Alysei
//
//  Created by namrata upadhyay on 18/09/21.
//

import UIKit

class DiscoverRecipeHomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var exploreView: UIView!
    @IBOutlet weak var exploreLabel: UILabel!
    @IBOutlet weak var exploreHighlightView: UIView!
    
    
    override func awakeFromNib() {
         super.awakeFromNib()
         
         contentView.translatesAutoresizingMaskIntoConstraints = true
         
//         NSLayoutConstraint.activate([
//             contentView.leftAnchor.constraint(equalTo: 10),
//             contentView.rightAnchor.constraint(equalTo: 10),
//             contentView.topAnchor.constraint(equalTo: topAnchor),
//             contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
//         ])
     }
}
