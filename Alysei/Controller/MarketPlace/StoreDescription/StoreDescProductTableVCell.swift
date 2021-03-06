//
//  StoreDescProductTableVCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/9/21.
//

import UIKit

class StoreDescProductTableVCell: UITableViewCell {
    @IBOutlet weak var storeProductCollectionView: UICollectionView!
    @IBOutlet weak var lblAllProduct: UILabel!
    
    var storeProduct: [ProductSearchListModel]?
    var pushCallback: ((Int) -> Void)? = nil
    override func awakeFromNib() {
        lblAllProduct.text = MarketPlaceConstant.kAllProducts
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(_ data: [ProductSearchListModel]?){
        self.storeProductCollectionView.reloadData()
        self.storeProduct = data
    }
}

extension StoreDescProductTableVCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storeProduct?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = storeProductCollectionView.dequeueReusableCell(withReuseIdentifier: "StoreDescProductCollectionViewCell", for: indexPath) as? StoreDescProductCollectionViewCell else {return UICollectionViewCell()}
        let baseUrl = storeProduct?[indexPath.row].product_gallery?.first?.baseUrl ?? ""
        cell.imgProduct.setImage(withString: baseUrl + String.getString(storeProduct?[indexPath.row].product_gallery?.first?.attachment_url))
        cell.labelProductName.text = storeProduct?[indexPath.row].title
        cell.avgRating = storeProduct?[indexPath.row].avg_rating
        cell.configCell(storeProduct?[indexPath.row] ?? ProductSearchListModel(with: [:]))
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.storeProductCollectionView.frame.width / 3, height: 280)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushCallback?(self.storeProduct?[indexPath.row].marketplaceProductId ?? 0)
       
    }
}
