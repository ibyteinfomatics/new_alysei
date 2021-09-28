//
//  EditLanguageTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 20/01/21.
//

import UIKit

class EditLanguageTableCell: UITableViewCell {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var lblHeading: UILabel!
  @IBOutlet weak var lblLanguage: UILabelExtended!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  //MARK: - Public Methods -
  
  public func configure(withSettingsEditDataModel model: SettingsEditDataModel){
      
    self.lblHeading.text = model.settingsHeading
    
  }
}
