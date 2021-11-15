//
//  ViewRecipeViewController.swift
//  New Recipe module
//
//  Created by mac on 12/08/21.
//

import UIKit

var recipeId = Int()
var stepsModel: [StepsDataModel]? = []
var recipeModel : ViewRecipeDetailDataModel?
var usedIngridientModel : [UsedIngridientDataModel]? = []
var usedToolModel: [UsedToolsDataModel]? = []
class ViewRecipeViewController: AlysieBaseViewC, ViewRecipeDelegate, CategoryRowDelegate{
    
    
    @IBOutlet weak var viewStartCookingHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnStartCooking: UIButton!
    
    var checkbutton = 0
    var imgUrl1 = String()
    let recipeImageView = UIImageView()
    let backButton = UIButton()
    let menuButton = UIButton()
    override func viewWillAppear(_ animated: Bool) {
        
        if isFromComment == "Review" {
            self.getRecipeDetail()
        }
        else{
            tableView.reloadData()
        }
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
        
        recipeImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300)
        backButton.frame = CGRect(x: 0, y: 20, width: 40, height: 40)
        menuButton.frame = CGRect(x: UIScreen.main.bounds.size.width-40, y: 20, width: 40, height: 40)
        
        backButton.setImage(UIImage(named: "back_white.png"), for: .normal)
        menuButton.setImage(UIImage(named: "icons8_menu_vertical.png"), for: .normal)
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(backAction))
        backButton.addGestureRecognizer(tap)
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(menuAction))
        menuButton.addGestureRecognizer(tap1)
        
        view.addSubview(recipeImageView)
        view.addSubview(backButton)
        view.addSubview(menuButton)
        
        btnStartCooking.layer.borderWidth = 1
        btnStartCooking.layer.cornerRadius = 24
        btnStartCooking.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
        
        isFromComment = ""
        tableView.register(UINib(nibName: "ViewRecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewRecipeTableViewCell")
        
        getRecipeDetail()
        
    }
    
    func cellTapped(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewRecipeViewController") as! ViewRecipeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func backAction(_ tap: UITapGestureRecognizer){
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func menuAction(_ tap: UITapGestureRecognizer){
        
        let actionSheet = UIAlertController(style: .actionSheet)
        
        
        let deleteRecipe = UIAlertAction(title: "Delete Recipe", style: .destructive) { action in
            self.deleteRecipe()
        }
        
        let shareRecipe = UIAlertAction(title: "Share Recipe", style: .default) { action in
            self.share()
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        
        if recipeModel?.userId == Int(kSharedUserDefaults.loggedInUserModal.userId ?? "0"){
            actionSheet.addAction(deleteRecipe)
            actionSheet.addAction(shareRecipe)
            actionSheet.addAction(cancelAction)
        }
        else{
            actionSheet.addAction(shareRecipe)
            actionSheet.addAction(cancelAction)
        }
        
        
        
        self.present(actionSheet, animated: true, completion: nil)
        
        
    }
    
    func share(){
        let message = "Checkout" + " " + (recipeModel?.recipeName ?? "") +  " " + "from Alysei app."
        
        //                let appName = "Alysei"
        //                let appScheme = "\(appName)://app"
        //                let appUrl = URL(string: appScheme)
        let url = URL(string:"https://alyseiweb.ibyteworkshop.com/")
        
        //            if UIApplication.shared.canOpenURL(appUrl! as URL) {
        //                UIApplication.shared.open(appUrl!)
        //            } else {
        //                UIApplication.shared.open(url!)
        //            }
        
        
        
        let activityVC : UIActivityViewController  = UIActivityViewController(activityItems: [(message + "\n" + "\(url ?? URL(fileURLWithPath: ""))")], applicationActivities: nil)
        activityVC.view.backgroundColor = UIColor.white
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    @IBAction func tapForStartCooking(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StepsViewController") as! StepsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setImage(){
        let imgUrl = (kImageBaseUrl + (recipeModel?.image?.imgUrl ?? ""))
        recipeImageView.setImage(withString: imgUrl)
    }
}



extension ViewRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 5
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
            
        }else if section == 1{
            switch checkbutton {
            case 0:
                
                return usedIngridientModel?.count ?? 0
            case 1:
                return usedToolModel?.count ?? 0
                
            default:
                print("Invalid")
            }
        }
        else if section == 2{
            return 1
        }
        else if section == 3{
            return 1
        }
        else{
            return 1
        }
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell  = tableView.dequeueReusableCell(withIdentifier: "ViewDetailsTableViewCell", for: indexPath) as? ViewDetailsTableViewCell else {return UITableViewCell()}
            cell.labelRecipeName.text = recipeModel?.recipeName
            
            cell.likeCallback = {
                
                cell.labelLike.text = "\(recipeModel?.favCount ?? 0 )" + " " + "Likes"
                cell.imagLike.image = recipeModel?.isFav == 0 ? UIImage(named: "like_icon") : UIImage(named: "like_icon_active")
                
            }
            cell.imagLike.image = recipeModel?.isFav == 1 ? UIImage(named: "like_icon_active") : UIImage(named: "like_icon")
            cell.labelLike.text = "\(recipeModel?.favCount ?? 0 )" + " " + "Likes"
            cell.labelUserName.text = recipeModel?.userName
            cell.labelReview.text = "\(recipeModel?.totalReview ?? 0)" + " " + "Reviews"
            cell.labelTime.text = "\( recipeModel?.hours ?? 0)" + " " + "hours" + " " + "\( recipeModel?.minute ?? 0)" + " " + "minutes"
            cell.labelServing.text = "\(recipeModel?.serving ?? 0)" + " " + "Serving"
            cell.labelMealType.text = recipeModel?.meal?.mealName ?? "NA"
            
            if recipeModel?.avgRating ?? "0.0" == "0.0" {
                cell.rateImg1.image = UIImage(named: "icons8_star")
                cell.rateImg2.image = UIImage(named: "icons8_star")
                cell.rateImg3.image = UIImage(named: "icons8_star")
                cell.rateImg4.image = UIImage(named: "icons8_star")
                cell.rateImg5.image = UIImage(named: "icons8_star")
                
            }
            else if recipeModel?.avgRating ?? "0.0" == "0.5" {
                cell.rateImg1.image = UIImage(named: "Group 1142")
                cell.rateImg2.image = UIImage(named: "icons8_star")
                cell.rateImg3.image = UIImage(named: "icons8_star")
                cell.rateImg4.image = UIImage(named: "icons8_star")
                cell.rateImg5.image = UIImage(named: "icons8_star")
            }else if recipeModel?.avgRating ?? "0.0" == "1.0" {
                cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg2.image = UIImage(named: "icons8_star")
                cell.rateImg3.image = UIImage(named: "icons8_star")
                cell.rateImg4.image = UIImage(named: "icons8_star")
                cell.rateImg5.image = UIImage(named: "icons8_star")
            }
            else if recipeModel?.avgRating ?? "0.0" == "1.5" {
                cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg2.image = UIImage(named: "Group 1142")
                cell.rateImg3.image = UIImage(named: "icons8_star")
                cell.rateImg4.image = UIImage(named: "icons8_star")
                cell.rateImg5.image = UIImage(named: "icons8_star")
            }else if recipeModel?.avgRating ?? "0.0" == "2.0" {
                cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg3.image = UIImage(named: "icons8_star")
                cell.rateImg4.image = UIImage(named: "icons8_star")
                cell.rateImg5.image = UIImage(named: "icons8_star")
            }
            else if recipeModel?.avgRating ?? "0.0" == "2.5" {
                cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg3.image = UIImage(named: "Group 1142")
                cell.rateImg4.image = UIImage(named: "icons8_star")
                cell.rateImg5.image = UIImage(named: "icons8_star")
            }else if recipeModel?.avgRating ?? "0.0" == "3.0" {
                cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg4.image = UIImage(named: "icons8_star")
                cell.rateImg5.image = UIImage(named: "icons8_star")
            }
            else if recipeModel?.avgRating ?? "0.0" == "3.5" {
                cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg4.image = UIImage(named: "Group 1142")
                cell.rateImg5.image = UIImage(named: "icons8_star")
            }else if recipeModel?.avgRating ?? "0.0" == "4.0" {
                cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg4.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg5.image = UIImage(named: "icons8_star")
            }
            else if recipeModel?.avgRating ?? "0.0" == "4.5" {
                cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg4.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg5.image = UIImage(named: "Group 1142")
            }else if recipeModel?.avgRating ?? "0.0" == "5.0" {
                cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg4.image = UIImage(named: "icons8_christmas_star")
                cell.rateImg5.image = UIImage(named: "icons8_christmas_star")
            }
            cell.reloadTableViewCallback = { tag in
                self.checkbutton = tag
                self.tableView.reloadData()
                
            }
            
            return cell
        case 1:
            guard let cell:ViewRecipeTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "ViewRecipeTableViewCell", for: indexPath) as? ViewRecipeTableViewCell else {return UITableViewCell()}
            if checkbutton == 0{
                
                let imgUrl = (kImageBaseUrl + (usedIngridientModel?[indexPath.row].ingridient?.imageId?.imgUrl ?? ""))
                
                cell.ingredientImageView.setImage(withString: imgUrl)
                cell.ingredientNameLabel.text = usedIngridientModel?[indexPath.row].ingridient?.ingridientTitle
                cell.ingredientQuantityLabel.text = (usedIngridientModel?[indexPath.row].quantity ?? "0") + " " + (usedIngridientModel?[indexPath.row].unit ?? "")
                editSavedIngridientId = usedIngridientModel?[indexPath.row].recipeSavedIngridientId ?? 0
                
                
            }else{
                let imgUrl = (kImageBaseUrl + (usedToolModel?[indexPath.row].tool?.imageId?.imgUrl ?? ""))
                
                cell.ingredientImageView.setImage(withString: imgUrl)
                cell.ingredientNameLabel.text = usedToolModel?[indexPath.row].tool?.toolTitle
                cell.ingredientQuantityLabel.text = usedToolModel?[indexPath.row].quantityTool
                editSavedtoolId = usedToolModel?[indexPath.row].recipeSavedToolId ?? 0
            }
            
            return cell
            
        case 2:
            guard let cell:RecipeByTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "RecipeByTableViewCell") as? RecipeByTableViewCell else {return UITableViewCell()}
            let imgUrl = (kImageBaseUrl + (recipeModel?.userMain?.avatarId?.imageUrl ?? ""))
            
            cell.profileImg.setImage(withString: imgUrl)
            cell.profileImg.layer.cornerRadius = cell.profileImg.frame.height/2
            cell.labelUserName.text = recipeModel?.userName
            cell.labelEmail.text = recipeModel?.userMain?.email
            
            cell.btnViewProfileCallback = {
                
                let controller = self.pushViewController(withName: ProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? ProfileViewC
                controller?.userLevel = .other
                controller?.fromRecipe = "Recipe"
                
                controller?.userID = recipeModel?.userId
            }
            
            return cell
            
        case 3:
            guard let cell:RatingAndReviewTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "RatingAndReviewTableViewCell") as? RatingAndReviewTableViewCell else {return UITableViewCell()}
            
            cell.selectionStyle = .none
            
            let doubleTotalReview = Double.getDouble(recipeModel?.totalReview)
            
            cell.totalOneStar.text = "\(Int(calculateRatingPercentage(doubleTotalReview, Double.getDouble(recipeModel?.total_one_star))))%"
            cell.totalTwoStar.text = "\(Int(calculateRatingPercentage(doubleTotalReview, Double.getDouble(recipeModel?.total_two_star))))%"
            cell.totalThreeeStar.text = "\(Int(calculateRatingPercentage(doubleTotalReview, Double.getDouble(recipeModel?.total_three_star))))%"
            cell.totalFourStar.text = "\(Int(calculateRatingPercentage(doubleTotalReview, Double.getDouble(recipeModel?.total_four_star))))%"
            cell.totalFiveStar.text = "\(Int(calculateRatingPercentage(doubleTotalReview, Double.getDouble(recipeModel?.total_five_star))))%"
            
            
            
            cell.totalOneStarProgress.setProgress(Float(calculateRatingPercentage(doubleTotalReview, Double.getDouble(recipeModel?.total_one_star)))/100, animated: false)
            
            cell.totalTwoStarProgress.setProgress(Float(calculateRatingPercentage(doubleTotalReview, Double(recipeModel?.total_two_star ?? 0)))/100, animated: false)
            
            cell.totalThreeeStarProgress.setProgress(Float(calculateRatingPercentage(doubleTotalReview, Double.getDouble(recipeModel?.total_three_star)))/100, animated: false)
            
            cell.totalFourStarProgress.setProgress(Float(calculateRatingPercentage(doubleTotalReview, Double.getDouble(recipeModel?.total_four_star)))/100, animated: false)
            
            cell.totalFiveStarProgress.setProgress(Float(calculateRatingPercentage(doubleTotalReview, Double.getDouble(recipeModel?.total_five_star)))/100, animated: false)
            if recipeModel?.latestReview == nil {
                cell.viewComment.isHidden = true
                cell.heightuserName.constant = 0
                cell.heightStackView.constant = 0
                cell.vwCommentTop.constant = 0
            }else{
                cell.viewComment.isHidden = false
                cell.heightuserName.constant = 17.5
                cell.heightStackView.constant = 15
                cell.vwCommentTop.constant = 20
                
            }
            cell.lblTotalReview.text = "\(recipeModel?.totalReview ?? 0) reviews"
            cell.lblAvgRating.text = "\(recipeModel?.avgRating ?? "0")"
            cell.avgRating = recipeModel?.avgRating
            cell.configCell(recipeModel?.latestReview ?? LatestReviewDataModel(with: [:]))
            cell.btnAddReviewCallback = {
                let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "AddReviewRecipeViewController") as! AddReviewRecipeViewController
                viewAll.recipeReviewId = recipeModel!.recipeId!
                self.navigationController?.pushViewController(viewAll, animated: true)
            }
            return cell
        default:
            guard let cell:LikeRecipeTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "LikeRecipeTableViewCell") as? LikeRecipeTableViewCell else {return UITableViewCell()}
            cell.post = true
            cell.delegate = self
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section{
        case 0:
            return 230
        case 1:
            return 70
        case 2:
            return 122
        case 3:
            return UITableView.automaticDimension
        case 4:
            return 350
        default:
            return 400
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 300 - (scrollView.contentOffset.y + 300)
        let height = min(max(y, 60), 400)
        recipeImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        
    }
}

