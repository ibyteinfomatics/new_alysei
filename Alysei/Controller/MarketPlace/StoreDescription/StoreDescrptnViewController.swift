//
//  StoreDescrptnViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 11/25/21.
//

import UIKit

class StoreDescrptnViewController: AlysieBaseViewC {
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblStoreName: UILabel!
    var storeDetails: MyStoreProductDetail?
    var storeProducts: [ProductSearchListModel]?
    var passStoreId: String?

    
    var number : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        vwHeader.drawBottomShadow()
        
        callStoreDetailApi()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callStoreDetailApi()
    }
    func setUIData(){
        lblStoreName.text = storeDetails?.name
        self.number = storeDetails?.phone
    }
    
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnViewAllReview(_ sender: UIButton){
        let controller = pushViewController(withName: ReviewScreenViewController.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? ReviewScreenViewController
        controller?.productStoreId = "\(self.storeDetails?.marketplace_store_id ?? 0)"
        controller?.productStoreType = "1"
    }
}

extension StoreDescrptnViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoreDescTopTableViewCell", for: indexPath) as? StoreDescTopTableViewCell else {return UITableViewCell()}
            cell.selectionStyle = .none
            cell.callBackMoveToProfile = {
                let controller = self.pushViewController(withName: ProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? ProfileViewC
               // controller?.userLevel = .other
                controller?.userID = self.storeDetails?.user_id
                if kSharedUserDefaults.loggedInUserModal.userId == "\(self.storeDetails?.user_id ?? 0)"{
                    controller?.userLevel = .own
                }else{
                    controller?.userLevel = .other
                }
               
            }
            cell.callApiCallBack = {
                self.callStoreDetailApi()
            }
            cell.callLocationCallBack = {
                let storboard = UIStoryboard(name: "Login", bundle: nil)
                guard let nextVC = storboard.instantiateViewController(identifier: "MapViewC") as? MapViewC else {return}
                nextVC.fromVC = .StoreDetail
                nextVC.hubLatCordinate = Double.getDouble(self.storeDetails?.latitude)
                nextVC.hubLongCordinate = Double.getDouble(self.storeDetails?.longitude)
               self.navigationController?.pushViewController(nextVC, animated: true)
            }
            
            cell.callWebsiteViewCallBack = {
                let website = (self.storeDetails?.website ?? "")
                print("Website----------------------------",website)
                guard let url = URL(string: website) else { return }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        cell.lblTotalProducts.text = "\(storeProducts?.count ?? 0)"
        
        cell.configCell(self.storeDetails ?? MyStoreProductDetail(with: [:]))
            return cell
        }else if indexPath.row == 1{
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
        }else{
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
        if indexPath.row == 2{
            if self.storeProducts?.count == 0 {
                return 0
            }
            if self.storeProducts?.count == 1 || self.storeProducts?.count == 2 {
                return 280
            }
            return CGFloat((280 * ((self.storeProducts?.count ?? 0) / 2 )))
        }
        return UITableView.automaticDimension
    }
}

extension StoreDescrptnViewController{
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
//
//            self.imageCollectionView.reloadData()
            self.tableView.reloadData()
        }
    }

    
}
