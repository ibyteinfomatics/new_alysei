//
//  EditIngridientViewController.swift
//  Alysei
//
//  Created by namrata upadhyay on 10/10/21.
//

import UIKit
var selectedEditIngridentsArray: [IngridentArray] = []
class EditIngridientViewController: UIViewController, EditIngridientsTableViewCellProtocol, AddIngridientsTableViewCellProtocol {
   
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var addIngredientsView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var saveAndProceedTabBar: UIView!
    
    @IBOutlet weak var addMissingIngridientsButton: UIButton!
    @IBOutlet weak var addIngridientsTableView: UITableView!
    @IBOutlet weak var viewAddMissingIngridient: UIView!
    
    @IBOutlet weak var addMissingIngridientsTableView: UITableView!
    
    
    @IBOutlet weak var addIndridentPopupView: UIView!
    @IBOutlet weak var quantityView: UIView!
    @IBOutlet weak var unitView: UIView!
    @IBOutlet weak var addsaveButton: UIButton!
    
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var unitLabel: UILabel!
    
    @IBOutlet weak var addNewMissingIngridientBtn: UIButton!
    
    @IBOutlet weak var searchIngridientTextField: UITextField!
    
    @IBOutlet weak var addIngridientPopUpViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var labelIngridientTitle: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var unitLabelTitle: UILabel!
    
    var newSearchModel: [AddIngridientDataModel]? = []
    var ingridientSearchModel: [IngridentArray] = []
    var addMissingIngridientModel: [IngridentTypeDataModel]? = []
    
    
    var arrayPickerData: [String] = []
    var selectedIndexPath : IndexPath?
    var selectedIndexPath1 : IndexPath?
    var toolBar = UIToolbar()
    var picker1  = UIPickerView()
    var strReturn = String()
    var strReturn1 = Int()
    var arrQuantity = NSMutableArray()
    var arrUnit = NSMutableArray()
    var searchText = String()
    var strIngridientQuantity = Int()
    var strIngridientUnit = String()
    var strIngridientId = Int()
    var searching = false
    var selected : Bool?
    var quantity: Int?
    var unit: String?
    var singleIngridientData: IngridentArray?
    var singleUsedIngridientData: UsedIngridientDataModel?
    var arrayMyRecipe: [HomeTrending]? = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addIngridientsTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = RecipeConstants.kEditRecipeIngredient
        searchIngridientTextField.placeholder = RecipeConstants.kSearchIngredients
        quantityLabel.text = RecipeConstants.kQuantity
        unitLabelTitle.text = RecipeConstants.kUnit
        addsaveButton.setTitle(RecipeConstants.kAddtoList, for: .normal)
        saveButton.setTitle(RecipeConstants.kSaveIngridients, for: .normal)
        
        
        picker1.delegate = self
        picker1.dataSource = self
        self.addNewMissingIngridientBtn.isHidden = true
        arrQuantity = [2, 4, 6, 8, 10, 12, 14]
        arrUnit = [RecipeConstants.kKg, RecipeConstants.kLitre,  RecipeConstants.kPieces, RecipeConstants.kDozen, RecipeConstants.kgm, RecipeConstants.kMl, RecipeConstants.kSpoon, RecipeConstants.kDrops]
        setupUI()
        searchIngridientTextField.delegate = self
        searchIngridientTextField.autocorrectionType = .no
        callAddIngridients()
        addIndridentPopupView.translatesAutoresizingMaskIntoConstraints = false
        
        self.viewAddMissingIngridient.isHidden = true
        self.addIndridentPopupView.isHidden = true
        self.setUI()
        self.addIngridientsTableView.delegate = self
        self.addIngridientsTableView.dataSource = self
        
