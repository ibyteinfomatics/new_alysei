//
//  ViewAllTrendingViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 27/09/21.
//

import UIKit

class ViewAllTrendingViewController: UIViewController {

    @IBOutlet weak var trendingLabel: UILabel!
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    var arrayTrending : [HomeTrending]?
    
    override func viewWillAppear(_ animated: Bool) {
        getTrending()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        trendingLabel.text = RecipeConstants.kTrending
        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        
        let cellNib = UINib(nibName: "MyRecipeCollectionViewCell", bundle: nil)
        self.trendingCollectionView.register(cellNib, forCellWithReuseIdentifier: "MyRecipeCollectionViewCell")
        getTrending()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        headerView.drawBottomShadow()
    }
    
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getTrending(){
        self.view.isUserInteractionEnabled = false
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
            self.view.isUserInteractionEnabled = true
    }
    }

}
extension ViewAllTrendingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
          return  self.arrayTrending?.count ?? 0
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyRecipeCollectionViewCell", for: indexPath) as? MyRecipeCollectionViewCell {
            
            cell.deaftButton.isHidden = true
            cell.editRecipeButton.isHidden = true
          
                let imgUrl = ((arrayTrending?[indexPath.item].image?.baseUrl ?? "") + (arrayTrending?[indexPath.item].image?.imgUrl ?? ""))
                
                cell.recipeImageView.setImage(withString: imgUrl)
            
                cell.recipeImageView.contentMode = .scaleAspectFill
                cell.recipeName.text = arrayTrending?[indexPath.item].name
            cell.likeLabel.text = "\(arrayTrending?[indexPath.item].totalLikes ?? 0)" + " " + RecipeConstants.kLikes
                cell.userNameLabel.text = arrayTrending?[indexPath.item].userName
            cell.timeLabel.text = "\( arrayTrending?[indexPath.item].hours ?? 0)" + " " + RecipeConstants.kHours + " " + "\( arrayTrending?[indexPath.item].minute ?? 0)" + " " + RecipeConstants.kMinutes
            cell.servingLabel.text = "\(arrayTrending?[indexPath.item].serving ?? 0)" + " " + RecipeConstants.kServingHome
                cell.typeLabel.text = arrayTrending?[indexPath.item].meal?.mealName
            
            if arrayTrending?[indexPath.row].isFavourite == 0{
                cell.heartBtn.setImage(UIImage(named: "like_icon_white.png"), for: .normal)
            }
            else{
                cell.heartBtn.setImage(UIImage(named: "liked_icon.png"), for: .normal)
            }
            
            
            if arrayTrending?[indexPath.row].avgRating == "0.0" || arrayTrending?[indexPath.row].avgRating  == "0" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }  else if (arrayTrending?[indexPath.row].avgRating  ?? "0") >= ("0.1") && (arrayTrending?[indexPath.row].avgRating  ?? "0") <= ("0.9") {
                cell.rating1ImgVw.image = UIImage(named: "HalfStar")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayTrending?[indexPath.row].avgRating == ("1.0") || arrayTrending?[indexPath.row].avgRating  == ("1") {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if (arrayTrending?[indexPath.row].avgRating ?? "0") >= ("1.1") && (arrayTrending?[indexPath.row].avgRating ?? "0") <= ("1.9"){
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "HalfStar")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayTrending?[indexPath.row].avgRating == ("2.0") || arrayTrending?[indexPath.row].avgRating  == ("2"){
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if (arrayTrending?[indexPath.row].avgRating ?? "0") >= ("2.1") && (arrayTrending?[indexPath.row].avgRating  ?? "0") <= ("2.9"){
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "HalfStar")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayTrending?[indexPath.row].avgRating  == ("3.0") || arrayTrending?[indexPath.row].avgRating  == ("3"){
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if (arrayTrending?[indexPath.row].avgRating ?? "0") >= ("3.1") && (arrayTrending?[indexPath.row].avgRating  ?? "0") <= ("3.9") {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating4ImgvW.image = UIImage(named: "HalfStar")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayTrending?[indexPath.row].avgRating  == ("4.0") || arrayTrending?[indexPath.row].avgRating  == ("4"){
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if (arrayTrending?[indexPath.row].avgRating  ?? "0") >= ("4.1") && (arrayTrending?[indexPath.row].avgRating  ?? "0") <= ("4.9"){
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell.rating5ImgVw.image = UIImage(named: "HalfStar")
            }else if arrayTrending?[indexPath.row].avgRating  == ("5.0") || arrayTrending?[indexPath.row].avgRating  == ("5"){
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star")
            }else{cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                print("Invalid Rating")
            }
            
            return cell
           
           
        }
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewRecipeViewController") as! ViewRecipeViewController
        recipeId = (arrayTrending?[indexPath.row].recipeId)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
        return CGSize(width: (self.trendingCollectionView.frame.width), height: 260.0)
       }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if delegate != nil {
//            delegate?.cellTapped()
//            }
//
//}

}
