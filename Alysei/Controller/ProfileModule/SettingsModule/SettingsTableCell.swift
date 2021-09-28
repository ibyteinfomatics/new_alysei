//
//  SettingsTableCell.swift
//  Alysie
//
//  Created by Alendra Kumar on 18/01/21.
//

import UIKit

class SettingsTableCell: UITableViewCell{

  //MARK: - IBOutlet -
  
  @IBOutlet weak var imgViewSettings: UIImageView!
  @IBOutlet weak var lblSettings: UILabel!
  
  override func awakeFromNib() {
    
    super.awakeFromNib()
    //txtFieldSettingsProperty.borderStyle = UITextField.BorderStyle.none
  }
  
  //MARK: - Public Methods -
  
  public func configure(_ indexPath: IndexPath){
    
    imgViewSettings.image = UIImage.init(named: StaticArrayData.kSettingPrdrTblScreenDict[indexPath.item].image)
    lblSettings.text = StaticArrayData.kSettingPrdrTblScreenDict[indexPath.item].name
    
  }
    public func configureCell(_ indexPath: IndexPath){
      
      imgViewSettings.image = UIImage.init(named: StaticArrayData.kSettingScreenDict[indexPath.item].image)
      lblSettings.text = StaticArrayData.kSettingScreenDict[indexPath.item].name
      
    }
}
