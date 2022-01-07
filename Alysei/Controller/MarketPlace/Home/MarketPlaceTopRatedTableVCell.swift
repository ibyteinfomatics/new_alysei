//
//  MarketPlaceTopRatedTableVCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 1/6/22.
//

import UIKit

class MarketPlaceTopRatedTableVCell: UITableViewCell {

    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    var top_rated_products: [MyStoreProductDetail]?
    var callback:((Int) -> Void)? = nil
    var viewAllcallback:((Int) -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configData(_ data: [MyStoreProductDetail]){
        top_rated_products = data
        self.topRatedCollectionView.reloadData()
        
    }
    
    @IBAction func viewAll(_ sender: UIButton){
        viewAllcallback?(sender.tag)
    }
}
extension MarketPlaceTopRatedTableVCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return top_rated_products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = topRatedCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketPlaceHomeTopSearchedCVC", for: indexPath) as? MarketPlaceHomeTopSearchedCVC  else {return UICollectionViewCell()}
        cell.configCell(self.top_rated_products?[indexPath.row] ?? MyStoreProductDetail(with: [:]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 , height: 280)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callback?(self.top_rated_products?[indexPath.row].marketplace_product_id ?? 0)
    }
}
