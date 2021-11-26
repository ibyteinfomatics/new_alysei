//
//  BusinessCategoryCollectionCell.swift
//  Alysie
//
//  Created by CodeAegis on 24/01/21.
//

import UIKit

class BusinessCategoryCollectionCell: UICollectionViewCell {
  
  //MARK: - IBOutlet -
  
    @IBOutlet weak var viewBusiness: UIView!
    @IBOutlet weak var lblBusinessHeading: UILabel!
    @IBOutlet weak var imgViewBusiness: UIImageView!
 
  
  override func layoutSubviews() {
    
    super.layoutSubviews()
    self.layoutIfNeeded()
  }
  
  override func layoutIfNeeded() {
    
    super.layoutIfNeeded()
//    self.viewBottom.drawBottomShadow()
  }
  
  //MARK: - Public Methods -
  
  public func configureData(indexPath: IndexPath, currentIndex: Int) -> Void{
    
    self.lblBusinessHeading.text = StaticArrayData.kBusinessCategoryDict[indexPath.item].name
    self.viewBusiness.layer.cornerRadius = 22
    
    
    if indexPath.item == currentIndex{
        self.imgViewBusiness.image = UIImage(named: StaticArrayData.kBusinessCategoryDict[indexPath.item].image)
        self.lblBusinessHeading.textColor = .white
        self.viewBusiness.layer.backgroundColor = UIColor.init(red: 96/255, green: 96/255, blue: 96/255, alpha: 1).cgColor
//            UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
       
        self.viewBusiness.layer.borderColor = UIColor.clear.cgColor
        self.viewBusiness.layer.borderWidth = 0
    }
    else{
        self.imgViewBusiness.image = UIImage(named: StaticArrayData.kInactiveBusinessCategoryDict[indexPath.item].image)
        self.lblBusinessHeading.textColor = .black
        self.viewBusiness.layer.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
        self.viewBusiness.layer.borderColor = UIColor.clear.cgColor
        self.viewBusiness.layer.borderWidth = 0
    }
    
  }
}
