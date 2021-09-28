//
//  FeaturedProductCollectionCell.swift
//  Alysie
//
//  Created by Alendra Kumar on 18/01/21.
//

import UIKit

protocol FeaturedProductCollectionCellProtocol {
    func deleteProduct(_ productID: Int)
}

class FeaturedProductCollectionCell: UICollectionViewCell {

  //MARK: - IBOutlet -
  
  @IBOutlet weak var imgViewProduct: UIImageView!
  @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var deleteButton: UIButton!

  var pushedFrom: Int = 0
    var model: AllProductsDataModel?
    var delegate: FeaturedProductCollectionCellProtocol!
  
  override func layoutSubviews() {
    
    super.layoutSubviews()
    self.layoutIfNeeded()
  }
  
  override func layoutIfNeeded() {
    
    super.layoutIfNeeded()
    if pushedFrom == 0{
      self.viewBorder.layer.borderWidth = 1.0
      self.viewBorder.layer.borderColor = AppColors.gray.color.cgColor
      self.viewBorder.makeCornerRadius(radius: 8.0)
    }
  }

    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        guard let productIDInString = self.model?.featuredListingId else { return }
        guard let productID = Int(productIDInString) else { return }
        delegate.deleteProduct(productID)
    }
  
  //MARK: - Public Methods -
  
  public func configure(withAllProductsDataModel model: AllProductsDataModel?,pushedFrom: Int = 0) -> Void{

    self.model = model
    self.imgViewProduct.setImage(withString: kImageBaseUrl + String.getString(model?.imagePath))
    self.lblProductName.text = model?.productTitle
  }
    
}
