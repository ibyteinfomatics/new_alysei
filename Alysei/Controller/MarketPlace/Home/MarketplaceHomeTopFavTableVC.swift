//
//  MarketplaceHomeTopFavTableVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 11/1/21.
//

import UIKit

class MarketplaceHomeTopFavTableVC: UITableViewCell {
    @IBOutlet weak var maximumSearchedCollectionView: UICollectionView!
    var maketPlaceHomeScreenData: MaketPlaceHomeScreenModel?
    var callback:(( Int) -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(_ data: MaketPlaceHomeScreenModel){
        self.maketPlaceHomeScreenData = data
        self.maximumSearchedCollectionView.reloadData()
    }

}

extension MarketplaceHomeTopFavTableVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.maketPlaceHomeScreenData?.top_favourite_products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = maximumSearchedCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketPlaceHomeMaximumSearchedCVC", for: indexPath) as? MarketPlaceHomeMaximumSearchedCVC  else {return UICollectionViewCell()}
        cell.configCell(self.maketPlaceHomeScreenData?.top_favourite_products?[indexPath.row] ?? MyStoreProductDetail(with: [:]))
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callback?(self.maketPlaceHomeScreenData?.top_favourite_products?[indexPath.row].marketplace_product_id ?? 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 , height: 270)
    }
    
}
