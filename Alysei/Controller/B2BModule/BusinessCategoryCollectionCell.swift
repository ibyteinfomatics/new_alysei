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
    self.viewBusiness.layer.cornerRadius = self.viewBusiness.frame.height / 2
    self.lblBusinessHeading.text = StaticArrayData.kBusinessCategoryDict[indexPath.item].name
   
    
    
    if indexPath.item == currentIndex{
        self.imgViewBusiness.image = UIImage(named: StaticArrayData.kBusinessCategoryDict[indexPath.item].image)
       // self.lblBusinessHeading.textColor = .white
       // self.viewBusiness.layer.backgroundColor = UIColor.init(red: 96/255, green: 96/255, blue: 96/255, alpha: 1).cgColor
//            UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        self.viewBusiness.backgroundColor = .white
       
          self.viewBusiness.layer.borderColor = UIColor.init(red: 0/255, green: 69/255, blue: 119/255, alpha: 1).cgColor
          self.viewBusiness.layer.borderWidth = 2
        // Remove shadow
        viewBusiness.layer.shadowColor = UIColor.clear.cgColor
        viewBusiness.layer.shadowOpacity = 0.0
        viewBusiness.layer.shadowRadius = 0.0
        viewBusiness.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
       
       // self.viewBusiness.layer.borderColor = UIColor.clear.cgColor
       // self.viewBusiness.layer.borderWidth = 0
    }
    else{
        self.imgViewBusiness.image = UIImage(named: StaticArrayData.kInactiveBusinessCategoryDict[indexPath.item].image)
        self.lblBusinessHeading.textColor = .black
        self.viewBusiness.backgroundColor = .white
        self.viewBusiness.layer.borderColor = UIColor.init(red: 154/255, green: 154/255, blue: 154/255, alpha: 0.2).cgColor
        self.viewBusiness.layer.borderWidth = 0.5
        // drop shadow
        viewBusiness.layer.shadowColor = UIColor.init(red: 154/255, green: 154/255, blue: 154/255, alpha: 1).cgColor
        viewBusiness.layer.shadowOpacity = 0.8
        viewBusiness.layer.shadowRadius = 3.0
        viewBusiness.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
       // self.viewBusiness.layer.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
        //self.viewBusiness.layer.borderColor = UIColor.lightGray.cgColor
      //  self.viewBusiness.layer.borderWidth = 0
    }
    
  }
}
