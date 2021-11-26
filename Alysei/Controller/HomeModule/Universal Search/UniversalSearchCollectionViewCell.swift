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
      @IBOutlet weak var imgViewBusiness: UIImageView!
   
   var imagArraySelecetd = ["Group 643", "icons8_people","icon-6", "icon-8", "icon-7", "icon-1", "icon-5"]
    var imagArray = ["Group 436", "icons_people_inactive","icons8_rss_1", "icons8_traveler", "icons8_event", "posts_icon_normal", "icons8_certificate_2"]
    
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
        self.imgViewBusiness.image = UIImage(named: imagArraySelecetd[indexPath.item])
          self.lblBusinessHeading.textColor = .white
        self.viewBusiness.layer.backgroundColor = UIColor.init(red: 96/255, green: 96/255, blue: 96/255, alpha: 1).cgColor
//            UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
         
          self.viewBusiness.layer.borderColor = UIColor.clear.cgColor
          self.viewBusiness.layer.borderWidth = 0
      }
      else{
        self.imgViewBusiness.image = UIImage(named: imagArray[indexPath.item])
          self.lblBusinessHeading.textColor = .black
        self.viewBusiness.layer.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
          self.viewBusiness.layer.borderColor = UIColor.clear.cgColor
          self.viewBusiness.layer.borderWidth = 0
      }
      
    }
  }
