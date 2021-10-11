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
        
        if enteredValueInTxtVw == ""{
            desciptionTextView.text = "Your recipe description text here..."
            desciptionTextView.textColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        }
        else{
            desciptionTextView.text = enteredValueInTxtVw
            desciptionTextView.textColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.86)
        }
    }
}
extension EditStepCollectionViewCell : UITextViewDelegate, UITextFieldDelegate {
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.text == "Your recipe direction text here..." {
        if enteredValueInTxtVw == ""{
            desciptionTextView.text = ""
            desciptionTextView.textColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.86)
            
           
        }
        else{
            desciptionTextView.textColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.86)
        }
       
        textView.becomeFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == ""{
            enteredValueInTxtVw = "Your recipe direction text here..."
            descriptionView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            desciptionTextView.text = "Your recipe direction text here..."
//            enteredValueInTxtVw = ""
            desciptionTextView.textColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        }
        else{
            enteredValueInTxtVw = desciptionTextView.text
            desciptionTextView.textColor = .black
        }
        textView.resignFirstResponder()
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


