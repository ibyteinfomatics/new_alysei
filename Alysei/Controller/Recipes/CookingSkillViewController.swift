//
//  CookingSkillViewController.swift
//  Preferences
//
//  Created by mac on 27/08/21.
//

import UIKit
import SVGKit

var preferenceNumber : Int?
var arrayPreference5: PreferencesDataModel?
class CookingSkillViewController: AlysieBaseViewC {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var arrSelectedIndex = [IndexPath]() // This is selected cell Index array
    var arrCookingSkill = [SelectCookingSkillsDataModel]()
    var selectedIndexPath: IndexPath? = nil
    var arraySelectedCookingSkill: [Int]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "FoodAllergyCollectionViewCell", bundle: .main ), forCellWithReuseIdentifier: "FoodAllergyCollectionViewCell")
        self.view.isUserInteractionEnabled = false
        preferenceNumber = 5
        collectionView.delegate = self
        collectionView.dataSource = self
        nextButton.layer.borderWidth = 1
        nextButton.layer.cornerRadius = 30
        nextButton.layer.borderColor = UIColor.init(red: 201/255, green: 201/255, blue: 201/255, alpha: 1).cgColor
        backButton.layer.borderWidth = 1
        backButton.layer.cornerRadius = 30
        backButton.layer.borderColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
        postRequestToGetCookinSkills()
    }
    @IBAction func tapNextToMainScreen(_ sender: Any) {
        arrayPreference5 = PreferencesDataModel.init(id: arraySelectedCookingSkill ?? [], preference: preferenceNumber)
        arrayPreferencesModelData?.append(arrayPreference5 ?? PreferencesDataModel(id: [], preference: 0))
        postRequestToSaveAllPreferences()
       
        if nextButton.layer.backgroundColor == UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor{
        let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverRecipeViewController") as! DiscoverRecipeViewController
        self.navigationController?.pushViewController(viewAll, animated: true)

        }
        else{}
    }
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapSkip(_ sender: Any) {
        let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverRecipeViewController") as! DiscoverRecipeViewController
       
        for i in 0..<(arrCookingSkill.count ){
        self.arrCookingSkill[i].isSelected = false
            self.arrSelectedIndex.removeAll()
        }
        arrayPreferencesModelData?.removeAll()
        self.navigationController?.pushViewController(viewAll, animated: true)
    }
    
    func postRequestToGetCookinSkills() -> Void{
        
       TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getCookingSkill, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (response, error, errorType, statusCode) in
           
           let res = response as? [String:Any]
           
           if let data = res?["data"] as? [[String:Any]]{
               self.arrCookingSkill = data.map({SelectCookingSkillsDataModel.init(with: $0)})
           }
           
        self.collectionView.reloadData()
        self.view.isUserInteractionEnabled = true
       }
       
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
    
   func postRequestToSaveAllPreferences() -> Void{

    let params = ["params": self.createPreferencesJson(preferences: arrayPreferencesModelData)]
        
    TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.savePreferences, requestMethod: .POST, requestParameters: params, withProgressHUD:  true){ (dictResponse, error, errorType, statusCode) in
        
        
      }
    }
    
}
extension CookingSkillViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCookingSkill.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FoodAllergyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodAllergyCollectionViewCell", for: indexPath) as! FoodAllergyCollectionViewCell
        let imgUrl = (kImageBaseUrl + (arrCookingSkill[indexPath.row].imageId?.imgUrl ?? ""))
        let mySVGImage: SVGKImage = SVGKImage(contentsOf: URL(string: imgUrl))
        cell.image1.contentMode = .scaleAspectFit
        cell.image1.image = mySVGImage.uiImage
        cell.imageNameLabel.text = arrCookingSkill[indexPath.row].cookingSkillName
        cell.viewOfImage.layer.cornerRadius = cell.viewOfImage.bounds.width/2
        cell.viewOfImage.layer.borderWidth = 4
        cell.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
        
                cell.layoutSubviews()
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as? FoodAllergyCollectionViewCell
        
//        if selectedIndexPath == indexPath {
//                    // it was already selected
//                    selectedIndexPath = nil
//                    collectionView.deselectItem(at: indexPath, animated: false)
//                        cell?.viewOfImage.layer.borderWidth = 4
//                        cell?.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
//                        nextButton.layer.backgroundColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
//
//            print("deselect")
//                } else {
                    // wasn't yet selected, so let's remember it
                    selectedIndexPath = indexPath
                    arraySelectedCookingSkill?.append(arrCookingSkill[indexPath.row].cookinSkillId ?? 0)
                                cell?.viewOfImage.layer.borderWidth = 4
                                cell?.viewOfImage.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
                    
                                nextButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
                   
                    print("select")
//                }

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as? FoodAllergyCollectionViewCell
        cell?.viewOfImage.layer.borderWidth = 4
        cell?.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
        nextButton.layer.backgroundColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
        self.selectedIndexPath = nil
        for (index,item) in arraySelectedCookingSkill!.enumerated(){
            if item == arrCookingSkill[indexPath.row].cookinSkillId{
                arraySelectedCookingSkill?.remove(at: index)
            }
            
        }
        print("previous Deselect")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: (collectionView.bounds.width)/3 - 10 , height: 130)
        return cellSize
        
    }
    
    
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//            //Where elements_count is the count of all your items in that
//            //Collection view...
//            let cellCount = CGFloat(arrCookingSkill.count)
//
//            //If the cell count is zero, there is no point in calculating anything.
//            if cellCount > 0 {
//                let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
//                let cellWidth = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
//
//                //20.00 was just extra spacing I wanted to add to my cell.
//                let totalCellWidth = cellWidth*cellCount + 20.00 * (cellCount-1)
//                let contentWidth = collectionView.frame.size.width - collectionView.contentInset.left - collectionView.contentInset.right
//
//                if (totalCellWidth < contentWidth) {
//                    //If the number of cells that exists take up less room than the
//                    //collection view width... then there is an actual point to centering them.
//
//                    //Calculate the right amount of padding to center the cells.
//                    let padding = (contentWidth - totalCellWidth) / 2.0
//                    return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
//                } else {
//                    //Pretty much if the number of cells that exist take up
//                    //more room than the actual collectionView width, there is no
//                    // point in trying to center them. So we leave the default behavior.
//                    return UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
//                }
//            }
//            return UIEdgeInsets.zero
//        }
}
