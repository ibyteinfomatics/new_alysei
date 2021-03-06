//
//  DiscoverRecipeViewController.swift
//  Alysei Recipe Module
//
//  Created by mac on 26/07/21.
//

var selectedIndex: Int?

import UIKit
import Instructions

var recipeWalkthroughId = [String]()
var arrayMyRecipe: [HomeTrending]? = []
class DiscoverRecipeViewController: AlysieBaseViewC, UIScrollViewDelegate, CategoryRowDelegate, SearchRecipeDelegate{
    
    @IBOutlet weak var createRecipeBtn: UIButton!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var marketPlcLabel: UILabel!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var createRecipeLbl: UILabel!
    @IBOutlet weak var cravingLabel: UILabel!
    @IBOutlet weak var discoverRecipeView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var searchRecipe: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var containerTableVw: UITableView!
    @IBOutlet weak var tapPostVw: UIView!
    @IBOutlet weak var tapMarketPlaceVw: UIView!
    @IBOutlet weak var tapNotificationVw: UIView!
    @IBOutlet weak var discoverCollectionView: UICollectionView!
    
    //Animation
    @IBOutlet weak var walkView1: UIView!
    @IBOutlet weak var vwwWalkContainer1: UIView!
    @IBOutlet weak var vwwWalkContainer2: UIView!
    
    @IBOutlet weak var walkView2Img: UIImageView!
    @IBOutlet weak var walkView2Tilte:UILabel!
    @IBOutlet weak var walkView2SubTitle: UILabel!
    
    @IBOutlet weak var walkView1Leading: NSLayoutConstraint!
    @IBOutlet weak var walkView1Trailing: NSLayoutConstraint!
    @IBOutlet weak var walkView1Top: NSLayoutConstraint!
    @IBOutlet weak var walkView1Bottom: NSLayoutConstraint!
    @IBOutlet weak var walkView1height: NSLayoutConstraint!
    @IBOutlet weak var pageControl1: UIView!
    @IBOutlet weak var pageControl2: UIView!
    @IBOutlet weak var pageControl3: UIView!
    @IBOutlet weak var pageControl4: UIView!
    @IBOutlet weak var pageControl5: UIView!
    @IBOutlet weak var pageControl6: UIView!
    @IBOutlet weak var pageContrl1Width: NSLayoutConstraint!
    @IBOutlet weak var pageContrl2Width: NSLayoutConstraint!
    @IBOutlet weak var pageContrl3Width: NSLayoutConstraint!
    
    @IBOutlet weak var pageContrl4Width: NSLayoutConstraint!
    @IBOutlet weak var pageContrl5Width: NSLayoutConstraint!
    @IBOutlet weak var pageContrl6Width: NSLayoutConstraint!
    
    @IBOutlet weak var walkSubView1: UIView!
    @IBOutlet weak var walkSubView2: UIView!
    @IBOutlet weak var walkSubView3: UIView!
    
    @IBOutlet weak var walkSubView1Img: UIImageView!
    @IBOutlet weak var walkSubView1Title: UILabel!
    @IBOutlet weak var walkSubView1SubTitle: UILabel!
    
    @IBOutlet weak var walkSubView2Img: UIImageView!
    @IBOutlet weak var walkSubView2Title: UILabel!
    @IBOutlet weak var walkSubView2SubTitle: UILabel!
    
    @IBOutlet weak var walkSubView3Img: UIImageView!
    @IBOutlet weak var walkSubView3Title: UILabel!
    @IBOutlet weak var walkSubView3SubTitle: UILabel!
    @IBOutlet weak var vwwWalkContainer2BgImg: UIImageView!
    @IBOutlet weak var walkSubView3Height: NSLayoutConstraint!
    @IBOutlet weak var walknextBtn: UIButton!
    @IBOutlet weak var walknextBtn2: UIButton!
    
    @IBOutlet weak var walkVw1Img: UIImageView!
    @IBOutlet weak var walkVw1Title: UILabel!
    @IBOutlet weak var walkVw1SubTitle: UILabel!
    @IBOutlet weak var walkVwContainer1Img: UIImageView!
    @IBOutlet weak var vwNotification: UIView!
    @IBOutlet weak var lblNotificationCount: UILabel!
    
    var arrayMyFavouriteRecipe: [HomeTrending]? = []
    
    var arrayHeader = NSMutableArray()
    var arrayCollection = NSMutableArray()
    var checkbutton = 0
    
