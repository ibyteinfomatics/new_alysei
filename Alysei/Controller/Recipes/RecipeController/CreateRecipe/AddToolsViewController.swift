//
//  AddToolsViewController.swift
//  Alysei Recipe Module
//
//  Created by mac on 30/07/21.
//

import UIKit


var selectedToolsArray : [ToolsArray] = []
var arraySelectedItemTools: [IndexPath] = []

class AddToolsViewController: AlysieBaseViewC, AddToolTableViewCellProtocol {
    @IBOutlet weak var addToolsView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var saveAndProceedTabBar: UIView!
    @IBOutlet weak var addMissingToolButton: UIButton!
    @IBOutlet weak var addToolsTableView: UITableView!
    @IBOutlet weak var addMissingToolView: UIView!
    @IBOutlet weak var searchToolTextField: UITextField!
    @IBOutlet weak var addToolPopUpView: UIView!
    
    @IBOutlet weak var addToolQuantityView: UIView!
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var addToolUnitView: UIView!
    
    @IBOutlet weak var unitLabel: UILabel!
    
    @IBOutlet weak var addMissingToolTableView: UITableView!
    @IBOutlet weak var addedToolQuantityLabel: UILabel!
    @IBOutlet weak var addedToolItemButton: UIButton!
    
    @IBOutlet weak var addNewMissingToolBtn: UIButton!
    @IBOutlet weak var addMissingToolPopUpHeight: NSLayoutConstraint!
    var newSearchModel: [AddToolsDataModel]? = []
    var toolSearchModel: [ToolsArray] = []
    var addMissingToolModel: [ToolTypeDataModel]? = []
    
    var array1 = NSMutableArray()
    var array2 = NSMutableArray()
    
    var toolBar = UIToolbar()
    var picker1  = UIPickerView()
    var strReturn = String()
    var strReturn1 = Int()
    var arrQuantity = NSMutableArray()
    var arrUnit = NSMutableArray()
    var searchText = String()
    var arrayPickerData: [String] = []
    var selectedIndexPath : IndexPath?
    var selectedIndexPath1: IndexPath?
    
