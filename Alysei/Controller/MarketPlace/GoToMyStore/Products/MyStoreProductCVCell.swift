//
//  MyStoreProductCVCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/24/21.
//

import UIKit

class MyStoreProductCVCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgProduct: ImageLoader!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var userRatingStar1: UIImageView!
    @IBOutlet weak var userRatingStar2: UIImageView!
    @IBOutlet weak var userRatingStar3: UIImageView!
    @IBOutlet weak var userRatingStar4: UIImageView!
    @IBOutlet weak var userRatingStar5: UIImageView!
    @IBOutlet weak var totalRating: UILabel!
    
    var editCallBack:((Int, Int) -> Void)? = nil
    var deleteCallBack:((Int) -> Void)? = nil
    var data: MyStoreProductDetail?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addShadow()
    }
    
    func configCell(_ data: MyStoreProductDetail){
        self.data = data
        lblProductName.text = data.title
        self.lblRating.text = data.avg_rating
        
        let baseUrl = data.product_gallery?.first?.baseUrl ?? ""
        let imageString = String(baseUrl + String.getString(data.product_gallery?.first?.attachment_url))
           
        if imageString != "" {
            let imgProductUrl = URL(string: imageString)!
            self.imgProduct.loadImageWithUrl(imgProductUrl)
        }
       // self.imgProduct.setImage(withString: )
        setUserRatngStarUI()
    }
    func setUserRatngStarUI(){
        if self.data?.avg_rating == "0.0" || data?.avg_rating == "0" {
            userRatingStar1.image = UIImage(named: "icons8_star")
            userRatingStar2.image = UIImage(named: "icons8_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        } else if data?.avg_rating == "1.0" || data?.avg_rating == "1" {
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.avg_rating == "1.5" {
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "HalfStar")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.avg_rating == "2.0" || data?.avg_rating == "2"{
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.avg_rating == "2.5" {
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "HalfStar")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.avg_rating == "3.0" || data?.avg_rating == "3"{
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.avg_rating == "3.5" {
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star")
            userRatingStar4.image = UIImage(named: "HalfStar")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.avg_rating == "4.0" || data?.avg_rating == "4"{
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star")
            userRatingStar4.image = UIImage(named: "icons8_christmas_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.avg_rating == "4.5" {
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star")
            userRatingStar4.image = UIImage(named: "icons8_christmas_star")
            userRatingStar5.image = UIImage(named: "HalfStar")
        }else if data?.avg_rating == "5.0" || data?.avg_rating == "5"{
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star")
            userRatingStar4.image = UIImage(named: "icons8_christmas_star")
            userRatingStar5.image = UIImage(named: "icons8_christmas_star")
        }else{userRatingStar1.image = UIImage(named: "icons8_star")
            userRatingStar2.image = UIImage(named: "icons8_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
           
        }
    }
    @IBAction func editProduct(_ sender: UIButton){
        self.editCallBack?(self.data?.marketplace_product_id ?? 0, sender.tag)
    }
    
    @IBAction func deleteProduct(_ sender: UIButton){
        self.deleteCallBack?(self.data?.marketplace_product_id ?? 0)
    }
    
}
