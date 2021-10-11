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
    
    
    @IBOutlet weak var collectionView: UICollectionView!

    var delegate:CategoryRowDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        
        let imgUrl = (kImageBaseUrl + (youMightAlsoLikeModel?[indexPath.item].image?.imgUrl ?? ""))
        
        cell.imageView?.setImage(withString: imgUrl)
        cell.recipeNameLabel.text = youMightAlsoLikeModel?[indexPath.row].recipeName
        cell.UsernameLabel.text = youMightAlsoLikeModel?[indexPath.row].userName
        cell.timeLabel.text = "\( youMightAlsoLikeModel?[indexPath.item].hours ?? 0)" + " " + "hours" + " " + "\( youMightAlsoLikeModel?[indexPath.item].minute ?? 0)" + " " + "minutes"
        cell.servingLabel.text = "\(youMightAlsoLikeModel?[indexPath.item].serving ?? 0)" + " " + "Serving"
        cell.cousineTypeLabel.text = youMightAlsoLikeModel?[indexPath.item].meal?.mealName ?? "NA"
        cell.likeLLabel.text = "\(youMightAlsoLikeModel?[indexPath.row].favCount ?? 0 )" + " " + "Likes"
       
        if youMightAlsoLikeModel?[indexPath.item].avgRating ?? "0.0" == "0.0" {
            cell.rateImg1.image = UIImage(named: "icons8_star")
            cell.rateImg2.image = UIImage(named: "icons8_star")
            cell.rateImg3.image = UIImage(named: "icons8_star")
            cell.rateImg4.image = UIImage(named: "icons8_star")
            cell.rateImg5.image = UIImage(named: "icons8_star")

        }
        else if youMightAlsoLikeModel?[indexPath.item].avgRating ?? "0.0" == "0.5" {
            cell.rateImg1.image = UIImage(named: "Group 1142")
            cell.rateImg2.image = UIImage(named: "icons8_star")
            cell.rateImg3.image = UIImage(named: "icons8_star")
            cell.rateImg4.image = UIImage(named: "icons8_star")
           cell.rateImg5.image = UIImage(named: "icons8_star")
        }else if youMightAlsoLikeModel?[indexPath.item].avgRating ?? "0.0" == "1.0" {
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_star")
            cell.rateImg3.image = UIImage(named: "icons8_star")
            cell.rateImg4.image = UIImage(named: "icons8_star")
           cell.rateImg5.image = UIImage(named: "icons8_star")
        }
        else if youMightAlsoLikeModel?[indexPath.item].avgRating ?? "0.0" == "1.5" {
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "Group 1142")
            cell.rateImg3.image = UIImage(named: "icons8_star")
            cell.rateImg4.image = UIImage(named: "icons8_star")
            cell.rateImg5.image = UIImage(named: "icons8_star")
        }else if youMightAlsoLikeModel?[indexPath.item].avgRating ?? "0.0" == "2.0" {
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg3.image = UIImage(named: "icons8_star")
            cell.rateImg4.image = UIImage(named: "icons8_star")
            cell.rateImg5.image = UIImage(named: "icons8_star")
        }
        else if youMightAlsoLikeModel?[indexPath.item].avgRating ?? "0.0" == "2.5" {
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg3.image = UIImage(named: "Group 1142")
            cell.rateImg4.image = UIImage(named: "icons8_star")
            cell.rateImg5.image = UIImage(named: "icons8_star")
        }else if youMightAlsoLikeModel?[indexPath.item].avgRating ?? "0.0" == "3.0" {
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg4.image = UIImage(named: "icons8_star")
            cell.rateImg5.image = UIImage(named: "icons8_star")
        }
        else if youMightAlsoLikeModel?[indexPath.item].avgRating ?? "0.0" == "3.5" {
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg4.image = UIImage(named: "Group 1142")
            cell.rateImg5.image = UIImage(named: "icons8_star")
        }else if youMightAlsoLikeModel?[indexPath.item].avgRating ?? "0.0" == "4.0" {
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg4.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg5.image = UIImage(named: "icons8_star")
        }
        else if youMightAlsoLikeModel?[indexPath.item].avgRating ?? "0.0" == "4.5" {
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg4.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg5.image = UIImage(named: "Group 1142")
        }else if youMightAlsoLikeModel?[indexPath.item].avgRating ?? "0.0" == "5.0" {
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg4.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg5.image = UIImage(named: "icons8_christmas_star")
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
