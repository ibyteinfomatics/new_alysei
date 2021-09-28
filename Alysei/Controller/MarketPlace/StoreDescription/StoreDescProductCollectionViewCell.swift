//
//  StoreDescProductCollectionViewCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/9/21.
//

import UIKit

class StoreDescProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var lblavgRating: UILabel!
    @IBOutlet weak var lblTotalRating: UILabel!
    
    @IBOutlet weak var productAvgStar1: UIImageView!
    @IBOutlet weak var productAvgStar2: UIImageView!
    @IBOutlet weak var productAvgStar3: UIImageView!
    @IBOutlet weak var productAvgStar4: UIImageView!
    @IBOutlet weak var productAvgStar5: UIImageView!
    
    var avgRating :String?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(_ data: ProductSearchListModel){
        lblavgRating.text = data.avg_rating
        lblTotalRating.text = "\(data.total_reviews ?? 0) Reviews"
        setStarUI()
    }
    func setStarUI(){
        if avgRating == "0.0" || avgRating == "0"{
            productAvgStar1.image = UIImage(named: "icons8_star")
            productAvgStar2.image = UIImage(named: "icons8_star")
            productAvgStar3.image = UIImage(named: "icons8_star")
            productAvgStar4.image = UIImage(named: "icons8_star")
            productAvgStar5.image = UIImage(named: "icons8_star")
        }else if avgRating == "1.0"{
            productAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar2.image = UIImage(named: "icons8_star")
            productAvgStar3.image = UIImage(named: "icons8_star")
            productAvgStar4.image = UIImage(named: "icons8_star")
            productAvgStar5.image = UIImage(named: "icons8_star")
        }else if avgRating == "1.5"{
            productAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar2.image = UIImage(named: "HalfStar")
            productAvgStar3.image = UIImage(named: "icons8_star")
            productAvgStar4.image = UIImage(named: "icons8_star")
            productAvgStar5.image = UIImage(named: "icons8_star")
        }else if avgRating == "2.0"{
            productAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar3.image = UIImage(named: "icons8_star")
            productAvgStar4.image = UIImage(named: "icons8_star")
            productAvgStar5.image = UIImage(named: "icons8_star")
        }else if avgRating == "2.5"{
            productAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar3.image = UIImage(named: "HalfStar")
            productAvgStar4.image = UIImage(named: "icons8_star")
            productAvgStar5.image = UIImage(named: "icons8_star")
        }else if avgRating == "3.0"{
            productAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar3.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar4.image = UIImage(named: "icons8_star")
            productAvgStar5.image = UIImage(named: "icons8_star")
        }else if avgRating == "3.5"{
            productAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar3.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar4.image = UIImage(named: "HalfStar")
            productAvgStar5.image = UIImage(named: "icons8_star")
        }else if avgRating == "4.0"{
            productAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar3.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar4.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar5.image = UIImage(named: "icons8_star")
        }else if avgRating == "4.5"{
            productAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar3.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar4.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar5.image = UIImage(named: "HalfStar")
        }else if avgRating == "5.0"{
            productAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar3.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar4.image = UIImage(named: "icons8_christmas_star_2")
            productAvgStar5.image = UIImage(named: "icons8_christmas_star_2")
        }else{
            productAvgStar1.image = UIImage(named: "icons8_star")
            productAvgStar2.image = UIImage(named: "icons8_star")
            productAvgStar3.image = UIImage(named: "icons8_star")
            productAvgStar4.image = UIImage(named: "icons8_star")
            productAvgStar5.image = UIImage(named: "icons8_star")
            print("Invalid Rating")
        }
    
}
}
