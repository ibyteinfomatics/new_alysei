//
//  StoreDescViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/9/21.
//

import UIKit
import GoogleMaps
import CoreLocation

class StoreDescViewController: AlysieBaseViewC {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgCover : UIImageView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var labelAvgRating: UILabel!
    @IBOutlet weak var labelTotalReview: UILabel!
    @IBOutlet weak var lblTotalProducts: UILabel!
    @IBOutlet weak var lblCategories: UILabel!
    @IBOutlet weak var lblStoreDesc: UILabel!
    @IBOutlet weak var lblProducerName: UILabel!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var imgProducer: UIImageView!
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var imgCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var vwStoreLike: UIView!
    @IBOutlet weak var imgLikeUnlike: UIImageView!
    @IBOutlet weak var vwCall: UIView!
    @IBOutlet weak var vwLoaction: UIView!
    @IBOutlet weak var vwWebsite: UIView!
   
    @IBOutlet weak var lblOurGallery: UILabel!
    var storeDetails: MyStoreProductDetail?
    var storeProducts: [ProductSearchListModel]?
    var passStoreId: String?
    //var arrRatingReview: [RatingReviewModel]?
    @IBOutlet weak var storeAvgStar1: UIImageView!
    @IBOutlet weak var storeAvgStar2: UIImageView!
    @IBOutlet weak var storeAvgStar3: UIImageView!
    @IBOutlet weak var storeAvgStar4: UIImageView!
    @IBOutlet weak var storeAvgStar5: UIImageView!

    
    var number: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgCover.layer.cornerRadius = 20
        imgCover.layer.masksToBounds = true
        callStoreDetailApi()
        //callGetReviewApi()
        imgProfile.layer.cornerRadius = 60
        imgProducer.layer.cornerRadius = 25
        imgProfile.layer.borderWidth = 2
        imgProfile.layer.borderColor = UIColor.white.cgColor
        vwHeader.addShadow()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(callLikeDisLikeApi))
        self.vwStoreLike.addGestureRecognizer(tap)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(callUser))
        self.vwCall.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(openWebsite))
        self.vwWebsite.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(openLocation))
        self.vwLoaction.addGestureRecognizer(tap3)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callStoreDetailApi()
    }
    func setUIData(){
        lblStoreName.text = storeDetails?.name
        lblTotalProducts.text = "\(storeProducts?.count ?? 0)"
        lblStoreDesc.text = storeDetails?.description
        lblProducerName.text = storeDetails?.prefilled?.companyName
        lblCategories.text = "\(storeDetails?.totalCategory ?? 0)"
         labelAvgRating.text = storeDetails?.avg_rating
        labelTotalReview.text = (storeDetails?.total_reviews ?? "0") + " Reviews"
        self.imgProfile.setImage(withString: kImageBaseUrl + String.getString(storeDetails?.logo_id))
        self.imgCover.setImage(withString: kImageBaseUrl + String.getString(storeDetails?.banner_id))
        self.imgProducer.setImage(withString: kImageBaseUrl + String.getString(storeDetails?.prefilled?.avatarId?.attachmentUrl))
//        if self.storeProducts?.count == 0{
//            self.imageCollectionView.isHidden = true
//            self.imgCollectionViewHeight.constant = 0
//        }else{
//            self.imageCollectionView.isHidden = false
//            self.imgCollectionViewHeight.constant = 250
//        }
//        if self.storeDetails?.store_gallery?.count == 0 || self.storeDetails?.store_gallery?.count == nil{
//            self.imageCollectionView.isHidden = true
//            self.imgCollectionViewHeight.constant = 0
//            self.lblOurGallery.isHidden = true
//        }else{
//            self.imageCollectionView.isHidden = false
//            self.imgCollectionViewHeight.constant = 250
//            self.lblOurGallery.isHidden = false
//        }
        if storeDetails?.is_favourite == 0{
            self.imgLikeUnlike.image = UIImage(named: "LikesBlue")
        }else{
            self.imgLikeUnlike.image = UIImage(named: "LikeIcon")
            
        }
        self.mapView.isMyLocationEnabled = true
        self.number = storeDetails?.phone
        //Create the pin location of your restaurant(you need the GPS coordinates for this)
        
        let doubleLat = Double.getDouble(storeDetails?.latitude)
        let doubleLong = Double.getDouble(storeDetails?.longitude)
        
        //let storeLoaction = CLLocation(latitude: doubleLat, longitude: doubleLong)//
            //CLLocationCoordinate2D(latitude: storeDetails?.lattitude, longitude: storeDetails?.longitude)

              //Center the map on the place location
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
            print("Invalid Rating")
        }
    }
    
    @objc func callLikeDisLikeApi(){
        if storeDetails?.is_favourite == 0{
            self.callLikeApi()
            self.imgLikeUnlike.image = UIImage(named: "LikeIcon")
        }else{
            self.callUnLikeApi()
            self.imgLikeUnlike.image = UIImage(named: "LikesBlue")
            
        }
    }
    @objc func callUser(){
        if let url = URL(string: "tel://\(number ?? "")"),
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
        let storboard = UIStoryboard(name: "Login", bundle: nil)
        guard let nextVC = storboard.instantiateViewController(identifier: "MapViewC") as? MapViewC else {return}
        nextVC.fromVC = .StoreDetail
        nextVC.hubLatCordinate = Double.getDouble(self.storeDetails?.latitude)
        nextVC.hubLongCordinate = Double.getDouble(self.storeDetails?.longitude)
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @objc func openWebsite(){
        let website = (storeDetails?.website ?? "")
        print("Website----------------------------",website)
        guard let url = URL(string: website) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        guard let url = URL(string: website) else {
//          return //be safe
//        }
//        if #available(iOS 10.0, *) {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        } else {
//            UIApplication.shared.openURL(url)
//        }
    }
    @IBAction func btnViewAllReview(_ sender: UIButton){
        let controller = pushViewController(withName: ReviewScreenViewController.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? ReviewScreenViewController
        controller?.productStoreId = "\(self.storeDetails?.marketplace_store_id ?? 0)"
        controller?.productStoreType = "1"
    }
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func moveToProfile(_ sender: UIButton){
        let controller = pushViewController(withName: ProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? ProfileViewC
        controller?.userLevel = .other
        controller?.userID = storeDetails?.user_id
    }
}

extension StoreDescViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoreRatingReviewTableVCell", for: indexPath) as? StoreRatingReviewTableVCell else {return UITableViewCell()}
            
            cell.selectionStyle = .none
            let doubleTotalReview = Double.getDouble(storeDetails?.total_reviews)
            
            cell.totalOneStar.text = "\(Int(calculateRatingPercentage(doubleTotalReview, Double.getDouble(storeDetails?.total_one_star))))%"
            cell.totalTwoStar.text = "\(Int(calculateRatingPercentage(doubleTotalReview, Double.getDouble(storeDetails?.total_two_star))))%"
            cell.totalThreeeStar.text = "\(Int(calculateRatingPercentage(doubleTotalReview, Double.getDouble(storeDetails?.total_three_star))))%"
            cell.totalFourStar.text = "\(Int(calculateRatingPercentage(doubleTotalReview, Double.getDouble(storeDetails?.total_four_star))))%"
            cell.totalFiveStar.text = "\(Int(calculateRatingPercentage(doubleTotalReview, Double.getDouble(storeDetails?.total_five_star))))%"
            
           
            
            cell.totalOneStarProgress.setProgress(Float(calculateRatingPercentage(doubleTotalReview, Double.getDouble(storeDetails?.total_one_star)))/100, animated: false)
            
            cell.totalTwoStarProgress.setProgress(Float(calculateRatingPercentage(doubleTotalReview, Double(storeDetails?.total_two_star ?? 0)))/100, animated: false)
            
            cell.totalThreeeStarProgress.setProgress(Float(calculateRatingPercentage(doubleTotalReview, Double.getDouble(storeDetails?.total_three_star)))/100, animated: false)
            
            cell.totalFourStarProgress.setProgress(Float(calculateRatingPercentage(doubleTotalReview, Double.getDouble(storeDetails?.total_four_star)))/100, animated: false)
            
            cell.totalFiveStarProgress.setProgress(Float(calculateRatingPercentage(doubleTotalReview, Double.getDouble(storeDetails?.total_five_star)))/100, animated: false)
            if storeDetails?.latest_review == nil {
                cell.viewComment.isHidden = true
            }else{
                cell.viewComment.isHidden = false
    
            }
            cell.lblTotalReview.text = "\(self.storeDetails?.total_reviews ?? "0") reviews"
            cell.lblAvgRating.text = "\(self.storeDetails?.avg_rating ?? "0")"
            cell.avgRating = storeDetails?.avg_rating
            cell.configCell(self.storeDetails?.latest_review ?? RatingReviewModel(with: [:]))
            return cell
        }else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoreDescProductTableVCell", for: indexPath) as? StoreDescProductTableVCell else {return UITableViewCell()}
            cell.configCell(storeProducts)
            cell.pushCallback = { id in
                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ProductDetailVC") as? ProductDetailVC else {return}
                nextVC.marketplaceProductId = "\(id)"
                         self.navigationController?.pushViewController(nextVC, animated: true)
            }
           
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            if storeDetails?.latest_review == nil  {
                //return 250
                return UITableView.automaticDimension
            }else{
                return UITableView.automaticDimension //+ 250
            }
        }else {
            return CGFloat((280 * ((self.storeProducts?.count ?? 0) / 2 )))
            
            // return CGFloat((250 * (6 / 2)))
        }
    }
    
    
}
extension StoreDescViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
        cell.imgStore.setImage(withString: kImageBaseUrl + String.getString(storeDetails?.store_gallery?[indexPath.row].attachment_url))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.imageCollectionView.frame.width / 2, height: 220)
    }
    
    
}

