//
//  IngridientViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 20/09/21.
//

import UIKit
var arrayPreference4: PreferencesDataModel?

class IngridientViewController: UIViewController {
    @IBOutlet weak var seeIngedientLabel: UILabel!
    @IBOutlet weak var ingredientsCollectionView: UICollectionView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchViewHeight: NSLayoutConstraint!
    @IBOutlet weak var addAnotherIngredientLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    var searching = false
    
    var searchTextPreferences = String()
    var selectedIndexPath : IndexPath?
    var newSearchModel: [AddIngridientDataModel]? = []
    
    
    var ingdntArray: [IngridentArray] = []
    var ingdntArray1: [IngridentArray] = []
    var ingridientId : Int?
    var searchingridientId: Int?
    var ingridientIdArray : [Int]? = []
    var ingridientSearchModel: [SearchIngridientDataModel]? = []
    var getSavedIngridientPreferencesModel : [GetSavedPreferencesDataModel]? = []
    var showAllIngridient: [MapDataModel]? = []
    var showAllIngridient1: [MapDataModel]? = []
    var firstSixingdntArray: [IngridentArray] = []
    var callbackResult: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        addAnotherIngredientLbl.text = RecipeConstants.kAddOtherIngredient
        seeIngedientLabel.text = RecipeConstants.kPreference4
        saveButton.setTitle(RecipeConstants.kSave, for: .normal)
        backButton.setTitle(RecipeConstants.kBack, for: .normal)
        callChooseIngridients()
        scrollView.isScrollEnabled = false
        searchViewHeight.constant = 130
      //  ingredientsCollectionView.register(UINib(nibName: "FoodAllergyCollectionViewCell", bundle: .main ), forCellWithReuseIdentifier: "FoodAllergyCollectionViewCell")
        ingredientsCollectionView.register(UINib(nibName: "PreferencesImageCollectionViewCell", bundle: .main ), forCellWithReuseIdentifier: "PreferencesImageCollectionViewCell")
        self.view.isUserInteractionEnabled = false
        ingredientsCollectionView.delegate = self
        ingredientsCollectionView.dataSource = self
        saveButton.layer.borderWidth = 1
        saveButton.layer.cornerRadius = 30
        saveButton.layer.borderColor = UIColor.init(red: 201/255, green: 201/255, blue: 201/255, alpha: 1).cgColor
        
        backButton.layer.borderWidth = 1
        backButton.layer.cornerRadius = 30
        backButton.layer.borderColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
        preferenceNumber = 4
        
        getSavedIngridientMyPreferences()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTextField.delegate = self
        searchTextField.autocorrectionType = .no
        searchTextField.placeholder = RecipeConstants.kSearchOtherIngredient
        
    }
    
    
    @IBAction func tapSave(_ sender: Any) {
        if saveButton.layer.backgroundColor == UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor{
            arrayPreferencesModelData.removeAll()
            
            arrayPreference1 = PreferencesDataModel.init(id: arraySelectedCuisine, preference: 1)
            arrayPreference2 = PreferencesDataModel.init(id: arraySelectedFood, preference: 2)
            arrayPreference3 = PreferencesDataModel.init(id: arraySelectedDiet, preference: 3)
            arrayPreference4 = PreferencesDataModel.init(id: arraySelectedIngridient, preference: 4)
            arrayPreference5 = PreferencesDataModel.init(id: arraySelectedCookingSkill, preference: 5)
            
            arrayPreferencesModelData.append(arrayPreference1 ?? PreferencesDataModel(id: [], preference: 0))
            arrayPreferencesModelData.append(arrayPreference2 ?? PreferencesDataModel(id: [], preference: 0))
            arrayPreferencesModelData.append(arrayPreference3 ?? PreferencesDataModel(id: [], preference: 0))
            arrayPreferencesModelData.append(arrayPreference4 ?? PreferencesDataModel(id: [], preference: 0))
            arrayPreferencesModelData.append(arrayPreference5 ?? PreferencesDataModel(id: [], preference: 0))
            
            postRequestToSaveIngridientPreferences()
            callbackResult?()
            
        }
        
        
    }
    
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}
extension IngridientViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.showAllIngridient?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: PreferencesImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreferencesImageCollectionViewCell", for: indexPath) as! PreferencesImageCollectionViewCell
        
        let imgUrl = ((showAllIngridient?[indexPath.row].imageId?.baseUrl ?? "") + (self.showAllIngridient?[indexPath.row].imageId?.imgUrl ?? ""))
        cell.imageView1.setImage(withString: "")
        cell.imageView1.isHidden = false
        cell.imageView.setImage(withString: imgUrl)
        cell.imageView.contentMode = .scaleAspectFit
        cell.imageNameLabel.text = self.showAllIngridient?[indexPath.item].title
   
        //cell.imageNameLabel.text = showAllIngridient?[indexPath.item].name
        cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
        cell.vwImage.layer.cornerRadius = cell.imageView.frame.height/2
        cell.vwImage.layer.borderWidth = 3
        cell.vwImage.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
   //     cell.vwImage.image = UIImage(named: "")
        cell.vwImage.clipsToBounds = true
       // let cell: FoodAllergyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodAllergyCollectionViewCell", for: indexPath) as! FoodAllergyCollectionViewCell
        
