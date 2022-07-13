//
//  ReviewScreenViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/9/21.
//

import UIKit

class ReviewScreenViewController: AlysieBaseViewC {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnEditAdd : UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    var productStoreType: String?
    var productStoreId: String?
    var arrRatingReviewData: [RatingReviewModel]?
    var isReviewed: Int?
    var isAddReview: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.drawBottomShadow()
        lblTitle.text = MarketPlaceConstant.kAddReview
        lblSubTitle.text = MarketPlaceConstant.kCapReviews
        callGetReviewApi()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callGetReviewApi()
    }
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addReview(_ sender: UIButton){
        
        let controller = self.pushViewController(withName: AddReviewViewController.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? AddReviewViewController
        if isAddReview == true{
            controller?.productStoreId = "\(self.arrRatingReviewData?.first?.marketplace_review_rating_id ?? 0)"
            controller?.editReviewData = self.arrRatingReviewData?.first
        }else{
            controller?.productStoreId = self.productStoreId
            
        }
       
       
        controller?.productStoreType = self.productStoreType
        controller?.isEditReview = isAddReview
    }
}


extension ReviewScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRatingReviewData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewScreenTableViewCell", for: indexPath) as? ReviewScreenTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        
        if arrRatingReviewData?[indexPath.row].user?.role_id == UserRoles.restaurant.rawValue{
        cell.lblName.text = arrRatingReviewData?[indexPath.row].user?.restaurant_name
        }else if arrRatingReviewData?[indexPath.row].user?.role_id == UserRoles.voyagers.rawValue || arrRatingReviewData?[indexPath.row].user?.role_id == UserRoles.voiceExperts.rawValue{
            cell.lblName.text = "\(arrRatingReviewData?[indexPath.row].user?.first_name ?? "")" + "\(arrRatingReviewData?[indexPath.row].user?.last_name ?? "")"
        }else{
            cell.lblName.text = arrRatingReviewData?[indexPath.row].user?.company_name
        }
        cell.lblUserReview.text = arrRatingReviewData?[indexPath.row].review
        
        cell.imgUser.setImage(withString: (String.getString(arrRatingReviewData?[indexPath.row].user?.avatarId?.baseUrl)) + String.getString(arrRatingReviewData?[indexPath.row].user?.avatarId?.attachment_url))
        
        if "\(arrRatingReviewData?[indexPath.row].rating ?? "")" == "0" {
            cell.imgStar1.image = UIImage(named: "icons8_star")
            cell.imgStar2.image = UIImage(named: "icons8_star")
            cell.imgStar3.image = UIImage(named: "icons8_star")
            cell.imgStar4.image = UIImage(named: "icons8_star")
            cell.imgStar5.image = UIImage(named: "icons8_star")
           
        }else if "\(arrRatingReviewData?[indexPath.row].rating ?? "")" == "1" {
            cell.imgStar1.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar2.image = UIImage(named: "icons8_star")
            cell.imgStar3.image = UIImage(named: "icons8_star")
            cell.imgStar4.image = UIImage(named: "icons8_star")
            cell.imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(arrRatingReviewData?[indexPath.row].rating ?? "")" == "2" {
            cell.imgStar1.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar2.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar3.image = UIImage(named: "icons8_star")
            cell.imgStar4.image = UIImage(named: "icons8_star")
            cell.imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(arrRatingReviewData?[indexPath.row].rating ?? "")" == "3" {
            cell.imgStar1.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar2.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar3.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar4.image = UIImage(named: "icons8_star")
            cell.imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(arrRatingReviewData?[indexPath.row].rating ?? "")" == "4" {
            cell.imgStar1.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar2.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar3.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar4.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(arrRatingReviewData?[indexPath.row].rating ?? "")" == "5" {
            cell.imgStar1.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar2.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar3.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar4.image = UIImage(named: "icons8_christmas_star")
            cell.imgStar5.image = UIImage(named: "icons8_christmas_star")
        }
//        cell.editReviewCallback = { index in
//            let controller = self.pushViewController(withName: "AddReviewViewController", fromStoryboard: StoryBoardConstants.kMarketplace) as? AddReviewViewController
//            controller?.productStoreId = "\(self.arrRatingReviewData?[indexPath.row].marketplace_review_rating_id ?? 0)"
//            controller?.productStoreType = self.productStoreType
//            controller?.editReviewData = self.arrRatingReviewData?[index]
//            controller?.isEditReview = self.isAddReview
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ReviewScreenViewController {
    func callGetReviewApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetReview + "\(productStoreId ?? "")" + "&type=" + "\(productStoreType ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errtype, statusCode) in
            
            let response = dictResponse as? [String:Any]
            if let data = response?["data"] as? [[String:Any]]{
                self.arrRatingReviewData = data.map({RatingReviewModel.init(with: $0)})
            }
            self.isReviewed = response?["is_rated"] as? Int
            if self.isReviewed == 0 || self.isReviewed == nil {
                self.isAddReview = false
                self.btnEditAdd.setImage(UIImage(named: "add_icon_blue"), for: .normal)
            }else{
                self.isAddReview = true
                self.btnEditAdd.setImage(UIImage(named: "icons8_edit_3"), for: .normal)
            }
            self.tableView.reloadData()
        }
    }
    
}
