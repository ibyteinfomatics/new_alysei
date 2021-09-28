//
//  RecipeIngredientsUseViewController.swift
//  Alysei Recipe Module
//
//  Created by mac on 06/08/21.
//

import UIKit

var strIngridientQuantity = String()
var strIngridientId = Int()
var finalUnitIngridirnt: String?
var finalquantityIngridirnt: Int?

var strToolQuantity = String()
var strToolId = Int()
var finalquantityTool: Int?
var finalUnitTool: String?

var strTitle : String?
var strDescription : String?
var ingridientArray:Int? = 0
var toolArray : Int? = 0

class RecipeIngredientsUseViewController: AlysieBaseViewC,UITableViewDelegate,UITableViewDataSource, RecipeIngredientsUsedTableViewCellProtocol, NumberOfStepsDelegateProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    //    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var addEditPopUpView: UIView!
    
    @IBOutlet weak var addEditQuantityView: UIView!
    @IBOutlet weak var editquantityTextField: UITextField!
    
    @IBOutlet weak var addEditUnitView: UIView!
    
    @IBOutlet weak var editunitLabel: UILabel!
    @IBOutlet weak var btnEditSave: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    var header = ["Ingredients","Utencils,Appliances & Tools","Recipe Steps"]

    var toolBar = UIToolbar()
    var picker1  = UIPickerView()
    var strReturn = String()
    var strReturn1 = Int()
    var arrQuantity = NSMutableArray()
    var arrUnit = NSMutableArray()
    var selectedIndexPath : IndexPath?
    var footerView = UIView()
    var dunamicButton  = UIButton()
    var statusLabel = UILabel()
    var statusLabel1 = UILabel()
    

    @IBOutlet weak var headerLabelLeading: NSLayoutConstraint!
    
    @IBOutlet weak var backButtonWidth: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.addEditPopUpView.isHidden = true
        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
        
        picker1.delegate = self
        picker1.dataSource = self
        
        arrQuantity = [2, 4, 6, 8, 10, 12, 14]
         arrUnit = ["kg","litre", "pieces", "dozen", "gm", "meter"]
       
        
        if arrayStepFinalData.count == 0 {
            self.btnBack.isHidden = false
        }
        else{
            self.btnBack.isHidden = true
            self.headerLabelLeading.constant = 0
            self.backButtonWidth.constant = 0
        }
         
        
        tableView.register(UINib(nibName: "RecipeIngredientsUsedTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeIngredientsUsedTableViewCell")
        tableView.register(UINib(nibName: "NumberofStepsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell1")
        
        //self.heightTableView.constant = CGFloat(70 * (arrlbl1[0][1].count))
        self.tableView.reloadData()
        self.setFooterView()
       
    }
    
    func setupUI(){
        addEditQuantityView.layer.borderWidth = 1
        addEditQuantityView.layer.borderColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1).cgColor
        addEditQuantityView.layer.cornerRadius = 5
        addEditUnitView.layer.borderWidth = 1
        addEditUnitView.layer.borderColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1).cgColor
        addEditUnitView.layer.cornerRadius = 5
        saveButton.layer.cornerRadius = 5
        btnEditSave.layer.cornerRadius = 5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    func setFooterView(){
        
        footerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: self.tableView.frame.width,
                                              height: 50))
        
        footerView.backgroundColor = .white
        dunamicButton  = UIButton(type: .custom)
        dunamicButton.layer.borderWidth = 1
        dunamicButton.layer.cornerRadius = 5
        dunamicButton.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
//        dunamicButton.frame = CGRect(x: 15, y: 60, width: (self.view.frame.size.width-30), height: 48)
        dunamicButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 16)
        dunamicButton.setImage(UIImage(named: "Group 1127.png"), for: .normal)
        dunamicButton.setTitleColor(UIColor.black, for: .normal)
        footerView.addSubview(dunamicButton)
        
//        statusLabel.layer.borderWidth = 1
//        statusLabel.layer.cornerRadius = 5
//        statusLabel.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
//        statusLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
//        statusLabel.textColor = UIColor.lightGray
//        footerView.addSubview(statusLabel)
        
