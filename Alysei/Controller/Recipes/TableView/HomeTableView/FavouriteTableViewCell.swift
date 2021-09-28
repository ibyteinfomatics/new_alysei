//
//  FavouriteTableViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 27/08/21.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
    var arrayMyRecipe: [[String: Any]] = []
    var check: Bool?
    @IBOutlet weak var favouriteCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.favouriteCollectionView.delegate = self
        self.favouriteCollectionView.dataSource = self

        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "MyRecipeCollectionViewCell", bundle: nil)
        self.favouriteCollectionView.register(cellNib, forCellWithReuseIdentifier: "MyRecipeCollectionViewCell")
        
        favouriteCollectionView.reloadData()
    }
    
}
extension FavouriteTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//       return self.rowWithimage?.count ?? 0
        return 8
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyRecipeCollectionViewCell", for: indexPath) as? MyRecipeCollectionViewCell {
            
            cell.editRecipeButton.isHidden = check ?? false
            cell.deaftButton.isHidden = check ?? false
            
//            let imageName =  self.rowWithimage?[indexPath.item].image
//            cell.itemImgVw.image = UIImage.init(named: "brussels_sprouts_sliders")
//            cell.itemNameLbl.text = self.rowWithimage?[indexPath.item].name ?? ""
//            cell.itemImgVw.layer.cornerRadius = cell.itemImgVw.frame.height/2
//            cell.itemNameLbl.text = "Appetizer"
            return cell
           
        }
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
        return CGSize(width: self.favouriteCollectionView.frame.width, height: 250.0)
       }
}
