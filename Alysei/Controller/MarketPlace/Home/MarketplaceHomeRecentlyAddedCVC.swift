//
//  MarketplaceHomeRecentlyAddedCVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 10/11/21.
//

import UIKit

class MarketplaceHomeRecentlyAddedCVC: UICollectionViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblAvgRating: UILabel!
    @IBOutlet weak var lblTotalReview: UILabel!
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configCell(_ data: MyStoreProductDetail){
        let imgUrl = (kImageBaseUrl + (data.logo_id ?? ""))
        print("imgUrl---------------------------------------",imgUrl)
        imgProduct.setImage(withString: imgUrl)
        
        lblProductName.text = data.title
        lblStoreName.text = data.storeName
        lblTotalReview.text = (data.total_reviews ?? "0") + "reviews"
        lblAvgRating.text = data.avg_rating
        
        if "\(data.avg_rating ?? "")" == "0" {
           imgStar1.image = UIImage(named: "icons8_star")
            imgStar2.image = UIImage(named: "icons8_star")
            imgStar3.image = UIImage(named: "icons8_star")
            imgStar4.image = UIImage(named: "icons8_star")
           imgStar5.image = UIImage(named: "icons8_star")
           
        }else if "\(data.avg_rating ?? "")" == "1" {
            imgStar1.image = UIImage(named: "icons8_christmas_star_2")
            imgStar2.image = UIImage(named: "icons8_star")
            imgStar3.image = UIImage(named: "icons8_star")
            imgStar4.image = UIImage(named: "icons8_star")
            imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(data.avg_rating ?? "")" == "2" {
            imgStar1.image = UIImage(named: "icons8_christmas_star_2")
            imgStar2.image = UIImage(named: "icons8_christmas_star_2")
            imgStar3.image = UIImage(named: "icons8_star")
            imgStar4.image = UIImage(named: "icons8_star")
            imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(data.avg_rating ?? "")" == "3" {
            imgStar1.image = UIImage(named: "icons8_christmas_star_2")
            imgStar2.image = UIImage(named: "icons8_christmas_star_2")
            imgStar3.image = UIImage(named: "icons8_christmas_star_2")
            imgStar4.image = UIImage(named: "icons8_star")
            imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(data.avg_rating ?? "")" == "4" {
            imgStar1.image = UIImage(named: "icons8_christmas_star_2")
            imgStar2.image = UIImage(named: "icons8_christmas_star_2")
            imgStar3.image = UIImage(named: "icons8_christmas_star_2")
            imgStar4.image = UIImage(named: "icons8_christmas_star_2")
            imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(data.avg_rating ?? "")" == "5" {
            imgStar1.image = UIImage(named: "icons8_christmas_star_2")
            imgStar2.image = UIImage(named: "icons8_christmas_star_2")
            imgStar3.image = UIImage(named: "icons8_christmas_star_2")
            imgStar4.image = UIImage(named: "icons8_christmas_star_2")
            imgStar5.image = UIImage(named: "icons8_christmas_star_2")
        }
        
        
    }
}
