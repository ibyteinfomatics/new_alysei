//
//  ViewAllTrendingViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 27/09/21.
//

import UIKit

class ViewAllTrendingViewController: UIViewController {

    @IBOutlet weak var trendingCollectionView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    var arrayTrending : [HomeTrending]?
    override func viewDidLoad() {
        super.viewDidLoad()

        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        
        headerView.backgroundColor = UIColor.init(red: 236/255, green: 247/255, blue: 255/255, alpha:1)
        let cellNib = UINib(nibName: "TrendingCollectionViewCell", bundle: nil)
        self.trendingCollectionView.register(cellNib, forCellWithReuseIdentifier: "TrendingCollectionViewCell")
        getTrending()
    }
    
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func getTrending(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getRecipeHomeScreen
                                                   , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                
                if let trendings = data["trending_recipes"] as? [[String:Any]]{
                    let trending = trendings.map({HomeTrending.init(with: $0)})
                    self.arrayTrending = trending
                    print("\(String(describing: arrayTrending?.count))")
                }
            }
            self.trendingCollectionView.reloadData()
    }
    }

}
extension ViewAllTrendingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
          return  self.arrayTrending?.count ?? 0
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCollectionViewCell", for: indexPath) as? TrendingCollectionViewCell {
            
            
          
                let imgUrl = (kImageBaseUrl + (arrayTrending?[indexPath.item].image?.imgUrl ?? ""))
                
                cell.trendingImgVw.setImage(withString: imgUrl)
            
                cell.trendingImgVw.contentMode = .scaleAspectFill
                cell.recipeNameLbl.text = arrayTrending?[indexPath.item].name
                cell.likeLabel.text = "\(arrayTrending?[indexPath.item].totalLikes ?? 0)" + " " + "Likes"
                cell.userNameLabel.text = arrayTrending?[indexPath.item].userName
                cell.timeLabel.text = "\( arrayTrending?[indexPath.item].hours ?? 0)" + " " + "hours" + " " + "\( arrayTrending?[indexPath.item].minute ?? 0)" + " " + "minutes"
                cell.servingLabel.text = "\(arrayTrending?[indexPath.item].serving ?? 0)"
                cell.typeLabel.text = arrayTrending?[indexPath.item].meal?.mealName
            
            return cell
           
           
        }
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
        return CGSize(width: (self.trendingCollectionView.frame.width), height: 320.0)
       }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if delegate != nil {
//            delegate?.cellTapped()
//            }
//
//}

}