extension ViewRecipeViewController{
    func getRecipeDetail(){
        self.view.isUserInteractionEnabled = false
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getRecipeDeatail + "\(recipeId)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["recipe"] as? [String:Any]{
                recipeModel = ViewRecipeDetailDataModel.init(with: data)
                
            }
            if let data = dictResponse?["used_ingredients"] as? [[String:Any]]{
                usedIngridientModel = data.map({UsedIngridientDataModel.init(with: $0)})
                
            }
            if let data = dictResponse?["used_tools"] as? [[String:Any]]{
                usedToolModel = data.map({UsedToolsDataModel.init(with: $0)})
                
            }
            
            if let data = dictResponse?["steps"] as? [[String:Any]]{
                stepsModel = data.map({StepsDataModel.init(with: $0)})
                
            }
            
            if let data = dictResponse?["you_might_also_like"] as? [[String:Any]]{
                youMightAlsoLikeModel = data.map({ViewRecipeDetailDataModel.init(with: $0)})
                
            }
            setImage()
            if stepsModel?.count == 0{
                btnStartCooking.isHidden = true
                viewStartCookingHeight.constant = 0
            }
            else{
                btnStartCooking.isHidden = false
                viewStartCookingHeight.constant = 70
            }
            
            self.tableView.reloadData()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    func deleteRecipe(){
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.deleteRecipe + "\(recipeId)", requestMethod: .POST,requestParameters: [:], withProgressHUD:  true){ (dictResponse, error, errorType, statusCode) in
            let add = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverRecipeViewController") as! DiscoverRecipeViewController
            add.currentIndex = 2
            add.checkbutton = 2
            self.navigationController?.pushViewController(add, animated: true)
            
        }
    }
    
}

extension Date {
    
    func getElapsedInterval(timeStamp :String?) -> String {
        
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year" :
                "\(year)" + " " + "years"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month" :
                "\(month)" + " " + "months"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day" :
                "\(day)" + " " + "days"
        } else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + "hour" :
                "\(hour)" + " " + "hours"
        } else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "minute" :
                "\(minute)" + " " + "minutes"
        } else if let second = interval.second, second > 0 {
            return second == 1 ? "\(second)" + " " + "second" :
                "\(second)" + " " + "seconds"
        } else {
            return "a moment ago"
        }
        
    }
}

