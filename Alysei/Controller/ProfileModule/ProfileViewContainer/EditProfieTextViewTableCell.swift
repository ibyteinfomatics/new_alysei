//
//  EditProfileTextViewTableCell.swift
//  Alysie
//
//  Created by Alendra Kumar on 15/01/21.
//

import UIKit

class EditProfileTextViewTableCell: UITableViewCell {

  //MARK: - IBOutlet -
  
  @IBOutlet weak var lblHeading: UILabel!
  @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var lblHeadingTopConst: NSLayoutConstraint!
  //MARK: - Properties -
  
  var model: SignUpStepOneDataModel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.txtView.makeCornerRadius(radius: 5.0)
    self.txtView.delegate = self
  }
  
  //MARK: - Public Methods -
  
  public func configure(withSignUpStepOneDataModel model: SignUpStepOneDataModel) -> Void{
    
    self.model = model
    self.lblHeading.text = model.title
    self.txtView.text = (model.selectedValue == "0") ? "" : model.selectedValue
  }
}

//MARK: - TextViewDelegate Methods -

extension EditProfileTextViewTableCell: UITextViewDelegate{
  
  func textViewDidChange(_ textView: UITextView) {
  
    self.model.selectedValue = String.getString(textView.text)
  }
}
