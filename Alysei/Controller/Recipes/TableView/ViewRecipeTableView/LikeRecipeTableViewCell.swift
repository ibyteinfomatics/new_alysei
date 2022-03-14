//
//  LikeRecipeTableViewCell.swift
//  New Recipe module
//
//  Created by mac on 19/08/21.
//

import UIKit

protocol ViewRecipeDelegate {
    func cellTapped()
}
var youMightAlsoLikeModel: [ViewRecipeDetailDataModel]? = []
class LikeRecipeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var youMightLikeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate:CategoryRowDelegate?
    
    var post: Bool?{
        didSet{
            self.collectionView.reloadData()
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        youMightLikeLabel.text = RecipeConstants.kYouMightLike
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension LikeRecipeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        youMightAlsoLikeModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LikeRecipeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeRecipeCollectionViewCell", for: indexPath) as! LikeRecipeCollectionViewCell
        
        let imgUrl = ((youMightAlsoLikeModel?[indexPath.item].image?.baseUrl ?? "") + (youMightAlsoLikeModel?[indexPath.item].image?.imgUrl ?? ""))
        
        cell.imageView?.setImage(withString: imgUrl)
        cell.recipeNameLabel.text = youMightAlsoLikeModel?[indexPath.row].recipeName
        cell.UsernameLabel.text = youMightAlsoLikeModel?[indexPath.row].userName
        cell.timeLabel.text = "\( youMightAlsoLikeModel?[indexPath.item].hours ?? 0)" + " " + RecipeConstants.kHours + " " + "\( youMightAlsoLikeModel?[indexPath.item].minute ?? 0)" + " " + RecipeConstants.kMinutes
        cell.servingLabel.text = "\(youMightAlsoLikeModel?[indexPath.item].serving ?? 0)" + " " + RecipeConstants.kServingHome
        cell.cousineTypeLabel.text = youMightAlsoLikeModel?[indexPath.item].meal?.mealName ?? RecipeConstants.kNA
        cell.likeLLabel.text = "\(youMightAlsoLikeModel?[indexPath.row].favCount ?? 0 )" + " " + RecipeConstants.kLikes
        
        if youMightAlsoLikeModel?[indexPath.row].avgRating == "0.0" || youMightAlsoLikeModel?[indexPath.row].avgRating  == "0" {
            cell.rateImg1.image = UIImage(named: "icons8_star")
            cell.rateImg2.image = UIImage(named: "icons8_star")
            cell.rateImg3.image = UIImage(named: "icons8_star")
            cell.rateImg4.image = UIImage(named: "icons8_star")
            cell.rateImg5.image = UIImage(named: "icons8_star")
        }  else if (youMightAlsoLikeModel?[indexPath.row].avgRating  ?? "0") >= ("0.1") && (youMightAlsoLikeModel?[indexPath.row].avgRating  ?? "0") <= ("0.9") {
            cell.rateImg1.image = UIImage(named: "HalfStar")
            cell.rateImg2.image = UIImage(named: "icons8_star")
            cell.rateImg3.image = UIImage(named: "icons8_star")
            cell.rateImg4.image = UIImage(named: "icons8_star")
            cell.rateImg5.image = UIImage(named: "icons8_star")
        }else if youMightAlsoLikeModel?[indexPath.row].avgRating == ("1.0") || youMightAlsoLikeModel?[indexPath.row].avgRating  == ("1") {
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_star")
            cell.rateImg3.image = UIImage(named: "icons8_star")
            cell.rateImg4.image = UIImage(named: "icons8_star")
            cell.rateImg5.image = UIImage(named: "icons8_star")
        }else if (youMightAlsoLikeModel?[indexPath.row].avgRating ?? "0") >= ("1.1") && (youMightAlsoLikeModel?[indexPath.row].avgRating ?? "0") <= ("1.9"){
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "HalfStar")
            cell.rateImg3.image = UIImage(named: "icons8_star")
            cell.rateImg4.image = UIImage(named: "icons8_star")
            cell.rateImg5.image = UIImage(named: "icons8_star")
        }else if youMightAlsoLikeModel?[indexPath.row].avgRating == ("2.0") || youMightAlsoLikeModel?[indexPath.row].avgRating  == ("2"){
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg3.image = UIImage(named: "icons8_star")
            cell.rateImg4.image = UIImage(named: "icons8_star")
            cell.rateImg5.image = UIImage(named: "icons8_star")
        }else if (youMightAlsoLikeModel?[indexPath.row].avgRating ?? "0") >= ("2.1") && (youMightAlsoLikeModel?[indexPath.row].avgRating  ?? "0") <= ("2.9"){
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg3.image = UIImage(named: "HalfStar")
            cell.rateImg4.image = UIImage(named: "icons8_star")
            cell.rateImg5.image = UIImage(named: "icons8_star")
        }else if youMightAlsoLikeModel?[indexPath.row].avgRating  == ("3.0") || youMightAlsoLikeModel?[indexPath.row].avgRating  == ("3"){
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg4.image = UIImage(named: "icons8_star")
            cell.rateImg5.image = UIImage(named: "icons8_star")
        }else if (youMightAlsoLikeModel?[indexPath.row].avgRating ?? "0") >= ("3.1") && (youMightAlsoLikeModel?[indexPath.row].avgRating  ?? "0") <= ("3.9") {
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg4.image = UIImage(named: "HalfStar")
            cell.rateImg5.image = UIImage(named: "icons8_star")
        }else if youMightAlsoLikeModel?[indexPath.row].avgRating  == ("4.0") || youMightAlsoLikeModel?[indexPath.row].avgRating  == ("4"){
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg4.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg5.image = UIImage(named: "icons8_star")
        }else if (youMightAlsoLikeModel?[indexPath.row].avgRating  ?? "0") >= ("4.1") && (youMightAlsoLikeModel?[indexPath.row].avgRating  ?? "0") <= ("4.9"){
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg4.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg5.image = UIImage(named: "HalfStar")
        }else if youMightAlsoLikeModel?[indexPath.row].avgRating  == ("5.0") || youMightAlsoLikeModel?[indexPath.row].avgRating  == ("5"){
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg4.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg5.image = UIImage(named: "icons8_christmas_star")
        }else{cell.rateImg1.image = UIImage(named: "icons8_star")
            cell.rateImg2.image = UIImage(named: "icons8_star")
            cell.rateImg3.image = UIImage(named: "icons8_star")
            cell.rateImg4.image = UIImage(named: "icons8_star")
            cell.rateImg5.image = UIImage(named: "icons8_star")
            print("Invalid Rating")
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width) - 80 , height: 320)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            recipeId = (youMightAlsoLikeModel?[indexPath.item].recipeId)!
            delegate?.cellTapped()
        }
        
    }
}
