//
//  EditToolViewController.swift
//  Alysei
//
//  Created by namrata upadhyay on 10/10/21.
//

import UIKit
var selectedEditToolArray: [ToolsArray] = []
class EditToolViewController: UIViewController, EditToolTableViewCellProtocol, AddToolTableViewCellProtocol {
    
    
    @IBOutlet weak var addToolsView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var saveAndProceedTabBar: UIView!
    @IBOutlet weak var addMissingToolButton: UIButton!
    @IBOutlet weak var addToolsTableView: UITableView!
    @IBOutlet weak var addMissingToolView: UIView!
    @IBOutlet weak var searchToolTextField: UITextField!
    
    @IBOutlet weak var addMissingToolTableView: UITableView!
   
    @IBOutlet weak var addNewMissingToolBtn: UIButton!
    @IBOutlet weak var addMissingToolPopUpHeight: NSLayoutConstraint!
    
    @IBOutlet weak var headerLabel: UILabel!
    
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
    var singleToolData: ToolsArray?
    var singleUsedToolData: UsedToolsDataModel?
    var strToolQuantity = Int()
    var strToolId = Int()
    var strToolUnit = String()
    var searching = false
    var quantity: Int?
    var unit: String?
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addToolsTableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchToolTextField.delegate = self
        searchToolTextField.autocorrectionType = .no
        self.addNewMissingToolBtn.isHidden = true
        setUI()
       
        callAddTools()
        callListTools()
        
        self.addMissingToolView.isHidden = true
       
        self.addToolsTableView.delegate = self
        self.addToolsTableView.dataSource = self
        
        self.addMissingToolTableView.delegate = self
        self.addMissingToolTableView.dataSource = self
        
        searchToolTextField.placeholder = RecipeConstants.kSearchTools
        headerLabel.text = RecipeConstants.kEditTool
        saveButton.setTitle(RecipeConstants.kSaveTool, for: .normal)
        
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

            self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
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

}

extension EditToolViewController: UITableViewDelegate
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
            return 100
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
            let cell:EditToolTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EditToolTableViewCell") as! EditToolTableViewCell
            
            cell.indexPath = indexPath
            cell.addToolDelegate = self
            
            if kSharedUserDefaults.getAppLanguage() == "it"{
                cell.addBtnWidth.constant = 120
                cell.selectedImgWidth.constant = 120
            }
            else{
                cell.addBtnWidth.constant = 80
                cell.selectedImgWidth.constant = 80
            }
            
            if searching == true {
                cell.data = toolSearchModel[indexPath.row]
            }
            else{
            cell.data = newSearchModel?[indexPath.section].tools?[indexPath.row]
            }
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
        self.singleToolData = data
        if checkStatus == true{
            

            if let index = selectedEditToolArray.firstIndex(where: { $0.recipeToolIds == data.recipeToolIds }) {
                print("Found at \(index)")
                selectedEditToolArray.remove(at: index)

            }
            if let index = editusedToolModel.firstIndex(where: { $0.tool?.recipeToolIds == data.recipeToolIds }) {
                print("Found at \(index)")
                
                editusedToolModel.remove(at: index)
                removeEditDatainStep1(data: data)
            }
            

            self.addToolsTableView.reloadData()
            
        }
        else{
            
            let data = UsedToolsDataModel(with: [:])
            data.recipeSavedToolId = editSavedtoolId;
            data.recipeToolId = editRecipeId
            data.toolId = singleToolData?.recipeToolIds
            data.tool = singleToolData
            data.isSelected = 1
            
            if (((newSearchModel?.contains(where: { $0.toolId == data.toolId }))) == true)  {
                print("contain yes")
            }else{
                print("contain no")
                editusedToolModel.append(data)
                addDatainStep1(data: data)
            }
            
            let data1 = ToolsArray()
            data1.recipeToolIds = singleToolData?.recipeToolIds
            data1.toolTitle = singleToolData?.toolTitle
            data1.imageId = singleToolData?.imageId
            data1.parent = singleToolData?.parent
            data1.isSelected = true
            if (((newSearchModel?.contains(where: { $0.toolId == data1.recipeToolIds }))) == true)  {
                print("contain yes")
            }else{
                print("contain no")
                selectedEditToolArray.append(data1)

            }
           
            
            self.saveButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha:1).cgColor
            self.addToolsTableView.reloadData()
            
        }
        
        
    }
    
    
    func removeEditDatainStep1(data: ToolsArray){
        for item in editstepsModel{

            if let index = item.stepTool?.firstIndex(where: { $0.tool?.recipeToolIds == data.recipeToolIds }) {
                print("Found at \(index)")

                item.stepTool?.remove(at: index)
            }
        }

    }
    
    func addDatainStep1(data: UsedToolsDataModel){
        data.isSelected = 0
        for item in editstepsModel{
            item.stepTool?.append(data)
        }
    }
    
}


extension EditToolViewController{
    
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
            }
                
            case 409:
                self.newSearchModel = [AddToolsDataModel]()
                self.toolSearchModel = [ToolsArray]()
                self.showAlert(withMessage: RecipeConstants.kNoTools)
            
            default:
              break
            }
            self.addToolsTableView.reloadData()
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
extension EditToolViewController: UITextFieldDelegate{
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        searchToolTextField.becomeFirstResponder()
//        return true
//    }
    
    
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
            callAddTools()
            self.addMissingToolButton.isHidden = false
        }
      }
       
        return true
    }
}