        self.addMissingIngridientsTableView.delegate = self
        self.addMissingIngridientsTableView.dataSource = self
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        addIngredientsView.drawBottomShadow()
    }
    func setUI(){
        
        addIngredientsView.layer.masksToBounds = false
        addIngredientsView.layer.shadowRadius = 2
        addIngredientsView.layer.shadowOpacity = 0.2
        addIngredientsView.layer.shadowColor = UIColor.lightGray.cgColor
        addIngredientsView.layer.shadowOffset = CGSize(width: 0 , height:2)
        searchView.layer.cornerRadius = 5
        saveButton.layer.cornerRadius = 5
        saveAndProceedTabBar.layer.masksToBounds = false
        saveAndProceedTabBar.layer.shadowRadius = 2
        saveAndProceedTabBar.layer.shadowOpacity = 0.8
        saveAndProceedTabBar.layer.shadowColor = UIColor.gray.cgColor
        saveAndProceedTabBar.layer.shadowOffset = CGSize(width: 0 , height:2)
    }
    
    func setupUI(){
        quantityView.layer.borderWidth = 1
        quantityView.layer.borderColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1).cgColor
        quantityView.layer.cornerRadius = 5
        unitView.layer.borderWidth = 1
        unitView.layer.borderColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1).cgColor
        unitView.layer.cornerRadius = 5
        addsaveButton.layer.cornerRadius = 5
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
        
        
        
        let doneButton = UIBarButtonItem(title: RecipeConstants.kDone, style: UIBarButtonItem.Style.plain, target: self, action: #selector(onDoneButtonTapped))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: RecipeConstants.kCancel, style: UIBarButtonItem.Style.plain, target: self, action: #selector(onCancelButtonTapped))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        self.view.addSubview(toolBar)
        
    }
    
    @objc func onDoneButtonTapped() {
        
        switch picker1.tag {
        
        case 1:
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
    
    @IBAction func tapUnit(_ sender: Any) {
        picker1.tag = 1
        picker1.reloadAllComponents()
        setPickerToolbar()
    }
    
    @IBAction func cancelingridentButton(_ sender: UIButton) {
        self.addIndridentPopupView.isHidden = true
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        if self.quantityTextField.text == "" || self.quantityTextField.text == "0"{
            showAlert(withMessage: AlertMessage.kenterQuantity)
            self.addIndridentPopupView.isHidden = false
            self.saveButton.layer.backgroundColor = UIColor.lightGray.cgColor
        }
        else if self.unitLabel.text == RecipeConstants.kUnit{
            showAlert(withMessage: AlertMessage.kselectUnit)
            self.addIndridentPopupView.isHidden = false
            self.saveButton.layer.backgroundColor = UIColor.lightGray.cgColor
        }
        else {
            self.addIndridentPopupView.isHidden = true
            let quantity = self.quantityTextField.text
            let unit = self.strReturn
            
//            let pickerData = ((quantity ?? "") + " " + unit)
//            arrayPickerData.append(pickerData)
//
            self.saveButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha:1).cgColor
            
            let data = UsedIngridientDataModel(with: [:])
            data.recipeSavedIngridientId = editSavedIngridientId
            data.recipeId = editRecipeId
            data.ingridientId = singleIngridientData?.recipeIngredientIds
            data.ingridient = singleIngridientData
            data.quantity = quantity
            data.unit = unit
            data.createdAt = singleIngridientData?.createdAt
            data.updatedAt = singleIngridientData?.updatedAt
            data.isSelected = 1
        
            if (((newSearchModel?.contains(where: { $0.ingridientId == data.ingridientId }))) == true)  {
                print("contain yes")
            }else{
                print("contain no")
                editusedIngridientModel.append(data)
                addDatainStep(data: data)
            }
            
            let data1 = IngridentArray()
            data1.recipeIngredientIds = singleIngridientData?.recipeIngredientIds
            data1.ingridientTitle = singleIngridientData?.ingridientTitle
            data1.imageId = singleIngridientData?.imageId
            data1.parent = singleIngridientData?.parent
            data1.quantity = Int(quantity!)
            data1.unit = unit
            data1.createdAt = singleIngridientData?.createdAt
            data1.updatedAt = singleIngridientData?.updatedAt
            data1.isSelected = true
        
            if (((newSearchModel?.contains(where: { $0.ingridientId == data1.recipeIngredientIds }))) == true)  {
                print("contain yes")
            }else{
                print("contain no")
                selectedEditIngridentsArray.append(data1)
               
            }

            self.addIngridientsTableView.reloadData()
        }
    }
    
    func addDatainStep(data: UsedIngridientDataModel){
        data.isSelected = 0
        for item in editstepsModel{
            item.stepIngridient?.append(data)
        }
    }
    func removeEditDatainStep(data: IngridentArray){
        for item in editstepsModel{
            
            if let index = item.stepIngridient?.firstIndex(where: { $0.ingridient?.recipeIngredientIds == data.recipeIngredientIds }) {
                print("Found at \(index)")
                
                item.stepIngridient?.remove(at: index)
            }
        }
        
    }
    
    @IBAction func saveAndProceedButton(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)

        
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        
        if searching == true{
            self.searching = false
            self.searchIngridientTextField.text = ""
            addIngridientsTableView.reloadData()
            self.addMissingIngridientsButton.isHidden = false
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }

    }
    
    
    @IBAction func tapForAddMissingIngridients(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected == false
        {
            self.addMissingIngridientsButton.setImage(UIImage.init(named: "MENU"), for: .normal)
            self.viewAddMissingIngridient.isHidden = true
        }
        else
        {
            self.addMissingIngridientsButton.setImage(UIImage.init(named: "5"), for: .normal)
            self.viewAddMissingIngridient.isHidden = false
            
        }
        
    }
    
    @IBAction func tapAddMainMissIngridient(_ sender: Any) {
        
        let addmissIngridient = self.storyboard?.instantiateViewController(withIdentifier: "AddMissingIngridientViewController") as! AddMissingIngridientViewController
        self.viewAddMissingIngridient.isHidden = true
        self.addMissingIngridientsButton.setImage(UIImage.init(named: "MENU"), for: .normal)
        self.addMissingIngridientsButton.isSelected = false
        self.navigationController?.pushViewController(addmissIngridient, animated: true)
    }
    
    
}

