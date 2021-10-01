//
//  ViewAllQuickEasyViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 27/09/21.
//

import UIKit

class ViewAllQuickEasyViewController: UIViewController {

    @IBOutlet weak var quickEasyCollectionView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    var arrayQuickEasy : [HomeQuickEasy]?
    override func viewDidLoad() {
        super.viewDidLoad()

        quickEasyCollectionView.delegate = self
        quickEasyCollectionView.dataSource = self
        
        headerView.layer.masksToBounds = false
        headerView.layer.shadowRadius = 2
        headerView.layer.shadowOpacity = 0.2
        headerView.layer.shadowColor = UIColor.lightGray.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0 , height:2)
        
        let cellNib = UINib(nibName: "TrendingCollectionViewCell", bundle: nil)
        self.quickEasyCollectionView.register(cellNib, forCellWithReuseIdentifier: "TrendingCollectionViewCell")
        getQuickEasy()
    }
    
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func getQuickEasy(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getRecipeHomeScreen
                                                   , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                
                if let quickEasy = data["quick_easy"] as? [[String:Any]]{
                    let quickEase = quickEasy.map({HomeQuickEasy.init(with: $0)})
                    self.arrayQuickEasy = quickEase
                    print("\(String(describing: arrayQuickEasy?.count))")
                }
            }
            self.quickEasyCollectionView.reloadData()
    }
    }

}
extension ViewAllQuickEasyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
          return  self.arrayQuickEasy?.count ?? 0
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewRecipeViewController") as! ViewRecipeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
        return CGSize(width: (self.quickEasyCollectionView.frame.width), height: 320.0)
       }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if delegate != nil {
//            delegate?.cellTapped()
//            }
//
//}

}
