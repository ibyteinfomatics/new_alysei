//
//  BusinessFiltersCollectionCell.swift
//  Alysie
//
//  Created by CodeAegis on 25/01/21.
//

import UIKit

class BusinessFiltersCollectionCell: UICollectionViewCell {
  
  @IBOutlet weak var imgViewFilter: UIImageView!
  @IBOutlet weak var lblFilterHeading: UILabel!
  
  //MARK: - Public Methods -
  
  public func configureData(withBusinessDataModel model: BusinessDataModel,indexPath: IndexPath, selectedIndex: [Int]) -> Void{
    
    self.lblFilterHeading.text = model.arrFilters[indexPath.item]
    
    if selectedIndex.contains(indexPath.item){
      self.imgViewFilter.image = UIImage(named: "icon_greenCheckMark")
    }
    else{
      self.imgViewFilter.image = UIImage(named: "icons_grey_checkbox")
    }
  }
}
