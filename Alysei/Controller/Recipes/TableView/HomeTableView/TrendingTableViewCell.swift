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
var arrayTrending : [HomeTrending]?
var arrayQuickEasy : [HomeQuickEasy]?
class TrendingTableViewCell: UITableViewCell {

    @IBOutlet weak var quickSearchTrendingLabel: UILabel!
    @IBOutlet weak var collectionVwTrending: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    
    var delegate:CategoryRowDelegate?
    var tapViewAllTrending:(()->())?
    var checkCellTrending = 0
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
        // Initialization code
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
     
        let colorTop =  UIColor(red: 55.0/255.0, green: 162.0/255.0, blue: 130.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 47.0/255.0, green: 151.0/255.0, blue: 193.0/255.0, alpha: 1.0).cgColor
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.shouldRasterize = true
        self.headerView.layer.insertSublayer(gradientLayer, at: 0)
    }
    @IBAction func tapTrendingViewAll(_ sender: Any) {
        tapViewAllTrending!()
    }
    
//    func getTrending(){
//        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getRecipeHomeScreen
//                                                   , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
//
//            let dictResponse = dictResponse as? [String:Any]
//
//            if let data = dictResponse?["data"] as? [String:Any]{
//
//                if let trendings = data["trending_recipes"] as? [[String:Any]]{
//                    let trending = trendings.map({HomeTrending.init(with: $0)})
//                    arrayTrending = trending
//                    print("\(String(describing: arrayTrending?.count))")
//                }
//            }
//            self.collectionVwTrending.reloadData()
//    }
//    }
    
//    func getQuickEasy(){
//        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getRecipeHomeScreen
//                                                   , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
//
//            let dictResponse = dictResponse as? [String:Any]
//
//            if let data = dictResponse?["data"] as? [String:Any]{
//
//                if let quickEasy = data["quick_easy"] as? [[String:Any]]{
//                    let quickEase = quickEasy.map({HomeQuickEasy.init(with: $0)})
//                   arrayQuickEasy = quickEase
//                    print("\(String(describing: arrayQuickEasy?.count))")
//                }
//            }
//            self.collectionVwTrending.reloadData()
//    }
//    }
}
extension TrendingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if checkCellTrending == 0{
          return  arrayTrending?.count ?? 0
        }
        else {
           return arrayQuickEasy?.count ?? 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCollectionViewCell", for: indexPath) as? TrendingCollectionViewCell {
            
            
            if checkCellTrending == 0{
                let imgUrl = (kImageBaseUrl + (arrayTrending?[indexPath.item].image?.imgUrl ?? ""))
                
                cell.trendingImgVw.setImage(withString: imgUrl)
            
                cell.trendingImgVw.contentMode = .scaleAspectFill
                cell.recipeNameLbl.text = arrayTrending?[indexPath.item].name
                cell.likeLabel.text = "\(arrayTrending?[indexPath.item].totalLikes ?? 0)" + " " + "Likes"
                cell.userNameLabel.text = arrayTrending?[indexPath.item].userName
                cell.timeLabel.text = "\( arrayTrending?[indexPath.item].hours ?? 0)" + " " + "hours" + " " + "\( arrayTrending?[indexPath.item].minute ?? 0)" + " " + "minutes"
                cell.servingLabel.text = "\(arrayTrending?[indexPath.item].serving ?? 0)"
                cell.typeLabel.text = arrayTrending?[indexPath.item].meal?.mealName
            }
            else{
                let imgUrl = (kImageBaseUrl + (arrayQuickEasy?[indexPath.item].image?.imgUrl ?? ""))
                
                cell.trendingImgVw.setImage(withString: imgUrl)
                
                cell.trendingImgVw.contentMode = .scaleAspectFill
                cell.recipeNameLbl.text = arrayQuickEasy?[indexPath.item].name
                cell.likeLabel.text = ""
                cell.userNameLabel.text = ""
                cell.timeLabel.text = "\( arrayQuickEasy?[indexPath.item].hours ?? 0)" + " " + "hours" + " " + "\( arrayQuickEasy?[indexPath.item].minute ?? 0)" + " " + "minutes"
                cell.servingLabel.text = "\(arrayQuickEasy?[indexPath.item].serving ?? 0)"
                cell.typeLabel.text = arrayQuickEasy?[indexPath.item].meal?.mealName
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
            delegate?.cellTapped()
            }

}

}
