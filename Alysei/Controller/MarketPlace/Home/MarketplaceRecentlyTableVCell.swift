//
//  MarketplaceRecentlyTableVCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 1/6/22.
//

import UIKit

class MarketplaceRecentlyTableVCell: UITableViewCell {
    
    @IBOutlet weak var recentlyAddedCollectionView: UICollectionView!
    var recentlyAddedProduct: [MyStoreProductDetail]?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configData(_ data: [MyStoreProductDetail]){
        recentlyAddedProduct = data
        self.recentlyAddedCollectionView.reloadData()
        
    }
}
extension MarketplaceRecentlyTableVCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentlyAddedProduct?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = recentlyAddedCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketplaceHomeRecentlyAddedCVC", for: indexPath) as? MarketplaceHomeRecentlyAddedCVC else {return UICollectionViewCell()}
       // cell.addShadow()
        cell.configCell(self.recentlyAddedProduct?[indexPath.row] ?? MyStoreProductDetail(with: [:]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: recentlyAddedCollectionView.frame.width / 2 , height: 275)
    }

}
