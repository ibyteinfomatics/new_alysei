//
//  ProductRatingTableVCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/2/21.
//

import UIKit

class ProductRatingTableVCell: UITableViewCell {

    @IBOutlet weak var lblTotalReview: UILabel!
    @IBOutlet weak var lblAvgRating: UILabel!
    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var lblClientReview: UILabel!
    @IBOutlet weak var lblReviewData: UILabel!
    @IBOutlet weak var lblProducerName:UILabel!
    @IBOutlet weak var imgProducer: UIImageView!
    @IBOutlet weak var viewComment: UIView!
    @IBOutlet weak var productAvgStar1: UIImageView!
    @IBOutlet weak var productAvgStar2: UIImageView!
    @IBOutlet weak var productAvgStar3: UIImageView!
    @IBOutlet weak var productAvgStar4: UIImageView!
    @IBOutlet weak var productAvgStar5: UIImageView!
    
    @IBOutlet weak var userRatingStar1: UIImageView!
    @IBOutlet weak var userRatingStar2: UIImageView!
    @IBOutlet weak var userRatingStar3: UIImageView!
    @IBOutlet weak var userRatingStar4: UIImageView!
    @IBOutlet weak var userRatingStar5: UIImageView!
    
    @IBOutlet weak var totalOneStar: UILabel!
    @IBOutlet weak var totalTwoStar: UILabel!
    @IBOutlet weak var totalThreeeStar: UILabel!
    @IBOutlet weak var totalFourStar: UILabel!
    @IBOutlet weak var totalFiveStar: UILabel!
    
//    @IBOutlet weak var totalOneStarProgress: UIProgressView!
//    @IBOutlet weak var totalTwoStarProgress: UIProgressView!
//    @IBOutlet weak var totalThreeeStarProgress: UIProgressView!
//    @IBOutlet weak var totalFourStarProgress: UIProgressView!
//    @IBOutlet weak var totalFiveStarProgress: UIProgressView!
    @IBOutlet weak var totalOneStarProgress: UIProgressView!
    @IBOutlet weak var totalTwoStarProgress: UIProgressView!
    @IBOutlet weak var totalThreeeStarProgress: UIProgressView!
    @IBOutlet weak var totalFourStarProgress: UIProgressView!
    @IBOutlet weak var totalFiveStarProgress: UIProgressView!
    @IBOutlet weak var lblStoreInfo: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var btnViewStore: UIButton!
    @IBOutlet weak var btnSeeAll: UIButton!
    
    var avgRating:String?
    var data: RatingReviewModel?
    var pushCallBack: ((Int) -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgProducer.layer.cornerRadius = 25
        lblStoreInfo.text = AppConstants.storeInfo
        lblRating.text = MarketPlaceConstant.kRatingAndReviews
        btnViewStore.setTitle(AppConstants.ViewStore, for: .normal)
        btnSeeAll.setTitle(MarketPlaceConstant.kSeeAll, for: .normal)
        self.setStarUI()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(_ data: RatingReviewModel){
       
        self.data = data
        if data.user?.role_id == UserRoles.restaurant.rawValue{
            lblClientName.text = data.user?.restaurant_name
        }else if data.user?.role_id == UserRoles.voyagers.rawValue || data.user?.role_id == UserRoles.voiceExperts.rawValue{
            
            lblClientName.text = "\(data.user?.first_name ?? "")" + "\(data.user?.last_name ?? "")"
        }else{
            lblClientName.text = data.user?.company_name
        }
       
        self.lblClientReview.text = data.review
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: data.created_at ?? "") {
            print(dateFormatterPrint.string(from: date))
            self.lblReviewData.text = "\(dateFormatterPrint.string(from: date))"
        } else {
           print("There was an error decoding the string")
        }
        setStarUI()
        setUserRatngStarUI()
    }

