//
//  SignUpFormSelectTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 06/02/21.
//

import UIKit

class SignUpFormSelectTableCell: UITableViewCell {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var lblHeading: UILabel!
  @IBOutlet weak var txtFieldSelect: UITextFieldExtended!
  @IBOutlet weak var imgViewDropDown: UIImageView!
  @IBOutlet weak var imgViewLocation: UIImageView!
    var title:String?
  
  //MARK: - Properties -
  
  var currentModel: SignUpStepTwoDataModel!
  
  override func awakeFromNib() {
    
    super.awakeFromNib()
    txtFieldSelect.makeCornerRadius(radius: 5.0)
    self.txtFieldSelect.delegate = self
    self.txtFieldSelect.addTarget(self, action: #selector(SignUpFormSelectTableCell.textFieldEditingChanged(_:)),for: UIControl.Event.editingChanged)
  }
  
  //MARK: - Public Methods -
  
  @objc func textFieldEditingChanged(_ sender: UITextFieldExtended){

    self.currentModel.selectedValue = String.getString(self.txtFieldSelect.text)
  }

  //MARK: - Public Methods -
  
  public func configureData(withSignUpStepTwoDataModel model: SignUpStepTwoDataModel) -> Void{
    
    self.lblHeading.text = (model.required == AppConstants.Yes) ? String.getString(model.title) + "*" : model.title
    self.title = (model.required == AppConstants.Yes) ? String.getString(model.title) + "*" : model.title
    self.txtFieldSelect.attributedPlaceholder = NSAttributedString(string: String.getString(model.placeholder).capitalized,
                                                                   attributes: [NSAttributedString.Key.foregroundColor: AppColors.liteGray.color])
    
    if model.title == AppConstants.kVATNo || model.title == AppConstants.kZipCode{
        self.txtFieldSelect.keyboardType = .numberPad
    } else {
        self.txtFieldSelect.keyboardType = .default
    }
    
    self.currentModel = model
    switch model.type {
    case AppConstants.Text:
      self.txtFieldSelect.isUserInteractionEnabled = true
      self.txtFieldSelect.text = model.selectedValue
      self.imgViewDropDown.isHidden = true
      self.imgViewLocation.isHidden = true
    case AppConstants.Map:
      self.imgViewDropDown.isHidden = true
      self.imgViewLocation.isHidden = false
        let firstchar = model.selectedValue?.first
        print("First char -----------------",firstchar)
        if firstchar == "," {
            model.selectedValue?.removeFirst()
        }
      self.txtFieldSelect.text = model.selectedValue
      self.txtFieldSelect.isUserInteractionEnabled = false
    default:
      self.imgViewDropDown.isHidden = false
      self.imgViewLocation.isHidden = true
      self.txtFieldSelect.isUserInteractionEnabled = false
      self.txtFieldSelect.text = model.selectedOptionName

    }
  }
}
extension SignUpFormSelectTableCell: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                if title == AppConstants.kZipCode + "*" {
            print("textField Count-------------------------\(textField.text?.count ?? 0)")
             if textField.text?.count ?? 0 == 11 {
                if let char = string.cString(using: String.Encoding.utf8) {
                    let isBackSpace = strcmp(char, "\\b")
                    if (isBackSpace == -92) {
                        print("Backspace was pressed")
                        return true
            }
                }
            }
            if textField.text?.count ?? 0 <= 10{
                if let char = string.cString(using: String.Encoding.utf8) {
                    let isBackSpace = strcmp(char, "\\b")
                    if (isBackSpace == -92) {
                        print("Backspace was pressed")
                        return true
                    }else {
                        var strText: String? = textField.text
                        if strText == nil {
                            strText = ""
                        }
                        strText = strText?.replacingOccurrences(of: "-", with: "")
                         if strText!.count > 1 && strText!.count % 5 == 0 && string != "" {
                            textField.text = "\(textField.text!)-\(string)"
                            return false
                        }
                    }
                }
            }else{
                    return false
                }
        }
            return true
            
        }
}
