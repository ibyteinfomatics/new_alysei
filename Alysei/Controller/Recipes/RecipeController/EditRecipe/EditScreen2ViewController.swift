//
//  EditScreen2ViewController.swift
//  Alysei
//
//  Created by namrata upadhyay on 10/10/21.
//

import UIKit

class EditScreen2ViewController: UIViewController  {

    @IBOutlet weak var editscreenTableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    
    var selectedIndexPath : IndexPath?
    var headerView = UIView()
    var dunamicButton  = UIButton()
    var statusLabel = UILabel()
    var statusLabel1 = UILabel()
    
    
    var editstepsModel: [StepsDataModel]? = []
    var editusedIngridientModel : [UsedIngridientDataModel]? = []
    var editusedToolModel: [UsedToolsDataModel]? = []
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.editscreenTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = 5
        editscreenTableView.dataSource = self
        editscreenTableView.delegate = self
        
        editscreenTableView.register(UINib(nibName: "EditRecipeIngridientTableViewCell", bundle: nil), forCellReuseIdentifier: "EditRecipeIngridientTableViewCell")
        editscreenTableView.register(UINib(nibName: "EditNumberOfStepsTableViewCell", bundle: nil), forCellReuseIdentifier: "EditNumberOfStepsTableViewCell")
        getRecipeDetail()
        
        self.editscreenTableView.reloadData()
        self.setHeaderView()
        // Do any additional setup after loading the view.
    }
    
    func setHeaderView(){
        
        headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: self.editscreenTableView.frame.width,
                                              height: 50))
        
        headerView.backgroundColor = .white
        dunamicButton  = UIButton(type: .custom)
        dunamicButton.layer.borderWidth = 1
        dunamicButton.layer.cornerRadius = 5
        dunamicButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor

        dunamicButton.titleLabel?.font = UIFont(name: "Helvetica Neue Bold", size: 16)
        
        dunamicButton.setTitleColor(UIColor.white, for: .normal)
        headerView.addSubview(dunamicButton)
        

    }
   
    @objc func addExtraIngridients(sender:AnyObject){
        let add = self.storyboard?.instantiateViewController(withIdentifier: "EditIngridientViewController") as! EditIngridientViewController
        self.navigationController?.pushViewController(add, animated: true)
    }
    
    @objc func addExtraTools(sender:AnyObject){
        let add = self.storyboard?.instantiateViewController(withIdentifier: "EditToolViewController") as! EditToolViewController
        self.navigationController?.pushViewController(add, animated: true)
    }
    
    @IBAction func saveEditRecipe(_ sender: Any) {
        let add = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverRecipeViewController") as! DiscoverRecipeViewController
        self.navigationController?.pushViewController(add, animated: true)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func editClickSteps(index: IndexPath) {
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "EditStepViewController") as! EditStepViewController
//        editVC.selectedIndex = index.row
//        editVC.page = (index.row + 1)
        
        self.navigationController?.pushViewController(editVC, animated: true)
    }
}

extension EditScreen2ViewController: UITableViewDelegate, UITableViewDataSource, EditRecipeIngredientTableViewCellProtocol, EditNumberOfStepsDelegateProtocol{
    
    func tapForDeleteIngridient(indexPath: IndexPath) {
        if indexPath.section == 0 {
            selectedIngridentsArray[indexPath.row].isSelected = false
            selectedIngridentsArray.remove(at: indexPath.row)
            
            
        } else if indexPath.section == 1 {
            selectedToolsArray[indexPath.row].isSelected = false
            selectedToolsArray.remove(at: indexPath.row)
           
        }
        else{
            return
        }
        editscreenTableView.beginUpdates()
        editscreenTableView.deleteRows(at: [indexPath], with: .left)
        self.editscreenTableView.reloadData()
        editscreenTableView.endUpdates()
    }
    
