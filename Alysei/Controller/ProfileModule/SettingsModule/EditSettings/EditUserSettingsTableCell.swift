//
//  SettingScreenTableCell.swift
//  Alysie
//
//  Created by Alendra Kumar on 18/01/21.
//

import UIKit

class EditUserSettingsTableCell: UITableViewCell {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var lblHeading: UILabel!
  @IBOutlet weak var txtFieldSettings: UITextFieldExtended!
  @IBOutlet weak var btnInfo: UIButton!
  
  //MARK: - Properties -
  
  var settingsEditDataModel: SettingsEditDataModel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
      self.txtFieldSettings.delegate = self
    self.txtFieldSettings.addTarget(self, action: #selector(EditUserSettingsTableCell.textFieldEditingChanged(_:)),for: UIControl.Event.editingChanged)
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapInfo(_ sender: UIButton) {
    
  }
  
  //MARK: - Public Methods -
  
  @objc func textFieldEditingChanged(_ sender: UITextFieldExtended){

    self.settingsEditDataModel.settingsSelectedValue = String.getString(self.txtFieldSettings.text)
  }
  
  public func configure(withSettingsEditDataModel model: SettingsEditDataModel){
      
    self.settingsEditDataModel = model

    self.txtFieldSettings.text = model.settingsSelectedValue
    self.lblHeading.text = model.settingsHeading
    self.txtFieldSettings.isUserInteractionEnabled = ((model.settingsHeading == AppConstants.Email.capitalized) || (model.settingsHeading == AppConstants.CompanyName.capitalized)) ? false : true
    self.txtFieldSettings.attributedPlaceholder = NSAttributedString(string: String.getString(model.settingsPlaceholder),
                                                                   attributes: [NSAttributedString.Key.foregroundColor: AppColors.liteGray.color])
      
      if ((model.settingsHeading == AppConstants.Username) && ((model.settingsSelectedValue != ""))) {
          txtFieldSettings.isUserInteractionEnabled = false
          
      }else{
          txtFieldSettings.isUserInteractionEnabled = true
      }
  }
}
extension EditUserSettingsTableCell:  UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {

        if self.settingsEditDataModel.settingsHeading == AppConstants.kUrl ||  self.settingsEditDataModel.settingsHeading == AppConstants.kURL  {
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.spellCheckingType = .no
            return true

        }
        return true
    }
}