extension StoreDescViewController{
    func callStoreDetailApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetSellerProfile + "\(passStoreId ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let response = dictResponse as? [String:Any]
            
            if let data = response?["data"] as? [String:Any]{
                self.storeDetails = MyStoreProductDetail.init(with: data)
            }
            
            if let arrData = response?["store_products"] as? [[String:Any]]{
                self.storeProducts = arrData.map({ProductSearchListModel.init(with: $0)})
            }
            self.setUIData()
            
            self.imageCollectionView.reloadData()
            self.tableView.reloadData()
        }
    }
//    func callGetReviewApi(){
//
//        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetReview + "\(self.passStoreId ?? "")" + "&type=1", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
//            switch statusCode {
//            case 200:
//                let response = dictResponse as? [String:Any]
//                if let data = response?["data"] as? [[String:Any]]{
//                    self.arrRatingReview = data.map({RatingReviewModel.init(with: $0)})
//                }
//            default:
//                print("invalid")
//            }
//
//            self.tableView.reloadData()
//        }
//    }
    func callLikeApi(){
        
        let params: [String:Any] = [
            APIConstants.kId : storeDetails?.marketplace_store_id ?? 0,
            APIConstants.kfavourite_type: "1"
        ]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kLikeProductApi, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
           // let response = dictResponse as? [String:Any]
            switch statusCode{
            case 200:
               // self.productDetail?.product_detail?.is_favourite = 0
                //self.setFavUnfavProduct()
                self.callStoreDetailApi()
                //self.btnLikeUnlike.setImage(UIImage(named: "liked_icon"), for: .normal)
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
               // self.productDetail?.product_detail?.is_favourite = 0
                //self.setFavUnfavProduct()
                self.callStoreDetailApi()
                //self.btnLikeUnlike.setImage(UIImage(named: "liked_icon"), for: .normal)
            default:
                 print("Error")
            }
        }
    }
}
