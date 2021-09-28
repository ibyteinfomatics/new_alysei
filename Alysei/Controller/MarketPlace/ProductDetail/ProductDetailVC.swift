//
//  ProductDetailVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/2/21.
//

import UIKit

class ProductDetailVC: AlysieBaseViewC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    var arrRatingReview: [RatingReviewModel]?
    @IBOutlet weak var lblProductName: UILabel!
    
    
    
    // @IBOutlet weak var btnLikeUnlike: UIButton!
    
    var marketplaceProductId : String?
    var productDetail: ProductDetailModel?
    
    var expandedIndexPath = false
    var previousIndex: IndexPath?
    var nextIndex: IndexPath?
    var arrRatingCount:Int?
    //    var handlingInstrSelected = false
    //    var DispatchInstrSelected = false
    var sellerName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.addShadow()
        callProductDetailApi()
        callGetReviewApi()
        // Do any additional setup after loading the view.
    }
    
    //    func setFavUnfavProduct(){
    //        if self.productDetail?.product_detail?.is_favourite == 0{
    //            self.btnLikeUnlike.setImage(UIImage(named: "like_icon"), for: .normal)
    //        }else{
    //            self.btnLikeUnlike.setImage(UIImage(named: "liked_icon"), for: .normal)
    //        }
    //    }
    
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    //    @IBAction func likeUnlikeAction(_ sender: UIButton){
    //        if self.productDetail?.product_detail?.is_favourite == 1{
    //            self.callUnLikeApi()
    //        }else{
    //            self.callLikeApi()
    //        }
    //    }
    func scrollToTop(){
        // self.tableViewEditProfile.setContentOffset(CGPointMake(0,  UIApplication.shared.statusBarFrame.height ), animated: true)
        self.tableView.setContentOffset(CGPoint(x: 0, y: UIApplication.shared.statusBarFrame.height ), animated: true)
    }
    
    
    
}

extension ProductDetailVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTableVC", for: indexPath) as? ProductDetailTableVC else {return UITableViewCell()}
            cell.selectionStyle = .none
            cell.callLikeUnikeCallback = { likeUnlikeCheck in
                if likeUnlikeCheck == 0{
                    self.callUnLikeApi()
                    cell.btnLikeUnlike.setImage(UIImage(named: "UnlikeCircle_icon"), for: .normal)
                }else{
                    self.callLikeApi()
                    cell.btnLikeUnlike.setImage(UIImage(named: "LikeCircle_icon"), for: .normal)
                }
                
            }
            cell.configCell(productDetail ?? ProductDetailModel(with: [:]))
            
            return cell
        }else if indexPath.row == 1 || indexPath.row == 5 || indexPath.row == 6{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDescriptionTableVC", for: indexPath) as? ProductDescriptionTableVC else {return UITableViewCell()}
            cell.selectionStyle = .none
            //cell.lblDesc.numberOfLines = (self.handlingInstrSelected ) ? 0 : 2
            cell.reloadTableView = {
                self.tableView.reloadData()
            }
            cell.configCell(productDetail ?? ProductDetailModel(with: [:]), indexPath.row)
            
            return cell
        }else if indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 7{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDescOptionTableVC", for: indexPath) as? ProductDescOptionTableVC else {return UITableViewCell()}
            cell.selectionStyle = .none
            cell.configCell(productDetail ?? ProductDetailModel(with: [:]), indexPath.row)
            return cell
        }else if indexPath.row == 8{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductRatingTableVCell", for: indexPath) as? ProductRatingTableVCell else {return UITableViewCell()}
            cell.selectionStyle = .none
            cell.totalOneStar.text = "\(productDetail?.product_detail?.total_one_star ?? 0)"
            cell.totalTwoStar.text = "\(productDetail?.product_detail?.total_two_star ?? 0)"
            cell.totalThreeeStar.text = "\(productDetail?.product_detail?.total_three_star ?? 0)"
            cell.totalFourStar.text = "\(productDetail?.product_detail?.total_four_star ?? 0)"
            cell.totalFiveStar.text = "\(productDetail?.product_detail?.total_five_star ?? 0)"
            
            cell.totalOneStarProgress.setProgress((Float(productDetail?.product_detail?.total_one_star ?? 0) / 100), animated: true)
            cell.totalTwoStarProgress.setProgress(Float((productDetail?.product_detail?.total_two_star ?? 0) / 100), animated: true)
            cell.totalThreeeStarProgress.setProgress(Float((productDetail?.product_detail?.total_three_star ?? 0) / 100), animated: true)
            cell.totalFourStarProgress.setProgress(Float((productDetail?.product_detail?.total_four_star ?? 0)  / 100), animated: true)
            cell.totalFiveStarProgress.setProgress(Float((productDetail?.product_detail?.total_five_star ?? 0) / 100), animated: true)
            if arrRatingReview?.count == nil || arrRatingReview?.count == 0{
                cell.viewComment.isHidden = true
            }else{
                cell.viewComment.isHidden = false
                cell.lblProducerName.text = self.productDetail?.product_detail?.store_detail?.name
                cell.imgProducer.setImage(withString: kImageBaseUrl + String.getString(productDetail?.product_detail?.store_logo))
            }
            cell.pushCallBack = { tag in
                switch tag{
                case 0:
                    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "StoreDescViewController") as? StoreDescViewController else {return}
                    nextVC.passStoreId = "\(self.productDetail?.product_detail?.marketPlaceStoreId ?? 0)"
                    self.navigationController?.pushViewController(nextVC, animated: true)
                    
                case 1:
                    let controller = self.pushViewController(withName: ReviewScreenViewController.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? ReviewScreenViewController
                    controller?.productStoreId = "\(self.productDetail?.product_detail?.marketplaceProductId ?? 0)"
                    controller?.productStoreType = "2"
                default:
                    print("No action")
                }
            }
            cell.lblTotalReview.text = "\(self.productDetail?.product_detail?.total_reviews ?? 0) reviews"
            cell.lblAvgRating.text = "\(self.productDetail?.product_detail?.avg_rating ?? "0")"
            cell.avgRating = self.productDetail?.product_detail?.avg_rating
            cell.configCell(self.arrRatingReview?.first ?? RatingReviewModel(with: [:]))
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SimilarProductTableVCell", for: indexPath) as? SimilarProductTableVCell else {return UITableViewCell()}
            cell.selectionStyle = .none
            cell.showProductDetailCallBack = { productId in
                self.marketplaceProductId = "\(productId)"
                self.callProductDetailApi()
                self.scrollToTop()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    cell.collectonView.reloadData()
                }
            }
            cell.configCell(productDetail ?? ProductDetailModel(with: [:]))
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 580
        }else if indexPath.row == 1 || indexPath.row == 5 || indexPath.row == 6{
            return UITableView.automaticDimension
        }else if indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 7{
            return 60
        }else if indexPath.row == 8 {
            
            if arrRatingReview?.count == nil || arrRatingReview?.count == 0 {
                return 250
            }else{
                return UITableView.automaticDimension + 300
            }
        }else {
            return CGFloat((270 * ((self.productDetail?.related_products?.count ?? 0) / 2 )))
        }
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        if let cell = tableView.cellForRow(at: indexPath) as? ProductDescriptionTableVC{
    //            if indexPath.row == 5{
    //                self.handlingInstrSelected = !self.handlingInstrSelected
    //                if self.self.handlingInstrSelected == true{
    //                cell.lblDesc.numberOfLines = 2
    //                }else{
    //                    cell.lblDesc.numberOfLines = 0
    //                }
    //            }else{
    //                self.DispatchInstrSelected = !self.DispatchInstrSelected
    //                if self.self.DispatchInstrSelected == true{
    //                cell.lblDesc.numberOfLines = 2
    //                }else{
    //                    cell.lblDesc.numberOfLines = 0
    //                }
    //            }
    //            self.tableView.reloadData()
    //        }
    //    }
    
}