//        let imgUrl = ((showAllIngridient?[indexPath.row].imageId?.baseUrl ?? "") + (self.showAllIngridient?[indexPath.row].imageId?.imgUrl ?? ""))
//        cell.image2.setImage(withString: "")
//        cell.image1.setImage(withString: imgUrl)
//        cell.imageNameLabel.text = self.showAllIngridient?[indexPath.item].title
//        cell.viewOfImage.layer.cornerRadius = cell.viewOfImage.bounds.width/2
//        cell.viewOfImage.layer.borderWidth = 4
//        cell.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
        
        
        if showAllIngridient?[indexPath.row].isSelected == 1{
            cell.imageView1.image = UIImage(named: "Group 1165")
        } else{
            cell.imageView1.image = nil
        }
        
        cell.layoutSubviews()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as? PreferencesImageCollectionViewCell
        if searching == true{
        for i in 0..<(self.showAllIngridient?.count ?? 0){
            if self.searchingridientId == self.showAllIngridient?[i].ingridientId{
                let indexpath = IndexPath(row: i, section: 0)
                selectedIndexPath = indexpath
            }
        }
        }else{
        selectedIndexPath = indexPath
        }
        
        if  showAllIngridient?[selectedIndexPath?.row ?? 0].isSelected == 1{
            showAllIngridient?[selectedIndexPath?.row ?? 0].isSelected = 0
          //  cell?.image2.image = nil
            cell?.imageView1.image = nil
            
            print("You deselected cell #\(indexPath.item)!")
            
            for (index,item) in arraySelectedIngridient!.enumerated(){
                if item == showAllIngridient?[selectedIndexPath?.row ?? 0].ingridientId{
                    arraySelectedIngridient?.remove(at: index)
                }
            }
            
        }
        else {
            showAllIngridient?[selectedIndexPath?.row ?? 0].isSelected = 1
            cell?.imageView1.image = UIImage(named: "Group 1165")
            
            arraySelectedIngridient?.append(showAllIngridient?[selectedIndexPath?.row ?? 0].ingridientId ?? 0)
            
        }
        saveButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
        
        self.ingredientsCollectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: (collectionView.bounds.width)/3 - 10 , height: 130)
        return cellSize
        
    }
    
}

extension IngridientViewController{
    
    func createPreferencesJson(preferences:[PreferencesDataModel]?)->[[String:Any]] {
        var params = [[String:Any]]()
        for preference in preferences ?? [] {
            var pm = [String:Any]()
            pm["preference"] = preference.preference
            pm["id"] = preference.id
            params.append(pm)
        }
        return params
    }
    
