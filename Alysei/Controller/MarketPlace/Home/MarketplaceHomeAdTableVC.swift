//
//  MarketplaceHomeAdTableVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 11/1/21.
//

import UIKit

class MarketplaceHomeAdTableVC: UITableViewCell {
    @IBOutlet weak var adCollectionView: UICollectionView!
    var maketPlaceHomeScreenData: MaketPlaceHomeScreenModel?

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
        self.adCollectionView.reloadData()
    }

}
extension MarketplaceHomeAdTableVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maketPlaceHomeScreenData?.bottom_banners?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = adCollectionView.dequeueReusableCell(withReuseIdentifier: "AdCollectionVC", for: indexPath) as? AdCollectionVC  else {return UICollectionViewCell()}
        let imgUrl = (kImageBaseUrl + (self.maketPlaceHomeScreenData?.bottom_banners?[indexPath.row].attachment?.attachmentURL ?? ""))
        print("imgUrl---------------------------------------",imgUrl)
        cell.imgBanner.setImage(withString: imgUrl)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 , height: 220)
    }
}
