//
//  PreferencesImageCollectionViewCell.swift
//  Filter App
//
//  Created by mac on 15/09/21.
//

import UIKit

class PreferencesImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var vwImage: UIView!
    @IBOutlet weak var imgLeading: NSLayoutConstraint!
    @IBOutlet weak var imgTrailing: NSLayoutConstraint!
    @IBOutlet weak var imgTop: NSLayoutConstraint!
    @IBOutlet weak var imgBottom: NSLayoutConstraint!
    
//    @IBOutlet weak var imageIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imgTop.constant = 0
        imgLeading.constant = 0
        imgBottom.constant = 0
        imgTrailing.constant = 0
    }
}
