//
//  FeaturedProductTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 08/03/21.
//

import UIKit

protocol AddProductCallBack {
  
  func tappedAddProduct(withProductCategoriesDataModel model: ProductCategoriesDataModel,featureListingId: String?) -> Void
}

class FeaturedProductTableCell: UITableViewCell {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var lblAddProductHeading: UILabel!
  @IBOutlet weak var collectionViewProducts: UICollectionView!
  @IBOutlet weak var viewShadow: UIView!
  @IBOutlet weak var btnAddProduct: UIButton!
  
  //MARK: - Properties -
  
  var productCategoriesDataModel: ProductCategoriesDataModel!
  var delegate: AddProductCallBack?
    var featureProductDeletage: FeaturedProductCollectionCellProtocol!
  
  override func awakeFromNib() {
    
    super.awakeFromNib()
    self.collectionViewProducts.delegate = self
    self.collectionViewProducts.dataSource = self
    self.viewShadow.drawShadow()
  }
  
  //MARK: - IBAction  -
  
  @IBAction func tapAddProduct(_ sender: UIButton) {
    
    self.delegate?.tappedAddProduct(withProductCategoriesDataModel: self.productCategoriesDataModel, featureListingId: nil)
  }
  
  //MARK: - Private Methods -
  
  private func getFeaturedProductCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
  
      let featuredProductCollectionCell = collectionViewProducts.dequeueReusableCell(withReuseIdentifier: FeaturedProductCollectionCell.identifier(), for: indexPath) as! FeaturedProductCollectionCell
    featuredProductCollectionCell.delegate = featureProductDeletage
      featuredProductCollectionCell.configure(withAllProductsDataModel: self.productCategoriesDataModel.arrAllProducts[indexPath.row])
      return featuredProductCollectionCell
  }
   
  //MARK: - Public Methods -
  
  func configureData(withProductCategoriesDataModel model: ProductCategoriesDataModel) -> Void{
    
    self.productCategoriesDataModel = model
    self.lblTitle.text = model.title
    self.lblAddProductHeading.text = AppConstants.Add + String.getString(model.title)
    self.collectionViewProducts.reloadData()
  }
}

//MARK: - CollectionView Methods -

extension FeaturedProductTableCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return self.productCategoriesDataModel?.arrAllProducts.count ?? 0
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    return self.getFeaturedProductCollectionCell(indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> Void {
    
    let model = self.productCategoriesDataModel.arrAllProducts[indexPath.row]
    self.delegate?.tappedAddProduct(withProductCategoriesDataModel: self.productCategoriesDataModel,featureListingId: model.featuredListingId)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: 100.0, height: 130.0)
  }
}
