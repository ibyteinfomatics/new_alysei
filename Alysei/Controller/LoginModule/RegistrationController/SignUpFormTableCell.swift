//
//  SignUpSecondTableCell.swift
//  ScreenBuild
//
//  Created by Alendra Kumar on 14/01/21.
//

import UIKit

protocol TappedSwitch {
  
  func tapSwitch(_ stepTwoModel: SignUpStepTwoDataModel?,_ stepOneModel: SignUpStepOneDataModel? ,switchAnswer: UISwitch, btn: UIButton, currentTapType: Int?) -> Void
}

class SignUpFormTableCell: UITableViewCell {
    
  //MARK: - IBOutlet -
    
  @IBOutlet weak var lblProperty: UILabel!
  @IBOutlet weak var btnInfo: UIButton!
  @IBOutlet weak var switchAnswer: UISwitch!
  @IBOutlet weak var lblHeadingTopConst: NSLayoutConstraint!
  //@IBOutlet weak var txtFieldProperty: UITextField!
  
  @IBOutlet weak var lblValue: UILabel!
  
  //MARK: - Properties -
  
  var delegate: TappedSwitch?
  var currentStepTwoModel: SignUpStepTwoDataModel!
  var currentStepOneModel: SignUpStepOneDataModel!
    
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  //MARK: - Public Methods -
  
//  @objc func textFieldEditingChanged(_ sender: UITextFieldExtended){
//
//    if self.currentStepTwoModel != nil{
//      self.currentStepTwoModel.selectedValue = String.getString(self.txtFieldProperty.text)
//    }
//    else{
//     self.currentStepOneModel.selectedValue = String.getString(self.txtFieldProperty.text)
//    }
//  }
  
  public func configure(withSignUpStepTwoDataModel model: SignUpStepTwoDataModel){
      
    self.currentStepTwoModel = model
    self.switchAnswer.isOn = (model.selectedValue == AppConstants.Yes.capitalized) ? true : false
    lblProperty.text = model.title
    //self.lblValue.isUserInteractionEnabled = true
    self.lblValue.text = (model.selectedValue == AppConstants.Yes.capitalized) ? AppConstants.Yes.capitalized : AppConstants.No
  }
  
  public func configure(withSignUpStepOneDataModel model: SignUpStepOneDataModel){
      
    self.currentStepOneModel = model
    self.switchAnswer.isOn = (model.selectedValue == AppConstants.Yes.capitalized) ? true : false
    lblProperty.text = model.title
    //self.txtFieldProperty.isUserInteractionEnabled = true
    self.lblValue.text = (model.selectedValue == AppConstants.Yes.capitalized) ? AppConstants.Yes.capitalized : AppConstants.No
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapSwitch(_ sender: UISwitch) {
    
    self.delegate?.tapSwitch(self.currentStepTwoModel, self.currentStepOneModel, switchAnswer: self.switchAnswer,btn: self.btnInfo,currentTapType: 0)
  }
  
  @IBAction func tapInfo(_ sender: UIButton) {
    
    self.delegate?.tapSwitch(self.currentStepTwoModel,self.currentStepOneModel ,switchAnswer: self.switchAnswer,btn: self.btnInfo,currentTapType: 1)
  }
  
}

