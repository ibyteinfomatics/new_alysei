//
//  LikeRecipeTableViewCell.swift
//  New Recipe module
//
//  Created by mac on 19/08/21.
//

import UIKit
var youMightAlsoLikeModel: [ViewRecipeDetailDataModel]? = []
class LikeRecipeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var collectionView: UICollectionView!

    
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
        
        let imgUrl = (kImageBaseUrl + (youMightAlsoLikeModel?[indexPath.item].userMain?.avatarId?.imageUrl ?? ""))
        
        cell.imageView?.setImage(withString: imgUrl)
        cell.recipeNameLabel.text = youMightAlsoLikeModel?[indexPath.row].recipeName
        cell.UsernameLabel.text = youMightAlsoLikeModel?[indexPath.row].userName
        cell.timeLabel.text = "\( youMightAlsoLikeModel?[indexPath.item].hours ?? 0)" + " " + "hours" + " " + "\( youMightAlsoLikeModel?[indexPath.item].minute ?? 0)" + " " + "minutes"
        cell.servingLabel.text = "\(youMightAlsoLikeModel?[indexPath.item].serving ?? 0)" + " " + "Serving"
        cell.cousineTypeLabel.text = youMightAlsoLikeModel?[indexPath.item].meal?.mealName ?? "NA"
        
       
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width) - 80 , height: 320)
        
    }
}
