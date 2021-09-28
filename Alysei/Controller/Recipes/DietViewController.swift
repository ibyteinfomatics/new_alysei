//
//  DietViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 20/09/21.
//

import UIKit
import SVGKit
var arraySelectedDietMyPreferences: [Int]? = []
class DietViewController: AlysieBaseViewC  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var arrSelectedIndex = [IndexPath]() // This is selected cell Index array
    var selectedIndexPath : IndexPath?
    var getSavedDietPreferencesModel : [GetSavedPreferencesDataModel]? = []
    var showAllDiet: [MapDataModel]? = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "FoodAllergyCollectionViewCell", bundle: .main ), forCellWithReuseIdentifier: "FoodAllergyCollectionViewCell")
        self.view.isUserInteractionEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        saveButton.layer.borderWidth = 1
        saveButton.layer.cornerRadius = 30
        saveButton.layer.borderColor = UIColor.init(red: 201/255, green: 201/255, blue: 201/255, alpha: 1).cgColor
        saveButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
        backButton.layer.borderWidth = 1
        backButton.layer.cornerRadius = 30
        backButton.layer.borderColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
        getSavedDietMyPreferences()
        
    }
    
    @IBAction func tapSave(_ sender: Any) {
        arrayPreference1 = PreferencesDataModel.init(id: arraySelectedCuisine ?? [], preference: 1)
        arrayPreference2 = PreferencesDataModel.init(id: arraySelectedFood ?? [], preference: 2)
        arrayPreference3 = PreferencesDataModel.init(id: arraySelectedDietMyPreferences ?? [], preference: 3)
        arrayPreference4 = PreferencesDataModel.init(id: arraySelectedIngridientMyPreferences ?? [], preference: 4)
        arrayPreference5 = PreferencesDataModel.init(id: arraySelectedCookingSkillMyPrefrences ?? [], preference: 5)
        arrayPreferencesModelData?.append(arrayPreference1 ?? PreferencesDataModel(id: [], preference: 0))
        arrayPreferencesModelData?.append(arrayPreference2 ?? PreferencesDataModel(id: [], preference: 0))
        arrayPreferencesModelData?.append(arrayPreference3 ?? PreferencesDataModel(id: [], preference: 0))
        arrayPreferencesModelData?.append(arrayPreference4 ?? PreferencesDataModel(id: [], preference: 0))
        arrayPreferencesModelData?.append(arrayPreference5 ?? PreferencesDataModel(id: [], preference: 0))
        postRequestToSaveDietPreferences()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
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
    
    func postRequestToSaveDietPreferences() -> Void{
        
        let params = ["params": self.createPreferencesJson(preferences: arrayPreferencesModelData)]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.savePreferences, requestMethod: .POST, requestParameters: params, withProgressHUD:  true){ (dictResponse, error, errorType, statusCode) in
            
            
        }
    }
    
    func getSavedDietMyPreferences() -> Void{
        self.view.isUserInteractionEnabled = false
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getsavedPreferences, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (response, error, errorType, statusCode) in
            
            let res = response as? [String:Any]
            
            if let data = res?["data"] as? [[String:Any]]{
                self.getSavedDietPreferencesModel = data.map({GetSavedPreferencesDataModel.init(with: $0)})
                
            }
            
            for i in (0..<(self.getSavedDietPreferencesModel?[2].maps?.count ?? 0))
            {
                self.showAllDiet?.append(self.getSavedDietPreferencesModel?[2].maps?[i] ?? MapDataModel(with: [:]) )
                
                self.collectionView.reloadData()
                self.view.isUserInteractionEnabled = true
            }
        }
    }
}
extension DietViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showAllDiet?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FoodAllergyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodAllergyCollectionViewCell", for: indexPath) as! FoodAllergyCollectionViewCell
        
        let imgUrl = (kImageBaseUrl + (showAllDiet?[indexPath.row].imageId?.imgUrl ?? ""))
        
        let mySVGImage: SVGKImage = SVGKImage(contentsOf: URL(string: imgUrl))
        cell.image1.contentMode = .scaleAspectFit
        cell.image1.image = mySVGImage.uiImage
        cell.imageNameLabel.text = showAllDiet?[indexPath.row].name
        cell.viewOfImage.layer.cornerRadius = cell.viewOfImage.bounds.width/2
        cell.viewOfImage.layer.borderWidth = 4
        cell.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
        
        if showAllDiet?[indexPath.row].isSelected == 1{
            cell.viewOfImage.layer.borderWidth = 4
            cell.viewOfImage.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
        }
        else{
            cell.viewOfImage.layer.borderWidth = 4
            cell.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
            
        }
        
//        if arraySelectedDietMyPreferences?.count != 0{
//            saveButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
//        }
//        else{
//            saveButton.layer.borderColor = UIColor.init(red: 201/255, green: 201/255, blue: 201/255, alpha: 1).cgColor
//        }
        
        cell.layoutSubviews()
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as? FoodAllergyCollectionViewCell
        selectedIndexPath = indexPath
        if  showAllDiet?[indexPath.row].isSelected == 1 {
            showAllDiet?[indexPath.row].isSelected = 0
            //            cell?.image2.image = nil
            cell?.viewOfImage.layer.borderWidth = 4
            cell?.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
            for (index,item) in arrSelectedIndex.enumerated(){
                if item == indexPath{
                    arrSelectedIndex.remove(at: index)
                    
                }
            }
            
            for (index,item) in arraySelectedDietMyPreferences!.enumerated(){
                if item == showAllDiet?[indexPath.row].dietId{
                    arraySelectedDietMyPreferences?.remove(at: index)
                }
            }
//            if arrSelectedIndex.count == 0{
//                saveButton.layer.backgroundColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
//            }
            
        } else {
            showAllDiet?[indexPath.row].isSelected = 1
            cell?.viewOfImage.layer.borderWidth = 4
            cell?.viewOfImage.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
//            saveButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            //            cell?.image2.image = UIImage(named: "Group 1163")
            arraySelectedDietMyPreferences?.append(showAllDiet?[indexPath.row].dietId ?? 0)
            arrSelectedIndex.append(selectedIndexPath!)
            print("\(String(describing: arrSelectedIndex.count))")
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: (collectionView.bounds.width)/3 - 10 , height: 130)
        return cellSize
        
    }
    
    
}