extension EditIngridientViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if tableView == addIngridientsTableView{
            if searching == true{
                return 1
            }
            else{
                return self.newSearchModel?.count ?? 0
            }
            
        }
        if tableView == addMissingIngridientsTableView{
            return 1
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if tableView == addIngridientsTableView{
            if searching == true{
                return ""
            }
            else{
                return self.newSearchModel?[section].ingridientDataName
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
        if tableView == addIngridientsTableView{
            if searching == true{
                return 0
            }
            else
            {
                return 40
            }
            
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == addIngridientsTableView{
            if searching == true{
                return self.ingridientSearchModel.count
            }
            else{
                return self.newSearchModel?[section].ingridents?.count ?? 0
            }
            
        }
        else if tableView == addMissingIngridientsTableView{
            if self.addMissingIngridientModel?.count == 1{
                addIngridientPopUpViewHeight.constant = 100
            }
            else if self.addMissingIngridientModel?.count == 2{
                addIngridientPopUpViewHeight.constant = 140
            }
            else if self.addMissingIngridientModel?.count == 3{
                addIngridientPopUpViewHeight.constant = 180
            }
            else if self.addMissingIngridientModel?.count == 4{
                addIngridientPopUpViewHeight.constant = 220
            }
            else if self.addMissingIngridientModel?.count == 5{
                addIngridientPopUpViewHeight.constant = 260
            }
            else if self.addMissingIngridientModel?.count == 6{
                addIngridientPopUpViewHeight.constant = 300
            }
            else{
                addIngridientPopUpViewHeight.constant = 437
            }
            return self.addMissingIngridientModel?.count ?? 0
        }
        else{
            return 0
        }
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == addIngridientsTableView {
            let cell:EditIngridientTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EditIngridientTableViewCell") as! EditIngridientTableViewCell
            
            cell.indexPath = indexPath
            cell.addIngridientDelegate = self
            
            if kSharedUserDefaults.getAppLanguage() == "it"{
                cell.addBtnWidth.constant = 120
                cell.selectedImgWidth.constant = 120
            }
            else{
                cell.addBtnWidth.constant = 80
                cell.selectedImgWidth.constant = 80
            }
            
            if searching == true {
                cell.data = ingridientSearchModel[indexPath.row]
            }
            else {
                cell.data = newSearchModel?[indexPath.section].ingridents?[indexPath.row]
            }
            return cell
        }
        else {
            let cell:EditMissingIngridientTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EditMissingIngridientTableViewCell") as! EditMissingIngridientTableViewCell
            
            cell.ingridientsTypeLabel.text = self.addMissingIngridientModel?[indexPath.row].ingridientType
            cell.ingridientsQuantityLabel.text = "\(self.addMissingIngridientModel?[indexPath.row].count ?? 0)"
            return cell
        }
    }
    
    func tapForIngridient(indexPath: IndexPath, data: IngridentArray, checkStatus: Bool?) {
        
        self.singleIngridientData = data
        if checkStatus == true {
            if let index = selectedEditIngridentsArray.firstIndex(where: { $0.recipeIngredientIds == data.recipeIngredientIds }) {
                print("Found at \(index)")
                selectedEditIngridentsArray.remove(at: index)
                removeEditDatainStep(data: data)

            }
            
            if let index = editusedIngridientModel.firstIndex(where: { $0.ingridient?.recipeIngredientIds == data.recipeIngredientIds }) {
                print("Found at \(index)")
                editusedIngridientModel.remove(at: index)
                removeEditDatainStep(data: data)
            }
            
            
//            arrayPickerData.remove(at: indexPath.row)
//            self.quantityLabel.text = "\(selectedIngridentsArray.count) Items"
//
//            if  self.quantityLabel.text == "0 Items" {
//                self.saveButton.layer.backgroundColor = UIColor.lightGray.cgColor
//            }
          
            self.addIngridientsTableView.reloadData()
        }
        else {
            quantityTextField.text = ""
            unitLabel.text = RecipeConstants.kUnit
            self.addIndridentPopupView.isHidden = false
            self.labelIngridientTitle.text = data.ingridientTitle
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == addIngridientsTableView{
            return 100
        }
        else{
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if tableView == addIngridientsTableView{
            return
        }
        else{
            self.addMissingIngridientsButton.setImage(UIImage.init(named: "MENU"), for: .normal)
            self.addMissingIngridientsButton.isSelected = false
            self.viewAddMissingIngridient.isHidden = true
            selectedIndexPath1 = indexPath
            let row = indexPath.row
            
            print("\(String(describing: selectedIndexPath1))")
            let indexPath = IndexPath(row: NSNotFound, section: row)
            addIngridientsTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            
        }
    }
}

extension EditIngridientViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch picker1.tag {
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
        
        case 1:
            
            let stName = self.arrUnit[row]
            
            str_return = "\(stName)"
            
            
        default: break
            
        }
        return str_return
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch picker1.tag {
        
        case 1:
            
            strReturn = arrUnit[row] as! String
            
        default:
            break
        }
    }
}

extension EditIngridientViewController{
    
    func callAddIngridients(){
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getrecipeIngridents, requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [[String:Any]]{
                self.newSearchModel = data.map({AddIngridientDataModel.init(with: $0)})
                
                for i in (0..<(self.newSearchModel?.count ?? 0)){
                    for j in (0..<(self.newSearchModel?[i].ingridents?.count ?? 0))
                    {
                        self.ingridientSearchModel.append(self.newSearchModel?[i].ingridents?[j] ?? IngridentArray())
                    }
                }
                self.addIngridientsTableView.reloadData()
            }
            
            if let data = dictResponse?["types"] as? [[String:Any]]{
                self.addMissingIngridientModel = data.map({IngridentTypeDataModel.init(with: $0)})
                self.addMissingIngridientsTableView.reloadData()
            }
            
        }
    }
    
    func callSearchIngridients(){
       
        TANetworkManager.sharedInstance.requestApi(withServiceName: "\(APIUrl.Recipes.searchIngridient)\(searchText)&type=2" , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
            switch statusCode{
            case 200:
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [[String:Any]]{
                self.ingridientSearchModel = data.map({IngridentArray.init(with: $0)})
            }
            
            case 409:
                self.ingridientSearchModel = [IngridentArray]()
                self.newSearchModel = [AddIngridientDataModel]()
                self.showAlert(withMessage: RecipeConstants.kNoIngredient)
            
            default:
              break
            }
            self.addIngridientsTableView.reloadData()
        }
        
    }
}

extension EditIngridientViewController: UITextFieldDelegate{
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        searchIngridientTextField.becomeFirstResponder()
//        return true
//    }
//    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        if let text = textField.text,
                   let textRange = Range(range, in: text) {
                   let updateText = text.replacingCharacters(in: textRange,
                                                               with: string)
        if updateText.count > 0 {
            self.searching = true
            searchText = updateText
            callSearchIngridients()
            self.addMissingIngridientsButton.isHidden = true
            hideKeyboardWhenTappedAround()
         }
        else{
            self.searching = false
           callAddIngridients()
            self.addMissingIngridientsButton.isHidden = false
        }
      }
      
        return true
    }
}

