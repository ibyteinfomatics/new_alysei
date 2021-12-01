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
   
   var imagArraySelecetd = ["Vector-1", "ic2","ic3", "ic4", "ic5", "ic7", "ic8"]
//    var imagArray = ["Group 436", "icons_people_inactive","icons8_rss_1", "icons8_traveler", "icons8_event", "posts_icon_normal", "icons8_certificate_2"]
    
    override func layoutSubviews() {
      
      super.layoutSubviews()
      self.layoutIfNeeded()
    }
    
    override func layoutIfNeeded() {
      
      super.layoutIfNeeded()
 
    }
    
    //MARK: - Public Methods -
    
    public func configData(indexPath: IndexPath, currentIndex: Int) -> Void{
      
        self.lblBusinessHeading.text = titleUniversal[indexPath.item]
      self.viewBusiness.layer.cornerRadius = 22
      
      
      if indexPath.item == currentIndex && searchTap == true{
        self.imgViewBusiness.image = UIImage(named: imagArraySelecetd[indexPath.item])
          self.lblBusinessHeading.textColor = .black
        self.viewBusiness.backgroundColor = .white
       
          self.viewBusiness.layer.borderColor = UIColor.init(red: 0/255, green: 69/255, blue: 119/255, alpha: 1).cgColor
          self.viewBusiness.layer.borderWidth = 2
        // Remove shadow
        viewBusiness.layer.shadowColor = UIColor.clear.cgColor
        viewBusiness.layer.shadowOpacity = 0.0
        viewBusiness.layer.shadowRadius = 0.0
        viewBusiness.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
      }
      else{
        self.imgViewBusiness.image = UIImage(named: imagArraySelecetd[indexPath.item])
          self.lblBusinessHeading.textColor = .black
        self.viewBusiness.backgroundColor = .white
        self.viewBusiness.layer.borderColor = UIColor.init(red: 154/255, green: 154/255, blue: 154/255, alpha: 0.2).cgColor
        self.viewBusiness.layer.borderWidth = 0.5
        // drop shadow
        viewBusiness.layer.shadowColor = UIColor.init(red: 154/255, green: 154/255, blue: 154/255, alpha: 1).cgColor
        viewBusiness.layer.shadowOpacity = 0.8
        viewBusiness.layer.shadowRadius = 3.0
        viewBusiness.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
      }
      
    }
  }
