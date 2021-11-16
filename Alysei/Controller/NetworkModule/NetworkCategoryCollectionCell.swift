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
  
  public func configureData(indexPath: IndexPath, currentIndex: Int) -> Void{
    
    self.lblNetworkHeading.text = StaticArrayData.kNetworkCategoryDict[indexPath.item].name
  
    self.viewNetwork.layer.cornerRadius = 22
    
    
    if indexPath.item == currentIndex{
        self.imgViewNetwork.image = UIImage(named: StaticArrayData.kNetworkCategoryDict[indexPath.item].image)
        self.lblNetworkHeading.textColor = .white
        self.viewNetwork.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
       
        self.viewNetwork.layer.borderColor = UIColor.clear.cgColor
        self.viewNetwork.layer.borderWidth = 0
    }
    else{
        self.imgViewNetwork.image = UIImage(named: StaticArrayData.kInactiveNetworkCategoryDict[indexPath.item].image)
        self.lblNetworkHeading.textColor = .black
        self.viewNetwork.backgroundColor = .white
        self.viewNetwork.layer.borderColor = UIColor.black.cgColor
        self.viewNetwork.layer.borderWidth = 1
    }
  }
}
