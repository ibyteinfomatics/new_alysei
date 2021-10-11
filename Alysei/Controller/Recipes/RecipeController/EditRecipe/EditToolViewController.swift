//
//  EditToolViewController.swift
//  Alysei
//
//  Created by namrata upadhyay on 10/10/21.
//

import UIKit

class EditToolViewController: UIViewController, EditToolTableViewCellProtocol, AddToolTableViewCellProtocol {
    @IBOutlet weak var addToolsView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var saveAndProceedTabBar: UIView!
    @IBOutlet weak var addMissingToolButton: UIButton!
    @IBOutlet weak var addToolsTableView: UITableView!
    @IBOutlet weak var addMissingToolView: UIView!
    
    
    @IBOutlet weak var addMissingToolTableView: UITableView!
   
    @IBOutlet weak var addNewMissingToolBtn: UIButton!
    @IBOutlet weak var addMissingToolPopUpHeight: NSLayoutConstraint!
    var newSearchModel: [AddToolsDataModel]? = []
    var addMissingToolModel: [ToolTypeDataModel]? = []
    
    var array1 = NSMutableArray()
    var array2 = NSMutableArray()
    
    var toolBar = UIToolbar()
    var picker1  = UIPickerView()
    var strReturn = String()
    var strReturn1 = Int()
    var arrQuantity = NSMutableArray()
    var arrUnit = NSMutableArray()
    
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
//        self.addedToolQuantityLabel.text = "\(selectedToolsArray.count) Items"
//        if self.addedToolQuantityLabel.text == "0 Items"{
//            self.saveButton.layer.backgroundColor = UIColor.lightGray.cgColor
//        }
//        else{
//            self.saveButton.layer.backgroundColor =
//                UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha:1).cgColor
//        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addNewMissingToolBtn.isHidden = true
        setUI()
       
        callAddTools()
        callListTools()
        
        self.addMissingToolView.isHidden = true
       
        self.addToolsTableView.delegate = self
        self.addToolsTableView.dataSource = self
        
        self.addMissingToolTableView.delegate = self
        self.addMissingToolTableView.dataSource = self
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
//        if addedToolQuantityLabel.text != "0 Items" {
//            let addSteps = self.storyboard?.instantiateViewController(withIdentifier: "AddStepsViewController") as! AddStepsViewController
//            if  arrayStepFinalData.count == 0 {
//            var ingridentsArray : [IngridentArray] = []
//            for item in selectedIngridentsArray{
//                let ingridients: IngridentArray = IngridentArray.init()
//                ingridients.recipeIngredientIds = item.recipeIngredientIds
//                ingridients.ingridientTitle = item.ingridientTitle
//                ingridients.imageId = item.imageId
//                ingridients.parent = item.parent
//                ingridients.pickerData = item.pickerData
//                ingridients.quantity = item.quantity
//                ingridients.unit = item.unit
//                ingridients.createdAt = item.createdAt
//                ingridients.updatedAt = item.updatedAt
//                ingridients.isSelected = false
//                ingridentsArray.append(ingridients)
//            }
//
//            var toolsArray : [ToolsArray] = []
//            for item in selectedToolsArray{
//                let tools: ToolsArray = ToolsArray.init()
//                tools.recipeToolIds = item.recipeToolIds
//                tools.toolTitle = item.toolTitle
//                tools.imageId = item.imageId
//                tools.parent = item.parent
//                tools.pickerData = item.pickerData
//                tools.quantity = item.quantity
//                tools.unit = item.unit
//                tools.isSelected = false
//                toolsArray.append(tools)
//            }
//            addSteps.arrayIngridients = ingridentsArray
//            addSteps.arraytools = toolsArray
//            addSteps.page = 1
//            }
//            else{
//                addSteps.page = 1
//                addSteps.selectedIndex = 0
//            }
            self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func tapForaddMyMissingTool(_ sender: Any) {
        
        let addmissIngridient = self.storyboard?.instantiateViewController(withIdentifier: "AddMissingToolViewController") as! AddMissingToolViewController
        self.addMissingToolView.isHidden = true
        self.addMissingToolButton.setImage(UIImage.init(named: "MENU"), for: .normal)
        self.addMissingToolButton.isSelected = false
        self.navigationController?.pushViewController(addmissIngridient, animated: true)
        
    }
    
    
    
    
}

extension EditToolViewController: UITableViewDelegate
                                  , UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == addToolsTableView{
            return self.newSearchModel?.count ?? 0
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
            
            return newSearchModel?[section].tools?.count ?? 0
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
            return self.newSearchModel?[section].toolDataName
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
            return 40
        }
        else{
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == addToolsTableView{
            let cell:EditToolTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EditToolTableViewCell") as! EditToolTableViewCell
            
            cell.indexPath = indexPath
            cell.addToolDelegate = self
            
            cell.data = newSearchModel?[indexPath.section].tools?[indexPath.row]
            
            return cell
        }
        else{
            let cell:EditMissingToolTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EditMissingToolTableViewCell") as! EditMissingToolTableViewCell
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
    
    func tapForTool(indexPath: IndexPath, data: ToolsArray, checkStatus: Bool?){
        self.singleIngridientData = data
        if checkStatus == true{
            

            if let index = selectedToolsArray.firstIndex(where: { $0.recipeToolIds == data.recipeToolIds }) {
                print("Found at \(index)")
                selectedToolsArray.remove(at: index)
            }
//            self.addedToolQuantityLabel.text = "\(selectedToolsArray.count) Items"
//
//            if  self.addedToolQuantityLabel.text == "0 Items"{
//                self.saveButton.layer.backgroundColor = UIColor.lightGray.cgColor
//
//            }
            self.addToolsTableView.reloadData()
            
        }
        else{
            
            
            let data = ToolsArray()
            data.recipeToolIds = singleIngridientData?.recipeToolIds
            data.toolTitle = singleIngridientData?.toolTitle
            data.imageId = singleIngridientData?.imageId
            data.parent = singleIngridientData?.parent
            data.isSelected = true
                selectedToolsArray.append(data)

            
            self.saveButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha:1).cgColor
            self.addToolsTableView.reloadData()
            
        }
        
        
    }
    
}


extension EditToolViewController{
    
    func callAddTools(){
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getrecipeTools, requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            
            if let data = dictResponse?["data"] as? [[String:Any]]{
                self.newSearchModel = data.map({AddToolsDataModel.init(with: $0)})
                self.addToolsTableView.reloadData()
                
                
            }
        }
    }
    
    func callListTools(){
       
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getrecipeTools, requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["types"] as? [[String:Any]]{
                self.addMissingToolModel = data.map({ToolTypeDataModel.init(with: $0)})
                self.addMissingToolTableView.reloadData()
            }
        }
    }
}
