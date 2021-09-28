//
//  StateWiseHubCollectionCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 7/16/21.
//

import UIKit

class StateWiseHubCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var viewBottom: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
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
      
      if indexPath.item == currentIndex{
        
        self.viewBottom.isHidden = false
        
      }
      else{
        self.viewBottom.isHidden = true
      }
      
    }

}
