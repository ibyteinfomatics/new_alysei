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
    @IBOutlet weak var lblTextCount: UILabel!
    
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
    let finalText = txtView.text.removeWhitespace()
    self.lblTextCount.text = "\(finalText.count)"
  }
}

//MARK: - TextViewDelegate Methods -

extension EditProfileTextViewTableCell: UITextViewDelegate{
  
  func textViewDidChange(_ textView: UITextView) {
  
    self.model.selectedValue = String.getString(textView.text)
  }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let spaceCount = textView.text.count
        
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        let finalText = updatedText.removeWhitespace()
        if finalText.count <= 200{
         //   let finalText = updatedText.removeWhitespace()
            self.lblTextCount.text = "\(finalText.count)"
            return true
        }else{
            if text == "" && range.length > 0  {
                print("Backspace was pressed")
              //  let finalText = textView.text.removeWhitespace()
                self.lblTextCount.text = "\(finalText.count)"
                return true
            }
            else{
                return false
                
            }
            
        }
        
    }
}
