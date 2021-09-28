//
//  AddIngredientsViewController.swift
//  Alysei Recipe Module
//
//  Created by mac on 28/07/21.
//

import UIKit
import Foundation
// Changes done
var selectedIngridentsArray: [IngridentArray] = []

class AddIngredientsViewController: AlysieBaseViewC, AddIngridientsTableViewCellProtocol {
    @IBOutlet weak var addIngredientsView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var saveAndProceedTabBar: UIView!
    
    @IBOutlet weak var addMissingIngridientsButton: UIButton!
    @IBOutlet weak var addIngridientsTableView: UITableView!
    @IBOutlet weak var viewAddMissingIngridient: UIView!
    
    @IBOutlet weak var addMissingIngridientsTableView: UITableView!
    
    @IBOutlet weak var itemsButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addIngridientsTableView.reloadData()
        self.quantityLabel.text = "\(selectedIngridentsArray.count) Items"
        if self.quantityLabel.text == "0 Items"{
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
        self.addNewMissingIngridientBtn.isHidden = true
        arrQuantity = [2, 4, 6, 8, 10, 12, 14]
        arrUnit = ["kg","litre", "pieces", "dozen", "gm", "meter", "spoon", "drops"]
        setupUI()
        searchIngridientTextField.delegate = self
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
        
        itemsButton.layer.borderWidth = 1
        itemsButton.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
        itemsButton.layer.cornerRadius = 5
        quantityLabel.text = "0 Items"
        
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
        else if self.unitLabel.text == "Unit"{
            showAlert(withMessage: AlertMessage.kselectUnit)
            self.addIndridentPopupView.isHidden = false
            self.saveButton.layer.backgroundColor = UIColor.lightGray.cgColor
        }
        else{
            self.addIndridentPopupView.isHidden = true
            let quantity = self.quantityTextField.text
            let unit = self.strReturn
            
            let pickerData = ((quantity!) + " " + unit)
            
            arrayPickerData.append(pickerData)
          
            self.saveButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha:1).cgColor
           
                singleIngridientData?.quantity = Int(quantity!)
                singleIngridientData?.unit = unit
                singleIngridientData?.pickerData = pickerData
                singleIngridientData?.isSelected = true
                singleIngridientData?.recipeIngredientIds = strIngridientId
            
                
            
            if arraySelectedIngridient?.contains(strIngridientId) == false{
                print("hiiii")
                selectedIngridentsArray.append(singleIngridientData ?? IngridentArray())
            }
           
                self.quantityLabel.text = "\(selectedIngridentsArray.count) Items"
                self.addIngridientsTableView.reloadData()
                
            
        }
        
        
    }
    
    @IBAction func tapForShowItemDetails(_ sender: Any) {
        let recipeIngredients = self.storyboard?.instantiateViewController(withIdentifier: "RecipeIngredientsUseViewController") as! RecipeIngredientsUseViewController
        
        self.navigationController?.pushViewController(recipeIngredients, animated: true)
        
    }
    @IBAction func saveAndProceedButton(_ sender: UIButton) {
        if quantityLabel.text != "0 Items"{
            let addtools =  self.storyboard?.instantiateViewController(withIdentifier: "AddToolsViewController") as! AddToolsViewController
            
            self.navigationController?.pushViewController(addtools, animated: true)
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

extension AddIngredientsViewController: UITableViewDelegate, UITableViewDataSource{
    
    
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
        
        if tableView == addIngridientsTableView{
            let cell:AddIngridientsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AddIngridientsTableViewCell") as! AddIngridientsTableViewCell
            
            cell.indexPath = indexPath
            
//            cell.btnAddCallback = { tag in
//
//                if self.ingridientSearchModel[indexPath.row].isSelected == true{
//
//                    self.ingridientSearchModel[indexPath.row].isSelected = false
//                    self.addIndridentPopupView.isHidden = true
//                    //self.arrayPickerData.remove(at: indexPath.row)
//                    self.quantityLabel.text = "\(selectedIngridentsArray.count) Items"
//
//                    if  self.quantityLabel.text == "0 Items"{
//                        self.saveButton.layer.backgroundColor = UIColor.lightGray.cgColor
//
//                    }
//                    self.addIngridientsTableView.reloadData()
//
//                }
//                else{
//                    //self.ingridientSearchModel[indexPath.row].isSelected = true
//                    self.quantityTextField.text = ""
//                    self.unitLabel.text = "Unit"
//                    self.addIndridentPopupView.isHidden = false
//
//                }
//
//            }
//
            cell.addIngridientDelegate = self
            if searching == true{
                cell.configCell(data: ingridientSearchModel[indexPath.row])
                let imgUrl = (kImageBaseUrl + (self.ingridientSearchModel[indexPath.row].imageId?.imgUrl ?? ""))
                
                cell.ingridientsImageView.setImage(withString: imgUrl)
                strIngridientQuantity = self.ingridientSearchModel[indexPath.row].quantity ?? 0
                strIngridientUnit = self.ingridientSearchModel[indexPath.row].unit ?? ""
                strIngridientId = self.ingridientSearchModel[indexPath.row].recipeIngredientIds ?? 0
                cell.ingredientsNameLabel.text = self.ingridientSearchModel[indexPath.row].ingridientTitle
                
               
//                if self.ingridientSearchModel[indexPath.row].isSelected == false{
//                    cell.selectImgView.isHidden = true
//                }
//                else{
//                    cell.selectImgView.isHidden = false
//                }
                
            }
            else{
                
                cell.configCell(data: newSearchModel?[indexPath.section].ingridents?[indexPath.row] ?? IngridentArray(with: [:]))
               
                let imgUrl = (kImageBaseUrl + (self.newSearchModel?[indexPath.section].ingridents?[indexPath.row].imageId?.imgUrl ?? ""))
                
                cell.ingridientsImageView.setImage(withString: imgUrl)
                strIngridientQuantity = self.newSearchModel?[indexPath.section].ingridents?[indexPath.row].quantity ?? 0
                strIngridientUnit = self.newSearchModel?[indexPath.section].ingridents?[indexPath.row].unit ?? ""
                strIngridientId = self.newSearchModel?[indexPath.section].ingridents?[indexPath.row].recipeIngredientIds ?? 0
                cell.ingredientsNameLabel.text = self.newSearchModel?[indexPath.section].ingridents?[indexPath.row].ingridientTitle
                
            }
            return cell
        }
        else{
            let cell:AddMissingIngridientTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AddMissingIngridientTableViewCell") as! AddMissingIngridientTableViewCell
            cell.ingridientsTypeLabel.text = self.addMissingIngridientModel?[indexPath.row].ingridientType
            
            cell.ingridientsQuantityLabel.text = "\(self.addMissingIngridientModel?[indexPath.row].count ?? 0)"
            
            return cell
        }
        
    }
    
    func tapForIngridient(indexPath: IndexPath, data: IngridentArray, checkStatus: Bool?){
        
        if checkStatus == true{
            
            self.addIndridentPopupView.isHidden = true
            data.isSelected = false
//            selectedIngridentsArray.rem
            arrayPickerData.remove(at: indexPath.row)
            self.quantityLabel.text = "\(selectedIngridentsArray.count) Items"
            
            if  self.quantityLabel.text == "0 Items"{
                self.saveButton.layer.backgroundColor = UIColor.lightGray.cgColor
                
            }
            self.addIngridientsTableView.reloadData()
            
        }
        else{
            quantityTextField.text = ""
            unitLabel.text = "Unit"
            self.addIndridentPopupView.isHidden = false
            self.singleIngridientData = data
            self.labelIngridientTitle.text = data.ingridientTitle
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == addIngridientsTableView{
            return 80
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

extension AddIngredientsViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
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

extension AddIngredientsViewController{
    
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
        disableWindowInteraction()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.searchIngridient + searchText, requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [[String:Any]]{
                self.ingridientSearchModel = data.map({IngridentArray.init(with: $0)})
                self.searching = true
                self.addIngridientsTableView.reloadData()
            }
            
            
        }
    }
}

extension AddIngredientsViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchIngridientTextField.becomeFirstResponder()
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        searchText = string
        if searchText.count > 0 {
            
            callSearchIngridients()
            self.addMissingIngridientsButton.isHidden = true
            hideKeyboardWhenTappedAround()
        }
        else{
            self.searching = false
//            ingridientSearchModel.removeAll()
//            callAddIngridients()
            addIngridientsTableView.reloadData()
            self.addMissingIngridientsButton.isHidden = false
        }
        
        return true
    }
}
