//
//  SignUpTermsTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 03/02/21.
//

import UIKit

protocol SignUpTermsDelegate {
  
  func tapOnButtons(stepOneModel: SignUpStepOneDataModel?,stepTwoModel: SignUpStepTwoDataModel?) -> Void
}

class SignUpTermsTableCell: UITableViewCell {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var btnCheckBox: UIButtonExtended!
  @IBOutlet weak var txtViewTitle: UITextView!
  
  //MARK: - Properties -
  
  var currentStepOneModel: SignUpStepOneDataModel?
  var currentStepTwoModel: SignUpStepTwoDataModel?
  var delegate: SignUpTermsDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.btnCheckBox.isSelected = false
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapCheckBox(_ sender: UIButton) {
    
    if currentStepOneModel != nil{
      self.delegate?.tapOnButtons(stepOneModel: self.currentStepOneModel!, stepTwoModel: nil)
    }
    else{
      self.delegate?.tapOnButtons(stepOneModel: nil, stepTwoModel: self.currentStepTwoModel!)
    }
  }
  
  //MARK: - Public Methods -
  
  public func configure(withSignUpStepOneDataModel stepOnemodel: SignUpStepOneDataModel?,withSignUpStepTwoDataModel stepTwomodel: SignUpStepTwoDataModel?){
    
    if stepOnemodel != nil{
      
      self.currentStepOneModel = stepOnemodel
      let image = (stepOnemodel?.selectedValue == AppConstants.Yes.capitalized) ? UIImage(named: "icon_greenCheckMark") : UIImage(named: "icon_uncheckedBox")
      self.btnCheckBox.setImage(image, for: .normal)
      txtViewTitle.attributedText = String.getString(stepOnemodel?.title).htmlAttributedString()
    }
    else{
      self.currentStepTwoModel = stepTwomodel
      let image = (stepTwomodel?.selectedValue == AppConstants.Yes.capitalized) ? UIImage(named: "icon_greenCheckMark") : UIImage(named: "icon_uncheckedBox")
      self.btnCheckBox.setImage(image, for: .normal)
      txtViewTitle.attributedText = String.getString(stepTwomodel?.title).htmlAttributedString()
    }
    
  }
}