    func postRequestToSaveIngridientPreferences() -> Void{
        
        let params = ["params": self.createPreferencesJson(preferences: arrayPreferencesModelData)]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.savePreferences, requestMethod: .POST, requestParameters: params, withProgressHUD:  true){ (dictResponse, error, errorType, statusCode) in
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    func getSavedIngridientMyPreferences() -> Void{
        self.view.isUserInteractionEnabled = false
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getsavedPreferences, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (response, error, errorType, statusCode) in
            
            let res = response as? [String:Any]
            
            if let data = res?["data"] as? [[String:Any]]{
                self.getSavedIngridientPreferencesModel = data.map({GetSavedPreferencesDataModel.init(with: $0)})
                
            }
            
            for i in (0..<(self.getSavedIngridientPreferencesModel?[3].maps?.count ?? 0))
            {
                self.showAllIngridient1?.append(self.getSavedIngridientPreferencesModel?[3].maps?[i] ?? MapDataModel(with: [:]) )
                
                self.showAllIngridient = self.showAllIngridient1?.sorted(by: { ($0.title ?? "") < ($1.title ?? "")})
               
                self.ingredientsCollectionView.reloadData()
                self.view.isUserInteractionEnabled = true
            }
        }
    }
    func callChooseIngridients(){
        self.view.isUserInteractionEnabled = false
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getrecipeIngridents, requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [[String:Any]]{
                self.newSearchModel = data.map({AddIngridientDataModel.init(with: $0)})
                
            }
            
            for i in (0..<(self.newSearchModel?.count ?? 0)){
                for j in (0..<(self.newSearchModel?[i].ingridents?.count ?? 0))
                {
                    self.ingdntArray1.append(self.newSearchModel?[i].ingridents?[j] ?? IngridentArray())
                    
                    self.ingdntArray = self.ingdntArray1.sorted(by: { ($0.ingridientTitle ?? "") < ($1.ingridientTitle ?? "")})
                    
                }
            }
            
            //            for i in 0..<6{
            //                self.firstSixingdntArray.append(self.ingdntArray[i])
            //            }
            
            print("IngrdntArray-------",self.ingdntArray)
            UIView.performWithoutAnimation{
                self.ingredientsCollectionView.reloadData()
            }
            self.searchTableView.reloadData()
            self.view.isUserInteractionEnabled = true
        }
    }
    func callSearchIngridients(){
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: "\(APIUrl.Recipes.searchIngridient)\(searchTextPreferences)&type=2", requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [[String:Any]]{
                self.ingridientSearchModel = data.map({SearchIngridientDataModel.init(with: $0)})
                
                self.searchTableView.reloadData()
            }
            
        }
    }
    
}
extension IngridientViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching == true{
            return self.ingridientSearchModel?.count ?? 0
        }
        else{
            //            return self.firstSixingdntArray.count
            return 0
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DontSeeIngredientsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DontSeeIngredientsTableViewCell") as! DontSeeIngredientsTableViewCell
        
        
        if searching == true{
            cell.searchNameLabel.text = self.ingridientSearchModel?[indexPath.row].ingridienttitle
            
            self.searchTableView.isScrollEnabled = true
            
            if (ingdntArray[indexPath.row].isSelected != nil) == true{
            
                cell.searchAddButton.setImage(UIImage(named: "Group 382"), for: .normal)
                    }
                else{
                    cell.searchAddButton.setImage(UIImage(named: "Group 1127"), for: .normal)
                }
            
            let selectedIngridient1 = ingridientSearchModel![indexPath.row].recipeIngridientId
            self.searchingridientId = selectedIngridient1
            print("\(String(describing: selectedIngridient1))")
            
            if arraySelectedIngridient?.contains(searchingridientId!) == true{
                print("hiiii")
                cell.searchAddButton.setImage(UIImage(named: "Group 382"), for: .normal)
            }
            else{
                cell.searchAddButton.setImage(UIImage(named: "Group 1127"), for: .normal)
            }
            
        }
        else{
            cell.searchNameLabel.text = self.firstSixingdntArray[indexPath.row].ingridientTitle
            self.searchTableView.isScrollEnabled = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.searchTableView.cellForRow(at: indexPath) as! DontSeeIngredientsTableViewCell
        let selectedIngridient1 = ingridientSearchModel![indexPath.row].recipeIngridientId
        self.searchingridientId = selectedIngridient1
        
        print("\(String(describing: selectedIngridient1))")
        
        if arraySelectedIngridient?.contains(searchingridientId!) == false{
            print("hiiii")
            arraySelectedIngridient?.append(searchingridientId!)
            
        }
        else{
            for (index,item) in arraySelectedIngridient!.enumerated(){
                if item == ingridientSearchModel?[indexPath.row].recipeIngridientId{
                    arraySelectedIngridient?.remove(at: index)
                }
                
            }
        }
        
        
        for (index,item) in self.ingdntArray.enumerated(){
            if ingdntArray[index].isSelected == true {
                if self.ingdntArray[index].recipeIngredientIds == searchingridientId {
                    ingdntArray[index].isSelected = false
                    cell.searchAddButton.setImage(UIImage(named: "Group 382"), for: .normal)
                }
                
            }
            else{
                
                if self.ingdntArray[index].recipeIngredientIds == searchingridientId {
                    ingdntArray[index].isSelected = true
                    
                }
            }
          
        }
        
        UIView.performWithoutAnimation{
            ingredientsCollectionView.reloadData()
            searchTableView.reloadData()
        }
        
        //MARK:- Collection ViewDidSelect
        
        self.ingredientsCollectionView.delegate?.collectionView?(ingredientsCollectionView, didSelectItemAt: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.becomeFirstResponder()
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updateText = text.replacingCharacters(in: textRange,
                                                      with: string)
            if updateText.count > 0 {
                searching = true
                scrollView.isScrollEnabled = true
                
                    searchViewHeight.constant = 300
                
                searchTextPreferences = updateText
                
                callSearchIngridients()
            }
            else{
                self.searching = false
                scrollView.isScrollEnabled = false
                
                
                    searchViewHeight.constant = 130
                
                //                searchTextPreferences = ""
                ingridientSearchModel?.removeAll()
                //                callSearchIngridients()
                self.searchTableView.reloadData()
            }
            
        }
        return true
    }
    
}
