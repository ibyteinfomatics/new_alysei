//
//  IngridientViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 20/09/21.
//

import UIKit
var arrayPreference4: PreferencesDataModel?

class IngridientViewController: UIViewController {
    @IBOutlet weak var ingredientsCollectionView: UICollectionView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var selectedIndexPath : IndexPath?
    var newSearchModel: [AddIngridientDataModel]? = []
    var ingdntArray: [IngridentArray] = []
    var ingridientId : Int?
    var searchingridientId: Int?
    var ingridientIdArray : [Int]? = []
    
    var getSavedIngridientPreferencesModel : [GetSavedPreferencesDataModel]? = []
    var showAllIngridient: [MapDataModel]? = []
  
    var callbackResult: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        ingredientsCollectionView.register(UINib(nibName: "FoodAllergyCollectionViewCell", bundle: .main ), forCellWithReuseIdentifier: "FoodAllergyCollectionViewCell")
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
        let cell: FoodAllergyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodAllergyCollectionViewCell", for: indexPath) as! FoodAllergyCollectionViewCell
        
        let imgUrl = (kImageBaseUrl + (self.showAllIngridient?[indexPath.row].imageId?.imgUrl ?? ""))
        cell.image2.setImage(withString: "")
        cell.image1.setImage(withString: imgUrl)
        cell.imageNameLabel.text = self.showAllIngridient?[indexPath.item].name
        cell.viewOfImage.layer.cornerRadius = cell.viewOfImage.bounds.width/2
        cell.viewOfImage.layer.borderWidth = 4
        cell.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
        
        
        if showAllIngridient?[indexPath.row].isSelected == 1{
            cell.image2.image = UIImage(named: "Group 1165")
        } else{
            cell.image2.image = nil
        }
        
        cell.layoutSubviews()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as? FoodAllergyCollectionViewCell
        
        selectedIndexPath = indexPath
        
        if  showAllIngridient?[indexPath.row].isSelected == 1{
            showAllIngridient?[indexPath.row].isSelected = 0
            cell?.image2.image = nil
            
            print("You deselected cell #\(indexPath.item)!")
            
            for (index,item) in arraySelectedIngridient!.enumerated(){
                if item == showAllIngridient?[indexPath.row].ingridientId{
                    arraySelectedIngridient?.remove(at: index)
                }
            }
            
        }
        else {
            
            
            showAllIngridient?[indexPath.row].isSelected = 1
            cell?.image2.image = UIImage(named: "Group 1165")
            
            arraySelectedIngridient?.append(showAllIngridient?[indexPath.row].ingridientId ?? 0)
            
        }
        saveButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
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
                self.showAllIngridient?.append(self.getSavedIngridientPreferencesModel?[3].maps?[i] ?? MapDataModel(with: [:]) )
                
                self.ingredientsCollectionView.reloadData()
                self.view.isUserInteractionEnabled = true
            }
        }
    }
    
}