    func setUserRatngStarUI(){
        if data?.rating == "0.0" || data?.rating == "0" {
            userRatingStar1.image = UIImage(named: "icons8_star")
            userRatingStar2.image = UIImage(named: "icons8_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        } else if (data?.rating  ?? "0") >= ("0.1") && (data?.rating  ?? "0") <= ("0.9") {
            userRatingStar1.image = UIImage(named: "HalfStar")
            userRatingStar2.image = UIImage(named: "icons8_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        } else if data?.rating == "1.0" || data?.rating == "1" {
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if ((data?.rating ?? "0") >= ("1.1") && (data?.rating ?? "0") <= ("1.9")){
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "HalfStar")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.rating == "2.0" || data?.rating == "2"{
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if(data?.rating ?? "0") >= ("2.1") && (data?.rating  ?? "0") <= ("2.9") {
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "HalfStar")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.rating == "3.0" || data?.rating == "3"{
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if (data?.rating ?? "0") >= ("3.1") && (data?.rating  ?? "0") <= ("3.9") {
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star")
            userRatingStar4.image = UIImage(named: "HalfStar")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.rating == "4.0" || data?.rating == "4"{
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star")
            userRatingStar4.image = UIImage(named: "icons8_christmas_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if (data?.rating ?? "0") >= ("4.1") && (data?.rating  ?? "0") <= ("4.9") {
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star")
            userRatingStar4.image = UIImage(named: "icons8_christmas_star")
            userRatingStar5.image = UIImage(named: "HalfStar")
        }else if data?.rating == "5.0" || data?.rating == "5"{
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
    func setStarUI(){
        if avgRating == "0.0" || avgRating == "0"{
            productAvgStar1.image = UIImage(named: "icons8_star")
            productAvgStar2.image = UIImage(named: "icons8_star")
            productAvgStar3.image = UIImage(named: "icons8_star")
            productAvgStar4.image = UIImage(named: "icons8_star")
            productAvgStar5.image = UIImage(named: "icons8_star")
        }else if (data?.rating  ?? "0") >= ("0.1") && (data?.rating  ?? "0") <= ("0.9") {
            productAvgStar1.image = UIImage(named: "HalfStar")
            productAvgStar2.image = UIImage(named: "icons8_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if avgRating == "1.0"{
            productAvgStar1.image = UIImage(named: "icons8_christmas_star")
            productAvgStar2.image = UIImage(named: "icons8_star")
            productAvgStar3.image = UIImage(named: "icons8_star")
            productAvgStar4.image = UIImage(named: "icons8_star")
            productAvgStar5.image = UIImage(named: "icons8_star")
        }else if ((avgRating ?? "0") >= ("1.1") && (avgRating ?? "0") <= ("1.9")){
            productAvgStar1.image = UIImage(named: "icons8_christmas_star")
            productAvgStar2.image = UIImage(named: "HalfStar")
            productAvgStar3.image = UIImage(named: "icons8_star")
            productAvgStar4.image = UIImage(named: "icons8_star")
            productAvgStar5.image = UIImage(named: "icons8_star")
        }else if avgRating == "2.0"{
            productAvgStar1.image = UIImage(named: "icons8_christmas_star")
            productAvgStar2.image = UIImage(named: "icons8_christmas_star")
            productAvgStar3.image = UIImage(named: "icons8_star")
            productAvgStar4.image = UIImage(named: "icons8_star")
            productAvgStar5.image = UIImage(named: "icons8_star")
        }else if ((avgRating ?? "0") >= ("2.1") && (avgRating ?? "0") <= ("2.9")){
            productAvgStar1.image = UIImage(named: "icons8_christmas_star")
            productAvgStar2.image = UIImage(named: "icons8_christmas_star")
            productAvgStar3.image = UIImage(named: "HalfStar")
            productAvgStar4.image = UIImage(named: "icons8_star")
            productAvgStar5.image = UIImage(named: "icons8_star")
        }else if avgRating == "3.0"{
            productAvgStar1.image = UIImage(named: "icons8_christmas_star")
            productAvgStar2.image = UIImage(named: "icons8_christmas_star")
            productAvgStar3.image = UIImage(named: "icons8_christmas_star")
            productAvgStar4.image = UIImage(named: "icons8_star")
            productAvgStar5.image = UIImage(named: "icons8_star")
        }else if ((avgRating ?? "0") >= ("3.1") && (avgRating ?? "0") <= ("3.9")){
            productAvgStar1.image = UIImage(named: "icons8_christmas_star")
            productAvgStar2.image = UIImage(named: "icons8_christmas_star")
            productAvgStar3.image = UIImage(named: "icons8_christmas_star")
            productAvgStar4.image = UIImage(named: "HalfStar")
            productAvgStar5.image = UIImage(named: "icons8_star")
        }else if avgRating == "4.0"{
            productAvgStar1.image = UIImage(named: "icons8_christmas_star")
            productAvgStar2.image = UIImage(named: "icons8_christmas_star")
            productAvgStar3.image = UIImage(named: "icons8_christmas_star")
            productAvgStar4.image = UIImage(named: "icons8_christmas_star")
            productAvgStar5.image = UIImage(named: "icons8_star")
        }else if ((avgRating ?? "0") >= ("4.1") && (avgRating ?? "0") <= ("4.9")){
            productAvgStar1.image = UIImage(named: "icons8_christmas_star")
            productAvgStar2.image = UIImage(named: "icons8_christmas_star")
            productAvgStar3.image = UIImage(named: "icons8_christmas_star")
            productAvgStar4.image = UIImage(named: "icons8_christmas_star")
            productAvgStar5.image = UIImage(named: "HalfStar")
        }else if avgRating == "5.0"{
            productAvgStar1.image = UIImage(named: "icons8_christmas_star")
            productAvgStar2.image = UIImage(named: "icons8_christmas_star")
            productAvgStar3.image = UIImage(named: "icons8_christmas_star")
            productAvgStar4.image = UIImage(named: "icons8_christmas_star")
            productAvgStar5.image = UIImage(named: "icons8_christmas_star")
        }else{
            productAvgStar1.image = UIImage(named: "icons8_star")
            productAvgStar2.image = UIImage(named: "icons8_star")
            productAvgStar3.image = UIImage(named: "icons8_star")
            productAvgStar4.image = UIImage(named: "icons8_star")
            productAvgStar5.image = UIImage(named: "icons8_star")
           
        }
    }
    
   
    @IBAction func btnViewProfile(_ sender: UIButton){
        self.pushCallBack?(sender.tag)
    }
    @IBAction func btnViewAllReview(_ sender: UIButton){
        self.pushCallBack?(sender.tag)
       
    }
}
