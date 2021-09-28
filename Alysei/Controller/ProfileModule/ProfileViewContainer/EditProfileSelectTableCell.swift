//
//  EditProfileSelectTableCell.swift
//  Alysie
//
//  Created by Alendra Kumar on 15/01/21.
//

import UIKit

class EditProfileSelectTableCell: UITableViewCell {
    
  //MARK: - IBOutlet -
    
  @IBOutlet weak var lblHeading: UILabel!
  @IBOutlet weak var txtField: UITextField!
  @IBOutlet weak var imgViewDropDown: UIImageView!
  @IBOutlet weak var lblHeadingTopConst: NSLayoutConstraint!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.txtField.makeCornerRadius(radius: 5.0)
  }
  
  //MARK: - IBOutlet -
  
  public func configure(withSignUpStepOneDataModel model: SignUpStepOneDataModel){
    
    self.lblHeading.text = model.title
    self.txtField.placeholder = model.placeholder
    self.txtField.text = model.selectedOptionName
    
    switch model.type {
    case AppConstants.Checkbox,AppConstants.Multiselect,AppConstants.Select:
      self.txtField.isUserInteractionEnabled = false
      self.imgViewDropDown.isHidden = false
    default:
      self.txtField.isUserInteractionEnabled = true
      self.imgViewDropDown.isHidden = true
    }
  }
}
