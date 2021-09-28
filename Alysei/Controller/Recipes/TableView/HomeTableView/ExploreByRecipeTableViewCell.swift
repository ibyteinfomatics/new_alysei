//
//  ExploreByRecipeTableViewCell.swift
//  Alysei
//
//  Created by namrata upadhyay on 23/08/21.
//

import UIKit
var arraySearchByRegion : [SelectRegionDataModel]?
class ExploreByRecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var quickSearchByRegionLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var collectionVwRegion: UICollectionView!
   
    
    var tapViewAllRecipe:(()->())?
    let gradientLayer = CAGradientLayer()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionVwRegion.delegate = self
        self.collectionVwRegion.dataSource = self

        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "SearchByRegionCollectionViewCell", bundle: nil)
        self.collectionVwRegion.register(cellNib, forCellWithReuseIdentifier: "SearchByRegionCollectionViewCell")
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
     
        let colorTop =  UIColor(red: 55.0/255.0, green: 162.0/255.0, blue: 130.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 47.0/255.0, green: 151.0/255.0, blue: 193.0/255.0, alpha: 1.0).cgColor
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.shouldRasterize = true
        self.headerView.layer.insertSublayer(gradientLayer, at: 0)
    }
    @IBAction func tapByRegionViewAll(_ sender: Any) {
        tapViewAllRecipe?()
    }
    
//    func getSearchByRegion(){
//        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getRecipeHomeScreen
//                                                   , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
//
//            let dictResponse = dictResponse as? [String:Any]
//
//            if let data = dictResponse?["data"] as? [String:Any]{
//
//                if let regions = data["regions"] as? [[String:Any]]{
//                    let region = regions.map({SelectRegionDataModel.init(with: $0)})
//                    arraySearchByRegion = region
//                    print("\(String(describing: arraySearchByRegion?.count))")
//                }
//            }
//            self.collectionVwRegion.reloadData()
//    }
//    }
    
}

extension ExploreByRecipeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arraySearchByRegion?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchByRegionCollectionViewCell", for: indexPath) as? SearchByRegionCollectionViewCell {
            
            let imgUrl = (kImageBaseUrl + (arraySearchByRegion?[indexPath.item].regionImage?.imgUrl ?? ""))
            
            cell.countryImgVw.setImage(withString: imgUrl)
            cell.countryImgVw.layer.cornerRadius = cell.countryImgVw.frame.height/2
            cell.countryImgVw.contentMode = .scaleAspectFit
            cell.countryNameLbl.text = arraySearchByRegion?[indexPath.item].regionName

            return cell
        }
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
        return CGSize(width: self.collectionVwRegion.frame.width / 3, height: 150.0)
       }

}