    var strToolQuantity = Int()
    var strToolId = Int()
    var strToolUnit = String()
    var searching = false
    var quantity: Int?
    var unit: String?
    var singleIngridientData: ToolsArray?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addToolsTableView.reloadData()
        self.addedToolQuantityLabel.text = "\(selectedToolsArray.count) Items"
        if self.addedToolQuantityLabel.text == "0 Items"{
            self.saveButton.layer.backgroundColor = UIColor.lightGray.cgColor
        }
        else{
            self.saveButton.layer.backgroundColor =
                UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha:1).cgColor
        }
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        picker1.delegate = self
        picker1.dataSource = self
        searchToolTextField.delegate = self
        arrQuantity = [2, 4, 6, 8, 10, 12, 14]
        arrUnit = ["kg","litre", "pieces", "dozen", "gm", "meter"]
        self.addNewMissingToolBtn.isHidden = true
        setUI()
        setupUI()
        callAddTools()
        callListTools()
        
        self.addMissingToolView.isHidden = true
        self.addToolPopUpView.isHidden = true
        self.setupUI()
        self.addToolsTableView.delegate = self
        self.addToolsTableView.dataSource = self
        
        self.addMissingToolTableView.delegate = self
        self.addMissingToolTableView.dataSource = self
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        addToolsView.drawBottomShadow()
    }
    func setUI(){
        
        addToolsTableView.delegate = self
        addToolsTableView.dataSource = self
        addToolsView.layer.masksToBounds = false
        addToolsView.layer.shadowRadius = 2
        addToolsView.layer.shadowOpacity = 0.2
        addToolsView.layer.shadowColor = UIColor.lightGray.cgColor
        addToolsView.layer.shadowOffset = CGSize(width: 0 , height:2)
        searchView.layer.cornerRadius = 5
        saveButton.layer.cornerRadius = 5
        saveAndProceedTabBar.layer.masksToBounds = false
        saveAndProceedTabBar.layer.shadowRadius = 2
        saveAndProceedTabBar.layer.shadowOpacity = 0.8
        saveAndProceedTabBar.layer.shadowColor = UIColor.gray.cgColor
        saveAndProceedTabBar.layer.shadowOffset = CGSize(width: 0 , height:2)
    }
    
    func setupUI(){
        addToolQuantityView.layer.borderWidth = 1
        addToolQuantityView.layer.borderColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1).cgColor
        addToolQuantityView.layer.cornerRadius = 5
        addToolUnitView.layer.borderWidth = 1
        addToolUnitView.layer.borderColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1).cgColor
        addToolUnitView.layer.cornerRadius = 5
        addedToolItemButton.layer.borderWidth = 1
        addedToolItemButton.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
        addedToolItemButton.layer.cornerRadius = 5
        addedToolQuantityLabel.text = "0 Items"
        
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
            let row = picker1.selectedRow(inComponent: 0);
            if let stId1 = self.arrQuantity[row] as? Int
            {
                self.strReturn1 = stId1
                self.quantityLabel.text = String(self.strReturn1)
            }
            
            toolBar.removeFromSuperview()
            picker1.removeFromSuperview()
        case 2:
            let row = picker1.selectedRow(inComponent: 0);
            if let stId1 = self.arrUnit[row] as? String
            {
                self.strReturn = stId1
                self.unitLabel.text = self.strReturn
            }
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
    @IBAction func addMissingToolButton(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected == false
        {
            self.addMissingToolButton.setImage(UIImage.init(named: "MENU"), for: .normal)
            self.addMissingToolView.isHidden = true
        }
        else
        {
            self.addMissingToolButton.setImage(UIImage.init(named: "5"), for: .normal)
            self.addMissingToolView.isHidden = false
            
        }
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        if addedToolQuantityLabel.text != "0 Items" {
            let addSteps = self.storyboard?.instantiateViewController(withIdentifier: "AddStepsViewController") as! AddStepsViewController
            if  arrayStepFinalData.count == 0 {
            var ingridentsArray : [IngridentArray] = []
            for item in selectedIngridentsArray{
                let ingridients: IngridentArray = IngridentArray.init()
                ingridients.recipeIngredientIds = item.recipeIngredientIds
                ingridients.ingridientTitle = item.ingridientTitle
                ingridients.imageId = item.imageId
                ingridients.parent = item.parent
                ingridients.pickerData = item.pickerData
                ingridients.quantity = item.quantity
                ingridients.unit = item.unit
                ingridients.createdAt = item.createdAt
                ingridients.updatedAt = item.updatedAt
                ingridients.isSelected = false
                ingridentsArray.append(ingridients)
            }
            
            var toolsArray : [ToolsArray] = []
            for item in selectedToolsArray{
                let tools: ToolsArray = ToolsArray.init()
                tools.recipeToolIds = item.recipeToolIds
                tools.toolTitle = item.toolTitle
                tools.imageId = item.imageId
                tools.parent = item.parent
                tools.pickerData = item.pickerData
                tools.quantity = item.quantity
                tools.unit = item.unit
                tools.isSelected = false
                toolsArray.append(tools)
            }
            addSteps.arrayIngridients = ingridentsArray
            addSteps.arraytools = toolsArray
            addSteps.page = 1
            }
            else{
               addSteps.page = 1
               addSteps.selectedIndex = 0
            }
            fromVC = "AddToolsViewController"
            self.navigationController?.pushViewController(addSteps, animated: true)
        }
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        let cancelPopUpVC = self.storyboard?.instantiateViewController(withIdentifier: "CancelPopUpViewController") as! CancelPopUpViewController
        
        cancelPopUpVC.modalPresentationStyle = .overFullScreen
        cancelPopUpVC.modalTransitionStyle = .crossDissolve
        cancelPopUpVC.Callback = {
            let cancelPopVC = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverRecipeViewController") as! DiscoverRecipeViewController
            cancelPopVC.checkbutton = 2
            cancelPopVC.currentIndex = 2
            self.navigationController?.pushViewController(cancelPopVC, animated: true)
            
        }
        self.present(cancelPopUpVC, animated: true)
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        if searching == true{
            self.searching = false
            self.searchToolTextField.text = ""
            addToolsTableView.reloadData()
            self.addMissingToolButton.isHidden = false
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
       
    }
    
    @IBAction func tapForaddMyMissingTool(_ sender: Any) {
        
        let addmissIngridient = self.storyboard?.instantiateViewController(withIdentifier: "AddMissingToolViewController") as! AddMissingToolViewController
        self.addMissingToolView.isHidden = true
        self.addMissingToolButton.setImage(UIImage.init(named: "MENU"), for: .normal)
        self.addMissingToolButton.isSelected = false
        self.navigationController?.pushViewController(addmissIngridient, animated: true)
        
    }
    
    @IBAction func tapForClosePopUp(_ sender: Any) {
        self.addToolPopUpView.isHidden = true
    }
    
    
    @IBAction func tapForAddToolQuantiy(_ sender: Any) {
        
        picker1.tag = 1
        picker1.reloadAllComponents()
        setPickerToolbar()
    }
    @IBAction func tapForAddToolUnit(_ sender: Any) {
        picker1.tag = 2
        picker1.reloadAllComponents()
        setPickerToolbar()
    }
    
    @IBAction func tapForSaveTool(_ sender: UIButton) {
        //        if self.quantityLabel.text == "0" || self.unitLabel.text == "Unit"{
        //            self.addToolPopUpView.isHidden = false
        //            self.saveButton.layer.backgroundColor = UIColor.lightGray.cgColor
        //        }
        //        else{
        //            self.addToolPopUpView.isHidden = true
        //
        //
        //            let quantity = self.strReturn1
        //            let unit = self.strReturn
        //            let pickerData = String(quantity) + " " + unit
        //            arrayPickerData.append(pickerData)
        //            arraySelectedItemTools.append(selectedIndexPath ?? IndexPath(row: sender.tag, section: 0))
        //            self.addedToolQuantityLabel.text = "\(arraySelectedItemTools.count) Items"
        //            addToolsTableView.reloadData()
        //            self.saveButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha:1).cgColor
        //
        //            selectedToolsArray.removeAll()
        //            for (indexPath,item) in arraySelectedItemTools.enumerated(){
        //
        //                let valueIngridients: ToolsArray = (self.newSearchModel?[item.section].tools?[item.row]) as! ToolsArray
        //                print(valueIngridients)
        //                valueIngridients.pickerData = arrayPickerData[indexPath]
        //                valueIngridients.quantity = quantity
        //                valueIngridients.unit = unit
        //                selectedToolsArray.append(valueIngridients)
        //            }
        //        }
        
    }
    @IBAction func tapForShowAddedTools(_ sender: Any) {
        let recipeIngredients = self.storyboard?.instantiateViewController(withIdentifier: "RecipeIngredientsUseViewController") as! RecipeIngredientsUseViewController
        
        self.navigationController?.pushViewController(recipeIngredients, animated: true)
    }
}

