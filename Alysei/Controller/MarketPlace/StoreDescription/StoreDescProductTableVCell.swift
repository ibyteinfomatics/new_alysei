//
//  StoreDescProductTableVCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/9/21.
//

import UIKit

class StoreDescProductTableVCell: UITableViewCell {
    @IBOutlet weak var storeProductCollectionView: UICollectionView!
    var storeProduct: [ProductSearchListModel]?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(_ data: [ProductSearchListModel]?){
        self.storeProduct = data
    }
}

extension StoreDescProductTableVCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storeProduct?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = storeProductCollectionView.dequeueReusableCell(withReuseIdentifier: "StoreDescProductCollectionViewCell", for: indexPath) as? StoreDescProductCollectionViewCell else {return UICollectionViewCell()}
        cell.imgProduct.setImage(withString: kImageBaseUrl + String.getString(storeProduct?[indexPath.row].product_gallery?.first?.attachment_url))
        cell.labelProductName.text = storeProduct?[indexPath.row].title
        cell.avgRating = storeProduct?[indexPath.row].avg_rating
        cell.configCell(storeProduct?[indexPath.row] ?? ProductSearchListModel(with: [:]))
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.storeProductCollectionView.frame.width / 3, height: 280)
    }
    
}