    var selectedIndexPath : IndexPath?
    var currentIndex : Int? = 0
    var isReloadData = true
    var nextWalkCount = 0
    let coachMarksController = CoachMarksController()
    var trendingTour = UILabel()
    var getUser:[userClass]?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.coachMarksController.stop(immediately: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsersData()
        vwNotification.layer.cornerRadius = self.vwNotification.frame.height / 2
        vwNotification.layer.masksToBounds = true
        self.coachMarksController.dataSource = self
        self.coachMarksController.delegate = self
        
        let skipView = CoachMarkSkipDefaultView()
        skipView.setTitle(RecipeConstants.kSkip, for: .normal)
        self.coachMarksController.skipView = skipView
        
        //MARK: Set Localization title------
        postLabel.text = MarketPlaceConstant.kPosts
        marketPlcLabel.text = MarketPlaceConstant.kMarketplace
        recipeLabel.text = RecipeConstants.kRecipe
        notificationLabel.text = MarketPlaceConstant.kNotifications
        createRecipeLbl.text = RecipeConstants.kCreateRecipe
        cravingLabel.text = RecipeConstants.kCravingTitle
        
        //MARK: UI Inhancement------
        discoverRecipeView.layer.masksToBounds = false
        discoverRecipeView.layer.shadowRadius = 2
        discoverRecipeView.layer.shadowOpacity = 0.2
        discoverRecipeView.layer.shadowColor = UIColor.lightGray.cgColor
        discoverRecipeView.layer.shadowOffset = CGSize(width: 0 , height:2)
        searchRecipe.layer.cornerRadius = 5
        searchTextField.attributedPlaceholder =  NSAttributedString(string: RecipeConstants.kSearchRecipe, attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        //MARK: Tap Post------
        let tapPost = UITapGestureRecognizer(target: self, action: #selector(openPost))
        self.tapPostVw.addGestureRecognizer(tapPost)
        
        //MARK: Tap MarketPlace------
        let tapMarket = UITapGestureRecognizer(target: self, action: #selector(openMarketPlace))
        self.tapMarketPlaceVw.addGestureRecognizer(tapMarket)
        
        //MARK: Tap Notification------
        let tapNotification = UITapGestureRecognizer(target: self, action: #selector(openNotification))
        self.tapNotificationVw.addGestureRecognizer(tapNotification)
        
        //MARK: Set TableViewCell------
        containerTableVw.register(UINib(nibName: "ExploreByIngridientTableViewCell", bundle: nil), forCellReuseIdentifier: "ExploreByIngridientTableViewCell")
        containerTableVw.register(UINib(nibName: "ExploreByMealTableViewCell", bundle: nil), forCellReuseIdentifier: "ExploreByMealTableViewCell")
        containerTableVw.register(UINib(nibName: "ExploreByRecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "ExploreByRecipeTableViewCell")
        containerTableVw.register(UINib(nibName: "TrendingTableViewCell", bundle: nil), forCellReuseIdentifier: "TrendingTableViewCell")
        containerTableVw.register(UINib(nibName: "QuickEasyTableViewCell", bundle: nil), forCellReuseIdentifier: "QuickEasyTableViewCell")
        containerTableVw.register(UINib(nibName: "FavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavouriteTableViewCell")
        containerTableVw.register(UINib(nibName: "MyRecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "MyRecipeTableViewCell")
        containerTableVw.register(UINib(nibName: "PreferencesTableViewCell", bundle: nil), forCellReuseIdentifier: "PreferencesTableViewCell")
        
        //MARK: Defined Array------
        arrayHeader = [RecipeConstants.kByIngredient, RecipeConstants.kByMeal, RecipeConstants.kByRegion, RecipeConstants.kTrendingNow, RecipeConstants.kQuickEasy]
        arrayCollection = [RecipeConstants.kExplore, RecipeConstants.kFavourite, RecipeConstants.kMyRecipe, RecipeConstants.kMyPreference]
        
        //MARK: Set Delegates------
        self.containerTableVw.delegate = self
        self.containerTableVw.dataSource = self
        
        self.discoverCollectionView.delegate = self
        self.discoverCollectionView.dataSource = self
        
        //MARK: Call Home api------
       getExploreData()
        
    }
    
    func setBottomUI() {
        walkView1.layer.maskedCorners = [.layerMaxXMinYCorner]
        walkView1.clipsToBounds = true
        pageControl1.layer.cornerRadius = self.pageControl1.frame.height / 2
        pageControl2.layer.cornerRadius = self.pageControl2.frame.height / 2
        pageControl3.layer.cornerRadius = self.pageControl3.frame.height / 2
        pageControl2.layer.borderWidth = 0.5
        pageControl2.layer.borderColor = UIColor.white.cgColor
        pageControl3.layer.borderWidth = 0.5
        pageControl3.layer.borderColor = UIColor.white.cgColor
        pageControl1.layer.backgroundColor = UIColor.white.cgColor
        pageContrl1Width.constant = 25
        pageContrl2Width.constant = 10
        pageContrl3Width.constant = 10
        walkView1.isHidden = false
        vwwWalkContainer1.isHidden = false
        vwwWalkContainer2.isHidden = true
        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
        //self.walkView1Trailing.constant = self.view.frame.width
        self.walkView1Top.constant = self.view.frame.height
        if !AppManager.getUserSeenAppInstruction() {
        self.coachMarksController.start(in: .viewController(self))

          }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if checkbutton == 3{
            getSavedMyPreferences()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.containerTableVw.reloadData()
            }
            
        }
        if checkbutton == 0{
            getExploreData()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                
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
            getMyFavouriteRecipes()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.containerTableVw.reloadData()
            }
        }
        self.nextWalkCount = 0
        self.walkView1.isHidden = true
        self.vwwWalkContainer1.isHidden = true
        self.vwwWalkContainer2.isHidden = true
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
        guard let vc = UIStoryboard(name: StoryBoardConstants.kMarketplace, bundle: nil).instantiateViewController(identifier: "MarketplaceHomePageVC") as? MarketplaceHomePageVC else {return}
        self.navigationController?.pushViewController(vc, animated: true)
        self.hidesBottomBarWhenPushed = true
    }
    
    @objc func openNotification(){
        guard let vc = UIStoryboard(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(identifier: "NotificationList") as? NotificationList else {return}
        self.navigationController?.pushViewController(vc, animated: true)
        self.hidesBottomBarWhenPushed = true
    }
    
    
    @IBAction func createNewRecipeButton(_ sender: Any) {
        //        if AppConstants.recipeWalkthrough == false{
        //            walknextBtn.setTitle("Next", for: .normal)
        //            animate1View()
        //            setBottomUI()
        //        }
        let userId = kSharedUserDefaults.loggedInUserModal.userId ?? ""
        let retriveArrayData = kSharedUserDefaults.array(forKey:  "SavedWalkthrough")
        if ((retriveArrayData?.contains(obj: userId)) != nil){
            let createNewRecipeVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateNewRecipeViewController") as! CreateNewRecipeViewController
            self.navigationController?.pushViewController(createNewRecipeVC, animated: true)
        }
        else{
            walknextBtn.setTitle(RecipeConstants.kNext, for: .normal)
            animate1View()
            setBottomUI()
        }
        
        
    }
    @IBAction func backAction(_ sender: UIButton){
        if nextWalkCount == 2{
            nextWalkCount = 1
            walknextBtn2.setTitle(RecipeConstants.kNext, for: .normal)
            vwwWalkContainer1.isHidden = true
            vwwWalkContainer2.isHidden = false
            animate2View()
            
        }else if nextWalkCount == 1 {
            nextWalkCount = 0
            walknextBtn.setTitle(RecipeConstants.kNext, for: .normal)
            vwwWalkContainer1.isHidden = false
            vwwWalkContainer2.isHidden = true
            animate1View()
        }else{
            self.walkView1.isHidden = true
            self.headerView.isUserInteractionEnabled = true
            self.discoverRecipeView.isUserInteractionEnabled = true
            self.containerTableVw.isUserInteractionEnabled = true
            self.discoverRecipeView.alpha = 1
            self.headerView.alpha = 1
            self.containerTableVw.alpha = 1
        }
    }
    @IBAction func nextAction(_ sender: UIButton){
        
        if nextWalkCount == 0 {
            walknextBtn2.setTitle(RecipeConstants.kNext, for: .normal)
            vwwWalkContainer1.isHidden = true
            nextWalkCount = 1
            animate2View()
        }else if nextWalkCount == 1 {
            self.walknextBtn.setTitle(RecipeConstants.kDone, for: .normal)
            animateView3()
            nextWalkCount = 2
            
        }else{
            self.walkView1.isHidden = true
            nextWalkCount = 0
            self.headerView.isUserInteractionEnabled = true
            self.discoverRecipeView.isUserInteractionEnabled = true
            self.containerTableVw.isUserInteractionEnabled = true
            self.discoverRecipeView.alpha = 1
            self.headerView.alpha = 1
            self.containerTableVw.alpha = 1
            //            AppConstants.recipeWalkthrough = true
            let userId = kSharedUserDefaults.loggedInUserModal.userId ?? ""
            recipeWalkthroughId.append(userId)
            kSharedUserDefaults.setValue(recipeWalkthroughId, forKey: "SavedWalkthrough")
            //
            //            let retriveArrayData = kSharedUserDefaults.object(forKey:  "SavedWalkthrough") as? NSData
            //            if (retriveArrayData != nil) == recipeWalkthroughId.contains(userId){
            //
            //            }
            _ = pushViewController(withName: CreateNewRecipeViewController.id(), fromStoryboard: StoryBoardConstants.kRecipesSelection)
            
            
            
        }
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
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func getExploreData(){
        self.view.isUserInteractionEnabled = false
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getRecipeHomeScreen
                                                   , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
            
            arraySearchByIngridient = [IngridentArray]()
            firstSixingdntArray = [IngridentArray]()
            arraySearchByMeal = [SelectMealDataModel]()
            firstSixMealArray = [SelectMealDataModel]()
            arraySearchByRegion = [SelectRegionDataModel]()
            arrayTrending = [HomeTrending]()
            arrayQuickEasy = [HomeQuickEasy]()
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                
                if let ingridients = data["ingredients"] as? [[String:Any]]{
                    let ingridient = ingridients.map({IngridentArray.init(with: $0)})
                    arraySearchByIngridient = ingridient
                    
                    if arraySearchByIngridient?.count ?? 0 <= 6{
                        firstSixingdntArray = arraySearchByIngridient
                    }
                    else{
                        for i in 0..<6{
                            firstSixingdntArray?.append(arraySearchByIngridient?[i] ?? IngridentArray())
                           }
                    }
                            
                    print("\(String(describing: arraySearchByIngridient?.count))")
                    
                }
                
                if let meals = data["meals"] as? [[String:Any]]{
                    let meal = meals.map({SelectMealDataModel.init(with: $0)})
                    arraySearchByMeal = meal
                    if arraySearchByMeal?.count ?? 0 <= 6{
                        firstSixMealArray = arraySearchByMeal
                    }
                    else{
                    for i in 0..<6{                        firstSixMealArray?.append(arraySearchByMeal?[i] ?? SelectMealDataModel(with: [:]))
                       }
                    }
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
            
            // SearchByIngridient cell height ---------
            
            if firstSixingdntArray?.count != 0{
                if (((firstSixingdntArray?.count ?? 0) % 3) == 0){
                    ingridentHeight = CGFloat((160 * ((firstSixingdntArray?.count ?? 0) / 3)) + 20)
                }
                else{
                    let heightIngridient = 160 * (((arraySearchByIngridient?.count ?? 0) / 3) + 1)
                    ingridentHeight = CGFloat(heightIngridient + 20)
                }
            }
            else{
                ingridentHeight = 0
            }
            
            if firstSixMealArray?.count != 0{
                if (((firstSixMealArray?.count ?? 0) % 3) == 0){
                    mealHeight = CGFloat((160 * ((firstSixMealArray?.count ?? 0) / 3)) + 40)
                }
                else{
                    let heightMeal = 160 * (((firstSixMealArray?.count ?? 0) / 3) + 1)
                    mealHeight = CGFloat(heightMeal + 40)
                }
            }
            else{
                mealHeight = 0
            }
            
            if arraySearchByRegion?.count == 0{
                regionHeight = 0
            }
            else{
            
                regionHeight = 200
            }
            
            if arrayTrending?.count == 0{
                trendingHeight = 0
            }
            else{
                trendingHeight = 360
            }
            
            if arrayQuickEasy?.count == 0{
                quickeasyHeight = 0
            }
            else{
                quickeasyHeight = 360
            }
            containerTableVw.reloadData()
            self.view.isUserInteractionEnabled = true
            
        }
    }
    
    func showAlert1(message: String) {
        
        let alert = UIAlertController(title: AlertTitle.appName, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: ButtonTitle.kOk, style: UIAlertAction.Style.default, handler: nil))
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
        let cell2 = containerTableVw.dequeueReusableCell(withIdentifier: "ExploreByRecipeTableViewCell") as! ExploreByRecipeTableViewCell
        let cell3 = containerTableVw.dequeueReusableCell(withIdentifier: "TrendingTableViewCell") as! TrendingTableViewCell
        let cellQuick = containerTableVw.dequeueReusableCell(withIdentifier: "QuickEasyTableViewCell") as! QuickEasyTableViewCell
        
        
       
       
        switch checkbutton{
        case 0:
            
            switch indexPath.section{
            case 0:
                
                cell1.quickSearchLbl.text = RecipeConstants.kByIngredient
                cell1.quickSearchLbl?.font = UIFont(name: "Helvetica Neue Bold", size: 18)
                cell1.delegate = self
                cell1.post = true
                cell1.tapViewAll = {[self] in
                    
                    let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "ViewAllViewController") as! ViewAllViewController
                    self.navigationController?.pushViewController(viewAll, animated: true)
                }
                
                return cell1
                
            case 1:
                
                cell.quickSearchLbl.text = RecipeConstants.kByMeal
                cell.quickSearchLbl?.font = UIFont(name: "Helvetica Neue Bold", size: 18)
                cell.delegate = self
                cell.tapViewAll = { [self] in
                    
                    let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "ViewAllMealViewController") as! ViewAllMealViewController
                    self.navigationController?.pushViewController(viewAll, animated: true)
                }
                
                return cell
                
            case 2:
                
                cell2.quickSearchByRegionLabel.text = RecipeConstants.kByRegion
                cell2.quickSearchByRegionLabel?.font = UIFont(name: "Helvetica Neue Bold", size: 18)
                cell2.delegate = self
                cell2.tapViewAllRecipe = { [self] in
                    
                    let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "ViewAllRegionViewController") as! ViewAllRegionViewController
                    self.navigationController?.pushViewController(viewAll, animated: true)
                    
                }
                return cell2
                
            case 3:
                cell3.quickSearchTrendingLabel.text = RecipeConstants.kTrendingNow
                cell3.quickSearchTrendingLabel?.font = UIFont(name: "Helvetica Neue Bold", size: 18)
                cell3.delegate = self
                
               
                
                cell3.tapViewAllTrending = { [self] in
                    
                    let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "ViewAllTrendingViewController") as! ViewAllTrendingViewController
                    self.navigationController?.pushViewController(viewAll, animated: true)
                    
                }
                return cell3
            case 4:
                cellQuick.quickSearchTrendingLabel.text = RecipeConstants.kQuickEasy
                cellQuick.quickSearchTrendingLabel?.font = UIFont(name: "Helvetica Neue Bold", size: 18)
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
            //            let imgUrl = (kImageBaseUrl + (arrayMyFavouriteRecipe?[indexPath.item].image?.imgUrl ?? ""))
            //
            //            cell4.recipeImageView.setImage(withString: imgUrl)
            //
            if let strUrl = "\((arrayMyFavouriteRecipe?[indexPath.item].image?.baseUrl ?? "") + (arrayMyFavouriteRecipe?[indexPath.item].image?.imgUrl ?? ""))".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
               let imgUrl = URL(string: strUrl) {
                print("ImageUrl-----------------------------------------\(imgUrl)")
                cell4.recipeImageView.loadImageWithUrl(imgUrl) // call this line for getting image to yourImageView
            }
            
            cell4.recipeImageView.contentMode = .scaleAspectFill
            cell4.recipeName.text = arrayMyFavouriteRecipe?[indexPath.item].name
            cell4.likeLabel.text = "\(arrayMyFavouriteRecipe?[indexPath.item].totalLikes ?? 0)" + " " + RecipeConstants.kLikes
            
            if arrayMyFavouriteRecipe?[indexPath.item].userName == ""{
                cell4.userNameLabel.text = RecipeConstants.kNA
            }
            else{
                cell4.userNameLabel.text = arrayMyFavouriteRecipe?[indexPath.item].userName
            }
            
            cell4.timeLabel.text = "\( arrayMyFavouriteRecipe?[indexPath.item].hours ?? 0)" + " " + RecipeConstants.kHours + " " + "\( arrayMyFavouriteRecipe?[indexPath.item].minute ?? 0)" + " " + RecipeConstants.kMinutes
            cell4.servingLabel.text = "\(arrayMyFavouriteRecipe?[indexPath.item].serving ?? 0)" + " " + RecipeConstants.kServingHome
            cell4.typeLabel.text = arrayMyFavouriteRecipe?[indexPath.item].meal?.mealName ?? RecipeConstants.kNA
            
            cell4.heartBtn.setImage(UIImage(named: "liked_icon.png"), for: .normal)
            
            if arrayMyFavouriteRecipe?[indexPath.row].avgRating == "0.0" || arrayMyFavouriteRecipe?[indexPath.row].avgRating  == "0" {
                cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell4.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }  else if (arrayMyFavouriteRecipe?[indexPath.row].avgRating  ?? "0") >= ("0.1") && (arrayMyFavouriteRecipe?[indexPath.row].avgRating  ?? "0") <= ("0.9") {
                cell4.rating1ImgVw.image = UIImage(named: "HalfStar")
                cell4.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayMyFavouriteRecipe?[indexPath.row].avgRating == ("1.0") || arrayMyFavouriteRecipe?[indexPath.row].avgRating  == ("1") {
                cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if (arrayMyFavouriteRecipe?[indexPath.row].avgRating ?? "0") >= ("1.1") && (arrayMyFavouriteRecipe?[indexPath.row].avgRating ?? "0") <= ("1.9"){
                cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating2ImgVw.image = UIImage(named: "HalfStar")
                cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayMyFavouriteRecipe?[indexPath.row].avgRating == ("2.0") || arrayMyFavouriteRecipe?[indexPath.row].avgRating  == ("2"){
                cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if (arrayMyFavouriteRecipe?[indexPath.row].avgRating ?? "0") >= ("2.1") && (arrayMyFavouriteRecipe?[indexPath.row].avgRating  ?? "0") <= ("2.9"){
                cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating3ImgVw.image = UIImage(named: "HalfStar")
                cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayMyFavouriteRecipe?[indexPath.row].avgRating  == ("3.0") || arrayMyFavouriteRecipe?[indexPath.row].avgRating  == ("3"){
                cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if (arrayMyFavouriteRecipe?[indexPath.row].avgRating ?? "0") >= ("3.1") && (arrayMyFavouriteRecipe?[indexPath.row].avgRating  ?? "0") <= ("3.9") {
                cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating4ImgvW.image = UIImage(named: "HalfStar")
                cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayMyFavouriteRecipe?[indexPath.row].avgRating  == ("4.0") || arrayMyFavouriteRecipe?[indexPath.row].avgRating  == ("4"){
                cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if (arrayMyFavouriteRecipe?[indexPath.row].avgRating  ?? "0") >= ("4.1") && (arrayMyFavouriteRecipe?[indexPath.row].avgRating  ?? "0") <= ("4.9"){
                cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell4.rating5ImgVw.image = UIImage(named: "HalfStar")
            }else if arrayMyFavouriteRecipe?[indexPath.row].avgRating  == ("5.0") || arrayMyFavouriteRecipe?[indexPath.row].avgRating  == ("5"){
                cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star")
            }else{cell4.rating1ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell4.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell4.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell4.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell4.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                print("Invalid Rating")
            }
            
            return cell4
        case 2:
            let cell5 = containerTableVw.dequeueReusableCell(withIdentifier: "MyRecipeTableViewCell") as! MyRecipeTableViewCell
            //            let imgUrl = (kImageBaseUrl + (arrayMyRecipe?[indexPath.item].image?.imgUrl ?? ""))
            //
            //            cell5.recipeImageView.setImage(withString: imgUrl)
            //
            if let strUrl = "\((arrayMyRecipe?[indexPath.item].image?.baseUrl ?? "") + (arrayMyRecipe?[indexPath.item].image?.imgUrl ?? ""))".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
               let imgUrl = URL(string: strUrl) {
                print("ImageUrl-----------------------------------------\(imgUrl)")
                cell5.recipeImageView.loadImageWithUrl(imgUrl) // call this line for getting image to yourImageView
            }
            cell5.btnEditCallback = { tag in
                let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "EditRecipeViewController") as! EditRecipeViewController
                viewAll.arrayMyRecipe1 = arrayMyRecipe
                
                viewAll.index = indexPath.row
                self.navigationController?.pushViewController(viewAll, animated: true)
            }
            cell5.recipeImageView.contentMode = .scaleAspectFill
            cell5.recipeName.text = arrayMyRecipe?[indexPath.item].name
            cell5.likeLabel.text = "\(arrayMyRecipe?[indexPath.item].totalLikes ?? 0)" + " " + RecipeConstants.kLikes
            if arrayMyRecipe?[indexPath.item].status == "0"{
                cell5.deaftButton.setTitle(RecipeConstants.kDraft, for: .normal)
                cell5.deaftButton.layer.backgroundColor = UIColor.init(red: 114/255, green: 114/255, blue: 114/255, alpha: 1).cgColor
            }
            else{
                cell5.deaftButton.setTitle(RecipeConstants.kPublish, for: .normal)
                cell5.deaftButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            }
            if arrayMyRecipe?[indexPath.item].userName == ""{
                cell5.userNameLabel.text = RecipeConstants.kNA
            }
            else{
                cell5.userNameLabel.text = arrayMyRecipe?[indexPath.item].userName
            }
            
            cell5.timeLabel.text = "\( arrayMyRecipe?[indexPath.item].hours ?? 0)" + " " + RecipeConstants.kHours + " " + "\( arrayMyRecipe?[indexPath.item].minute ?? 0)" + " " + RecipeConstants.kMinutes
            cell5.servingLabel.text = "\(arrayMyRecipe?[indexPath.item].serving ?? 0)" + " " + RecipeConstants.kServingHome
            cell5.typeLabel.text = arrayMyRecipe?[indexPath.item].meal?.mealName ?? RecipeConstants.kNA
            
            if arrayMyRecipe?[indexPath.row].isFavourite == 0{
                cell5.heartBtn.setImage(UIImage(named: "like_icon_white.png"), for: .normal)
            }
            else{
                cell5.heartBtn.setImage(UIImage(named: "liked_icon.png"), for: .normal)
            }
            if arrayMyRecipe?[indexPath.row].avgRating == "0.0" || arrayMyRecipe?[indexPath.row].avgRating  == "0" {
                cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }  else if (arrayMyRecipe?[indexPath.row].avgRating  ?? "0") >= ("0.1") && (arrayMyRecipe?[indexPath.row].avgRating  ?? "0") <= ("0.9") {
                cell5.rating1ImgVw.image = UIImage(named: "HalfStar")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayMyRecipe?[indexPath.row].avgRating == ("1.0") || arrayMyRecipe?[indexPath.row].avgRating  == ("1") {
                cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if (arrayMyRecipe?[indexPath.row].avgRating ?? "0") >= ("1.1") && (arrayMyRecipe?[indexPath.row].avgRating ?? "0") <= ("1.9"){
                cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating2ImgVw.image = UIImage(named: "HalfStar")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayMyRecipe?[indexPath.row].avgRating == ("2.0") || arrayMyRecipe?[indexPath.row].avgRating  == ("2"){
                cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if (arrayMyRecipe?[indexPath.row].avgRating ?? "0") >= ("2.1") && (arrayMyRecipe?[indexPath.row].avgRating  ?? "0") <= ("2.9"){
                cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating3ImgVw.image = UIImage(named: "HalfStar")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayMyRecipe?[indexPath.row].avgRating  == ("3.0") || arrayMyRecipe?[indexPath.row].avgRating  == ("3"){
                cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if (arrayMyRecipe?[indexPath.row].avgRating ?? "0") >= ("3.1") && (arrayMyRecipe?[indexPath.row].avgRating  ?? "0") <= ("3.9") {
                cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating4ImgvW.image = UIImage(named: "HalfStar")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrayMyRecipe?[indexPath.row].avgRating  == ("4.0") || arrayMyRecipe?[indexPath.row].avgRating  == ("4"){
                cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if (arrayMyRecipe?[indexPath.row].avgRating  ?? "0") >= ("4.1") && (arrayMyRecipe?[indexPath.row].avgRating  ?? "0") <= ("4.9"){
                cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell5.rating5ImgVw.image = UIImage(named: "HalfStar")
            }else if arrayMyRecipe?[indexPath.row].avgRating  == ("5.0") || arrayMyRecipe?[indexPath.row].avgRating  == ("5"){
                cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star")
            }else{cell5.rating1ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell5.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                print("Invalid Rating")
            }
            return cell5
            
        case 3:
            let cell6 = containerTableVw.dequeueReusableCell(withIdentifier: "PreferencesTableViewCell") as! PreferencesTableViewCell
            cell6.delegate = self
            
            cell6.post = true
            
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
                return ingridentHeight
            }
            if (indexPath.section == 1)
            {
                return mealHeight
                
            }
            
            if (indexPath.section == 2)
            {
                
                return regionHeight

            }
            if (indexPath.section == 3)
            {
                
                return trendingHeight

            }
            if (indexPath.section == 4)
            {
            
                return CGFloat(quickeasyHeight)

            }
        case 1:
            return 260
        case 2:
            return 260
        case 3:
            
            return finalHeight
            
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
            if kSharedUserDefaults.getAppLanguage() == "it"{
                return CGSize(width: 170 , height: 50.0)
            }
            else{
                return CGSize(width: 140 , height: 50.0)
            }
            
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
            getExploreData()
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
            getSavedMyPreferences()
            
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
        self.view.isUserInteractionEnabled = false
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getMyrecipe, requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
            switch statusCode{
            case 200:
                let dictResponse = dictResponse as? [String:Any]
                
                if let data = dictResponse?["data"] as? [[String:Any]]{
                    
                    arrayMyRecipe = data.map({HomeTrending.init(with: $0)})
                    
                    print("\(String(describing: arrayMyRecipe?.count))")
                }
            case 409:
                self.showAlert1(message: RecipeConstants.kNoRecipe)
            default:
                break
                
            }
            self.containerTableVw.reloadData()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    func getMyFavouriteRecipes(){
        self.view.isUserInteractionEnabled = false
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getFavouriteRecipe
                                                   , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
            
            arrayMyFavouriteRecipe?.removeAll()
            switch statusCode{
            
            case 200:
                let dictResponse = dictResponse as? [String:Any]
                
                if let data = dictResponse?["data"] as? [[String:Any]]{
                    
                    arrayMyFavouriteRecipe = data.map({HomeTrending.init(with: $0)})
                    
                    print("\(String(describing: arrayMyFavouriteRecipe?.count))")
                    
                }
                
            case 409:
                self.showAlert1(message: RecipeConstants.kNotLikeRecipe)
                
            default:
                break
            }
            self.containerTableVw.reloadData()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    func getSavedMyPreferences() -> Void{
        self.view.isUserInteractionEnabled = false
        getSavedPreferencesModel = [GetSavedPreferencesDataModel]()
        showCuisine?.removeAll()
        showFood?.removeAll()
        showDiet?.removeAll()
        showIngridient?.removeAll()
        showCookingSkill?.removeAll()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getsavedPreferences, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { [self] (response, error, errorType, statusCode) in
            
            let res = response as? [String:Any]
            
            if let data = res?["data"] as? [[String:Any]]{
                getSavedPreferencesModel = data.map({GetSavedPreferencesDataModel.init(with: $0)})
                
                for i in (0..<(getSavedPreferencesModel?.count ?? 0)){
                    switch i{
                    case 0:
                        for j in (0..<(getSavedPreferencesModel?[i].maps?.count ?? 0))
                        {
                            if getSavedPreferencesModel?[i].maps?[j].isSelected == 1{
                                showCuisine?.append(getSavedPreferencesModel?[i].maps?[j] ?? MapDataModel(with: [:]) )
                                
                                arraySelectedCuisine?.removeAll()
                                for k in (0..<(showCuisine?.count ?? 0)){
                                    arraySelectedCuisine?.append(showCuisine?[k].cousinId ?? 0 )
                                }
                            }
                        }
                    case 1:
                        for j in (0..<(getSavedPreferencesModel?[i].maps?.count ?? 0))
                        {
                            if getSavedPreferencesModel?[i].maps?[j].isSelected == 1{
                                showFood?.append(getSavedPreferencesModel?[i].maps?[j] ?? MapDataModel(with: [:]) )
                                
                                arraySelectedFood?.removeAll()
                                for k in (0..<(showFood?.count ?? 0)){
                                    arraySelectedFood?.append(showFood?[k].foodId ?? 0 )
                                }
                                
                            }
                            
                        }
                    case 2:
                        for j in (0..<(getSavedPreferencesModel?[i].maps?.count ?? 0))
                        {
                            if getSavedPreferencesModel?[i].maps?[j].isSelected == 1{
                                showDiet?.append(getSavedPreferencesModel?[i].maps?[j] ?? MapDataModel(with: [:]) )
                                
                                arraySelectedDiet?.removeAll()
                                for k in (0..<(showDiet?.count ?? 0)){
                                    
                                    arraySelectedDiet?.append(showDiet?[k].dietId ?? 0 )
                                }
                                
                            }
                        }
                    case 3:
                        for j in (0..<(getSavedPreferencesModel?[i].maps?.count ?? 0))
                        {
                            if getSavedPreferencesModel?[i].maps?[j].isSelected == 1{
                                showIngridient?.append(getSavedPreferencesModel?[i].maps?[j] ?? MapDataModel(with: [:]) )
                                
                                arraySelectedIngridient?.removeAll()
                                for k in (0..<(showIngridient?.count ?? 0)){
                                    
                                    arraySelectedIngridient?.append(showIngridient?[k].ingridientId ?? 0 )
                                }
                            }
                        }
                    case 4:
                        for j in (0..<(getSavedPreferencesModel?[i].maps?.count ?? 0))
                        {
                            if getSavedPreferencesModel?[i].maps?[j].isSelected == 1{
                                showCookingSkill?.append(getSavedPreferencesModel?[i].maps?[j] ?? MapDataModel(with: [:]))
                                
                                arraySelectedCookingSkill?.removeAll()
                                for k in (0..<(showCookingSkill?.count ?? 0)){
                                    
                                    arraySelectedCookingSkill?.append(showCookingSkill?[k].cookingSkillId ?? 0 )
                                }
                            }
                        }
                    default:
                        break
                        
                    }
                    
                }
                
            }
            first = 1
            let sec = ((((showFood?.count ?? 0) + 1) % 3) == 0)
            let sec1 = ((showFood?.count ?? 0) + 1) / 3
            let sec2 = (((showFood?.count ?? 0) + 1) / 3) + 1
            second = sec ? sec1 : sec2
            let thr = ((((showDiet?.count ?? 0) + 1) % 3) == 0)
                let thr1 = ((showDiet?.count ?? 0) + 1) / 3
                    let thr2 = (((showDiet?.count ?? 0) + 1) / 3) + 1
            third =  thr ? thr1 : thr2
            let four = ((((showIngridient?.count ?? 0) + 1) % 3) == 0)
                let four1 = ((showIngridient?.count ?? 0) + 1) / 3
                    let four2 = (((showIngridient?.count ?? 0) + 1) / 3) + 1
            fourth =  four ? four1 : four2
            fifth = 1
            
            finalHeight = CGFloat((140 * (first+second+third+fourth+fifth))+210)
           
            self.containerTableVw.reloadData()
            
            self.view.isUserInteractionEnabled = true
        }
    }
}
extension DiscoverRecipeViewController{
    func animate1View(){
        self.headerView.isUserInteractionEnabled = false
        self.discoverRecipeView.isUserInteractionEnabled = false
        self.containerTableVw.isUserInteractionEnabled = false
        self.discoverRecipeView.alpha = 0.5
        self.headerView.alpha = 0.5
        self.containerTableVw.alpha = 0.5
        self.walkView1.isHidden = false
        self.vwwWalkContainer1.isHidden = false
        self.vwwWalkContainer2.isHidden = true
        walkVwContainer1Img.image = UIImage(named: "Group 5296")
        walkVw1Img.image = UIImage(named: "undraw_cooking_lyxy")
        walkVw1Title.text = RecipeConstants.kWalk1Title
        walkVw1SubTitle.text = RecipeConstants.kWalk1Subtitle
        
        pageControl1.layer.cornerRadius = self.pageControl1.frame.height / 2
        pageControl2.layer.cornerRadius = self.pageControl2.frame.height / 2
        pageControl3.layer.cornerRadius = self.pageControl3.frame.height / 2
        pageContrl1Width.constant = 25
        pageContrl2Width.constant = 10
        pageContrl3Width.constant = 10
        pageControl3.layer.borderWidth = 0.5
        pageControl3.layer.borderColor = UIColor.white.cgColor
        pageControl2.layer.borderWidth = 0.5
        pageControl2.layer.borderColor = UIColor.white.cgColor
        pageControl3.layer.backgroundColor = UIColor.clear.cgColor
        pageControl1.layer.backgroundColor = UIColor.white.cgColor
        
        UIView.animate(withDuration: 0.5) {
            self.walkView1height.constant = 520
            self.walkView1Top.constant = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.walkView1height.constant = 500
                self.view.layoutIfNeeded()
            } completion: { _ in
                // print("Completion")
            }
        }
    }
    func animateView3(){
        self.vwwWalkContainer1.isHidden = false
        self.vwwWalkContainer2.isHidden = true
        walkVwContainer1Img.image = UIImage(named: "Group 5298")
        walkVw1Img.image = UIImage(named: "Group 5299")
        walkVw1Title.text = RecipeConstants.kWalk3Title
        walkVw1SubTitle.text = RecipeConstants.kWalk3Subtitle
        
        pageControl1.layer.cornerRadius = self.pageControl1.frame.height / 2
        pageControl2.layer.cornerRadius = self.pageControl2.frame.height / 2
        pageControl3.layer.cornerRadius = self.pageControl3.frame.height / 2
        pageContrl1Width.constant = 10
        pageContrl2Width.constant = 10
        pageContrl3Width.constant = 25
        pageControl1.layer.borderWidth = 0.5
        pageControl1.layer.borderColor = UIColor.white.cgColor
        pageControl2.layer.borderWidth = 0.5
        pageControl2.layer.borderColor = UIColor.white.cgColor
        pageControl1.layer.backgroundColor = UIColor.clear.cgColor
        pageControl3.layer.backgroundColor = UIColor.white.cgColor
        UIView.animate(withDuration: 0.5) {
            self.vwwWalkContainer1.isHidden = false
            self.walkView1height.constant = 520
            self.walkView1Trailing.constant = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            
            UIView.animate(withDuration: 0.5) {
                self.walkView1height.constant = 500
                self.view.layoutIfNeeded()
            } completion: { _ in
                // print("Completion")
            }
        }
     
    }
    func animate2View(){
        
        self.vwwWalkContainer1.isHidden = true
        self.vwwWalkContainer2.isHidden = false
        self.walkSubView3.isHidden = false
        vwwWalkContainer2BgImg.image = UIImage(named: "Group 5297")
        self.walkSubView3Height.constant = 55
        walkView2Img.image = UIImage(named: "Group 21767")
        walkView2Tilte.text = RecipeConstants.kWalk2Title
        walkView2SubTitle.text = RecipeConstants.kWalk2Subtitle
        
        walkSubView1Img.image = UIImage(named: "icons8_xlarge_icons")
        walkSubView1Title.text = RecipeConstants.kWalk2title1
        walkSubView1SubTitle.text = RecipeConstants.kWalk2Subtitle1
        
        walkSubView2Img.image = UIImage(named: "icons8_industrial_scales_connected")
        walkSubView2Title.text = RecipeConstants.kWalk2title2
        walkSubView2SubTitle.text = RecipeConstants.kWalk2Subtitle2
        
        walkSubView3Img.image = UIImage(named: "icons8_stairs")
        walkSubView3Title.text = RecipeConstants.kWalk2title3
        walkSubView3SubTitle.text = RecipeConstants.kWalk2Subtitle3
        
        pageControl4.layer.cornerRadius = self.pageControl1.frame.height / 2
        pageControl5.layer.cornerRadius = self.pageControl2.frame.height / 2
        pageControl6.layer.cornerRadius = self.pageControl3.frame.height / 2
        pageContrl4Width.constant = 10
        pageContrl5Width.constant = 25
        pageContrl6Width.constant = 10
        pageControl4.layer.borderWidth = 0.5
        pageControl4.layer.borderColor = UIColor.white.cgColor
        pageControl6.layer.borderWidth = 0.5
        pageControl6.layer.borderColor = UIColor.white.cgColor
        pageControl5.layer.backgroundColor = UIColor.white.cgColor
        pageControl6.layer.backgroundColor = UIColor.clear.cgColor
        UIView.animate(withDuration: 0.5) {
            self.vwwWalkContainer2.isHidden = false
            self.walkView1height.constant = self.view.frame.height / 2 + 320
            self.walkView1Trailing.constant = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.walkView1height.constant = self.view.frame.height / 2 + 300
                self.view.layoutIfNeeded()
            } completion: { _ in
                // print("Completion")
            }
        }
    }
    
}

extension DiscoverRecipeViewController : CoachMarksControllerDataSource, CoachMarksControllerDelegate{
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 2
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
        
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)

        switch index {
        case 0:
            coachViews.bodyView.hintLabel.text = TourGuideConstants.kForCreateRecipe
            coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
        case 1:
    coachViews.bodyView.hintLabel.text = TourGuideConstants.kForSearchbyIngedients
    coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
            
//        case 2:
//    coachViews.bodyView.hintLabel.text = TourGuideConstants.kForTrendingNow
//    coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
          
        default: break
        }

        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController,
                                  coachMarkAt index: Int) -> CoachMark {
        let indexpath1 = IndexPath(row: 0, section: 0)
        let cell1 = containerTableVw.cellForRow(at: indexpath1) as? ExploreByIngridientTableViewCell
        let indexpath3 = IndexPath(row: 0, section: 3)
        
       
        switch index {
        case 0: return coachMarksController.helper.makeCoachMark(for: createRecipeBtn)
        case 1: return coachMarksController.helper.makeCoachMark(for: cell1?.headerLabel)
//        case 2:
//            containerTableVw.scrollToRow(at: indexpath3, at: .top, animated: true)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                coachMarksController.flow.resume()
//
//            }
//            let cell3 = containerTableVw.cellForRow(at: .init(row: 0, section: 3)) as? TrendingTableViewCell
//
//            return coachMarksController.helper.makeCoachMark(for: trendingTour)
             
        default: return coachMarksController.helper.makeCoachMark()
        }
    }
    
    
    func coachMarksController(_ coachMarksController: CoachMarksController, willShow coachMark: inout CoachMark, beforeChanging change: ConfigurationChange, at index: Int) {
       
        let indexpath3 = IndexPath(row: 0, section: 3)
        switch index {
        case 0: coachMarksController.flow.resume()
        case 1: coachMarksController.flow.resume()
//        case 2: coachMarksController.flow.pause()
           
        default:
            coachMarksController.flow.resume()
        }
    }
    
    
    func coachMarksController(_ coachMarksController: CoachMarksController, didEndShowingBySkipping skipped: Bool) {
        AppManager.setUserSeenAppInstruction()
     }
}
extension DiscoverRecipeViewController{
    
    func getUsersData() {
        
        kChatharedInstance.receivce_user_data(userID: String.getString(kSharedUserDefaults.loggedInUserModal.userId)) { (users) in
            self.getUser?.removeAll()
            self.getUser = users
            
            if self.getUser![0].notification ?? 0 > 10 {
                self.vwNotification.isHidden = false
                self.lblNotificationCount.text = "10+"
            }else if self.getUser![0].notification ?? 0 > 0 && self.getUser![0].notification ?? 0 <= 10 {
                self.vwNotification.isHidden = false
                self.lblNotificationCount.text = String.getString(self.getUser![0].notification)
            } else {
                self.vwNotification.isHidden = true
            }
            
        }
        
    }
}
