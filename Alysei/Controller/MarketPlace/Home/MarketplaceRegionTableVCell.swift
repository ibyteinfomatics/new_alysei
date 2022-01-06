//
//  MarketplaceRegionTableVCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 1/6/22.
//

import UIKit

class MarketplaceRegionTableVCell: UITableViewCell {

    @IBOutlet weak var regionCollectionView: UICollectionView!
    var regions: [MyStoreProductDetail]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configData(_ data: [MyStoreProductDetail]){
        regions = data
        self.regionCollectionView.reloadData()
        
    }
}
extension MarketplaceRegionTableVCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return regions?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = regionCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketPlaceHomeRegionCViewCell", for: indexPath) as? MarketPlaceHomeRegionCViewCell  else {return UICollectionViewCell()}
        cell.lblRegionName.text = self.regions?[indexPath.row].name
        let baseUrl = self.regions?[indexPath.row].flagId?.baseUrl ?? ""
        let imgUrl = (baseUrl + ( self.regions?[indexPath.row].flagId?.attachmentUrl ?? ""))
        cell.imgRegion.setImage(withString: imgUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: regionCollectionView.frame.width / 4 , height: 147)
    }

}
