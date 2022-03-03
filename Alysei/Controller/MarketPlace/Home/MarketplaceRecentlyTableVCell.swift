//
//  MarketplaceRecentlyTableVCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 1/6/22.
//

import UIKit

class MarketplaceRecentlyTableVCell: UITableViewCell {
    
    @IBOutlet weak var recentlyAddedCollectionView: UICollectionView!
    
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var lblRecentlyAddedroduct: UILabel!
  
    var recentlyAddedProduct: [MyStoreProductDetail]?
    var callback:((Int) -> Void)? = nil
    
    var viewAllcallback:((Int) -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        btnViewAll.setTitle(MarketPlaceConstant.kViewAll, for: .normal)
        lblRecentlyAddedroduct.text = MarketPlaceConstant.kRecentlyAddedProject
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
    @IBAction func viewAll(_ sender: UIButton){
        viewAllcallback?(sender.tag)
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callback?(self.recentlyAddedProduct?[indexPath.row].marketplace_product_id ?? 0)
    }

}
