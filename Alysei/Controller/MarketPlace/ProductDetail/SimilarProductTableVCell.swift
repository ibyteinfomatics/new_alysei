//
//  SimilarProductTableVCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/2/21.
//

import UIKit

class SimilarProductTableVCell: UITableViewCell {
    

    @IBOutlet weak var collectonView: UICollectionView!
    var data: ProductDetailModel?
    var showProductDetailCallBack:((Int) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configCell(_ data: ProductDetailModel){
        self.data = data
        self.collectonView.reloadData()
    }

}

extension SimilarProductTableVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data?.related_products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarProductCollectionVCell", for: indexPath) as? SimilarProductCollectionVCell else {return UICollectionViewCell()}
        cell.labelProductName.text = data?.related_products?[indexPath.row].title
        cell.imgProduct.setImage(withString: kImageBaseUrl + String.getString(data?.related_products?[indexPath.row].product_gallery?.first?.attachment_url))
        cell.lblavgRating.text = data?.related_products?[indexPath.row].avg_rating
        cell.configCell(data?.related_products?[indexPath.row] ?? ProductSearchListModel(with: [:]))
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectonView.frame.width / 2, height: 270)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showProductDetailCallBack?(data?.related_products?[indexPath.row].marketplaceProductId ?? 0)
    }
}

class SimilarProductCollectionVCell: UICollectionViewCell{
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var lblavgRating: UILabel!
    @IBOutlet weak var lblTotalRating: UILabel!
    
    @IBOutlet weak var simProductAvgStar1: UIImageView!
    @IBOutlet weak var simProductAvgStar2: UIImageView!
    @IBOutlet weak var simProductAvgStar3: UIImageView!
    @IBOutlet weak var simProductAvgStar4: UIImageView!
    @IBOutlet weak var simProductAvgStar5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(_ data: ProductSearchListModel){
        lblTotalRating.text = "\(data.total_reviews ?? 0)" + " Reviews"
        if data.avg_rating == "0.0" || data.avg_rating == "0"{
            simProductAvgStar1.image = UIImage(named: "icons8_star")
            simProductAvgStar2.image = UIImage(named: "icons8_star")
            simProductAvgStar3.image = UIImage(named: "icons8_star")
            simProductAvgStar4.image = UIImage(named: "icons8_star")
            simProductAvgStar5.image = UIImage(named: "icons8_star")
        } else if data.avg_rating == "1.0" || data.avg_rating == "1" {
            simProductAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
            simProductAvgStar2.image = UIImage(named: "icons8_star")
            simProductAvgStar3.image = UIImage(named: "icons8_star")
            simProductAvgStar4.image = UIImage(named: "icons8_star")
            simProductAvgStar5.image = UIImage(named: "icons8_star")
            }else if data.avg_rating == "1.5" {
                simProductAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar2.image = UIImage(named: "HalfStar")
                simProductAvgStar3.image = UIImage(named: "icons8_star")
                simProductAvgStar4.image = UIImage(named: "icons8_star")
                simProductAvgStar5.image = UIImage(named: "icons8_star")
            }else if data.avg_rating == "2.0" || data.avg_rating == "2"{
                simProductAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar3.image = UIImage(named: "icons8_star")
                simProductAvgStar4.image = UIImage(named: "icons8_star")
                simProductAvgStar5.image = UIImage(named: "icons8_star")
            }else if data.avg_rating == "2.5" {
                simProductAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar3.image = UIImage(named: "HalfStar")
                simProductAvgStar4.image = UIImage(named: "icons8_star")
                simProductAvgStar5.image = UIImage(named: "icons8_star")
            }else if data.avg_rating == "3.0" || data.avg_rating == "3"{
                simProductAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar3.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar4.image = UIImage(named: "icons8_star")
                simProductAvgStar5.image = UIImage(named: "icons8_star")
            }else if data.avg_rating == "3.5" {
                simProductAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar3.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar4.image = UIImage(named: "HalfStar")
                simProductAvgStar5.image = UIImage(named: "icons8_star")
            }else if data.avg_rating == "4.0" || data.avg_rating == "4"{
                simProductAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar3.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar4.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar5.image = UIImage(named: "icons8_star")
            }else if data.avg_rating == "4.5" {
                simProductAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar3.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar4.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar5.image = UIImage(named: "HalfStar")
            }else if data.avg_rating == "5.0" || data.avg_rating == "5"{
                simProductAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar3.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar4.image = UIImage(named: "icons8_christmas_star_2")
                simProductAvgStar5.image = UIImage(named: "icons8_christmas_star_2")
            }else{
                simProductAvgStar1.image = UIImage(named: "icons8_star")
                simProductAvgStar2.image = UIImage(named: "icons8_star")
                simProductAvgStar3.image = UIImage(named: "icons8_star")
                simProductAvgStar5.image = UIImage(named: "icons8_star")
                simProductAvgStar5.image = UIImage(named: "icons8_star")
                print("Invalid Rating")
            }
        }
    }