    func deleteClickSteps(index: IndexPath) {
        return
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return editusedIngridientModel?.count ?? 0
        }
        else if section == 1 {
            return editusedToolModel?.count ?? 0
        }
        else if section == 2 {
            return editstepsModel?.count ?? 0
        }
       return 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70 //CGFloat(70 * (arrlbl1.count))
    }

    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        
        switch (section) {
        case 0:
            if editusedIngridientModel?.count ?? 0 == 0{
            
                return 120
            }
            else{

                return 80
            }
        case 1:
            if editusedToolModel?.count ?? 0 == 0{
               
                return 120
            }
            else{
                
                return 80
            }
        case 2:
            return 80
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        
    
        switch (section) {
        
        
        case 0:
            setHeaderView()
            statusLabel.layer.borderWidth = 1
            statusLabel.layer.cornerRadius = 5
            statusLabel.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
            statusLabel.font = UIFont(name: "Helvetica Neue Regular", size: 14)
            statusLabel.textColor = UIColor.lightGray
            headerView.addSubview(statusLabel)
            statusLabel.text = "  No Ingridients Added yet!"
            dunamicButton.setTitle("  Add Ingredients to Recipe", for: UIControl.State.normal)
            dunamicButton.setImage(UIImage(named: "icons8Plus.png"), for: .normal)
            dunamicButton.addTarget(self, action: #selector(addExtraIngridients(sender:)), for: .touchUpInside)
            if editusedIngridientModel?.count == 0{
                statusLabel.isHidden = false
                statusLabel.frame = CGRect(x: 50, y: 58, width: (self.view.frame.size.width-100), height: 40)
                dunamicButton.frame = CGRect(x: 15, y: 10, width: (self.view.frame.size.width-30), height: 48)
               
            }
            else{
                statusLabel.isHidden = true
                statusLabel.frame = CGRect(x: 50, y: 58, width: (self.view.frame.size.width-100), height: 0)
                dunamicButton.frame = CGRect(x: 15, y: 10, width: (self.view.frame.size.width-30), height: 48)
               
            }
            
            
        case 1:
           setHeaderView()
            statusLabel1.layer.borderWidth = 1
            statusLabel1.layer.cornerRadius = 5
            statusLabel1.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
            statusLabel1.font = UIFont(name: "Helvetica Neue Regular", size: 14)
            statusLabel1.textColor = UIColor.lightGray
            headerView.addSubview(statusLabel1)
            statusLabel1.text = "  No Tools Added yet!"
            dunamicButton.setTitle("  Add Tools, Appliances & Utencils", for: UIControl.State.normal)
            dunamicButton.setImage(UIImage(named: "icons8Plus.png"), for: .normal)
            dunamicButton.addTarget(self, action: #selector(addExtraTools(sender:)), for: .touchUpInside)
            if editusedToolModel?.count == 0{
                statusLabel1.isHidden = false
                statusLabel1.frame = CGRect(x: 50, y: 58, width: (self.view.frame.size.width-100), height: 40)
                dunamicButton.frame = CGRect(x: 15, y: 10, width: (self.view.frame.size.width-30), height: 48)
               
            }
            else{
                statusLabel1.isHidden = true
                statusLabel1.frame = CGRect(x: 50, y: 58, width: (self.view.frame.size.width-100), height: 0)
                dunamicButton.frame = CGRect(x: 15, y: 10, width: (self.view.frame.size.width-30), height: 48)
               
            }
            
            
            
        case 2:

                setHeaderView()
//            statusLabel1.layer.borderWidth = 1
//            statusLabel1.layer.cornerRadius = 5
//            statusLabel1.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
//            statusLabel1.font = UIFont(name: "Helvetica Neue Regular", size: 14)
//            statusLabel1.textColor = UIColor.lightGray
//            headerView.addSubview(statusLabel1)
//            statusLabel1.text = "  No Step Added yet!"
                dunamicButton.setTitle("  All Recipe Steps", for: UIControl.State.normal)
            dunamicButton.frame = CGRect(x: 15, y: 10, width: (self.view.frame.size.width-30), height: 48)

        default:
            break
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        var cell = tableView.dequeueReusableCell(withIdentifier: "EditRecipeIngridientTableViewCell") as! EditRecipeIngridientTableViewCell
        var cell2 = tableView.dequeueReusableCell(withIdentifier: "EditNumberOfStepsTableViewCell") as! EditNumberOfStepsTableViewCell
        
        switch indexPath.section    {
    
        case 0:
           let cell = tableView.dequeueReusableCell(withIdentifier: "EditRecipeIngridientTableViewCell") as! EditRecipeIngridientTableViewCell
           
            cell.indexPath = indexPath
            cell.deleteIngridientDelegate = self
//            if selectedIngridentsArray.count > indexPath.row {
//                strIngridientId = selectedIngridentsArray[indexPath.row].recipeIngredientIds ?? 0
//                finalUnitIngridirnt = selectedIngridentsArray[indexPath.row].unit ?? ""
//                finalquantityIngridirnt = selectedIngridentsArray[indexPath.row].quantity ?? 0
                cell.IngredientsNameLbl.text = editusedIngridientModel?[indexPath.row].ingridient?.ingridientTitle
//                strIngridientQuantity = selectedIngridentsArray[indexPath.row].pickerData ?? ""
                cell.IngredientsValueLbl.text = (editusedIngridientModel?[indexPath.row].quantity ?? "") + " " + (editusedIngridientModel?[indexPath.row].unit ?? "")
                let imgUrl = (kImageBaseUrl + (editusedIngridientModel?[indexPath.row].ingridient?.imageId?.imgUrl ?? ""))
                cell.img.setImage(withString: imgUrl)
                cell.indexPath = indexPath
                cell.IngredientsValueLbl.isHidden = false
                return cell
//            }
        case 1:
           let cell1 = tableView.dequeueReusableCell(withIdentifier: "EditRecipeIngridientTableViewCell") as! EditRecipeIngridientTableViewCell
            cell1.indexPath = indexPath
            cell1.deleteIngridientDelegate = self
//            strToolId = selectedToolsArray[indexPath.row].recipeToolIds ?? 0
            
            cell1.IngredientsNameLbl.text = editusedToolModel?[indexPath.row].tool?.toolTitle

            cell1.IngredientsValueLbl.isHidden = true

            let imgUrl = (kImageBaseUrl + (editusedToolModel?[indexPath.row].tool?.imageId?.imgUrl ?? ""))
            cell1.img.setImage(withString: imgUrl)
            cell1.indexPath = indexPath
            
            return cell1

        case 2:
            cell2 = tableView.dequeueReusableCell(withIdentifier: "EditNumberOfStepsTableViewCell") as! EditNumberOfStepsTableViewCell
            strTitle = editstepsModel?[indexPath.row].title
            strDescription = editstepsModel?[indexPath.row].description
//            ingridientArray = arrayStepFinalData[indexPath.row].ingridentsArray?[indexPath.row] ?? 0
//            toolArray = arrayStepFinalData[indexPath.row].toolsArray?[indexPath.row] ?? 0
            cell2.titleLabel.text = strTitle
            cell2.stepTitle.text = "Step \(indexPath.row + 1)"
            cell2.numberOfStepsDelegateProtocol = self
            cell2.indexPath = indexPath
            return cell2
            
            
        default:
            break
            
        }
        return cell2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}

extension EditScreen2ViewController{
    
    func getRecipeDetail(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getRecipeDeatail + "\(editRecipeId)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
//            if let data = dictResponse?["recipe"] as? [String:Any]{
//                recipeModel = ViewRecipeDetailDataModel.init(with: data)
//
//            }
            if let data = dictResponse?["used_ingredients"] as? [[String:Any]]{
                editusedIngridientModel = data.map({UsedIngridientDataModel.init(with: $0)})
               
            }
            if let data = dictResponse?["used_tools"] as? [[String:Any]]{
                editusedToolModel = data.map({UsedToolsDataModel.init(with: $0)})
               
            }
            if let data = dictResponse?["steps"] as? [[String:Any]]{
                editstepsModel = data.map({StepsDataModel.init(with: $0)})
               
            }
//            if let data = dictResponse?["you_might_also_like"] as? [[String:Any]]{
//                youMightAlsoLikeModel = data.map({ViewRecipeDetailDataModel.init(with: $0)})
//
//            }
           
            self.editscreenTableView.reloadData()
            
        }
    }
    
    func postRequestToSaveEditRecipe(){
        
        let imageId = createRecipeJson["recipeImage"] as? String
        let name = createRecipeJson["name"]
        let mealId = createRecipeJson["mealId"]
        let courseId = createRecipeJson["courseId"]
        let cousinId = createRecipeJson["cusineId"]
        let regionId = createRecipeJson["regionId"]
        let dietId = createRecipeJson["dietId"]
        let foodIntoleranceId = createRecipeJson["foodIntoleranceId"]
        let cookingSkillId = createRecipeJson["cookingSkillId"]
        let hour = createRecipeJson["hour"]
        let minute = createRecipeJson["minute"]
        let serving = createRecipeJson["serving"]
       
        let params: [String:Any] = [APIConstants.kImageId: imageId!, APIConstants.kName: name!, APIConstants.kMealId: mealId!, APIConstants.kCourseId: courseId!, APIConstants.kHours: hour!, APIConstants.kminutes: minute!, APIConstants.kServing: serving!, APIConstants.kCousinId: cousinId!, APIConstants.kRegionId: regionId!, APIConstants.kDietId: dietId!, APIConstants.kIntoleranceId: foodIntoleranceId ?? 0, APIConstants.kCookingSkillId: cookingSkillId!,APIConstants.kSavedIngridient: [[APIConstants.kIngridientId: strIngridientId, APIConstants.kQuantity: finalquantityIngridirnt!, APIConstants.kUnit: finalUnitIngridirnt!]],APIConstants.kSavedTools: [[APIConstants.kToolId: strToolId]], APIConstants.kRecipeStep: [[APIConstants.kTitle: strTitle ?? "", APIConstants.kDescription: strDescription!, APIConstants.kIngridients: [ingridientArray], APIConstants.kTools: [toolArray]]]]

        let paramsMain: [String: Any] = ["params": params]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.saveRecipe, requestMethod: .POST, requestParameters: paramsMain, withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
             let resultNew = dictResponse as? [String:Any]
            if let message = resultNew?["message"] as? String{
                self.showAlert(withMessage: message)
            }
            
        }
    }

    
}
