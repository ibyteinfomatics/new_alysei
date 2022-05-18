//
//  UserPhotosGridCollectionViewCell.swift
//  Alysei
//
//  Created by Janu Gandhi on 04/06/21.
//

import UIKit

class UserPhotosGridCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var imageView: ImageLoader!
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage(named: "image_placeholder")
        
    }
}
