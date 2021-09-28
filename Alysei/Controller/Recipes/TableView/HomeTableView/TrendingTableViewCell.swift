//
//  TrendingTableViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 26/08/21.
//

import UIKit


protocol CategoryRowDelegate {
   func cellTapped()
   }

class TrendingTableViewCell: UITableViewCell {

    @IBOutlet weak var quickSearchTrendingLabel: UILabel!
    @IBOutlet weak var collectionVwTrending: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    var delegate:CategoryRowDelegate?
    var tapViewAllTrending:(()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionVwTrending.delegate = self
        self.collectionVwTrending.dataSource = self
        headerView.backgroundColor = UIColor.init(red: 236/255, green: 247/255, blue: 255/255, alpha:1)
        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "TrendingCollectionViewCell", bundle: nil)
        self.collectionVwTrending.register(cellNib, forCellWithReuseIdentifier: "TrendingCollectionViewCell")

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapTrendingViewAll(_ sender: Any) {
        tapViewAllTrending!()
    }
    
}
extension TrendingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//       return self.rowWithimage?.count ?? 0
        return 6
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCollectionViewCell", for: indexPath) as? TrendingCollectionViewCell {
            
            
//            let imageName =  self.rowWithimage?[indexPath.item].image
//            cell.trendingImgVw.image = UIImage.init(named: "Group 660")
//            cell.itemNameLbl.text = self.rowWithimage?[indexPath.item].name ?? ""
            cell.recipeNameLbl.text = "Summer Berry Cake"
            
            
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
            delegate?.cellTapped()
            }

}

}
