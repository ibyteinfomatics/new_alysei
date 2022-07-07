//
//  CuisinesViewController.swift
//  Preferences
//
//  Created by mac on 24/08/21.
//

import UIKit

var arrayPreference1: PreferencesDataModel?
var arraySelecetdPreferenceCuisin : [Int]? = []
class CuisinesViewController: UIViewController {
    
    @IBOutlet weak var yourFavLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var arrSelectedIndex = [IndexPath]() // This is selected cell Index array
    var getSavedCousinPreferencesModel : [GetSavedPreferencesDataModel]? = []
    var showAllCuisine: [MapDataModel]? = []
    var showSelecetdAllCuisine: [Int]? = []
    var selectedIndexPath: IndexPath? = nil
    var cuisineId : Int?
    
    var callbackResult: (() -> Void)?
    
    override func viewDidLoad() {
        
        //yourFavLabel.text = RecipeConstants.kPreference1
        SaveButton.setTitle(RecipeConstants.kSave, for: .normal)
        backButton.setTitle(RecipeConstants.kBack, for: .normal)
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FoodAllergyCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FoodAllergyCollectionViewCell")
        
        SaveButton.layer.borderWidth = 1
        SaveButton.layer.cornerRadius = 30
        
        SaveButton.layer.borderColor = UIColor.init(red: 201/255, green: 201/255, blue: 201/255, alpha: 1).cgColor
        backButton.layer.borderWidth = 1
        backButton.layer.cornerRadius = 30
        backButton.layer.borderColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
        getSavedCusinMyPreferences()
    }
    
    
    @IBAction func tapSave(_ sender: Any) {
        
        if SaveButton.layer.backgroundColor == UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor{
            arrayPreference1 = PreferencesDataModel.init(id: arraySelectedCuisine, preference: preferenceNumber)
            arrayPreferencesModelData.remove(at: 0)
            arrayPreferencesModelData.insert(arrayPreference1 ?? PreferencesDataModel(id: [], preference: 0), at: 0)
            postRequestToSaveCousinPreferences()
            callbackResult?()
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

extension CuisinesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showAllCuisine?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FoodAllergyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodAllergyCollectionViewCell", for: indexPath) as! FoodAllergyCollectionViewCell
        let imgUrl = ((showAllCuisine?[indexPath.row].imageId?.baseUrl ?? "") + (showAllCuisine?[indexPath.row].imageId?.imgUrl ?? ""))
        cell.image1.setImage(withString: imgUrl)
        cell.image1.contentMode = .scaleToFill
        cell.imageNameLabel.text = showAllCuisine?[indexPath.row].name
        cell.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
        
        if showAllCuisine?[indexPath.row].isSelected == 1{
            cell.viewOfImage.layer.borderWidth = 4
            cell.viewOfImage.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            
        }
        else{
            cell.viewOfImage.layer.borderWidth = 4
            cell.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
            
        }
        
        cell.layoutSubviews()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellSize = CGSize(width: (collectionView.bounds.width)/3 - 10, height: 140)
        return cellSize
    }
    
}

extension CuisinesViewController{
    
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
    
    func postRequestToSaveCousinPreferences() -> Void{
        
        let params = ["params": self.createPreferencesJson(preferences: arrayPreferencesModelData)]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.savePreferences, requestMethod: .POST, requestParameters: params, withProgressHUD:  true){ (dictResponse, error, errorType, statusCode) in
            
            
        }
    }
    
    func getSavedCusinMyPreferences() -> Void{
        self.view.isUserInteractionEnabled = false
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getsavedPreferences, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (response, error, errorType, statusCode) in
            
            let res = response as? [String:Any]
            
            if let data = res?["data"] as? [[String:Any]]{
                self.getSavedCousinPreferencesModel = data.map({GetSavedPreferencesDataModel.init(with: $0)})
                
            }
            
            for i in (0..<(self.getSavedCousinPreferencesModel?[0].maps?.count ?? 0))
            {
                self.showAllCuisine?.append(self.getSavedCousinPreferencesModel?[0].maps?[i] ?? MapDataModel(with: [:]) )
                
                if self.showAllCuisine?[i].isSelected == 1{
                    arraySelectedCuisine?.append(self.showAllCuisine?[i].cousinId ?? 0 )
                }
                
                self.collectionView.reloadData()
                self.view.isUserInteractionEnabled = true
            }
            let title = self.getSavedCousinPreferencesModel?[0].name
            self.yourFavLabel.text = title
        }
    }
}



