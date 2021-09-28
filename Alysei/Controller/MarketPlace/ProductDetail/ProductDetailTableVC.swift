//
//  ProductDetailTableVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/2/21.
//

import UIKit

class ProductDetailTableVC: UITableViewCell {
    
    @IBOutlet weak var collectonView: UICollectionView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblProductCategory: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var btnLikeUnlike: UIButton!
    @IBOutlet weak var lblTotalRatings: UILabel!
   
    var callLikeUnikeCallback: ((Int) -> Void)? = nil

    
    var data: ProductDetailModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configCell(_ data: ProductDetailModel){
        self.data = data
        lblProductName.text = data.product_detail?.title
        lblProductCategory.text = data.product_detail?.product_category_name
        lblProductPrice.text = "$" + (data.product_detail?.product_price ?? "")
        print("Product count----------------------\(data.product_detail?.product_gallery?.count ?? 0)")
        self.pageControl.numberOfPages = data.product_detail?.product_gallery?.count ?? 0
        btnLikeUnlike.setImage(UIImage(named: "like_icon"), for: .normal)
        if self.data?.product_detail?.is_favourite == 1{
            btnLikeUnlike.setImage(UIImage(named: "LikeCircle_icon"), for: .normal)
        }else{
            btnLikeUnlike.setImage(UIImage(named: "UnlikeCircle_icon"), for: .normal)
        }
        lblRating.text = "\(data.product_detail?.avg_rating ?? "0")"
        lblTotalRatings.text = "\(data.product_detail?.total_reviews ?? 0) ratings"
        self.collectonView.reloadData()
    }
    @IBAction func likeUnlikeAction(_ sender: UIButton){
        print("is Fav---------------------------\(data?.product_detail?.is_favourite ?? 0)")
        if data?.product_detail?.is_favourite == 0{
        self.callLikeUnikeCallback?(1)
        }else{
            self.callLikeUnikeCallback?(0)
        }
    }

}

extension ProductDetailTableVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data?.product_detail?.product_gallery?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductImageColectionViewCell", for: indexPath) as? ProductImageColectionViewCell else {return UICollectionViewCell()}
        print("Current Page ---------------------\(indexPath.row )")
      //  self.pageControl.currentPage = indexPath.row
        cell.imgProduct.setImage(withString: kImageBaseUrl + String.getString(data?.product_detail?.product_gallery?[indexPath.row].attachment_url))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectonView.frame.width, height: 500)
    }
}

class ProductImageColectionViewCell: UICollectionViewCell{
    @IBOutlet weak var imgProduct: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
