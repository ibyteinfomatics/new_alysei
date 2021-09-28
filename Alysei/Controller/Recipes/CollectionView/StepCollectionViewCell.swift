//
//  StepCollectionViewCell.swift
//  New Recipe module
//
//  Created by mac on 20/08/21.
//

import UIKit

class StepCollectionViewCell: UICollectionViewCell {
    
@IBOutlet weak var stepButton: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        
        stepButton.layer.cornerRadius = stepButton.frame.width/2
        stepButton.layer.borderWidth = 1
        stepButton.layer.borderColor = UIColor.lightGray.cgColor
      
    }
    
    @IBAction func stepButtonTapped(_ sender: UIButton){
    
}
}
