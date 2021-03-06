//
//  QuickEasyTableViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 30/09/21.
//

import UIKit

class QuickEasyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var quickSearchTrendingLabel: UILabel!
    @IBOutlet weak var collectionVwTrending: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var viewAllBtn: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    
    var delegate:CategoryRowDelegate?
    
    var tapViewAllTrending:(()->())?
    let gradientLayer = CAGradientLayer()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerLabel.text = RecipeConstants.kQuickEasy
        viewAllBtn.setTitle(RecipeConstants.kViewAll, for: .normal)
        self.collectionVwTrending.delegate = self
        self.collectionVwTrending.dataSource = self
        //        headerView.backgroundColor = UIColor.init(red: 236/255, green: 247/255, blue: 255/255, alpha:1)
        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "TrendingCollectionViewCell", bundle: nil)
        self.collectionVwTrending.register(cellNib, forCellWithReuseIdentifier: "TrendingCollectionViewCell")
        //        setGradientBackground()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        gradientLayer.frame = self.headerView.bounds
        CATransaction.commit()
    }
    func setGradientBackground() {
        
        //        let colorTop =  UIColor(red: 94.0/255.0, green: 199.0/255.0, blue: 167.0/255.0, alpha: 1.0).cgColor
        //        let colorBottom = UIColor(red: 70.0/255.0, green: 172.0/255.0, blue: 213.0/255.0, alpha: 1.0).cgColor
        let colorTop =  UIColor(red: 21.0/255.0, green: 68.0/255.0, blue: 120.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 21.0/255.0, green: 68.0/255.0, blue: 120.0/255.0, alpha: 1.0).cgColor
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.shouldRasterize = true
        self.headerView.layer.insertSublayer(gradientLayer, at: 0)
    }
    @IBAction func tapTrendingViewAll(_ sender: Any) {
        tapViewAllTrending!()
    }
}
extension QuickEasyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayQuickEasy?.count ?? 0
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCollectionViewCell", for: indexPath) as? TrendingCollectionViewCell {
            
            
            
            //            let imgUrl = (kImageBaseUrl + (arrayQuickEasy?[indexPath.item].image?.imgUrl ?? ""))
            //
            //            cell.trendingImgVw.setImage(withString: imgUrl)
            if (arrayQuickEasy?[indexPath.item].image?.imgUrl ?? "") == ""{
                cell.trendingImgVw.image = UIImage(named: "image_placeholder.png")
            }
            else{
                if let strUrl = "\((arrayQuickEasy?[indexPath.item].image?.baseUrl ?? "") + (arrayQuickEasy?[indexPath.item].image?.imgUrl ?? ""))".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
                   let imgUrl = URL(string: strUrl) {
                    print("ImageUrl-----------------------------------------\(imgUrl)")
                    cell.trendingImgVw.loadImageWithUrl(imgUrl) // call this line for getting image to yourImageView
                }
            }
            
            cell.trendingImgVw.contentMode = .scaleAspectFill
            cell.recipeNameLbl.text = arrayQuickEasy?[indexPath.item].name
            
            cell.likeLabel.text = "\(arrayQuickEasy?[indexPath.item].totalLikes ?? 0)" + " " + RecipeConstants.kLikes
            if arrayQuickEasy?[indexPath.item].userName == ""{
                cell.userNameLabel.text = RecipeConstants.kNA
            }
            else{
                cell.userNameLabel.text = arrayQuickEasy?[indexPath.item].userName
            }
            cell.timeLabel.text = "\( arrayQuickEasy?[indexPath.item].hours ?? 0)" + " " + RecipeConstants.kHours + " " + "\( arrayQuickEasy?[indexPath.item].minute ?? 0)" + " " + RecipeConstants.kMinutes
            cell.servingLabel.text = "\(arrayQuickEasy?[indexPath.item].serving ?? 0)" + " " + RecipeConstants.kServingHome
            cell.typeLabel.text = arrayQuickEasy?[indexPath.item].meal?.mealName
            
            if arrayQuickEasy?[indexPath.row].isFavourite == 0{
                cell.heartBtn.setImage(UIImage(named: "like_icon_white.png"), for: .normal)
            }
            else{
                cell.heartBtn.setImage(UIImage(named: "liked_icon.png"), for: .normal)
            }
            
            if arrayQuickEasy?[indexPath.row].avgRating == "0.0" || arrayQuickEasy?[indexPath.row].avgRating  == "0" {
                cell.ratingImg1.image = UIImage(named: "icons8_christmas_star_2")
                cell.ratingImg2.image = UIImage(named: "icons8_christmas_star_2")
                cell.ratingImg3.image = UIImage(named: "icons8_christmas_star_2")
                cell.ratingImg4.image = UIImage(named: "icons8_christmas_star_2")
                cell.ratingImg5.image = UIImage(named: "icons8_christmas_star_2")
            }  else if (arrayQuickEasy?[indexPath.row].avgRating  ?? "0") >= ("0.1") && (arrayQuickEasy?[indexPath.row].avgRating  ?? "0") <= ("0.9") {
                cell.ratingImg1.image = UIImage(named: "HalfStar")
                cell.ratingImg2.image = UIImage(named: "icons8_christmas_star_2")
                cell.ratingImg3.image = UIImage(named: "icons8_christmas_star_2")
                cell.ratingImg4.image = UIImage(named: "icons8_christmas_star_2")
                cell.ratingImg5.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayQuickEasy?[indexPath.row].avgRating == ("1.0") || arrayQuickEasy?[indexPath.row].avgRating  == ("1") {
                cell.ratingImg1.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg2.image = UIImage(named: "icons8_christmas_star_2")
                cell.ratingImg3.image = UIImage(named: "icons8_christmas_star_2")
                cell.ratingImg4.image = UIImage(named: "icons8_christmas_star_2")
                cell.ratingImg5.image = UIImage(named: "icons8_christmas_star_2")
            }else if (arrayQuickEasy?[indexPath.row].avgRating ?? "0") >= ("1.1") && (arrayQuickEasy?[indexPath.row].avgRating ?? "0") <= ("1.9"){
                cell.ratingImg1.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg2.image = UIImage(named: "HalfStar")
                cell.ratingImg3.image = UIImage(named: "icons8_christmas_star_2")
                cell.ratingImg4.image = UIImage(named: "icons8_christmas_star_2")
                cell.ratingImg5.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayQuickEasy?[indexPath.row].avgRating == ("2.0") || arrayQuickEasy?[indexPath.row].avgRating  == ("2"){
                cell.ratingImg1.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg2.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg3.image = UIImage(named: "icons8_christmas_star_2")
                cell.ratingImg4.image = UIImage(named: "icons8_christmas_star_2")
                cell.ratingImg5.image = UIImage(named: "icons8_christmas_star_2")
            }else if (arrayQuickEasy?[indexPath.row].avgRating ?? "0") >= ("2.1") && (arrayQuickEasy?[indexPath.row].avgRating  ?? "0") <= ("2.9"){
                cell.ratingImg1.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg2.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg3.image = UIImage(named: "HalfStar")
                cell.ratingImg4.image = UIImage(named: "icons8_christmas_star_2")
                cell.ratingImg5.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayQuickEasy?[indexPath.row].avgRating  == ("3.0") || arrayQuickEasy?[indexPath.row].avgRating  == ("3"){
                cell.ratingImg1.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg2.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg3.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg4.image = UIImage(named: "icons8_christmas_star_2")
                cell.ratingImg5.image = UIImage(named: "icons8_christmas_star_2")
            }else if (arrayQuickEasy?[indexPath.row].avgRating ?? "0") >= ("3.1") && (arrayQuickEasy?[indexPath.row].avgRating  ?? "0") <= ("3.9") {
                cell.ratingImg1.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg2.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg3.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg4.image = UIImage(named: "HalfStar")
                cell.ratingImg5.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayQuickEasy?[indexPath.row].avgRating  == ("4.0") || arrayQuickEasy?[indexPath.row].avgRating  == ("4"){
                cell.ratingImg1.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg2.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg3.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg4.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg5.image = UIImage(named: "icons8_christmas_star_2")
            }else if (arrayQuickEasy?[indexPath.row].avgRating  ?? "0") >= ("4.1") && (arrayQuickEasy?[indexPath.row].avgRating  ?? "0") <= ("4.9"){
                cell.ratingImg1.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg2.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg3.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg4.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg5.image = UIImage(named: "HalfStar")
            }else if arrayQuickEasy?[indexPath.row].avgRating  == ("5.0") || arrayQuickEasy?[indexPath.row].avgRating  == ("5"){
                cell.ratingImg1.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg2.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg3.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg4.image = UIImage(named: "icons8_christmas_star")
                cell.ratingImg5.image = UIImage(named: "icons8_christmas_star")
            }else{cell.ratingImg1.image = UIImage(named: "icons8_christmas_star_2")
                cell.ratingImg2.image = UIImage(named: "icons8_christmas_star_2")
                cell.ratingImg3.image = UIImage(named: "icons8_christmas_star_2")
                cell.ratingImg4.image = UIImage(named: "icons8_christmas_star_2")
                cell.ratingImg5.image = UIImage(named: "icons8_christmas_star_2")
                print("Invalid Rating")
            }
            
            return cell
            
            
        }
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: (self.collectionVwTrending.frame.width) - 40, height: 320.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            recipeId = (arrayQuickEasy?[indexPath.row].recipeId)!
            delegate?.cellTapped()
        }
        
    }
    
}
