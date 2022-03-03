//
//  StoreDescTopTableViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 11/25/21.
//

import UIKit
import GoogleMaps
import CoreLocation

class StoreDescTopTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var imgCover : UIImageView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var labelAvgRating: UILabel!
    @IBOutlet weak var labelTotalReview: UILabel!
    @IBOutlet weak var lblTotalProducts: UILabel!
    @IBOutlet weak var lblCategories: UILabel!
    @IBOutlet weak var lblStoreDesc: UILabel!
    @IBOutlet weak var lblProducerName: UILabel!
    @IBOutlet weak var lblRole: UILabel!
   
    @IBOutlet weak var imgProducer: UIImageView!
   
    @IBOutlet weak var imgCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var vwStoreLike: UIView!
    @IBOutlet weak var imgLikeUnlike: UIImageView!
    @IBOutlet weak var vwCall: UIView!
    @IBOutlet weak var vwLocation: UIView!
    @IBOutlet weak var vwWebsite: UIView!
    
    @IBOutlet weak var storeAvgStar1: UIImageView!
    @IBOutlet weak var storeAvgStar2: UIImageView!
    @IBOutlet weak var storeAvgStar3: UIImageView!
    @IBOutlet weak var storeAvgStar4: UIImageView!
    @IBOutlet weak var storeAvgStar5: UIImageView!
    @IBOutlet weak var lblTitleProduct: UILabel!
    @IBOutlet weak var lblTitleCategories: UILabel!
    @IBOutlet weak var lblTitleLocation: UILabel!
    @IBOutlet weak var lblTitleCall: UILabel!
    @IBOutlet weak var lblTitleAddtoFav: UILabel!
    @IBOutlet weak var lblTitleMapLocation: UILabel!
    @IBOutlet weak var lblWebsite: UILabel!
    @IBOutlet weak var lblOurGallery: UILabel!
    
    var storeDetails: MyStoreProductDetail?
    var callBackMoveToProfile: (() -> Void)? = nil
    var callApiCallBack: (() -> Void)? = nil
    var callLocationCallBack: (() -> Void)? = nil
    var callWebsiteViewCallBack: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgCover.layer.cornerRadius = 20
        imgCover.layer.masksToBounds = true
        imgProfile.layer.cornerRadius = 60
        imgProducer.layer.cornerRadius = 25
        imgProfile.layer.borderWidth = 2
        imgProfile.layer.borderColor = UIColor.white.cgColor
        lblTitleProduct.text = MarketPlaceConstant.kProduct
        lblTitleCategories.text = MarketPlaceConstant.kCategories
        lblRole.text = MarketPlaceConstant.kItalianFBProducer
        lblTitleLocation.text = MarketPlaceConstant.kLocation
        lblTitleCall.text = MarketPlaceConstant.kCall
        lblTitleAddtoFav.text = MarketPlaceConstant.kAddToFav
        lblTitleMapLocation.text = MarketPlaceConstant.kLocation
        lblWebsite.text = MarketPlaceConstant.kCWebsite
        lblOurGallery.text = MarketPlaceConstant.kOurGallery
       
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(callLikeDisLikeApi))
        self.vwStoreLike.addGestureRecognizer(tap)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(callUser))
        self.vwCall.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(openWebsite))
        self.vwWebsite.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(openLocation))
        self.vwLocation.addGestureRecognizer(tap3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func moveToProfile(_ sender: UIButton){
        callBackMoveToProfile?()
    }
    func configCell(_ storeDetails: MyStoreProductDetail){
        self.imageCollectionView.reloadData()
        self.storeDetails = storeDetails
        lblStoreDesc.text = storeDetails.description
        lblProducerName.text = storeDetails.prefilled?.companyName
        lblCategories.text = "\(storeDetails.totalCategory ?? 0)"
         labelAvgRating.text = storeDetails.avg_rating
        labelTotalReview.text = (storeDetails.total_reviews ?? "0") + MarketPlaceConstant.kSpaceReview
        self.imgProfile.setImage(withString: (storeDetails.logo_base_url ?? "") + String.getString(storeDetails.logo_id))
        self.imgCover.setImage(withString: String.getString(storeDetails.banner_base_url) + String.getString(storeDetails.banner_id))
        self.imgProducer.setImage(withString: (storeDetails.prefilled?.avatarId?.baseUrl ?? "") + String.getString(storeDetails.prefilled?.avatarId?.attachmentUrl))
        
        if storeDetails.is_favourite == 0{
            self.imgLikeUnlike.image = UIImage(named: "LikesBlue")
        }else{
            self.imgLikeUnlike.image = UIImage(named: "LikeIcon")
            
        }
        self.mapView.isMyLocationEnabled = true
        
        //Create the pin location of your restaurant(you need the GPS coordinates for this)
        
        let doubleLat = Double.getDouble(storeDetails.latitude)
        let doubleLong = Double.getDouble(storeDetails.longitude)
        if storeDetails.is_favourite == 0{
            self.imgLikeUnlike.image = UIImage(named: "LikesBlue")
        }else{
            self.imgLikeUnlike.image = UIImage(named: "LikeIcon")
            
        }
     //   self.mapView.isMyLocationEabled = true
        //Create the pin location of your restaurant(you need the GPS coordinates for this)
        
        let camera = GMSCameraPosition.camera(withLatitude: doubleLat , longitude: doubleLong, zoom: 12.0)
        self.mapView.camera = camera
        setStarUI()
    }
    func setStarUI(){
        if storeDetails?.avg_rating == "0.0" || storeDetails?.avg_rating == "0"{
            storeAvgStar1.image = UIImage(named: "icons8_star")
            storeAvgStar2.image = UIImage(named: "icons8_star")
            storeAvgStar3.image = UIImage(named: "icons8_star")
            storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if storeDetails?.avg_rating == "1.0"{
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar2.image = UIImage(named: "icons8_star")
            storeAvgStar3.image = UIImage(named: "icons8_star")
            storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if storeDetails?.avg_rating == "1.5"{
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar2.image = UIImage(named: "HalfStar")
            storeAvgStar3.image = UIImage(named: "icons8_star")
            storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if storeDetails?.avg_rating == "2.0"{
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar2.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar3.image = UIImage(named: "icons8_star")
            storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if storeDetails?.avg_rating == "2.5"{
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar2.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar3.image = UIImage(named: "HalfStar")
            storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if storeDetails?.avg_rating == "3.0"{
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar2.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar3.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if storeDetails?.avg_rating == "3.5"{
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar2.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar3.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar4.image = UIImage(named: "HalfStar")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if storeDetails?.avg_rating == "4.0"{
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar2.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar3.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar4.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if storeDetails?.avg_rating == "4.5"{
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar2.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar3.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar4.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar5.image = UIImage(named: "HalfStar")
        }else if storeDetails?.avg_rating == "5.0"{
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar2.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar3.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar4.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar5.image = UIImage(named: "icons8_christmas_star")
        }else{
            storeAvgStar1.image = UIImage(named: "icons8_star")
            storeAvgStar2.image = UIImage(named: "icons8_star")
            storeAvgStar3.image = UIImage(named: "icons8_star")
            storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
            
        }
    }
    @objc func callLikeDisLikeApi(){
        if storeDetails?.is_favourite == 0{
            self.callLikeApi()
            
        }else{
            self.callUnLikeApi()
            
            
        }
    }
    @objc func callUser(){
        if let url = URL(string: "tel://\(storeDetails?.phone ?? "")"),
          UIApplication.shared.canOpenURL(url) {
             if #available(iOS 10, *) {
               UIApplication.shared.open(url, options: [:], completionHandler:nil)
              } else {
                  UIApplication.shared.openURL(url)
              }
          } else {
            print("Error")
                   // add error message here
          }
    }
    @objc func openLocation(){
        callLocationCallBack?()
        
    }
    
    @objc func openWebsite(){
        
        callWebsiteViewCallBack?()
       
//        guard let url = URL(string: website) else {
//          return //be safe
//        }
//        if #available(iOS 10.0, *) {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        } else {
//            UIApplication.shared.openURL(url)
//        }
    }
}

extension StoreDescTopTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if ((self.storeDetails?.store_gallery?.count == 0) || (self.storeDetails?.store_gallery?.count == nil)){
            return 1
        }
        return storeDetails?.store_gallery?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "StoreDescImageCollectionVCell", for: indexPath) as? StoreDescImageCollectionVCell else {return UICollectionViewCell()}
        if ((self.storeDetails?.store_gallery?.count == 0) || (self.storeDetails?.store_gallery?.count == nil)){
            cell.vwContainer.isHidden = false
            cell.imgStore.isHidden = true
        }else{
            cell.vwContainer.isHidden = true
            cell.imgStore.isHidden = false
            let imageUrl = ((storeDetails?.store_gallery?[indexPath.row].baseUrl ?? "") + String.getString(storeDetails?.store_gallery?[indexPath.row].attachment_url))
            cell.imgStore.setImage(withString: imageUrl)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.imageCollectionView.frame.width / 2, height: 220)
    }
    
}

extension StoreDescTopTableViewCell {
    func callLikeApi(){
        
        let params: [String:Any] = [
            APIConstants.kId : storeDetails?.marketplace_store_id ?? 0,
            APIConstants.kfavourite_type: "1"
        ]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kLikeProductApi, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
           // let response = dictResponse as? [String:Any]
            switch statusCode{
            case 200:
                self.imgLikeUnlike.image = UIImage(named: "LikeIcon")
                self.callApiCallBack?()
            default:
                 print("Error")
            }
           
        }
    }
    func callUnLikeApi(){
        
        let params: [String:Any] = [
            APIConstants.kId : storeDetails?.marketplace_store_id ?? 0,
            APIConstants.kfavourite_type: "1"
        ]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kUnlikeProductApi, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            switch statusCode{
            case 200:
                self.imgLikeUnlike.image = UIImage(named: "LikesBlue")
                self.callApiCallBack?()
            default:
                 print("Error")
            }
        }
    }
}
