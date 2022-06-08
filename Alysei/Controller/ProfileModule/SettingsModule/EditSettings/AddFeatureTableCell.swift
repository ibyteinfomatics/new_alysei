//
//  AddFeatureTableCell.swift
//  Alysie
//
//  Created by Alendra Kumar on 18/01/21.
//

import UIKit

class AddFeatureTableCell: UITableViewCell {
    
    //MARK: - IBOutlet -
    
    @IBOutlet weak var txtFieldAddFeature: UITextField!
    @IBOutlet weak var lblAddFeature: UILabel!
    @IBOutlet weak var txtViewAddFeature: UITextView!
    @IBOutlet weak var lblCountTxt: UILabel!
    @IBOutlet weak var lblMaxCount: UILabel!
    
    var callback: ((String) -> Void)? = nil
    var userLevel: UserLevel?
    
    var urlFeatureProduct: String?
    //MARK: - Properties -
    
    var productFieldsDataModel: ProductFieldsDataModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTextViewUI()
        txtFieldAddFeature.delegate = self
        self.txtFieldAddFeature.makeCornerRadius(radius: 5.0)
        self.txtFieldAddFeature.addTarget(self, action: #selector(AddFeatureTableCell.textFieldEditingChanged(_:)),for: UIControl.Event.editingChanged)
        self.txtViewAddFeature.makeCornerRadius(radius: 5.0)
        
    }
    
    func setTextViewUI(){
        txtViewAddFeature.layer.borderColor = UIColor.darkGray.cgColor
        txtViewAddFeature.layer.borderWidth = 1
        txtViewAddFeature.textColor = UIColor.lightGray
        txtViewAddFeature.text = AppConstants.kDescription
        txtViewAddFeature.delegate = self
        txtViewAddFeature.textContainer.heightTracksTextView = true
        txtViewAddFeature.isScrollEnabled = false
    }
    
    //MARK: - Public Methods -
    
    @objc func textFieldEditingChanged(_ sender: UITextFieldExtended){
        
        self.productFieldsDataModel.selectedValue = String.getString(self.txtFieldAddFeature.text)
    }
    
    public func configure(withProductFieldsDataModel model: ProductFieldsDataModel){
        
        self.productFieldsDataModel = model
        txtFieldAddFeature.placeholder = model.productTitle
        lblAddFeature.text = model.productTitle
        if userLevel == .other{
            txtFieldAddFeature.isUserInteractionEnabled = false
            txtViewAddFeature.isUserInteractionEnabled = false
        }else{
            txtFieldAddFeature.isUserInteractionEnabled = true
            txtViewAddFeature.isUserInteractionEnabled = true
        }
        if model.productTitle == AppConstants.kDescription{
            txtFieldAddFeature.isHidden = true
            txtViewAddFeature.isHidden = false
            lblCountTxt.isHidden = false
            lblMaxCount.isHidden = false
            
            if txtViewAddFeature.text == AppConstants.kDescription {
                self.lblCountTxt.text = "0"
            }else{
                self.lblCountTxt.text = "\(txtViewAddFeature.text.count)"
            }
        }else{
            txtFieldAddFeature.isHidden = false
            txtViewAddFeature.isHidden = true
            lblCountTxt.isHidden = true
            lblMaxCount.isHidden = true
           
        }
        if (model.productTitle == AppConstants.URL) || (model.productTitle == AppConstants.URL){
            self.urlFeatureProduct = model.selectedValue
            if model.selectedValue == ""  || model.selectedValue == nil {
                txtFieldAddFeature.textColor = UIColor.black
            }else{
                txtFieldAddFeature.textColor = UIColor.link
            }
         
        }
        if model.productTitle == AppConstants.kDescription{
            
        }
        switch model.type {
        case AppConstants.Calander:
            //  txtFieldAddFeature.isUserInteractionEnabled = false
            txtFieldAddFeature.text = String.getString(model.selectedValue)
        case AppConstants.Select:
            // txtFieldAddFeature.isUserInteractionEnabled = false
            txtFieldAddFeature.text = String.getString(model.selectedOptionName)
        default:
            txtFieldAddFeature.text = String.getString(model.selectedValue)
        // txtFieldAddFeature.isUserInteractionEnabled = true
        
        }
        if model.productTitle == AppConstants.kDescription{
            if model.selectedValue != "" {
                txtViewAddFeature.textColor = .black
                txtViewAddFeature.text = String.getString(model.selectedValue)
                lblCountTxt.text = "\(model.selectedValue?.count ?? 0)"
            }else{
                txtViewAddFeature.textColor = .lightGray
                txtViewAddFeature.text = AppConstants.kDescription
                lblCountTxt.text = "0"
            }
            
            
        }
        
    }
    
}

extension AddFeatureTableCell: UITextViewDelegate, UITextFieldDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {

        if productFieldsDataModel.productTitle == AppConstants.URL || productFieldsDataModel.productTitle == AppConstants.kUrl  {
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.spellCheckingType = .no
            return true

        }
        return true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = AppConstants.kDescription
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let spaceCount = textView.text.count
        
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        let finalText = updatedText//.removeWhitespace()
        if finalText.count <= 200 {
            if txtViewAddFeature.text == AppConstants.kDescription {
                self.lblCountTxt.text = "0"
            }else{
            self.lblCountTxt.text = "\(finalText.count)"
                //txtViewAddFeature.text = ""
                //txtViewAddFeature.text = updatedText
            }
           
            self.productFieldsDataModel.selectedValue = String.getString(self.txtViewAddFeature.text)
            callback?(txtViewAddFeature.text)
            return true
            
        }else{
            if text == "" && range.length > 0  {
                print("Backspace was pressed")
                return true
            }
            else{
                return false
                
            }
            
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (productFieldsDataModel.productTitle == AppConstants.URL) || (productFieldsDataModel.productTitle == AppConstants.kUrl){
            if textField.text == "" {
                textField.text = "https://"
            }
            return true
        }
        
//            if productFieldsDataModel.productTitle == AppConstants.Title{
//                if txtFieldAddFeature.text?.count ?? 0 >= 12{
//                    if let char = string.cString(using: String.Encoding.utf8) {
//                        let isBackSpace = strcmp(char, "\\b")
//                        if (isBackSpace == -92) {
//                            print("Backspace was pressed")
//                            return true
//                        }else{
//                            return false
//                        }
//                    }
//                }
//            }
        return true
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if (productFieldsDataModel.productTitle == AppConstants.URL) || (productFieldsDataModel.productTitle == AppConstants.kUrl){
            if textField.text == "https://" {
                textField.text = ""
                textField.placeholder = productFieldsDataModel.productTitle
            }
        }
    }
    
}