extension AddToolsViewController: UITableViewDelegate
                                  , UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == addToolsTableView{
            if searching == true{
                return 1
            }
            else{
            return self.newSearchModel?.count ?? 0
            }
        }
        if tableView == addMissingToolTableView{
            return 1
        }
        else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == addToolsTableView{
            if searching == true{
                return self.toolSearchModel.count
            }
            else{
            return newSearchModel?[section].tools?.count ?? 0
            }
        }
        if tableView == addMissingToolTableView{
            if self.addMissingToolModel?.count == 1{
                addMissingToolPopUpHeight.constant = 100
            }
            else if self.addMissingToolModel?.count == 2{
                addMissingToolPopUpHeight.constant = 140
            }
            else if self.addMissingToolModel?.count == 3{
                addMissingToolPopUpHeight.constant = 180
            }
            else if self.addMissingToolModel?.count == 4{
                addMissingToolPopUpHeight.constant = 220
            }
            else if self.addMissingToolModel?.count == 5{
                addMissingToolPopUpHeight.constant = 260
            }
            else if self.addMissingToolModel?.count == 6{
                addMissingToolPopUpHeight.constant = 320
            }
            else{
                addMissingToolPopUpHeight.constant = 437
            }
            return self.addMissingToolModel?.count ?? 0
        }
        else{
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == addToolsTableView{
            return 70
        }
        else{
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if tableView == addToolsTableView{
            if searching == true{
                return ""
            }
            else{
            return self.newSearchModel?[section].toolDataName
            }
        }
        else{
            return ""
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = UIColor.init(red: 236/255, green: 247/255, blue: 255/255, alpha:1)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == addToolsTableView{
            if searching == true{
                return 0
            }
            else{
            return 40
            }
        }
        else{
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == addToolsTableView{
            let cell:AddToolsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AddToolsTableViewCell") as! AddToolsTableViewCell
            
            cell.indexPath = indexPath
            cell.addToolDelegate = self
            if searching == true {
                cell.data = toolSearchModel[indexPath.row]
            }
            else{
            cell.data = newSearchModel?[indexPath.section].tools?[indexPath.row]
            }
            
            return cell
        }
        else{
            let cell:AddMissingToolsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AddMissingToolsTableViewCell") as! AddMissingToolsTableViewCell
            cell.toolitemLabel.text = self.addMissingToolModel?[indexPath.row].toolType
            
            cell.toolQuantityLabel.text = "\(self.addMissingToolModel?[indexPath.row].count ?? 0)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == addToolsTableView{
            return
        }
        else{
            self.addMissingToolButton.setImage(UIImage.init(named: "MENU"), for: .normal)
            self.addMissingToolButton.isSelected = false
            self.addMissingToolView.isHidden = true
            selectedIndexPath1 = indexPath
            
            let row = indexPath.row
            
            print("\(String(describing: selectedIndexPath1))")
            let indexPath = IndexPath(row: NSNotFound, section: row)
            addToolsTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            
            
        }
    }
    
    func removeDatainStep(data: ToolsArray){
        for item in arrayStepFinalData{
            
            if let index = item.toolsArray?.firstIndex(where: { $0.recipeToolIds == data.recipeToolIds }) {
                print("Found at \(index)")
                
                item.toolsArray?.remove(at: index)
            }
        }
        
    }
    
    func addDatainStep(data: ToolsArray){
        data.isSelected = false
        for item in arrayStepFinalData{
            item.toolsArray?.append(data)
        }
    }
    func tapForTool(indexPath: IndexPath, data: ToolsArray, checkStatus: Bool?){
        self.singleIngridientData = data
        if checkStatus == true{
            
            self.addToolPopUpView.isHidden = true
            if let index = selectedToolsArray.firstIndex(where: { $0.recipeToolIds == data.recipeToolIds }) {
                print("Found at \(index)")
                selectedToolsArray.remove(at: index)
                removeDatainStep(data: data)
            }
            self.addedToolQuantityLabel.text = "\(selectedToolsArray.count) Items"
            
            if  self.addedToolQuantityLabel.text == "0 Items"{
                self.saveButton.layer.backgroundColor = UIColor.lightGray.cgColor
                
            }
            self.addToolsTableView.reloadData()
            
        }
        else{
            
            self.addToolPopUpView.isHidden = true
            let data = ToolsArray()
            data.recipeToolIds = singleIngridientData?.recipeToolIds
            data.toolTitle = singleIngridientData?.toolTitle
            data.imageId = singleIngridientData?.imageId
            data.parent = singleIngridientData?.parent
            data.isSelected = true
            selectedToolsArray.append(data)
            addDatainStep(data: data)

            
            self.addedToolQuantityLabel.text = "\(selectedToolsArray.count) Items"
            self.saveButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha:1).cgColor
            self.addToolsTableView.reloadData()
            
        }
        
        
    }
    
}

extension AddToolsViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch picker1.tag {
        case 1:
            
            return self.arrQuantity.count
            
        case 2:
            
            return self.arrUnit.count
            
            
        default:
            
            break
            
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var str_return : String = String ()
        
        switch picker1.tag {
        
        case 1:
            
            let stName = self.arrQuantity[row]
            
            str_return = "\(stName)"
            
            
        case 2:
            
            let stName = self.arrUnit[row]
            
            str_return = "\(stName)"
            
        default: break
            
        }
        return str_return
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch picker1.tag {
        
        case 1:
            
            strReturn1 = arrQuantity[row] as! Int
            
        case 2:
            
            strReturn = arrUnit[row] as! String
        default:
            break
        }
    }
}

