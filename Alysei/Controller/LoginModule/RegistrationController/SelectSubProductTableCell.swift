//
//  SelectSubProductTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 01/02/21.
//

import UIKit

class SelectSubProductTableCell: UITableViewCell {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var imgViewSubProduct: UIImageView!
  @IBOutlet weak var lblSubProduct: UILabel!
  
  override func awakeFromNib() {
      super.awakeFromNib()
  }

  //MARK: - Public Methods -
    
  public func configure(withSignUpOptionsDataModel model: SignUpOptionsDataModel, indexPath: IndexPath){
    
    let sectionModel = model.arrSubSections[indexPath.section].arrSelectedSubOptions
    let subOptionDataModel = model.arrSubSections[indexPath.section].arrSubOptions[indexPath.row]
    lblSubProduct.text = subOptionDataModel.subOptionName
    
    for _ in 0..<model.arrSubSections[indexPath.section].arrSubOptions.count{
      
      if sectionModel.contains(String.getString(subOptionDataModel.userFieldOptionId)){
        
        lblSubProduct.textColor = AppColors.blue.color
        self.imgViewSubProduct.image = UIImage(named: "icon_blueSelected")
        
      }
      else{
        lblSubProduct.textColor = UIColor.black
        self.imgViewSubProduct.image = UIImage(named: "icon_uncheckedBox")
      }
    
    }
  }

}
