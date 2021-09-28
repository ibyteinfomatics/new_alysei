//
//  SignUpMultiSelectCollectionCell.swift
//  Alysie
//
//  Created by CodeAegis on 08/02/21.
//

import UIKit

class SignUpMultiSelectCollectionCell: UICollectionViewCell {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var imgViewCheckBox: UIImageView!
  @IBOutlet weak var lblHeading: UILabel!
  
  //MARK: - Public Methods -
  
  public func configureData(withSignUpStepTwoOptionsModel model: SignUpStepTwoOptionsModel) -> Void{
    
    self.lblHeading.text = model.optionName
    self.imgViewCheckBox.image  = (model.isSelected == true) ? UIImage(named: "icon_blueSelected") : UIImage(named: "icon_uncheckedBox")
  }
}
