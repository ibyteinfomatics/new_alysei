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
        arrayPreferencesModelData.remove(at: 1)
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
        //        cell.viewOfImage.layer.cornerRadius = cell.viewOfImage.bounds.width/2
        //        cell.viewOfImage.layer.borderWidth = 4
        cell.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
        
        if showAllFood?[indexPath.row].isSelected == 1{
            cell.viewOfImage.layer.borderWidth = 4
            cell.viewOfImage.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
        }
        else{
            cell.viewOfImage.layer.borderWidth = 4
            cell.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
            
        }
        
//        if arraySelectedFood?.count != 0{
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
//            if arraySelectedFood?.count == 0{
//                saveButton.layer.backgroundColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
//            }
            
        } else {
            showAllFood?[indexPath.row].isSelected = 1
            cell?.viewOfImage.layer.borderWidth = 4
            cell?.viewOfImage.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
//            saveButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
//
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
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //
    //        //Where elements_count is the count of all your items in that
    //        //Collection view...
    //        let cellCount = CGFloat(arrFoodIntolerance?.count ?? 0)
    //
    //        //If the cell count is zero, there is no point in calculating anything.
    //        if cellCount > 0 {
    //            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
    //            let cellWidth = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
    //
    //            //20.00 was just extra spacing I wanted to add to my cell.
    //            let totalCellWidth = cellWidth*cellCount + 20.00 * (cellCount-1)
    //            let contentWidth = collectionView.frame.size.width - collectionView.contentInset.left - collectionView.contentInset.right
    //
    //            if (totalCellWidth < contentWidth) {
    //                //If the number of cells that exists take up less room than the
    //                //collection view width... then there is an actual point to centering them.
    //
    //                //Calculate the right amount of padding to center the cells.
    //                let padding = (contentWidth - totalCellWidth) / 2.0
    //                return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    //            } else {
    //                //Pretty much if the number of cells that exist take up
    //                //more room than the actual collectionView width, there is no
    //                // point in trying to center them. So we leave the default behavior.
    //                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    //            }
    //        }
    //        return UIEdgeInsets.zero
    //    }
}

