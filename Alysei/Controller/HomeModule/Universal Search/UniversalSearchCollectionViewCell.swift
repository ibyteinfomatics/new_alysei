//
//  UniversalSearchCollectionViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 18/11/21.
//

import UIKit

class UniversalSearchCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlet -
    
      @IBOutlet weak var viewBusiness: UIView!
      @IBOutlet weak var lblBusinessHeading: UILabel!
   
   
    
    override func layoutSubviews() {
      
      super.layoutSubviews()
      self.layoutIfNeeded()
    }
    
    override func layoutIfNeeded() {
      
      super.layoutIfNeeded()
  //    self.viewBottom.drawBottomShadow()
    }
    
    //MARK: - Public Methods -
    
    public func configData(indexPath: IndexPath, currentIndex: Int) -> Void{
      
        self.lblBusinessHeading.text = titleUniversal[indexPath.item]
      self.viewBusiness.layer.cornerRadius = 22
      
      
      if indexPath.item == currentIndex && searchTap == true{
        
          self.lblBusinessHeading.textColor = .white
          self.viewBusiness.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
         
          self.viewBusiness.layer.borderColor = UIColor.clear.cgColor
          self.viewBusiness.layer.borderWidth = 0
      }
      else{
         
          self.lblBusinessHeading.textColor = .black
          self.viewBusiness.backgroundColor = .white
          self.viewBusiness.layer.borderColor = UIColor.black.cgColor
          self.viewBusiness.layer.borderWidth = 1
      }
      
    }
  }
