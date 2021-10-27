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
        
        let cellNib = UINib(nibName: "MyRecipeCollectionViewCell", bundle: nil)
        self.quickEasyCollectionView.register(cellNib, forCellWithReuseIdentifier: "MyRecipeCollectionViewCell")
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
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyRecipeCollectionViewCell", for: indexPath) as? MyRecipeCollectionViewCell {
            
            cell.deaftButton.isHidden = true
            cell.editRecipeButton.isHidden = true
          
                let imgUrl = (kImageBaseUrl + (arrayQuickEasy?[indexPath.item].image?.imgUrl ?? ""))
                
                cell.recipeImageView.setImage(withString: imgUrl)
            
                cell.recipeImageView.contentMode = .scaleAspectFill
                cell.recipeName.text = arrayQuickEasy?[indexPath.item].name
                cell.likeLabel.text = "\(arrayQuickEasy?[indexPath.item].totalLikes ?? 0)" + " " + "Likes"
                cell.userNameLabel.text = arrayQuickEasy?[indexPath.item].userName
                cell.timeLabel.text = "\( arrayQuickEasy?[indexPath.item].hours ?? 0)" + " " + "hours" + " " + "\( arrayQuickEasy?[indexPath.item].minute ?? 0)" + " " + "minutes"
                cell.servingLabel.text = "\(arrayQuickEasy?[indexPath.item].serving ?? 0)" + " " + "Serving"
                cell.typeLabel.text = arrayQuickEasy?[indexPath.item].meal?.mealName
            if arrayQuickEasy?[indexPath.row].isFavourite == 0{
                cell.heartBtn.setImage(UIImage(named: "like_icon_white.png"), for: .normal)
            }
            else{
                cell.heartBtn.setImage(UIImage(named: "liked_icon.png"), for: .normal)
            }
            
            if arrayQuickEasy?[indexPath.row].avgRating ?? "0.0" == "0.0" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")

            }
            else if arrayQuickEasy?[indexPath.row].avgRating ?? "0.0" == "0.5" {
                cell.rating1ImgVw.image = UIImage(named: "Group 1142")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
               cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayQuickEasy?[indexPath.row].avgRating ?? "0.0" == "1.0" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
               cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }
            else if arrayQuickEasy?[indexPath.row].avgRating ?? "0.0" == "1.5" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "Group 1142")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayQuickEasy?[indexPath.row].avgRating ?? "0.0" == "2.0" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }
            else if arrayQuickEasy?[indexPath.row].avgRating ?? "0.0" == "2.5" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "Group 1142")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayQuickEasy?[indexPath.row].avgRating ?? "0.0" == "3.0" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }
            else if arrayQuickEasy?[indexPath.row].avgRating ?? "0.0" == "3.5" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating4ImgvW.image = UIImage(named: "Group 1142")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayQuickEasy?[indexPath.row].avgRating ?? "0.0" == "4.0" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }
            else if arrayQuickEasy?[indexPath.row].avgRating ?? "0.0" == "4.5" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell.rating5ImgVw.image = UIImage(named: "Group 1142")
            }else if arrayQuickEasy?[indexPath.row].avgRating ?? "0.0" == "5.0" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star")
            }
            
            return cell
           
           
        }
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewRecipeViewController") as! ViewRecipeViewController
        recipeId = (arrayQuickEasy?[indexPath.row].recipeId)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
        return CGSize(width: (self.quickEasyCollectionView.frame.width), height: 260.0)
       }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if delegate != nil {
//            delegate?.cellTapped()
//            }
//
//}

}
