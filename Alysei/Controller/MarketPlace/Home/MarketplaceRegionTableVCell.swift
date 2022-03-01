//
//  MarketplaceRegionTableVCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 1/6/22.
//

import UIKit

class MarketplaceRegionTableVCell: UITableViewCell {

    @IBOutlet weak var regionCollectionView: UICollectionView!
    @IBOutlet weak var lblSearchItalianRegion: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    
    var regions: [MyStoreProductDetail]?
    var callback:((Int,String) -> Void)? = nil
    var viewAllcallback:((Int) -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        lblSearchItalianRegion.text = MarketPlaceConstant.kItalianRegion
        btnViewAll.setTitle(MarketPlaceConstant.kViewAll, for: .normal)
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
    @IBAction func viewAll(_ sender: UIButton){
        viewAllcallback?(sender.tag)
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callback?(self.regions?[indexPath.row].id ?? 0,self.regions?[indexPath.row].name ?? "" )
    }
}
