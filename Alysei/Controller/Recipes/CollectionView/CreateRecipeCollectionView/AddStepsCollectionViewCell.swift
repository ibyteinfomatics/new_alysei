//
//  AddStepsCollectionViewCell.swift
//  Alysei
//
//  Created by namrata upadhyay on 23/08/21.
//

import UIKit

class AddStepsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var desciptionTextView: UITextView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    
    @IBOutlet weak var step1Label: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    
    var enteredValueInTxtVw: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
        
        if fromVC == "AddToolsViewController"{
            desciptionTextView.text = "Your recipe direction text here..."
            desciptionTextView.textColor = UIColor.lightGray
        }
        else{
            if desciptionTextView.text == "Your recipe direction text here..."{
                desciptionTextView.textColor = UIColor.lightGray
            }
            else{
                desciptionTextView.textColor = UIColor.black
            }
           
        }
    }
}
extension AddStepsCollectionViewCell : UITextViewDelegate, UITextFieldDelegate {
    
    

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
            textView.textColor = UIColor.lightGray

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }

        
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
           textView.textColor = UIColor.black
            textView.text = text
          
       }

        else {
            
            return true
        }

        return false
    }

    func textFieldDidBeginEditing(_ textField: UITextField)
    {
       
      textField.becomeFirstResponder()
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (titleTextField.text! as NSString).replacingCharacters(in: range, with: string)
        let numberOfChars = newText.count
        return numberOfChars < 36
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        textField.resignFirstResponder()
    }
}

