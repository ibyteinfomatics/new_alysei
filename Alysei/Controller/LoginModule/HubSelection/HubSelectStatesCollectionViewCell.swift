//
//  HubSelectStatesCollectionViewCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 7/15/21.
//

import UIKit

class HubSelectStatesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var lblStateName: UILabel!
    
    override func layoutSubviews() {
      
      super.layoutSubviews()
      self.layoutIfNeeded()
    }
    
    override func layoutIfNeeded() {
      
      super.layoutIfNeeded()
      self.viewBottom.drawBottomShadow()
    }
    
    
    public func configureData(indexPath: IndexPath, currentIndex: Int) -> Void{
      
     // self.lblBusinessHeading.text = StaticArrayData.kBusinessCategoryDict[indexPath.item].name
     // self.imgViewBusiness.image = UIImage(named: StaticArrayData.kBusinessCategoryDict[indexPath.item].image)
      
      if indexPath.item == currentIndex{
        
        self.viewBottom.isHidden = false
        
      }
      else{
        self.viewBottom.isHidden = true
      }
      
    }
}
