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
  
  //MARK: - Properties -
  
  var productFieldsDataModel: ProductFieldsDataModel!
    
  override func awakeFromNib() {
    super.awakeFromNib()
    self.txtFieldAddFeature.makeCornerRadius(radius: 5.0)
    self.txtFieldAddFeature.addTarget(self, action: #selector(AddFeatureTableCell.textFieldEditingChanged(_:)),for: UIControl.Event.editingChanged)
  }
  
  //MARK: - Public Methods -
  
  @objc func textFieldEditingChanged(_ sender: UITextFieldExtended){

    self.productFieldsDataModel.selectedValue = String.getString(self.txtFieldAddFeature.text)
  }

  public func configure(withProductFieldsDataModel model: ProductFieldsDataModel){
      
    self.productFieldsDataModel = model
    lblAddFeature.text = model.productTitle
    
    switch model.type {
    case AppConstants.Calander:
      txtFieldAddFeature.isUserInteractionEnabled = false
      txtFieldAddFeature.text = String.getString(model.selectedValue)
    case AppConstants.Select:
      txtFieldAddFeature.isUserInteractionEnabled = false
      txtFieldAddFeature.text = String.getString(model.selectedOptionName)
    default:
      txtFieldAddFeature.text = String.getString(model.selectedValue)
      txtFieldAddFeature.isUserInteractionEnabled = true
    }
  }

}
