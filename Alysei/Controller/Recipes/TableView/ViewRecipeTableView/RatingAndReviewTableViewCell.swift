//
//  RatingAndReviewTableViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 27/10/21.
//

import UIKit

class RatingAndReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var ratingReviewLabel: UILabel!
    @IBOutlet weak var lblTotalReview: UILabel!
    @IBOutlet weak var lblAvgRating: UILabel!
    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var lblClientReview: UILabel!
    @IBOutlet weak var lblReviewData: UILabel!
    
    @IBOutlet weak var viewComment: UIView!
    
    @IBOutlet weak var storeAvgStar1: UIImageView!
    @IBOutlet weak var storeAvgStar2: UIImageView!
    @IBOutlet weak var storeAvgStar3: UIImageView!
    @IBOutlet weak var storeAvgStar4: UIImageView!
    @IBOutlet weak var storeAvgStar5: UIImageView!
    
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
    
    @IBOutlet weak var totalOneStarProgress: UIProgressView!
    @IBOutlet weak var totalTwoStarProgress: UIProgressView!
    @IBOutlet weak var totalThreeeStarProgress: UIProgressView!
    @IBOutlet weak var totalFourStarProgress: UIProgressView!
    @IBOutlet weak var totalFiveStarProgress: UIProgressView!
   
    @IBOutlet weak var heightuserName: NSLayoutConstraint!
    @IBOutlet weak var heightStackView: NSLayoutConstraint!
    @IBOutlet weak var vwCommentTop: NSLayoutConstraint!
    var btnAddReviewCallback:(() -> Void)? = nil
    var data: LatestReviewDataModel?
    var avgRating:String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        ratingReviewLabel.text = RecipeConstants.kRatingReview
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(_ data: LatestReviewDataModel){
        self.data = data
//        print("Data -----------------------------------\(String(describing: data.user?.compnyName))")
//        print("Data----------------------------\(data.review ?? "")")
//        if data.user?.roleId == UserRoles.restaurant.rawValue{
//            lblClientName.text = data.user?.restaurantName
//        }else if data.user?.roleId == UserRoles.voyagers.rawValue || data.user?.roleId == UserRoles.voiceExperts.rawValue{
            
            lblClientName.text = "\(data.user?.name ?? "")"
//        }else{
//            lblClientName.text = data.user?.compnyName
//        }
       
        self.lblClientReview.text = data.review
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: data.created ?? "") {
            print(dateFormatterPrint.string(from: date))
            self.lblReviewData.text = "\(dateFormatterPrint.string(from: date))"
        } else {
           print("There was an error decoding the string")
        }
        setUserRatngStarUI()
        setStarUI()
    }
    func setUserRatngStarUI(){
        if data?.rating == Int("0.0") || data?.rating == Int("0") {
            userRatingStar1.image = UIImage(named: "icons8_star")
            userRatingStar2.image = UIImage(named: "icons8_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }  else if (data?.rating ?? 0) >= Int("0.1") ?? 0 && (data?.rating ?? 0) <= Int("0.9") ?? 0 {
            userRatingStar1.image = UIImage(named: "HalfStar")
            userRatingStar2.image = UIImage(named: "icons8_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.rating == Int("1.0") || data?.rating == Int("1") {
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if (data?.rating ?? 0) >= Int("1.1") ?? 0  && (data?.rating ?? 0) <= Int("1.9") ?? 0{
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "HalfStar")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.rating == Int("2.0") || data?.rating == Int("2"){
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if (data?.rating ?? 0) >= Int("2.1") ?? 0  && (data?.rating ?? 0) <= Int("2.9") ?? 0 {
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "HalfStar")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.rating == Int("3.0") || data?.rating == Int("3"){
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if (data?.rating ?? 0) >= Int("3.1") ?? 0  && (data?.rating ?? 0) <= Int("3.9") ?? 0 {
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star")
            userRatingStar4.image = UIImage(named: "HalfStar")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.rating == Int("4.0") || data?.rating == Int("4"){
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star")
            userRatingStar4.image = UIImage(named: "icons8_christmas_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if (data?.rating ?? 0) >= Int("4.1") ?? 0  && (data?.rating ?? 0) <= Int("4.9") ?? 0{
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star")
            userRatingStar4.image = UIImage(named: "icons8_christmas_star")
            userRatingStar5.image = UIImage(named: "HalfStar")
        }else if data?.rating == Int("5.0") || data?.rating == Int("5"){
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
            print("Invalid Rating")
        }
    }
    func setStarUI(){
        if recipeModel?.avgRating == "0.0" || recipeModel?.avgRating  == "0" {
           storeAvgStar1.image = UIImage(named: "icons8_star")
            storeAvgStar2.image = UIImage(named: "icons8_star")
            storeAvgStar3.image = UIImage(named: "icons8_star")
            storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }  else if (recipeModel?.avgRating  ?? "0") >= ("0.1") && (recipeModel?.avgRating  ?? "0") <= ("0.9") {
            storeAvgStar1.image = UIImage(named: "HalfStar")
            storeAvgStar2.image = UIImage(named: "icons8_star")
            storeAvgStar3.image = UIImage(named: "icons8_star")
            storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if recipeModel?.avgRating == ("1.0") || recipeModel?.avgRating  == ("1") {
           storeAvgStar1.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar2.image = UIImage(named: "icons8_star")
            storeAvgStar3.image = UIImage(named: "icons8_star")
            storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if (recipeModel?.avgRating ?? "0") >= ("1.1") && (recipeModel?.avgRating ?? "0") <= ("1.9"){
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star")
           storeAvgStar2.image = UIImage(named: "HalfStar")
            storeAvgStar3.image = UIImage(named: "icons8_star")
            storeAvgStar4.image = UIImage(named: "icons8_star")
           storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if recipeModel?.avgRating == ("2.0") || recipeModel?.avgRating  == ("2"){
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star")
           storeAvgStar2.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar3.image = UIImage(named: "icons8_star")
            storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if (recipeModel?.avgRating ?? "0") >= ("2.1") && (recipeModel?.avgRating  ?? "0") <= ("2.9"){
           storeAvgStar1.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar2.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar3.image = UIImage(named: "HalfStar")
           storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if recipeModel?.avgRating  == ("3.0") || recipeModel?.avgRating  == ("3"){
           storeAvgStar1.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar2.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar3.image = UIImage(named: "icons8_christmas_star")
           storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if (recipeModel?.avgRating ?? "0") >= ("3.1") && (recipeModel?.avgRating  ?? "0") <= ("3.9") {
           storeAvgStar1.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar2.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar3.image = UIImage(named: "icons8_christmas_star")
           storeAvgStar4.image = UIImage(named: "HalfStar")
           storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if recipeModel?.avgRating  == ("4.0") || recipeModel?.avgRating  == ("4"){
           storeAvgStar1.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar2.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar3.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar4.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if (recipeModel?.avgRating  ?? "0") >= ("4.1") && (recipeModel?.avgRating  ?? "0") <= ("4.9"){
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star")
           storeAvgStar2.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar3.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar4.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar5.image = UIImage(named: "HalfStar")
        }else if recipeModel?.avgRating  == ("5.0") || recipeModel?.avgRating  == ("5"){
           storeAvgStar1.image = UIImage(named: "icons8_christmas_star")
           storeAvgStar2.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar3.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar4.image = UIImage(named: "icons8_christmas_star")
            storeAvgStar5.image = UIImage(named: "icons8_christmas_star")
        }else{storeAvgStar1.image = UIImage(named: "icons8_star")
            storeAvgStar2.image = UIImage(named: "icons8_star")
            storeAvgStar3.image = UIImage(named: "icons8_star")
            storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
            print("Invalid Rating")
        }
    }

    @IBAction func seeAll(_ sender: UIButton) {
        
        btnAddReviewCallback?()
    }
}
