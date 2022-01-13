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
    @IBOutlet weak var viewHeader: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       // self.viewHeader.layer.masksToBounds = true
        self.viewBottom.isHidden = true
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
     // self.imgViewBusiness.image = UIImage(named: StaticArrayData.kBusinessCategoryDict[indexPath.item].image)
      
//      if indexPath.item == currentIndex{
//
//        self.viewBottom.isHidden = false
//
//      }
//      else{
//        self.viewBottom.isHidden = true
//      }
        
        if indexPath.item == currentIndex{
        
            self.viewHeader.backgroundColor = UIColor.init(hexString: "#4BB3FD")
            self.lblStateName.textColor = .white
            self.viewHeader.layer.borderColor = UIColor.clear.cgColor
              self.viewHeader.layer.borderWidth = 2
            // Remove shadow
            viewHeader.layer.shadowColor = UIColor.clear.cgColor
            viewHeader.layer.shadowOpacity = 0.0
            viewHeader.layer.shadowRadius = 0.0
            viewHeader.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
           
           // self.viewBusiness.layer.borderColor = UIColor.clear.cgColor
           // self.viewBusiness.layer.borderWidth = 0
        }
        else{
           
            self.lblStateName.textColor = .black
            self.viewHeader.backgroundColor = .white
            self.viewHeader.layer.borderColor = UIColor.lightGray.cgColor
            self.viewHeader.layer.borderWidth = 0.5
            // drop shadow
            viewHeader.layer.shadowColor = UIColor.init(red: 154/255, green: 154/255, blue: 154/255, alpha: 1).cgColor
            viewHeader.layer.shadowOpacity = 0.8
            viewHeader.layer.shadowRadius = 3.0
            viewHeader.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
        }

      
    }
}
