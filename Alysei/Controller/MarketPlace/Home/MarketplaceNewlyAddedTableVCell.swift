//
//  MarketplaceNewlyAddedTableVCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 1/6/22.
//

import UIKit
import CoreMedia

class MarketplaceNewlyAddedTableVCell: UITableViewCell {
    
    @IBOutlet weak var newlyyAddedStoreCollectionView: UICollectionView!
    @IBOutlet weak var lblNewlyAdddStore: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    
    var newlyAddedStore: [MyStoreProductDetail]?
    var callback:((Int) -> Void)? = nil
    
    var viewAllcallback:((Int) -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        btnViewAll.setTitle(MarketPlaceConstant.kViewAll, for: .normal)
        lblNewlyAdddStore.text = MarketPlaceConstant.kNewlyAddedStore
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
        let data = self.newlyAddedStore?[indexPath.row]
        cell.image.setImage(withString: imgUrl)
        cell.lblStoreName.text = self.newlyAddedStore?[indexPath.row].name
        cell.lblStoreLoaction.text = self.newlyAddedStore?[indexPath.row].region?.name
        cell.lblTotalReview.text = (data?.total_reviews ?? "0") + MarketPlaceConstant.kSpacereview
        cell.lblAvgRating.text = data?.avg_rating
        if "\(data?.avg_rating ?? "")" == "0" || data?.avg_rating == "0.0"{
            cell.imgStar1.image = UIImage(named: "icons8_star")
            cell.imgStar2.image = UIImage(named: "icons8_star")
            cell.imgStar3.image = UIImage(named: "icons8_star")
            cell.imgStar4.image = UIImage(named: "icons8_star")
            cell.imgStar5.image = UIImage(named: "icons8_star")
            
        }else if(data?.avg_rating ?? "") >= "0.1" && (data?.avg_rating ?? "") <= "0.9" {
            cell.imgStar1.image = UIImage(named: "HalfStar")
            cell.imgStar2.image = UIImage(named: "icons8_star")
            cell.imgStar3.image = UIImage(named: "icons8_star")
            cell.imgStar4.image = UIImage(named: "icons8_star")
            cell.imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(data?.avg_rating ?? "")" == "1" || data?.avg_rating == "1.0"{
            cell.imgStar1.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar2.image = UIImage(named: "icons8_star")
            cell.imgStar3.image = UIImage(named: "icons8_star")
            cell.imgStar4.image = UIImage(named: "icons8_star")
            cell.imgStar5.image = UIImage(named: "icons8_star")
        }else if (data?.avg_rating ?? "") >= "1.1"  && (data?.avg_rating ?? "") <= "1.9" {
            cell.imgStar1.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar2.image = UIImage(named: "HalfStar")
            cell.imgStar3.image = UIImage(named: "icons8_star")
            cell.imgStar4.image = UIImage(named: "icons8_star")
            cell.imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(data?.avg_rating ?? "")" == "2" || data?.avg_rating == "2.0" {
            cell.imgStar1.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar2.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar3.image = UIImage(named: "icons8_star")
            cell.imgStar4.image = UIImage(named: "icons8_star")
            cell.imgStar5.image = UIImage(named: "icons8_star")
        }else if (data?.avg_rating ?? "") >= "2.1"  && (data?.avg_rating ?? "") <= "2.9" {
            cell.imgStar1.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar2.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar3.image = UIImage(named: "HalfStar")
            cell.imgStar4.image = UIImage(named: "icons8_star")
            cell.imgStar5.image = UIImage(named: "icons8_star")
        }else if data?.avg_rating == "3.0" || data?.avg_rating == "3"{
            cell.imgStar1.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar2.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar3.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar4.image = UIImage(named: "icons8_star")
            cell.imgStar5.image = UIImage(named: "icons8_star")
        }else if (data?.avg_rating ?? "") >= "3.1"  && (data?.avg_rating ?? "") <= "3.9" {
            cell.imgStar1.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar2.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar3.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar4.image = UIImage(named: "HalfStar")
            cell.imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(data?.avg_rating ?? "")" == "4" ||  data?.avg_rating == "4.0" {
            cell.imgStar1.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar2.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar3.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar4.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar5.image = UIImage(named: "icons8_star")
        }else if (data?.avg_rating ?? "") >= "4.1"  && (data?.avg_rating ?? "") <= "4.9" {
            cell.imgStar1.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar2.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar3.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar4.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar5.image = UIImage(named: "HalfStar")
        }else if "\(data?.avg_rating ?? "")" == "5" || data?.avg_rating == "5.0"{
            cell.imgStar1.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar2.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar3.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar4.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar5.image = UIImage(named: "icons8_christmas_star")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: newlyyAddedStoreCollectionView.frame.width / 2 , height: 225)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callback?(self.newlyAddedStore?[indexPath.row].marketplace_store_id ?? 0)
    }
    
}
