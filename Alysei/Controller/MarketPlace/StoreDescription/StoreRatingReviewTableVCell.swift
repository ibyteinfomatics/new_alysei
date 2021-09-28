//
//  StoreRatingReviewTableVCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/9/21.
//

import UIKit

class StoreRatingReviewTableVCell: UITableViewCell {
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
    
    var data: RatingReviewModel?
    var avgRating:String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(_ data: RatingReviewModel){
        self.data = data
        print("Data -----------------------------------\(String(describing: data.user?.company_name))")
        print("Data----------------------------\(data.review ?? "")")
        self.lblClientName.text = data.user?.company_name
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
        setUserRatngStarUI()
        setStarUI()
    }
    func setUserRatngStarUI(){
        if data?.rating == "0.0" || data?.rating == "0" {
            userRatingStar1.image = UIImage(named: "icons8_star")
            userRatingStar2.image = UIImage(named: "icons8_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        } else if data?.rating == "1.0" || data?.rating == "1" {
            userRatingStar1.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar2.image = UIImage(named: "icons8_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.rating == "1.5" {
            userRatingStar1.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar2.image = UIImage(named: "HalfStar")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.rating == "2.0" || data?.rating == "2"{
            userRatingStar1.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.rating == "2.5" {
            userRatingStar1.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar3.image = UIImage(named: "HalfStar")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.rating == "3.0" || data?.rating == "3"{
            userRatingStar1.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.rating == "3.5" {
            userRatingStar1.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar4.image = UIImage(named: "HalfStar")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.rating == "4.0" || data?.rating == "4"{
            userRatingStar1.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar4.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.rating == "4.5" {
            userRatingStar1.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar4.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar5.image = UIImage(named: "HalfStar")
        }else if data?.rating == "5.0" || data?.rating == "5"{
            userRatingStar1.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar4.image = UIImage(named: "icons8_christmas_star_2")
            userRatingStar5.image = UIImage(named: "icons8_christmas_star_2")
        }else{userRatingStar1.image = UIImage(named: "icons8_star")
            userRatingStar2.image = UIImage(named: "icons8_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
            print("Invalid Rating")
        }
    }
    func setStarUI(){
        if avgRating == "0.0" || avgRating == "0"{
            storeAvgStar1.image = UIImage(named: "icons8_star")
            storeAvgStar2.image = UIImage(named: "icons8_star")
            storeAvgStar3.image = UIImage(named: "icons8_star")
            storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if avgRating == "1.0"{
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar2.image = UIImage(named: "icons8_star")
            storeAvgStar3.image = UIImage(named: "icons8_star")
            storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if avgRating == "1.5"{
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar2.image = UIImage(named: "HalfStar")
            storeAvgStar3.image = UIImage(named: "icons8_star")
            storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if avgRating == "2.0"{
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar3.image = UIImage(named: "icons8_star")
            storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if avgRating == "2.5"{
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar3.image = UIImage(named: "HalfStar")
            storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if avgRating == "3.0"{
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar3.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if avgRating == "3.5"{
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar3.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar4.image = UIImage(named: "HalfStar")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if avgRating == "4.0"{
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar3.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar4.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar5.image = UIImage(named: "icons8_star")
        }else if avgRating == "4.5"{
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar3.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar4.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar5.image = UIImage(named: "HalfStar")
        }else if avgRating == "5.0"{
            storeAvgStar1.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar2.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar3.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar4.image = UIImage(named: "icons8_christmas_star_2")
            storeAvgStar5.image = UIImage(named: "icons8_christmas_star_2")
        }else{
            storeAvgStar1.image = UIImage(named: "icons8_star")
            storeAvgStar2.image = UIImage(named: "icons8_star")
            storeAvgStar3.image = UIImage(named: "icons8_star")
            storeAvgStar4.image = UIImage(named: "icons8_star")
            storeAvgStar5.image = UIImage(named: "icons8_star")
            print("Invalid Rating")
        }
    }
}
