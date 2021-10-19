//
//  FoodViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 20/09/21.
//

import UIKit
import SVGKit


class FoodViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var arrSelectedIndex = [IndexPath]() // This is selected cell Index array
    var selectedIndexPath : IndexPath?
    var getSavedFoodPreferencesModel : [GetSavedPreferencesDataModel]? = []
    var showAllFood: [MapDataModel]? = []
    var arrayPreference2: PreferencesDataModel?
    var callbackResult: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preferenceNumber = 2
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FoodAllergyCollectionViewCell", bundle: nil ), forCellWithReuseIdentifier: "FoodAllergyCollectionViewCell")
        
        self.view.isUserInteractionEnabled = false
        saveButton.layer.borderWidth = 1
        saveButton.layer.cornerRadius = 30
        saveButton.layer.borderColor = UIColor.init(red: 201/255, green: 201/255, blue: 201/255, alpha: 1).cgColor
        
        backButton.layer.borderWidth = 1
        backButton.layer.cornerRadius = 30
        backButton.layer.borderColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
        getSavedFoodMyPreferences()
        
    }
    
    
    @IBAction func tapSave(_ sender: Any) {
        
        if saveButton.layer.backgroundColor == UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor{
            arrayPreference2 = PreferencesDataModel.init(id: arraySelectedFood, preference: preferenceNumber)
            //        arrayPreferencesModelData.remove(at: 1)
            arrayPreferencesModelData.insert(arrayPreference2 ?? PreferencesDataModel(id: [], preference: 0), at: 1)
            
            postRequestToSaveFoodPreferences()
            callbackResult?()
            
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for aViewController in viewControllers {
                if aViewController is DiscoverRecipeViewController {
                    self.navigationController!.popToViewController(aViewController, animated: true)
                }
            }
        }
    }
    
    @IBAction func tapBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}
extension FoodViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showAllFood?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell: FoodAllergyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodAllergyCollectionViewCell", for: indexPath) as! FoodAllergyCollectionViewCell
        
        let imgUrl = (kImageBaseUrl + (showAllFood?[indexPath.row].imageId?.imgUrl ?? ""))
        let mySVGImage: SVGKImage = SVGKImage(contentsOf: URL(string: imgUrl))
        cell.image1.contentMode = .scaleAspectFit
        cell.image1.image = mySVGImage.uiImage
        cell.imageNameLabel.text = showAllFood?[indexPath.row].name
        
        cell.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
        
        if showAllFood?[indexPath.row].isSelected == 1{
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as? FoodAllergyCollectionViewCell
        
        selectedIndexPath = indexPath
        if  showAllFood?[indexPath.row].isSelected == 1 {
            showAllFood?[indexPath.row].isSelected = 0
            cell?.viewOfImage.layer.borderWidth = 4
            cell?.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
            
            for (index,item) in arrSelectedIndex.enumerated(){
                if item == indexPath{
                    arrSelectedIndex.remove(at: index)
                }
            }
            
            for (index,item) in arraySelectedFood!.enumerated(){
                if item == showAllFood?[indexPath.row].foodId{
                    arraySelectedFood?.remove(at: index)
                }
            }
            
        } else {
            showAllFood?[indexPath.row].isSelected = 1
            cell?.viewOfImage.layer.borderWidth = 4
            cell?.viewOfImage.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            
            arraySelectedFood?.append(showAllFood?[indexPath.row].foodId ?? 0)
            arrSelectedIndex.append(selectedIndexPath!)
            print("\(String(describing: arrSelectedIndex.count))")
        }
        saveButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: (collectionView.bounds.width)/3 - 10, height: 130)
        return cellSize
        
    }
    
}

extension FoodViewController{
    
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
    
    func postRequestToSaveFoodPreferences() -> Void{
        
        let params = ["params": self.createPreferencesJson(preferences: arrayPreferencesModelData)]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.savePreferences, requestMethod: .POST, requestParameters: params, withProgressHUD:  true){ (dictResponse, error, errorType, statusCode) in
            
            
        }
    }
    func getSavedFoodMyPreferences() -> Void{
        
        self.view.isUserInteractionEnabled = false
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getsavedPreferences, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (response, error, errorType, statusCode) in
            
            let res = response as? [String:Any]
            
            if let data = res?["data"] as? [[String:Any]]{
                self.getSavedFoodPreferencesModel = data.map({GetSavedPreferencesDataModel.init(with: $0)})
                
            }
            
            for i in (0..<(self.getSavedFoodPreferencesModel?[1].maps?.count ?? 0))
            {
                self.showAllFood?.append(self.getSavedFoodPreferencesModel?[1].maps?[i] ?? MapDataModel(with: [:]) )
                
                self.collectionView.reloadData()
                self.view.isUserInteractionEnabled = true
            }
        }
    }
    
}
