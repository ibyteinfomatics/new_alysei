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
class ViewRecipeViewController: UIViewController, ViewRecipeDelegate, CategoryRowDelegate {
    
    
    @IBOutlet weak var viewStartCookingHeight: NSLayoutConstraint!
    @IBOutlet weak var viewDeleteShare: UIView!
    @IBOutlet weak var viewDeleteShareHeight: NSLayoutConstraint!
    @IBOutlet weak var deleteShareTableview: UITableView!
    @IBOutlet weak var rightIconImageVw: UIImageView!
    @IBOutlet weak var rightIconBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var btnStartCooking: UIButton!
    
    var checkbutton = 0
    var imgUrl1 = String()
   
    override func viewWillAppear(_ animated: Bool) {
        
       if isFromComment == "Review" {
            self.getRecipeDetail()
        }
       else{
        tableView.reloadData()
       }
       

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        deleteShareTableview.delegate = self
        deleteShareTableview.dataSource = self
        viewDeleteShare.isHidden = true
        isFromComment = ""
        tableView.register(UINib(nibName: "ViewRecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewRecipeTableViewCell")
       
        getRecipeDetail()
        
        
        
        }
    
    func cellTapped(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewRecipeViewController") as! ViewRecipeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapBackHome(_ sender: Any) {

            self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func tapRightIcon(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == false
        {
            viewDeleteShare.isHidden = true
            
        }
        else{
            viewDeleteShare.isHidden = false
           
        }
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
        if tableView == deleteShareTableview{
           return 1
        }
        else{
            return 4
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == deleteShareTableview{
            viewDeleteShareHeight.constant = 40
           return 1
           
        }
        else{
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
        else{
        return 1
        }
        return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == deleteShareTableview{
            guard let cell  = tableView.dequeueReusableCell(withIdentifier: "DeleteShareTableViewCell", for: indexPath) as? DeleteShareTableViewCell else {return UITableViewCell()}
            cell.labelDelete.text = "Delete"
        }
        else{
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
                cell.layer.cornerRadius = 50
                cell.layer.masksToBounds = true

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

            if let imageURLString = kSharedUserDefaults.loggedInUserModal.UserAvatar_id?.attachment_url {
                        cell.profileImgComment.setImage(withString: "\(kImageBaseUrl)\(imageURLString)")
            }
            cell.profileImgComment.layer.cornerRadius = cell.profileImgComment.frame.height/2
            cell.labelUserName.text = recipeModel?.userName
            cell.labelEmail.text = recipeModel?.userMain?.email
            
            if recipeModel?.latestReview?.review != nil {
                cell.latestCommentUserName.isHidden = false
                cell.latestCommentImg.isHidden = false
                cell.latestCommentUserName.isHidden = false
                cell.latestCommentDate.isHidden = false
                cell.latestCommentTextView.isHidden = false
                cell.rateImg1.isHidden = false
                cell.rateImg2.isHidden = false
                cell.rateImg3.isHidden = false
                cell.rateImg4.isHidden = false
                cell.rateImg5.isHidden = false
                let imgUrl2 = (kImageBaseUrl + (recipeModel?.latestReview?.user?.avatarId?.imageUrl ?? ""))
                cell.latestCommentImg.setImage(withString: imgUrl2)
                cell.latestCommentImg.layer.cornerRadius = cell.latestCommentImg.frame.height/2
                if recipeModel?.latestReview?.user?.name == ""{
                    cell.latestCommentUserName.text = "NA"
                }
                else{
                    cell.latestCommentUserName.text = recipeModel?.latestReview?.user?.name
                }
                
                let date = Date(timeIntervalSinceNow: -180)
                cell.latestCommentDate.text = date.getElapsedInterval(timeStamp: String.getString(recipeModel?.latestReview?.created)) + "ago"
                
                cell.latestCommentTextView.text = recipeModel?.latestReview?.review
                
                if recipeModel?.latestReview?.rating ?? 0 == 0 {
                    cell.rateImg1.image = UIImage(named: "icons8_star")
                    cell.rateImg2.image = UIImage(named: "icons8_star")
                    cell.rateImg3.image = UIImage(named: "icons8_star")
                    cell.rateImg4.image = UIImage(named: "icons8_star")
                    cell.rateImg5.image = UIImage(named: "icons8_star")

                }
    //            else if recipeModel?.avgRating ?? "0.0" == "0.5" {
    //                cell.rateImg1.image = UIImage(named: "Group 1142")
    //                cell.rateImg2.image = UIImage(named: "icons8_star")
    //                cell.rateImg3.image = UIImage(named: "icons8_star")
    //                cell.rateImg4.image = UIImage(named: "icons8_star")
    //               cell.rateImg5.image = UIImage(named: "icons8_star")
    //            }
                else if recipeModel?.latestReview?.rating ?? 0 == 1 {
                    cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
                    cell.rateImg2.image = UIImage(named: "icons8_star")
                    cell.rateImg3.image = UIImage(named: "icons8_star")
                    cell.rateImg4.image = UIImage(named: "icons8_star")
                   cell.rateImg5.image = UIImage(named: "icons8_star")
                }
    //            else if recipeModel?.avgRating ?? "0.0" == "1.5" {
    //                cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
    //                cell.rateImg2.image = UIImage(named: "Group 1142")
    //                cell.rateImg3.image = UIImage(named: "icons8_star")
    //                cell.rateImg4.image = UIImage(named: "icons8_star")
    //                cell.rateImg5.image = UIImage(named: "icons8_star")
    //            }
            else if recipeModel?.latestReview?.rating ?? 0 == 2 {
                    cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
                    cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
                    cell.rateImg3.image = UIImage(named: "icons8_star")
                    cell.rateImg4.image = UIImage(named: "icons8_star")
                    cell.rateImg5.image = UIImage(named: "icons8_star")
                }
    //            else if recipeModel?.avgRating ?? "0.0" == "2.5" {
    //                cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
    //                cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
    //                cell.rateImg3.image = UIImage(named: "Group 1142")
    //                cell.rateImg4.image = UIImage(named: "icons8_star")
    //                cell.rateImg5.image = UIImage(named: "icons8_star")
    //            }
            else if recipeModel?.latestReview?.rating ?? 0 == 3 {
                    cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
                    cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
                    cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
                    cell.rateImg4.image = UIImage(named: "icons8_star")
                    cell.rateImg5.image = UIImage(named: "icons8_star")
                }
    //            else if recipeModel?.avgRating ?? "0.0" == "3.5" {
    //                cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
    //                cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
    //                cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
    //                cell.rateImg4.image = UIImage(named: "Group 1142")
    //                cell.rateImg5.image = UIImage(named: "icons8_star")
    //            }
                else if recipeModel?.latestReview?.rating ?? 0 == 4 {
                    cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
                    cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
                    cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
                    cell.rateImg4.image = UIImage(named: "icons8_christmas_star")
                    cell.rateImg5.image = UIImage(named: "icons8_star")
                }
    //            else if recipeModel?.avgRating ?? "0.0" == "4.5" {
    //                cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
    //                cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
    //                cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
    //                cell.rateImg4.image = UIImage(named: "icons8_christmas_star")
    //                cell.rateImg5.image = UIImage(named: "Group 1142")
    //            }
            else if recipeModel?.latestReview?.rating ?? 0 == 5 {
                    cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
                    cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
                    cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
                    cell.rateImg4.image = UIImage(named: "icons8_christmas_star")
                    cell.rateImg5.image = UIImage(named: "icons8_christmas_star")
                }
            }
            else{
                cell.latestCommentUserName.isHidden = true
                cell.latestCommentImg.isHidden = true
                cell.latestCommentUserName.isHidden = true
                cell.latestCommentDate.isHidden = true
                cell.latestCommentTextView.isHidden = true
                cell.rateImg1.isHidden = true
                cell.rateImg2.isHidden = true
                cell.rateImg3.isHidden = true
                cell.rateImg4.isHidden = true
                cell.rateImg5.isHidden = true
            }
           

            
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
    return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == deleteShareTableview{
            
            //MARK:show Alert Message
            let refreshAlert = UIAlertController(title: "", message: "All Recipe data will be lost.", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                  // Handle Ok logic here
                self.deleteRecipe()
                arrayMyRecipe?.remove(at: indexPath.row)
                let add = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverRecipeViewController") as! DiscoverRecipeViewController
                self.navigationController?.pushViewController(add, animated: true)
                
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                  print("Handle Cancel Logic here")
//                self.viewDeleteShare.isHidden = true
                self.dismiss(animated: true, completion: nil)
            }))
    
            self.present(refreshAlert, animated: true, completion: nil)
        }
        else{
           return
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == deleteShareTableview{
            return 40
        }
        else{
            
        switch indexPath.section{
        case 0:
            return 300
        case 1:
            return 70
        case 2:
            return 350
        case 3:
            return 350
        default:
            return 400
        }
      }
    }
}
        
extension ViewRecipeViewController{
    func getRecipeDetail(){
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
            if recipeModel?.userId == Int(kSharedUserDefaults.loggedInUserModal.userId ?? "0"){
                rightIconBtn.isUserInteractionEnabled = true
                rightIconImageVw.isHidden = false
            }
            else{
                rightIconBtn.isUserInteractionEnabled = false
                rightIconImageVw.isHidden = true
            }
            self.tableView.reloadData()
            
        }
    }
   
    func deleteRecipe(){
       
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.deleteRecipe + "\(recipeId)", requestMethod: .POST,requestParameters: [:], withProgressHUD:  true){ (dictResponse, error, errorType, statusCode) in
                
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

