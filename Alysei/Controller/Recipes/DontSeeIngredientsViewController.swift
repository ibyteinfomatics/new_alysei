//
//  DontSeeIngredientsViewController.swift
//  Preferences
//
//  Created by mac on 26/08/21.
//

import UIKit
var arraySelectedIngridient: [Int]? = []
class DontSeeIngredientsViewController: AlysieBaseViewC {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ingredientsCollectionView: UICollectionView!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var searchTextField: UITextField!
    var selectedIndexPath : IndexPath?
    var newSearchModel: [AddIngridientDataModel]? = []
    var ingdntArray: [IngridentArray] = []
    var firstSixingdntArray: [IngridentArray] = []
    var searching = false
    var ingridientId : Int?
    var searchingridientId: Int?
    var ingridientIdArray : [Int]? = []
    var ingridientSearchModel: [SearchIngridientDataModel]? = []
    var searchTextPreferences = String()
    var ingridientSet = Set<Int>()
    
    
    override func viewDidLayoutSubviews() {
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 800)
        
    }
    
    override func viewDidLoad() {
        preferenceNumber = 4
        super.viewDidLoad()
        ingredientsCollectionView.register(UINib(nibName: "FoodAllergyCollectionViewCell", bundle: .main ), forCellWithReuseIdentifier: "FoodAllergyCollectionViewCell")
        self.view.isUserInteractionEnabled = false
        ingredientsCollectionView.delegate = self
        ingredientsCollectionView.dataSource = self
        nextButton.layer.borderWidth = 1
        nextButton.layer.cornerRadius = 30
        nextButton.layer.borderColor = UIColor.init(red: 201/255, green: 201/255, blue: 201/255, alpha: 1).cgColor
        backButton.layer.borderWidth = 1
        backButton.layer.cornerRadius = 30
        backButton.layer.borderColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
        callChooseIngridients()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTextField.delegate = self
        
        
    }
    @IBAction func tapNextToCookigSkill(_ sender: Any) {
        if nextButton.layer.backgroundColor == UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor{
            let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "CookingSkillViewController") as! CookingSkillViewController
            self.searching = false
            self.searchTextField.text = nil
            self.searchTableView.reloadData()
            arrayPreference = PreferencesDataModel.init(id: arraySelectedIngridient ?? [], preference: preferenceNumber)
            arrayPreferencesModelData.append(arrayPreference ?? PreferencesDataModel(id: [], preference: 0))
            self.navigationController?.pushViewController(viewAll, animated: true)
        }
        else{}
    }
    @IBAction func tapBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapSkip(_ sender: Any) {
        let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "CookingSkillViewController") as! CookingSkillViewController
        for i in 0..<(ingdntArray.count){
            
            self.ingdntArray[i].isSelected = false
            arraySelectedIngridient?.removeAll()
            nextButton.layer.backgroundColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
            
            self.ingredientsCollectionView.reloadData()
            self.searching = false
            self.searchTextField.text = nil
            self.searchTableView.reloadData()
        }
        
        self.navigationController?.pushViewController(viewAll, animated: true)
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
                    self.ingdntArray.append(self.newSearchModel?[i].ingridents?[j] ?? IngridentArray())
                }
            }
            
//            for i in 0..<6{
//                self.firstSixingdntArray.append(self.ingdntArray[i])
//            }
            
            print("IngrdntArray-------",self.ingdntArray)
            self.ingredientsCollectionView.reloadData()
            self.searchTableView.reloadData()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    func callSearchIngridients(){
       
        TANetworkManager.sharedInstance.requestApi(withServiceName: "\(APIUrl.Recipes.searchIngridient)\(searchTextPreferences)&type=2", requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [[String:Any]]{
                self.ingridientSearchModel = data.map({SearchIngridientDataModel.init(with: $0)})
                self.searching = true
                self.searchTableView.reloadData()
            }
            
        }
    }
    
}
extension DontSeeIngredientsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ingdntArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FoodAllergyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodAllergyCollectionViewCell", for: indexPath) as! FoodAllergyCollectionViewCell
        
        let imgUrl = (kImageBaseUrl + (self.ingdntArray[indexPath.row].imageId?.imgUrl ?? ""))
        cell.image2.setImage(withString: "")
        cell.image1.setImage(withString: imgUrl)
        cell.imageNameLabel.text = self.ingdntArray[indexPath.item].ingridientTitle
        cell.viewOfImage.layer.cornerRadius = cell.viewOfImage.bounds.width/2
        cell.viewOfImage.layer.borderWidth = 4
        cell.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
        
        
        if ingdntArray[indexPath.row].isSelected == true{
            cell.image2.image = UIImage(named: "Group 1165")
        } else{
            cell.image2.image = nil
        }
        
        if arraySelectedIngridient?.count == 0{
            nextButton.layer.backgroundColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
        }
        else{
            nextButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
        }
        
        cell.layoutSubviews()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as? FoodAllergyCollectionViewCell
        
        selectedIndexPath = indexPath
        
        if  ingdntArray[indexPath.row].isSelected == true{
            ingdntArray[indexPath.row].isSelected = false
            cell?.image2.image = nil
            
            print("You deselected cell #\(indexPath.item)!")
            
            for (index,item) in arraySelectedIngridient!.enumerated(){
                if item == ingdntArray[indexPath.row].recipeIngredientIds{
                    arraySelectedIngridient?.remove(at: index)
                }
                
            }
            if arraySelectedIngridient?.count == 0{
                nextButton.layer.backgroundColor = UIColor.init(red: 141/255, green: 141/255, blue: 141/255, alpha: 1).cgColor
            }
            
        }
        else {
            print("You selected cell #\(indexPath.item)!")
            ingdntArray[indexPath.row].isSelected = true
            cell?.image2.image = UIImage(named: "Group 1165")
            
            let selectedIngridient = ingdntArray[indexPath.row].recipeIngredientIds
            self.searchingridientId = selectedIngridient
            arraySelectedIngridient?.append(searchingridientId!)
            nextButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: (collectionView.bounds.width)/3 - 10 , height: 130)
        return cellSize
        
    }
    
    
}
extension DontSeeIngredientsViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
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
        }
        else{
            cell.searchNameLabel.text = self.firstSixingdntArray[indexPath.row].ingridientTitle
            self.searchTableView.isScrollEnabled = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedIngridient1 = ingridientSearchModel![indexPath.row].recipeIngridientId
        self.searchingridientId = selectedIngridient1
        print("\(String(describing: selectedIngridient1))")
        
        if arraySelectedIngridient?.contains(searchingridientId!) == false{
            print("hiiii")
            arraySelectedIngridient?.append(searchingridientId!)
        }
        
        for (index,item) in self.ingdntArray.enumerated(){
            if self.ingdntArray[index].recipeIngredientIds == searchingridientId {
                ingdntArray[index].isSelected = true
            }
        }
        ingredientsCollectionView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.becomeFirstResponder()
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        searchTextPreferences = string
        if searchTextPreferences.count > 0 {
            callSearchIngridients()
        }
        else{
            self.searching = false
            ingridientSearchModel?.removeAll()
            self.searchTableView.reloadData()
        }
        
        return true
    }
    
}
