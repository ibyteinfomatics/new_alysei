//
//  ExploreByRecipeTableViewCell.swift
//  Alysei
//
//  Created by namrata upadhyay on 23/08/21.
//

import UIKit

class ExploreByRecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var quickSearchByRegionLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var collectionVwRegion: UICollectionView!
    
    var tapViewAllRecipe:(()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.collectionVwRegion.delegate = self
        self.collectionVwRegion.dataSource = self

        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "SearchByRegionCollectionViewCell", bundle: nil)
        self.collectionVwRegion.register(cellNib, forCellWithReuseIdentifier: "SearchByRegionCollectionViewCell")
        headerView.backgroundColor = UIColor.init(red: 236/255, green: 247/255, blue: 255/255, alpha:1)
        // Configure the view for the selected state
    }
    @IBAction func tapByRegionViewAll(_ sender: Any) {
        tapViewAllRecipe?()
    }
    
}

extension ExploreByRecipeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//       return self.rowWithimage?.count ?? 0
        return 6
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchByRegionCollectionViewCell", for: indexPath) as? SearchByRegionCollectionViewCell {
            
            
//            let imageName =  self.rowWithimage?[indexPath.item].image
            cell.countryImgVw.image = UIImage.init(named: "Group 660")
//            cell.itemNameLbl.text = self.rowWithimage?[indexPath.item].name ?? ""
            cell.countryNameLbl.text = "American Recipes"
            return cell
           
        }
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
        return CGSize(width: self.collectionVwRegion.frame.width / 5, height: 130.0)
       }

}

