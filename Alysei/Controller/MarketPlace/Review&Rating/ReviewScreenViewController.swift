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
    var productStoreType: String?
    var productStoreId: String?
    var arrRatingReviewData: [RatingReviewModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.addShadow()
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
        controller?.productStoreId = self.productStoreId
        controller?.productStoreType = self.productStoreType
    }
}


extension ReviewScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRatingReviewData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewScreenTableViewCell", for: indexPath) as? ReviewScreenTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        cell.lblName.text = arrRatingReviewData?[indexPath.row].user?.company_name
        cell.lblUserReview.text = arrRatingReviewData?[indexPath.row].review
        print("ImageUrl Image--------------------------\(kImageBaseUrl + String.getString(arrRatingReviewData?[indexPath.row].user?.avatarId?.attachment_url))")
        cell.imgUser.setImage(withString: kImageBaseUrl + String.getString(arrRatingReviewData?[indexPath.row].user?.avatarId?.attachment_url))
        if "\(arrRatingReviewData?[indexPath.row].rating ?? "")" == "0" {
            cell.imgStar1.image = UIImage(named: "icons8_star")
            cell.imgStar2.image = UIImage(named: "icons8_star")
            cell.imgStar3.image = UIImage(named: "icons8_star")
            cell.imgStar4.image = UIImage(named: "icons8_star")
            cell.imgStar5.image = UIImage(named: "icons8_star")
           
        }else if "\(arrRatingReviewData?[indexPath.row].rating ?? "")" == "1" {
            cell.imgStar1.image = UIImage(named: "icons8_christmas_star_2")
            cell.imgStar2.image = UIImage(named: "icons8_star")
            cell.imgStar3.image = UIImage(named: "icons8_star")
            cell.imgStar4.image = UIImage(named: "icons8_star")
            cell.imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(arrRatingReviewData?[indexPath.row].rating ?? "")" == "2" {
            cell.imgStar1.image = UIImage(named: "icons8_christmas_star_2")
            cell.imgStar2.image = UIImage(named: "icons8_christmas_star_2")
            cell.imgStar3.image = UIImage(named: "icons8_star")
            cell.imgStar4.image = UIImage(named: "icons8_star")
            cell.imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(arrRatingReviewData?[indexPath.row].rating ?? "")" == "3" {
            cell.imgStar1.image = UIImage(named: "icons8_christmas_star_2")
            cell.imgStar2.image = UIImage(named: "icons8_christmas_star_2")
            cell.imgStar3.image = UIImage(named: "icons8_christmas_star_2")
            cell.imgStar4.image = UIImage(named: "icons8_star")
            cell.imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(arrRatingReviewData?[indexPath.row].rating ?? "")" == "4" {
            cell.imgStar1.image = UIImage(named: "icons8_christmas_star_2")
            cell.imgStar2.image = UIImage(named: "icons8_christmas_star_2")
            cell.imgStar3.image = UIImage(named: "icons8_christmas_star_2")
            cell.imgStar4.image = UIImage(named: "icons8_christmas_star_2")
            cell.imgStar5.image = UIImage(named: "icons8_star")
        }else if "\(arrRatingReviewData?[indexPath.row].rating ?? "")" == "5" {
            cell.imgStar1.image = UIImage(named: "icons8_christmas_star_2")
            cell.imgStar2.image = UIImage(named: "icons8_christmas_star_2")
            cell.imgStar3.image = UIImage(named: "icons8_christmas_star_2")
            cell.imgStar4.image = UIImage(named: "icons8_christmas_star_2")
            cell.imgStar5.image = UIImage(named: "icons8_christmas_star_2")
        }
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
            self.tableView.reloadData()
        }
    }
}
