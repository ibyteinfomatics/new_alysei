//
//  ViewRecipeViewController.swift
//  New Recipe module
//
//  Created by mac on 12/08/21.
//

import UIKit
var recipeId = Int()
class ViewRecipeViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    var checkbutton = 0
    var recipeModel : ViewRecipeDetailDataModel?
    var usedIngridientModel : [UsedIngridientDataModel]? = []
    var usedToolModel: [UsedToolsDataModel]? = []
    var stepsModel: [StepsDataModel]? = []
   
   
    
    override func viewWillAppear(_ animated: Bool) {
        getRecipeDetail()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ViewRecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewRecipeTableViewCell")

        getRecipeDetail()
        
        }
    
    
    @IBAction func tapBackHome(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
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
        return 4
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
                cell.ingredientQuantityLabel.text = usedIngridientModel?[indexPath.row].quantity
        
                
            }else{
                let imgUrl = (kImageBaseUrl + (usedToolModel?[indexPath.row].tool?.imageId?.imgUrl ?? ""))
                
                cell.ingredientImageView.setImage(withString: imgUrl)
                cell.ingredientNameLabel.text = usedToolModel?[indexPath.row].tool?.toolTitle
                cell.ingredientQuantityLabel.text = usedToolModel?[indexPath.row].quantityTool
            }
            
            return cell
            
        case 2:
            guard let cell:RecipeByTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "RecipeByTableViewCell") as? RecipeByTableViewCell else {return UITableViewCell()}
            let imgUrl = (kImageBaseUrl + (recipeModel?.userMain?.avatarId?.imageUrl ?? ""))
            
            cell.profileImg.setImage(withString: imgUrl)
            cell.profileImgComment.setImage(withString: imgUrl)
            cell.labelUserName.text = recipeModel?.userName
            cell.labelEmail.text = recipeModel?.userMain?.email
            let imgUrl2 = (kImageBaseUrl + (recipeModel?.latestReview?.user?.avatarId?.imageUrl ?? ""))
            cell.latestCommentImg.setImage(withString: imgUrl2)
            cell.latestCommentUserName.text = recipeModel?.latestReview?.user?.name
            cell.latestCommentDate.text = recipeModel?.latestReview?.created
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
            
        return cell
            
        default:
            guard let cell:LikeRecipeTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "LikeRecipeTableViewCell") as? LikeRecipeTableViewCell else {return UITableViewCell()}
            
           
            
        return cell
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
        
extension ViewRecipeViewController{
    func getRecipeDetail(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getRecipeDeatail + "\(recipeId)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["recipe"] as? [String:Any]{
                self.recipeModel = ViewRecipeDetailDataModel.init(with: data)
               
            }
            if let data = dictResponse?["used_ingredients"] as? [[String:Any]]{
                self.usedIngridientModel = data.map({UsedIngridientDataModel.init(with: $0)})
               
            }
            if let data = dictResponse?["used_tools"] as? [[String:Any]]{
                self.usedToolModel = data.map({UsedToolsDataModel.init(with: $0)})
               
            }
            if let data = dictResponse?["steps"] as? [[String:Any]]{
                self.stepsModel = data.map({StepsDataModel.init(with: $0)})
               
            }
            if let data = dictResponse?["you_might_also_like"] as? [[String:Any]]{
                youMightAlsoLikeModel = data.map({ViewRecipeDetailDataModel.init(with: $0)})
               
            }
            setImage()
            self.tableView.reloadData()
            
        }
    }
   
}



