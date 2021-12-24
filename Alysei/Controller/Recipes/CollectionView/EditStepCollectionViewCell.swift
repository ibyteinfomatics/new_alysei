//
//  EditStepCollectionViewCell.swift
//  Alysei
//
//  Created by namrata upadhyay on 10/10/21.
//

import UIKit

class EditStepCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var desciptionTextView: UITextView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    
    @IBOutlet weak var step1Label: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    
//    var delegate: CollectionViewCellDelegate?
   
    var enteredValueInTxtVw: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
      
//        if desciptionTextView.text == "Your recipe direction text here..."{
//            enteredValueInTxtVw = nil
//        }
        
        desciptionTextView.delegate = self
        titleTextField.delegate = self
        titleTextField.autocorrectionType = .no
        desciptionTextView.autocorrectionType = .no
        descriptionView.layer.borderWidth = 1
        descriptionView.layer.cornerRadius = 5
        descriptionView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor

        titleView.layer.borderWidth = 1
        titleView.layer.cornerRadius = 5
        titleView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        
        if isFromStep == "Add Step"{
            desciptionTextView.text = "Your recipe direction text here..."
            desciptionTextView.textColor = UIColor.darkGray
        }
        else{
            desciptionTextView.textColor = UIColor.black
        }
    }
}
extension EditStepCollectionViewCell : UITextViewDelegate, UITextFieldDelegate {
    
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == "Your recipe direction text here..."{
            textView.text = ""
            
        }
        else{
            textView.textColor = UIColor.black
        }
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

    
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        
        if updatedText.isEmpty {
           
            textView.text = "Your recipe direction text here..."
            textView.textColor = UIColor.darkGray

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }

        
        else if textView.textColor == UIColor.darkGray && !text.isEmpty {
           textView.textColor = UIColor.black
            textView.text = text
          
       }

        else {
            
            return true
        }

        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
       
      textField.becomeFirstResponder()
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField)
    {
        textField.resignFirstResponder()
    }
}