extension AddToolsViewController{
    
    func callAddTools(){
        self.view.isUserInteractionEnabled = false
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getrecipeTools, requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            
            if let data = dictResponse?["data"] as? [[String:Any]]{
                self.newSearchModel = data.map({AddToolsDataModel.init(with: $0)})
                for i in (0..<(self.newSearchModel?.count ?? 0)){
                    for j in (0..<(self.newSearchModel?[i].tools?.count ?? 0))
                    {
                        self.toolSearchModel.append(self.newSearchModel?[i].tools?[j] ?? ToolsArray())
                    }
                }
                self.addToolsTableView.reloadData()
                self.view.isUserInteractionEnabled = true
                
            }
        }
    }
    
    func callSearchTools(){
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: "\(APIUrl.Recipes.searchTool)\(searchText)" , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
            switch statusCode{
            case 200:
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [[String:Any]]{
                self.toolSearchModel = data.map({ToolsArray.init(with: $0)})
                self.searching = true
            }
                
            case 409:
                self.newSearchModel = [AddToolsDataModel]()
                self.toolSearchModel = [ToolsArray]()
                self.showAlert(withMessage: "No Tools found")
            
            default:
              break
            }
            self.addToolsTableView.reloadData()
        }
   
    }
    
    func callListTools(){
        disableWindowInteraction()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getrecipeTools, requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["types"] as? [[String:Any]]{
                self.addMissingToolModel = data.map({ToolTypeDataModel.init(with: $0)})
                self.addMissingToolTableView.reloadData()
            }
        }
    }
}

extension AddToolsViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchToolTextField.becomeFirstResponder()
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        if let text = textField.text,
                   let textRange = Range(range, in: text) {
                   let updateText = text.replacingCharacters(in: textRange,
                                                               with: string)
        if updateText.count > 0 {
            self.searching = true
            searchText = updateText
            callSearchTools()
            self.addMissingToolButton.isHidden = true
            hideKeyboardWhenTappedAround()
         }
        else{
            self.searching = false
            addToolsTableView.reloadData()
            self.addMissingToolButton.isHidden = false
        }
      }
        return true
    }
}
extension UITableView {
    
    public func reloadData(_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion:{ _ in
            completion()
        })
    }
    
    func scroll(to: scrollsTo, animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            switch to{
            case .top:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.scrollToRow(at: indexPath, at: .top, animated: animated)
                }
                break
            case .bottom:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                    self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }
                break
            }
        }
    }
    
    enum scrollsTo {
        case top,bottom
    }
}
