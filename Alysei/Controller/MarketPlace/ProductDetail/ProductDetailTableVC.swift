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
    @IBOutlet weak var lblCostHght: NSLayoutConstraint!
   
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
        if (kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.travelAgencies.rawValue)" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.voyagers.rawValue)" || ( kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.restaurant.rawValue)") || kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.voiceExperts.rawValue)" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.producer.rawValue)") {
            lblCostHght.constant = 0
            lblProductPrice.isHidden = true
            
        }else{
            lblCostHght.constant = 24.5
            lblProductPrice.isHidden = false
        }
        lblProductName.text = data.product_detail?.title
        lblProductCategory.text = data.product_detail?.product_category_name
        lblProductPrice.text = "$" + (data.product_detail?.product_price ?? "")
       
        self.pageControl.numberOfPages = data.product_detail?.product_gallery?.count ?? 0
        btnLikeUnlike.setImage(UIImage(named: "like_icon"), for: .normal)
        if self.data?.product_detail?.is_favourite == 1{
            btnLikeUnlike.setImage(UIImage(named: "LikeCircle_icon"), for: .normal)
        }else{
            btnLikeUnlike.setImage(UIImage(named: "UnlikeCircle_icon"), for: .normal)
        }
        lblRating.text = "\(data.product_detail?.avg_rating ?? "0")"
        lblTotalRatings.text = "\(data.product_detail?.total_reviews ?? 0)" +  MarketPlaceConstant.kSRatings
        self.collectonView.reloadData()
    }
    @IBAction func likeUnlikeAction(_ sender: UIButton){
        
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
       
      //  self.pageControl.currentPage = indexPath.row
        let baseUrl = data?.product_detail?.product_gallery?[indexPath.row].baseUrl ?? ""
        let imageString = (baseUrl + String.getString(data?.product_detail?.product_gallery?[indexPath.row].attachment_url).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)
        if imageString != "" {
            let imageUrlS = URL(string: imageString)!
            cell.imgProduct.loadImageWithUrl(imageUrlS)
        }
        
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
    @IBOutlet weak var imgProduct: ImageLoader!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
