//
//  DiscoverRecipeViewController.swift
//  Alysei Recipe Module
//
//  Created by mac on 26/07/21.
//

var selectedIndex: Int?

import UIKit

class DiscoverRecipeViewController: UIViewController, UIScrollViewDelegate, CategoryRowDelegate, SearchRecipeDelegate{
    
    @IBOutlet weak var discoverRecipeView: UIView!
    @IBOutlet weak var searchRecipe: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var containerTableVw: UITableView!
    @IBOutlet weak var tapPostVw: UIView!
    @IBOutlet weak var tapMarketPlaceVw: UIView!
    @IBOutlet weak var discoverCollectionView: UICollectionView!
    var arrayMyRecipe: [HomeTrending]? = []
    var arrayMyFavouriteRecipe: [HomeTrending]? = []
    
    var arrayHeader = NSMutableArray()
    var arrayCollection = NSMutableArray()
    var checkbutton = 0
    
    var selectedIndexPath : IndexPath?
    var currentIndex : Int? = 0
    var isReloadData = true
    
    override func viewWillAppear(_ animated: Bool) {
        if checkbutton == 3{
            isReloadData = true
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.containerTableVw.reloadData()
            }
            
        }
        if checkbutton == 0{
            getExploreData()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {

                self.containerTableVw.reloadData()
            }
        }
        if checkbutton == 2{
            getMyAllRecipes()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.containerTableVw.reloadData()
            }
            
        }
        if checkbutton == 1{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.containerTableVw.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        discoverRecipeView.layer.masksToBounds = false
        discoverRecipeView.layer.shadowRadius = 2
        discoverRecipeView.layer.shadowOpacity = 0.2
        discoverRecipeView.layer.shadowColor = UIColor.lightGray.cgColor
        discoverRecipeView.layer.shadowOffset = CGSize(width: 0 , height:2)
        searchRecipe.layer.cornerRadius = 5
        searchTextField.attributedPlaceholder =  NSAttributedString(string:"Search recipes", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        let tapPost = UITapGestureRecognizer(target: self, action: #selector(openPost))
        self.tapPostVw.addGestureRecognizer(tapPost)
        
        let tapMarket = UITapGestureRecognizer(target: self, action: #selector(openMarketPlace))
        self.tapMarketPlaceVw.addGestureRecognizer(tapMarket)
        
        containerTableVw.register(UINib(nibName: "ExploreByIngridientTableViewCell", bundle: nil), forCellReuseIdentifier: "ExploreByIngridientTableViewCell")
        containerTableVw.register(UINib(nibName: "ExploreByMealTableViewCell", bundle: nil), forCellReuseIdentifier: "ExploreByMealTableViewCell")
        containerTableVw.register(UINib(nibName: "ExploreByRecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "ExploreByRecipeTableViewCell")
        containerTableVw.register(UINib(nibName: "TrendingTableViewCell", bundle: nil), forCellReuseIdentifier: "TrendingTableViewCell")
        containerTableVw.register(UINib(nibName: "QuickEasyTableViewCell", bundle: nil), forCellReuseIdentifier: "QuickEasyTableViewCell")
        containerTableVw.register(UINib(nibName: "FavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavouriteTableViewCell")
        containerTableVw.register(UINib(nibName: "MyRecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "MyRecipeTableViewCell")
        containerTableVw.register(UINib(nibName: "PreferencesTableViewCell", bundle: nil), forCellReuseIdentifier: "PreferencesTableViewCell")
        
        arrayHeader = ["Quick Search by Categories", "Quick Search by Ingridients", "Quick Search by Regions", "Trending Now", "Quick Easy"]
        arrayCollection = ["Explore", "Favourite", "My Recipes", "My Preferences"]
        
        self.containerTableVw.delegate = self
        self.containerTableVw.dataSource = self
        
        self.discoverCollectionView.delegate = self
        self.discoverCollectionView.dataSource = self
        
        getExploreData()
       
    }
    
    @objc func openPost(){
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeViewC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        
    }
    
    @objc func openMarketPlace(){
        guard let vc = UIStoryboard(name: StoryBoardConstants.kMarketplace, bundle: nil).instantiateViewController(identifier: "MarketPlaceHomeVC") as? MarketPlaceHomeVC else {return}
        self.navigationController?.pushViewController(vc, animated: true)
        self.hidesBottomBarWhenPushed = true
    }
    
    
    @IBAction func createNewRecipeButton(_ sender: Any) {
        let createNewRecipeVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateNewRecipeViewController") as! CreateNewRecipeViewController
        self.navigationController?.pushViewController(createNewRecipeVC, animated: true)
    }
    
    func cellTapped(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewRecipeViewController") as! ViewRecipeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func cellTappedForSearchRecipe(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilteredRecipeViewController") as! FilteredRecipeViewController
        searching = true
        vc.indexOfPageToRequest = 1
        vc.searchText = searchTitle
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapSearchRecipe(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilteredRecipeViewController") as! FilteredRecipeViewController
        isFilterLoading = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getExploreData(){
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getRecipeHomeScreen
                                                   , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                
                if let ingridients = data["ingredients"] as? [[String:Any]]{
                    let ingridient = ingridients.map({IngridentArray.init(with: $0)})
                    arraySearchByIngridient = ingridient
                    print("\(String(describing: arraySearchByIngridient?.count))")
                   
                }
                
                if let meals = data["meals"] as? [[String:Any]]{
                    let meal = meals.map({SelectMealDataModel.init(with: $0)})
                    arraySearchByMeal = meal
                    print("\(String(describing: arraySearchByMeal?.count))")
                }
                
                if let regions = data["regions"] as? [[String:Any]]{
                    let region = regions.map({SelectRegionDataModel.init(with: $0)})
                    arraySearchByRegion = region
                    print("\(String(describing: arraySearchByRegion?.count))")
                }
                
                if let trendings = data["trending_recipes"] as? [[String:Any]]{
                    let trending = trendings.map({HomeTrending.init(with: $0)})
                    arrayTrending = trending
                    print("\(String(describing: arrayTrending?.count))")
                }
                
                if let quickEasy = data["quick_easy"] as? [[String:Any]]{
                    let quickEase = quickEasy.map({HomeQuickEasy.init(with: $0)})
                    arrayQuickEasy = quickEase
                    print("\(String(describing: arrayQuickEasy?.count))")
                }
                
            }
            containerTableVw.reloadData()
        }
    }
    
    func showAlert1(message: String) {
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}

//MARK: UITableView
extension DiscoverRecipeViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch checkbutton{
        case 0:
            return arrayHeader.count
            
        case 1:
            
            return 1
        case 2:
            
            return 1
        case 3:
            return 1
            
        default:
            break
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        switch checkbutton {
        case 0:
            switch section{
            case 0:
                return 1
            case 1:
                return 1
            case 2:
                return 1
            case 3:
                return 1
            case 4:
                return 1
            default:
                break
            }
        case 1:
            return arrayMyFavouriteRecipe?.count ?? 0
        case 2:
            return arrayMyRecipe?.count ?? 0
        case 3:
            return 1
        default:
            break
        }
        
        return 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = containerTableVw.dequeueReusableCell(withIdentifier: "ExploreByIngridientTableViewCell") as! ExploreByIngridientTableViewCell
        let cell = containerTableVw.dequeueReusableCell(withIdentifier: "ExploreByMealTableViewCell") as! ExploreByMealTableViewCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "ExploreByRecipeTableViewCell") as! ExploreByRecipeTableViewCell
        let cell3 = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell") as! TrendingTableViewCell
        let cellQuick = containerTableVw.dequeueReusableCell(withIdentifier: "QuickEasyTableViewCell") as! QuickEasyTableViewCell
        switch checkbutton{
        case 0:
            
            switch indexPath.section{
            case 0:
                
                cell1.quickSearchLbl.text = "Quick Search By Ingridients"
                cell1.quickSearchLbl?.font = UIFont(name: "Helvetica Neue Bold", size: 16)
                cell1.delegate = self
                cell1.tapViewAll = {[self] in
                    
                    let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "ViewAllViewController") as! ViewAllViewController
                    self.navigationController?.pushViewController(viewAll, animated: true)
                }
                
                return cell1
                
            case 1:
                
                cell.quickSearchLbl.text = "Quick Search By Meal"
                cell.quickSearchLbl?.font = UIFont(name: "Helvetica Neue Bold", size: 16)
                cell.delegate = self
                cell.tapViewAll = { [self] in
                    
                    let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "ViewAllMealViewController") as! ViewAllMealViewController
                    self.navigationController?.pushViewController(viewAll, animated: true)
                    
                }
                
                return cell
                
            case 2:
                
                cell2.quickSearchByRegionLabel.text = "Quick Search By Region"
                cell2.quickSearchByRegionLabel?.font = UIFont(name: "Helvetica Neue Bold", size: 16)
                cell2.delegate = self
                return cell2
                
            case 3:
                cell3.quickSearchTrendingLabel.text = "Trending Now"
                cell3.quickSearchTrendingLabel?.font = UIFont(name: "Helvetica Neue Bold", size: 16)
                cell3.delegate = self
                cell3.tapViewAllTrending = { [self] in
                    
                    let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "ViewAllTrendingViewController") as! ViewAllTrendingViewController
                    self.navigationController?.pushViewController(viewAll, animated: true)
                    
                }
                return cell3
            case 4:
                cellQuick.quickSearchTrendingLabel.text = "Quick Easy"
                cellQuick.quickSearchTrendingLabel?.font = UIFont(name: "Helvetica Neue Bold", size: 16)
                cellQuick.delegate = self
                cellQuick.tapViewAllTrending = { [self] in
                    
                    let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "ViewAllQuickEasyViewController") as! ViewAllQuickEasyViewController
                    self.navigationController?.pushViewController(viewAll, animated: true)
                    
                }
                return cellQuick
                
            default:
                break
                
            }
       
        case 1:
            let cell4 = containerTableVw.dequeueReusableCell(withIdentifier: "FavouriteTableViewCell") as! FavouriteTableViewCell
            let imgUrl = (kImageBaseUrl + (arrayMyFavouriteRecipe?[indexPath.item].image?.imgUrl ?? ""))
            
            cell4.recipeImageView.setImage(withString: imgUrl)
        
            cell4.recipeImageView.contentMode = .scaleAspectFill
            cell4.recipeName.text = arrayMyFavouriteRecipe?[indexPath.item].name
            cell4.likeLabel.text = "\(arrayMyFavouriteRecipe?[indexPath.item].totalLikes ?? 0)" + " " + "Likes"
            
        if arrayMyFavouriteRecipe?[indexPath.item].userName == ""{
            cell4.userNameLabel.text = "NA"
        }
        else{
            cell4.userNameLabel.text = arrayMyFavouriteRecipe?[indexPath.item].userName
        }
           
            cell4.timeLabel.text = "\( arrayMyFavouriteRecipe?[indexPath.item].hours ?? 0)" + " " + "hours" + " " + "\( arrayMyFavouriteRecipe?[indexPath.item].minute ?? 0)" + " " + "minutes"
            cell4.servingLabel.text = "\(arrayMyFavouriteRecipe?[indexPath.item].serving ?? 0)" + " " + "Serving"
            cell4.typeLabel.text = arrayMyFavouriteRecipe?[indexPath.item].meal?.mealName ?? "NA"
        
        if arrayMyFavouriteRecipe?[indexPath.row].avgRating ?? "0.0" == "0.0" {
            cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            cell4.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
            cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")

        }
        else if arrayMyFavouriteRecipe?[indexPath.row].avgRating ?? "0.0" == "0.5" {
            cell4.rating1ImgVw.image = UIImage(named: "Group 1142")
            cell4.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
           cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
        }else if arrayMyFavouriteRecipe?[indexPath.row].avgRating ?? "0.0" == "1.0" {
            cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
            cell4.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
           cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
        }
        else if arrayMyFavouriteRecipe?[indexPath.row].avgRating ?? "0.0" == "1.5" {
            cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
            cell4.rating2ImgVw.image = UIImage(named: "Group 1142")
            cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
            cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
        }else if arrayMyFavouriteRecipe?[indexPath.row].avgRating ?? "0.0" == "2.0" {
            cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
            cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
        }
        else if arrayMyFavouriteRecipe?[indexPath.row].avgRating ?? "0.0" == "2.5" {
            cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
            cell4.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
            cell4.rating3ImgVw.image = UIImage(named: "Group 1142")
            cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
            cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
        }else if arrayMyFavouriteRecipe?[indexPath.row].avgRating ?? "0.0" == "3.0" {
            cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
            cell4.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
            cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
            cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
            cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
        }
        else if arrayMyFavouriteRecipe?[indexPath.row].avgRating ?? "0.0" == "3.5" {
            cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
            cell4.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
            cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
            cell4.rating4ImgvW.image = UIImage(named: "Group 1142")
            cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
        }else if arrayMyFavouriteRecipe?[indexPath.row].avgRating ?? "0.0" == "4.0" {
            cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
            cell4.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
            cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
            cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
            cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
        }
        else if arrayMyFavouriteRecipe?[indexPath.row].avgRating ?? "0.0" == "4.5" {
            cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
            cell4.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
            cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
            cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
            cell4.rating5ImgVw.image = UIImage(named: "Group 1142")
        }else if arrayMyFavouriteRecipe?[indexPath.row].avgRating ?? "0.0" == "5.0" {
            cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
            cell4.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
            cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
            cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
            cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star")
        }
           
            return cell4
        case 2:
            let cell5 = containerTableVw.dequeueReusableCell(withIdentifier: "MyRecipeTableViewCell") as! MyRecipeTableViewCell
            let imgUrl = (kImageBaseUrl + (arrayMyRecipe?[indexPath.item].image?.imgUrl ?? ""))
            
            cell5.recipeImageView.setImage(withString: imgUrl)
            cell5.btnEditCallback = { tag in
                let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "EditRecipeViewController") as! EditRecipeViewController
                viewAll.arrayMyRecipe = self.arrayMyRecipe
               
                viewAll.index = indexPath.row
                self.navigationController?.pushViewController(viewAll, animated: true)
            }
            cell5.recipeImageView.contentMode = .scaleAspectFill
            cell5.recipeName.text = arrayMyRecipe?[indexPath.item].name
            cell5.likeLabel.text = "\(arrayMyRecipe?[indexPath.item].totalLikes ?? 0)" + " " + "Likes"
            if arrayMyRecipe?[indexPath.item].status == "0"{
                cell5.deaftButton.setTitle("Draft", for: .normal)
                cell5.deaftButton.layer.backgroundColor = UIColor.init(red: 114/255, green: 114/255, blue: 114/255, alpha: 1).cgColor
            }
            else{
                cell5.deaftButton.setTitle("Publish", for: .normal)
                cell5.deaftButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            }
            if arrayMyRecipe?[indexPath.item].userName == ""{
                cell5.userNameLabel.text = "NA"
            }
            else{
                cell5.userNameLabel.text = arrayMyRecipe?[indexPath.item].userName
            }
            
            cell5.timeLabel.text = "\( arrayMyRecipe?[indexPath.item].hours ?? 0)" + " " + "hours" + " " + "\( arrayMyRecipe?[indexPath.item].minute ?? 0)" + " " + "minutes"
            cell5.servingLabel.text = "\(arrayMyRecipe?[indexPath.item].serving ?? 0)" + " " + "Serving"
            cell5.typeLabel.text = arrayMyRecipe?[indexPath.item].meal?.mealName ?? "NA"
            
            if arrayMyRecipe?[indexPath.row].avgRating ?? "0.0" == "0.0" {
                cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                
            }
            else if arrayMyRecipe?[indexPath.row].avgRating ?? "0.0" == "0.5" {
                cell5.rating1ImgVw.image = UIImage(named: "Group 1142")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayMyRecipe?[indexPath.row].avgRating ?? "0.0" == "1.0" {
                cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }
            else if arrayMyRecipe?[indexPath.row].avgRating ?? "0.0" == "1.5" {
                cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating2ImgVw.image = UIImage(named: "Group 1142")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayMyRecipe?[indexPath.row].avgRating ?? "0.0" == "2.0" {
                cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }
            else if arrayMyRecipe?[indexPath.row].avgRating ?? "0.0" == "2.5" {
                cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating3ImgVw.image = UIImage(named: "Group 1142")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayMyRecipe?[indexPath.row].avgRating ?? "0.0" == "3.0" {
                cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }
            else if arrayMyRecipe?[indexPath.row].avgRating ?? "0.0" == "3.5" {
                cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating4ImgvW.image = UIImage(named: "Group 1142")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayMyRecipe?[indexPath.row].avgRating ?? "0.0" == "4.0" {
                cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }
            else if arrayMyRecipe?[indexPath.row].avgRating ?? "0.0" == "4.5" {
                cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell5.rating5ImgVw.image = UIImage(named: "Group 1142")
            }else if arrayMyRecipe?[indexPath.row].avgRating ?? "0.0" == "5.0" {
                cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star")
            }
            
            
            return cell5
            
        case 3:
            let cell6 = containerTableVw.dequeueReusableCell(withIdentifier: "PreferencesTableViewCell") as! PreferencesTableViewCell
            cell6.delegate = self
            
            cell6.getSavedPreferencesModel = [GetSavedPreferencesDataModel]()
            if isReloadData{
                cell6.config()
                cell6.getSavedMyPreferences()
                isReloadData = false
            }
            return cell6
        default:
            break
            
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch checkbutton{
        case 0:
            
            if (indexPath.section == 0)
            {
                return 380
            }
            if (indexPath.section == 1)
            {
                return 200
                
            }
            
            if (indexPath.section == 2)
            {
                
                return 200;
            }
            if (indexPath.section == 3)
            {
                
                return 350;
            }
            if (indexPath.section == 4)
            {
                
                return 350;
            }
        case 1:
            return 250
        case 2:
            return 250
        case 3:
            return UITableView.automaticDimension
        default:
            break
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        switch checkbutton{
        case 0:
            return
        case 1:
           
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewRecipeViewController") as! ViewRecipeViewController
            recipeId = (arrayMyFavouriteRecipe?[indexPath.row].recipeId)!
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
           
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewRecipeViewController") as! ViewRecipeViewController
            recipeId = (arrayMyRecipe?[indexPath.row].recipeId)!
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            return
        default:
            break
        }
    }
}
extension DiscoverRecipeViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverRecipeHomeCollectionViewCell", for: indexPath) as? DiscoverRecipeHomeCollectionViewCell {
            cell1.exploreLabel.text = arrayCollection[indexPath.item] as? String
            
            if currentIndex == indexPath.item{
                cell1.exploreHighlightView.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
                
            }
            else{
                cell1.exploreHighlightView.backgroundColor = .clear
            }
            return cell1
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        
        if indexPath.item == 3  {
            return CGSize(width: 140 , height: 50.0)
        }
        else if indexPath.item == 2{
            return CGSize(width: 130 , height: 50.0)
        }
        else{
            return CGSize(width: self.discoverCollectionView.frame.width / 4 , height: 50.0)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> Void {
        let cell = discoverCollectionView.cellForItem(at: indexPath as IndexPath) as? DiscoverRecipeHomeCollectionViewCell
        currentIndex = indexPath.item
        
        switch indexPath.item {
        case 0:
            
            checkbutton = 0
            
            selectedIndexPath = indexPath
            cell?.exploreHighlightView.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            discoverCollectionView.reloadData()
            self.containerTableVw.reloadData()
            
        case 1:
            
            checkbutton = 1
            selectedIndexPath = indexPath
            cell?.exploreHighlightView.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            discoverCollectionView.reloadData()
            getMyFavouriteRecipes()
            self.containerTableVw.reloadData()
            
            
            
        case 2:
            
            checkbutton = 2
            selectedIndexPath = indexPath
            cell?.exploreHighlightView.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            discoverCollectionView.reloadData()
          
            getMyAllRecipes()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.containerTableVw.reloadData()
            }
        
        case 3:
            checkbutton = 3
            selectedIndexPath = indexPath
            cell?.exploreHighlightView.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            
            discoverCollectionView.reloadData()
            isReloadData = true
            self.containerTableVw.reloadData()
            
            
        default:
            break
        }
        discoverCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
}
extension DiscoverRecipeViewController: PreferencesDelegate{
    
    func pluscellTapped(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CuisinesViewController") as! CuisinesViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func pluscellTapped1(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FoodViewController") as! FoodViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pluscellTapped2(){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DietViewController") as! DietViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func pluscellTapped3(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "IngridientViewController") as! IngridientViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func pluscellTapped4(){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CookingViewController") as! CookingViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension DiscoverRecipeViewController{
    func getMyAllRecipes(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getMyrecipe, requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [[String:Any]]{
                
                arrayMyRecipe = data.map({HomeTrending.init(with: $0)})
                
                print("\(String(describing: arrayMyRecipe?.count))")
                
            }
           
            self.containerTableVw.reloadData()
            
        }
    }
    
    func getMyFavouriteRecipes(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getFavouriteRecipe
                                                   , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
            switch statusCode{
            case 200:
                let dictResponse = dictResponse as? [String:Any]
                
                if let data = dictResponse?["data"] as? [[String:Any]]{
                    
                    arrayMyFavouriteRecipe = data.map({HomeTrending.init(with: $0)})
                    
                    print("\(String(describing: arrayMyFavouriteRecipe?.count))")
                    
                }
                self.containerTableVw.reloadData()
                
            case 409:
                self.showAlert1(message: "You have not liked any recipe")
            default:
                self.showAlert1(message: "Something went wrong")
            }
            
        }
    }
}
