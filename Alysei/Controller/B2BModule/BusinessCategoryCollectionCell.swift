//
//  BusinessCategoryCollectionCell.swift
//  Alysie
//
//  Created by CodeAegis on 24/01/21.
//

import UIKit

class BusinessCategoryCollectionCell: UICollectionViewCell {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var lblBusinessHeading: UILabel!
  @IBOutlet weak var imgViewBusiness: UIImageView!
  @IBOutlet weak var viewBottom: UIView!
  
  override func layoutSubviews() {
    
    super.layoutSubviews()
    self.layoutIfNeeded()
  }
  
  override func layoutIfNeeded() {
    
    super.layoutIfNeeded()
    self.viewBottom.drawBottomShadow()
  }
  
  //MARK: - Public Methods -
  
  public func configureData(indexPath: IndexPath, currentIndex: Int) -> Void{
    
    self.lblBusinessHeading.text = StaticArrayData.kBusinessCategoryDict[indexPath.item].name
    self.imgViewBusiness.image = UIImage(named: StaticArrayData.kBusinessCategoryDict[indexPath.item].image)
    
    if indexPath.item == currentIndex{
      
      self.viewBottom.isHidden = false
      
    }
    else{
      self.viewBottom.isHidden = true
    }
    
  }
}
