//
//  MarketplaceAdTableVCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 1/6/22.
//

import UIKit

class MarketplaceAdTableVCell: UITableViewCell {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    var topBannerData: [TopBottomBanners]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configData(_ data: [TopBottomBanners]){
        topBannerData = data
        self.imageCollectionView.reloadData()
        
    }
}
extension MarketplaceAdTableVCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topBannerData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketplaceHomeImageCVC", for: indexPath) as? MarketplaceHomeImageCVC else {return UICollectionViewCell()}
        let baseUrl = self.topBannerData?[indexPath.row].attachment?.baseUrl ?? ""
        let imgUrl = (baseUrl + (self.topBannerData?[indexPath.row].attachment?.attachmentURL ?? ""))
        cell.image.setImage(withString: imgUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageCollectionView.frame.width / 1.2 , height: 190)
    }
  
}