extension ProductDetailVC {
    
    func callProductDetailApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetProductMarketDetail + (marketplaceProductId ?? ""), requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let response = dictResponse as? [String:Any]
            if let data = response?["data"] as? [String:Any]{
                self.productDetail = ProductDetailModel.init(with: data)
            }
            self.lblProductName.text = self.productDetail?.product_detail?.title
            //self.setFavUnfavProduct()
            
            self.tableView.reloadData()
            
        }
    }
    
    func callLikeApi(){
        
        let params: [String:Any] = [
            APIConstants.kId : productDetail?.product_detail?.marketplaceProductId ?? 0,
            APIConstants.kfavourite_type: "2"
        ]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kLikeProductApi, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            // let response = dictResponse as? [String:Any]
            switch statusCode{
            case 200:
                // self.productDetail?.product_detail?.is_favourite = 0
                //self.setFavUnfavProduct()
                self.callProductDetailApi()
            //self.btnLikeUnlike.setImage(UIImage(named: "liked_icon"), for: .normal)
            default:
                print("Error")
            }
            
        }
    }
    
    func callUnLikeApi(){
        
        let params: [String:Any] = [
            APIConstants.kId : productDetail?.product_detail?.marketplaceProductId ?? 0,
            APIConstants.kfavourite_type: "2"
        ]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kUnlikeProductApi, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            switch statusCode{
            case 200:
                // self.productDetail?.product_detail?.is_favourite = 0
                //self.setFavUnfavProduct()
                self.callProductDetailApi()
            //self.btnLikeUnlike.setImage(UIImage(named: "liked_icon"), for: .normal)
            default:
                print("Error")
            }
        }
    }
    
    func callGetReviewApi(){
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetReview + "\(self.marketplaceProductId ?? "")" + "&type=2", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            switch statusCode {
            case 200:
                let response = dictResponse as? [String:Any]
                if let data = response?["data"] as? [[String:Any]]{
                    self.arrRatingReview = data.map({RatingReviewModel.init(with: $0)})
                }
            default:
                print("invalid")
            }
            
            self.tableView.reloadData()
        }
    }
}

