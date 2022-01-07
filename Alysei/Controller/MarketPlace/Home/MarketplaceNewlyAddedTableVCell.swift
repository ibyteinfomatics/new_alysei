//
//  MarketplaceNewlyAddedTableVCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 1/6/22.
//

import UIKit

class MarketplaceNewlyAddedTableVCell: UITableViewCell {
    
    @IBOutlet weak var newlyyAddedStoreCollectionView: UICollectionView!
    var newlyAddedStore: [MyStoreProductDetail]?
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
        newlyAddedStore = data
        self.newlyyAddedStoreCollectionView.reloadData()
        
    }
    
    @IBAction func viewAll(_ sender: UIButton){
        viewAllcallback?(sender.tag)
    }
}
extension MarketplaceNewlyAddedTableVCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newlyAddedStore?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = newlyyAddedStoreCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketplaceNewlyAddedStoreHomeImageCVC", for: indexPath) as? MarketplaceNewlyAddedStoreHomeImageCVC else {return UICollectionViewCell()}
        let baseUrl = self.newlyAddedStore?[indexPath.row].logoId?.baseUrl ?? ""
        let imgUrl = (baseUrl + (self.newlyAddedStore?[indexPath.row].logoId?.attachmentURL ?? ""))
        cell.image.setImage(withString: imgUrl)
        cell.lblStoreName.text = self.newlyAddedStore?[indexPath.row].name
        cell.lblStoreLoaction.text = self.newlyAddedStore?[indexPath.row].location
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: newlyyAddedStoreCollectionView.frame.width / 2 , height: 225)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callback?(self.newlyAddedStore?[indexPath.row].marketplace_store_id ?? 0)
    }

}