//        statusLabel1.layer.borderWidth = 1
//        statusLabel1.layer.cornerRadius = 5
//        statusLabel1.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
//        statusLabel1.font = UIFont(name: "Montserrat-Regular", size: 14)
//        statusLabel1.textColor = UIColor.lightGray
//        footerView.addSubview(statusLabel1)
    }
    func setPickerToolbar(){
        
        picker1.backgroundColor = UIColor.white
        picker1.setValue(UIColor.black, forKey: "textColor")
        picker1.autoresizingMask = .flexibleWidth
        picker1.contentMode = .center
        picker1.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker1)
        picker1.reloadAllComponents()

        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 40))
        toolBar.barTintColor = AppColors.mediumBlue.color
        toolBar.tintColor = UIColor.white
        toolBar.sizeToFit()
        
       
    
       let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(onDoneButtonTapped))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    
       let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(onCancelButtonTapped))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)

        self.view.addSubview(toolBar)
        
            }
    
    @objc func onDoneButtonTapped() {
        
        switch picker1.tag {

        case 1:
            if let stId1 = self.arrUnit[0] as? String
            {
                self.strReturn = stId1
            }
            self.editunitLabel.text = String(self.strReturn)
            toolBar.removeFromSuperview()
            picker1.removeFromSuperview()
        default:
            break
        }
       
    }
    
    @objc func onCancelButtonTapped() {
        
        toolBar.removeFromSuperview()
        picker1.removeFromSuperview()

       }
    
    
    @objc func addExtraIngridients(sender:AnyObject){
//        var isVcPresent = false
        for controller in (self.navigationController?.viewControllers ?? []) as Array {
                    if controller.isKind(of: AddIngredientsViewController.self) {
                        self.navigationController?.popToViewController(controller, animated: true)
                        break
                    }
                }
//        if !isVcPresent{
//            pushViewController(withName: AddIngredientsViewController.id(), fromStoryboard: StoryBoardConstants.kRecipesSelection)
//        }

        
    }
    
    @objc func addExtraTools(sender:AnyObject){
        var isVcPresent = false
        for controller in (self.navigationController?.viewControllers ?? []) as Array {
            if controller.isKind(of: AddToolsViewController.self) {
                isVcPresent = true
                self.navigationController?.popToViewController(controller, animated: true)
                break
            }
        }
        if !isVcPresent{
            pushViewController(withName: AddToolsViewController.id(), fromStoryboard: StoryBoardConstants.kRecipesSelection)
        }
    }
    
    @objc func addExtraRecipeSteps(sender:AnyObject){

        var isVcPresent = false
        for controller in (self.navigationController?.viewControllers ?? []) as Array {
            if controller.isKind(of: AddStepsViewController.self) {
                isVcPresent = true
                self.navigationController?.popToViewController(controller, animated: true)
                break
            }
        }
        if !isVcPresent{
            let addSteps = self.storyboard?.instantiateViewController(withIdentifier: "AddStepsViewController") as! AddStepsViewController
            addSteps.arrayIngridients = selectedIngridentsArray
            addSteps.arraytools = selectedToolsArray
            addSteps.page = 1
            self.navigationController?.pushViewController(addSteps, animated: true)
        }

        
    }
    
    @IBAction func tapForBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func tapForEditUnit(_ sender: Any) {
        picker1.tag = 1
        picker1.reloadAllComponents()
        setPickerToolbar()
    }
    
    @IBAction func tapForCloseEdit(_ sender: Any) {
        self.addEditPopUpView.isHidden = true
        
    }
    @IBAction func tapForSaveEditQuantity(_ sender: Any) {
        
        if self.editquantityTextField.text == "0" || self.editquantityTextField.text == ""{
            showAlert(withMessage: AlertMessage.kenterQuantity)
            self.addEditPopUpView.isHidden = false
            self.saveButton.layer.backgroundColor = UIColor.lightGray.cgColor
        }
        else if self.editunitLabel.text == "Unit"{
            showAlert(withMessage: AlertMessage.kselectUnit)
            self.addEditPopUpView.isHidden = false
            self.saveButton.layer.backgroundColor = UIColor.lightGray.cgColor
        }
        else{
            self.addEditPopUpView.isHidden = true
            let cell = tableView.cellForRow(at: selectedIndexPath!) as! RecipeIngredientsUsedTableViewCell
            let quantity = self.editquantityTextField.text
            cell.IngredientsValueLbl.text = ((quantity ?? "") + " " + self.strReturn)
            self.saveButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha:1).cgColor
        }
    }
    
    @IBAction func tapForSaveRecipe(_ sender: Any) {
        
        if selectedIngridentsArray.count == 0 {
            showAlert(withMessage: AlertMessage.kSelectIngridient)
        }
        else if selectedToolsArray.count == 0{
            showAlert(withMessage: AlertMessage.kSelectTool)
        }
        else{
            postRequestToSaveRecipe()
            selectedIngridentsArray.removeAll()
            selectedToolsArray.removeAll()
            let discoverRecipeVC = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverRecipeViewController") as! DiscoverRecipeViewController
            discoverRecipeVC.currentIndex = 2
            discoverRecipeVC.checkbutton = 2
            self.navigationController?.pushViewController(discoverRecipeVC, animated: true)
        }
       
    }
    
    func tapForEditIngridient(indexPath: IndexPath){

            selectedIndexPath = indexPath
        self.addEditPopUpView.isHidden = false

       }
        
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
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .left)
        self.tableView.reloadData()
        tableView.endUpdates()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.header.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return selectedIngridentsArray.count
        }
        else if section == 1 {
            return selectedToolsArray.count
        }
        else if section == 2 {
            return arrayStepFinalData.count
        }
       return 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70 //CGFloat(70 * (arrlbl1.count))
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        return header[section]
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = UIColor.init(red: 236/255, green: 247/255, blue: 255/255, alpha:1)
//            headerView.backgroundView?.backgroundColor = .black
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tableView{
        return 40
        }
        else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {
        
        switch (section) {
        case 0:
            if selectedIngridentsArray.count == 0{
            
                return 120
            }
            else{

                return 80
            }
        case 1:
            if selectedToolsArray.count == 0{
               
                return 120
            }
            else{
                
                return 80
            }
            
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {
        
    
        switch (section) {
        
        
        case 0:
            setFooterView()
            statusLabel.layer.borderWidth = 1
            statusLabel.layer.cornerRadius = 5
            statusLabel.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
            statusLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
            statusLabel.textColor = UIColor.lightGray
            footerView.addSubview(statusLabel)
            statusLabel.text = "  No Ingridients Added yet!"
            dunamicButton.setTitle("  Add Ingredients in Recipe", for: UIControl.State.normal)
            dunamicButton.addTarget(self, action: #selector(addExtraIngridients(sender:)), for: .touchUpInside)
            if selectedIngridentsArray.count == 0{
                statusLabel.isHidden = false
                statusLabel.frame = CGRect(x: 50, y: 10, width: (self.view.frame.size.width-100), height: 40)
                dunamicButton.frame = CGRect(x: 15, y: 60, width: (self.view.frame.size.width-30), height: 48)
               
            }
            else{
                statusLabel.isHidden = true
                statusLabel.frame = CGRect(x: 50, y: 0, width: (self.view.frame.size.width-100), height: 0)
                dunamicButton.frame = CGRect(x: 15, y: 10, width: (self.view.frame.size.width-30), height: 48)
               
            }
            
            
        case 1:
            setFooterView()
            statusLabel1.layer.borderWidth = 1
            statusLabel1.layer.cornerRadius = 5
            statusLabel1.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
            statusLabel1.font = UIFont(name: "Montserrat-Regular", size: 14)
            statusLabel1.textColor = UIColor.lightGray
            footerView.addSubview(statusLabel1)
            statusLabel1.text = "  No Tools Added yet!"
            dunamicButton.setTitle("  Add Tools in Recipe", for: UIControl.State.normal)
            dunamicButton.addTarget(self, action: #selector(addExtraTools(sender:)), for: .touchUpInside)
            if selectedToolsArray.count == 0{
                statusLabel1.isHidden = false
                statusLabel1.frame = CGRect(x: 50, y: 10, width: (self.view.frame.size.width-100), height: 40)
                dunamicButton.frame = CGRect(x: 15, y: 60, width: (self.view.frame.size.width-30), height: 48)
               
            }
            else{
                statusLabel1.isHidden = true
                statusLabel1.frame = CGRect(x: 50, y: 0, width: (self.view.frame.size.width-100), height: 0)
                dunamicButton.frame = CGRect(x: 15, y: 20, width: (self.view.frame.size.width-30), height: 48)
               
            }
            
            
            
        case 2:
//            if arrayStepFinalData.count == 0{
//                setFooterView()
//                dunamicButton.setTitle("  Add Steps in Recipe", for: UIControl.State.normal)
//                dunamicButton.addTarget(self, action: #selector(addExtraRecipeSteps(sender:)), for: .touchUpInside)
//            }
//            else{
                setFooterView()
                footerView.isHidden = true
//             }
            
        default:
            break
        }
        return footerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "RecipeIngredientsUsedTableViewCell") as! RecipeIngredientsUsedTableViewCell
        var cell2 = tableView.dequeueReusableCell(withIdentifier: "cell1") as! NumberofStepsTableViewCell
        
        switch indexPath.section    {
    
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "RecipeIngredientsUsedTableViewCell") as! RecipeIngredientsUsedTableViewCell
           
            cell.indexPath = indexPath
            cell.editIngridientDelegate = self
            cell.deleteIngridientDelegate = self
            if selectedIngridentsArray.count > indexPath.row {
                strIngridientId = selectedIngridentsArray[indexPath.row].recipeIngredientIds ?? 0
                finalUnitIngridirnt = selectedIngridentsArray[indexPath.row].unit ?? ""
                finalquantityIngridirnt = selectedIngridentsArray[indexPath.row].quantity ?? 0
                cell.IngredientsNameLbl.text = selectedIngridentsArray[indexPath.row].ingridientTitle
                strIngridientQuantity = selectedIngridentsArray[indexPath.row].pickerData ?? ""
                cell.IngredientsValueLbl.text = strIngridientQuantity
                let imgUrl = (kImageBaseUrl + (selectedIngridentsArray[indexPath.row].imageId?.imgUrl ?? ""))
                cell.img.setImage(withString: imgUrl)
                cell.indexPath = indexPath
                cell.editBtn.isHidden = false
                cell.IngredientsValueLbl.isHidden = false
                return cell
            }
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "RecipeIngredientsUsedTableViewCell") as! RecipeIngredientsUsedTableViewCell
            cell.indexPath = indexPath
            cell.editIngridientDelegate = self
            cell.deleteIngridientDelegate = self
            strToolId = selectedToolsArray[indexPath.row].recipeToolIds ?? 0
            finalUnitTool = selectedToolsArray[indexPath.row].unit ?? ""
            finalquantityTool = selectedToolsArray[indexPath.row].quantity ?? 0
            cell.IngredientsNameLbl.text = selectedToolsArray[indexPath.row].toolTitle
//            strToolQuantity = selectedToolsArray[indexPath.row].pickerData ?? ""
            cell.editBtn.isHidden = true
            cell.IngredientsValueLbl.isHidden = true
//            cell.IngredientsValueLbl.text = strToolQuantity
           
            let imgUrl = (kImageBaseUrl + (selectedToolsArray[indexPath.row].imageId?.imgUrl ?? ""))
            cell.img.setImage(withString: imgUrl)
            cell.indexPath = indexPath
            return cell

        case 2:
            cell2 = tableView.dequeueReusableCell(withIdentifier: "cell1") as! NumberofStepsTableViewCell
            strTitle = arrayStepFinalData[indexPath.row].title ?? ""
            strDescription = arrayStepFinalData[indexPath.row].description
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
    
    func editClickSteps(index: IndexPath) {
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "AddStepsViewController") as! AddStepsViewController
        editVC.selectedIndex = index.row
        editVC.page = (index.row + 1)
        
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
//    func deleteClickSteps(index: IndexPath){
//
//    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension RecipeIngredientsUseViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch picker1.tag {
//        case 1:
//
//            return self.arrQuantity.count

        case 1:

        return self.arrUnit.count
            

        default:

        break

        }
     return 0
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var str_return : String = String ()
    
        switch picker1.tag {
        
//        case 1:

//             let stName = self.arrQuantity[row]
//
//            str_return = "\(stName)"
         

        case 1:

            let stName = self.arrUnit[row]
        
             str_return = "\(stName)"


        default: break

        }
      return str_return
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        var strSelectedId = String()
        switch picker1.tag {
        
//        case 1:
//
//            strReturn1 = arrQuantity[row] as! Int

        case 1:
            
            strReturn = arrUnit[row] as! String

        default:
            break
        }
    }
}
extension RecipeIngredientsUseViewController{
    
    func postRequestToSaveRecipe(){
        
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
            if let message = resultNew!["message"] as? String{
                self.showAlert(withMessage: message)
            }
            
           
//                let controller = self.pushViewController(withName: DiscoverRecipeViewController.id(), fromStoryboard: StoryBoardConstants.kRecipesSelection) as? DiscoverRecipeViewController
          
          
//                controller?..reloadData()
//                controller?.storeName = self.txtStoreName.text
//                controller?.marketPlaceStoreId = self.marketPlaceId
        }
    }

    
}
