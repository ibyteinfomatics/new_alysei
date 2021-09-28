//
//  LikeRecipeTableViewCell.swift
//  New Recipe module
//
//  Created by mac on 19/08/21.
//

import UIKit

class LikeRecipeTableViewCell: UITableViewCell {
    
    var imageArray2 = [#imageLiteral(resourceName: "monika-grabkowska-89HtiQoRgPc-unsplash"),#imageLiteral(resourceName: "monika-grabkowska-89HtiQoRgPc-unsplash"),#imageLiteral(resourceName: "monika-grabkowska-89HtiQoRgPc-unsplash"),#imageLiteral(resourceName: "monika-grabkowska-89HtiQoRgPc-unsplash")]
    var recipeNameArray = ["Dal Bati","Churma","Roti","Rice"]
    var userNameArray = ["Deepanshu","Abhishek","Rahul","Smriti"]
    var timeArray = ["2hr 10min","1hr","2hr 30min","30min"]
    var servingArray = ["2 Serving","1 Serving","5 Serving","10 Serving"]
    var cousineTypeArray = ["Dessert","Dessert","Lunch","Dinner"]
    
    @IBOutlet weak var collectionView: UICollectionView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension LikeRecipeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LikeRecipeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeRecipeCollectionViewCell", for: indexPath) as! LikeRecipeCollectionViewCell
        cell.imageView.image = imageArray2[indexPath.row]
        cell.recipeNameLabel.text = recipeNameArray[indexPath.row]
        cell.UsernameLabel.text = userNameArray[indexPath.row]
        cell.timeLabel.text = timeArray[indexPath.row]
        cell.servingLabel.text = servingArray[indexPath.row]
        cell.cousineTypeLabel.text = cousineTypeArray[indexPath.row]
        
       
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width) - 80 , height: 320)
        
    }
}
