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
  @IBOutlet weak var viewBottom: UIView!
  
  //MARK: - Public Methods -
  
  public func configureData(indexPath: IndexPath, currentIndex: Int) -> Void{
    
    self.lblNetworkHeading.text = StaticArrayData.kNetworkCategoryDict[indexPath.item].name
    self.imgViewNetwork.image = UIImage(named: StaticArrayData.kNetworkCategoryDict[indexPath.item].image)
    self.viewBottom.isHidden = (indexPath.item == currentIndex) ? false : true
  }
}
