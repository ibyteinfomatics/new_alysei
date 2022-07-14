//
//  NetworkCategoryCollectionCell.swift
//  Alysie
//
//  Created by CodeAegis on 25/01/21.
//

import UIKit

class NetworkCategoryCollectionCell: UICollectionViewCell {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var lblNetworkHeading: UILabel!
  @IBOutlet weak var lblNetworkCount: UILabelExtended!
  @IBOutlet weak var imgViewNetwork: UIImageView!
  
    @IBOutlet weak var viewNetwork: UIView!
    
  //MARK: - Public Methods -
var kNetworkCategoryDictnry:  [(image: String, name: String)]?
  public func configureData(indexPath: IndexPath, currentIndex: Int) -> Void{
    
      self.lblNetworkHeading.text = kNetworkCategoryDictnry?[indexPath.item].name
  
    self.viewNetwork.layer.cornerRadius = self.viewNetwork.frame.height / 2
   // self.viewNetwork.layer.masksToBounds = true
    self.lblNetworkHeading.textColor = .black

    if indexPath.item == currentIndex{
        self.imgViewNetwork.image = UIImage(named: kNetworkCategoryDictnry?[indexPath.item].image ?? "")
       // self.lblNetworkHeading.textColor = .white
        self.viewNetwork.backgroundColor = .white
       
          self.viewNetwork.layer.borderColor = UIColor.init(red: 0/255, green: 69/255, blue: 119/255, alpha: 1).cgColor
          self.viewNetwork.layer.borderWidth = 2
        // Remove shadow
        viewNetwork.layer.shadowColor = UIColor.clear.cgColor
        viewNetwork.layer.shadowOpacity = 0.0
        viewNetwork.layer.shadowRadius = 0.0
        viewNetwork.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        self.viewNetwork.layer.backgroundColor = UIColor.init(red: 96/255, green: 96/255, blue: 96/255, alpha: 1).cgColor
////            UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
//
//        self.viewNetwork.layer.borderColor = UIColor.clear.cgColor
//        self.viewNetwork.layer.borderWidth = 0
    }
    else{
        self.imgViewNetwork.image = UIImage(named: kNetworkCategoryDictnry?[indexPath.item].image ?? "")
       
        self.viewNetwork.backgroundColor = .white
        self.viewNetwork.layer.borderColor = UIColor.init(red: 154/255, green: 154/255, blue: 154/255, alpha: 0.2).cgColor
        self.viewNetwork.layer.borderWidth = 0.5
        // drop shadow
        viewNetwork.layer.shadowColor = UIColor.init(red: 154/255, green: 154/255, blue: 154/255, alpha: 1).cgColor
        viewNetwork.layer.shadowOpacity = 0.8
        viewNetwork.layer.shadowRadius = 3.0
        viewNetwork.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//        self.viewNetwork.layer.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
//        self.viewNetwork.layer.borderColor = UIColor.clear.cgColor
//        self.viewNetwork.layer.borderWidth = 0
    }
  }
}
