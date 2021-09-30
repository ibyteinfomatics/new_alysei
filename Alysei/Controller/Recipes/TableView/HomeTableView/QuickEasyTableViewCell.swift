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
    
    var delegate:CategoryRowDelegate?
    
    var tapViewAllTrending:(()->())?
    let gradientLayer = CAGradientLayer()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionVwTrending.delegate = self
        self.collectionVwTrending.dataSource = self
        headerView.backgroundColor = UIColor.init(red: 236/255, green: 247/255, blue: 255/255, alpha:1)
        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "TrendingCollectionViewCell", bundle: nil)
        self.collectionVwTrending.register(cellNib, forCellWithReuseIdentifier: "TrendingCollectionViewCell")
        setGradientBackground()
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
     
        let colorTop =  UIColor(red: 94.0/255.0, green: 199.0/255.0, blue: 167.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 70.0/255.0, green: 172.0/255.0, blue: 213.0/255.0, alpha: 1.0).cgColor
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
            
            
            
                let imgUrl = (kImageBaseUrl + (arrayQuickEasy?[indexPath.item].image?.imgUrl ?? ""))
                
                cell.trendingImgVw.setImage(withString: imgUrl)
                
                cell.trendingImgVw.contentMode = .scaleAspectFill
                cell.recipeNameLbl.text = arrayQuickEasy?[indexPath.item].name
                cell.likeLabel.text = ""
                cell.userNameLabel.text = ""
                cell.timeLabel.text = "\( arrayQuickEasy?[indexPath.item].hours ?? 0)" + " " + "hours" + " " + "\( arrayQuickEasy?[indexPath.item].minute ?? 0)" + " " + "minutes"
                cell.servingLabel.text = "\(arrayQuickEasy?[indexPath.item].serving ?? 0)"
                cell.typeLabel.text = arrayQuickEasy?[indexPath.item].meal?.mealName
           
            
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
