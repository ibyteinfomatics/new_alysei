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
    var callback: (() -> Void)? = nil
    var userLevel: UserLevel?
    
    var urlFeatureProduct: String?
  //MARK: - Properties -
  
  var productFieldsDataModel: ProductFieldsDataModel!
    
  override func awakeFromNib() {
    super.awakeFromNib()
    setTextViewUI()
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
    }else{
        txtFieldAddFeature.isHidden = false
        txtViewAddFeature.isHidden = true
    }
    if (model.productTitle == AppConstants.URL) || (model.productTitle == AppConstants.URL){
        urlFeatureProduct = model.selectedValue
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
        }else{
            txtViewAddFeature.textColor = .lightGray
            txtViewAddFeature.text = AppConstants.kDescription
        }
        
        
    }
  }

}
extension AddFeatureTableCell: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = AppConstants.kDescription
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let spaceCount = textView.text.filter{$0 == " "}.count
        if spaceCount <= 199{
            callback?()
            return true
        }else{
            return false
        }
        
    }
}
