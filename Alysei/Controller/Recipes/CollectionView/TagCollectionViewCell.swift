//
//  TagCollectionViewCell.swift
//  Filter App
//
//  Created by mac on 06/09/21.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    @IBOutlet var tagLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0
        self.layer.cornerRadius = 6
        self.backgroundColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.tagLabel.textColor = .black
    }
    
    
    override var isSelected: Bool {
            didSet {
                self.backgroundColor =  isSelected ? UIColor(red: 59/255, green: 156/255, blue: 128/255, alpha: 1) : UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
                self.isUserInteractionEnabled = isSelected ? false : true
                self.tagLabel.textColor = isSelected ? UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1) : .black
                
            }
        }
}
