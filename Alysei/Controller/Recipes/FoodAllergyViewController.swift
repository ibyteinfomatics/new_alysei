//
//  FoodAllergyViewController.swift
//  Preferences
//
//  Created by mac on 25/08/21.
//

import UIKit
import SVGKit

var arraySelectedFood : [Int]? = []
class FoodAllergyViewController: AlysieBaseViewC {
    
    @IBOutlet weak var foodAllergyLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnSkip: UIButton!
    
    var arrSelectedIndex = [IndexPath]() // This is selected cell Index array
    var selectedIndexPath : IndexPath?
    var arrFoodIntolerance: [SelectFoodIntoleranceDataModel]? = []
    var isFirStTimeLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preferenceNumber = 2
        
       // foodAllergyLabel.text = RecipeConstants.kPreference2
       
        
        collectionView.register(UINib(nibName: "FoodAllergyCollectionViewCell", bundle: nil ), forCellWithReuseIdentifier: "FoodAllergyCollectionViewCell")
        //disableWindowInteraction()
        self.view.isUserInteractionEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        nextButton.layer.borderWidth = 1
        nextButton.layer.cornerRadius = 30
        nextButton.layer.borderColor = UIColor.init(red: 201/255, green: 201/255, blue: 201/255, alpha: 1).cgColor
        backButton.layer.borderWidth = 1
        backButton.layer.cornerRadius = 30
        backButton.layer.borderColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
        
        postRequestToGetFoodIntolerance()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nextButton.setTitle(RecipeConstants.kSave, for: .normal)
        backButton.setTitle(RecipeConstants.kBack, for: .normal)
        btnSkip.setTitle(RecipeConstants.kSkip, for: .normal)
    }
    @IBAction func tapNextToDiets(_ sender: Any) {
        if nextButton.layer.backgroundColor == UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor{
            let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "FollowDietsViewController") as! FollowDietsViewController
//            let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "DontSeeIngredientsViewController") as! DontSeeIngredientsViewController
            
            arrayPreference = PreferencesDataModel.init(id: arraySelectedFood ?? [], preference: preferenceNumber)
            arrayPreferencesModelData.append(arrayPreference ?? PreferencesDataModel(id: [], preference: 0))
            self.navigationController?.pushViewController(viewAll, animated: true)
        }
        else{
            
        }
        
    }
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapSkip(_ sender: Any) {
        let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "FollowDietsViewController") as! FollowDietsViewController
        
        
        for i in 0..<(arrFoodIntolerance?.count ?? 0){
            self.arrFoodIntolerance?[i].isSelected = false
            
            self.arrSelectedIndex.removeAll()
            arraySelectedFood?.removeAll()
            nextButton.layer.backgroundColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
            collectionView.reloadData()
        }
        
        self.navigationController?.pushViewController(viewAll, animated: true)
    }
    
    
}
extension FoodAllergyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrFoodIntolerance?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell: FoodAllergyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodAllergyCollectionViewCell", for: indexPath) as! FoodAllergyCollectionViewCell
        
        let imgUrl = ((arrFoodIntolerance?[indexPath.row].imageId?.baseUrl ?? "") + (arrFoodIntolerance?[indexPath.row].imageId?.imgUrl ?? ""))
        let mySVGImage: SVGKImage = SVGKImage(contentsOf: URL(string: imgUrl))
        cell.image1.contentMode = .scaleAspectFit
        cell.image1.image = mySVGImage.uiImage
        cell.imageNameLabel.text = arrFoodIntolerance?[indexPath.row].foodName
        
        cell.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
        
        cell.layoutSubviews()
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as? FoodAllergyCollectionViewCell
        
        selectedIndexPath = indexPath
        if  arrFoodIntolerance?[indexPath.row].isSelected == true {
            arrFoodIntolerance?[indexPath.row].isSelected = false
            cell?.viewOfImage.layer.borderWidth = 4
            cell?.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
            
            for (index,item) in arrSelectedIndex.enumerated(){
                if item == indexPath{
                    arrSelectedIndex.remove(at: index)
                }
            }
            
            for (index,item) in arraySelectedFood!.enumerated(){
                if item == arrFoodIntolerance?[indexPath.row].foodId{
                    arraySelectedFood?.remove(at: index)
                }
            }
            if arrSelectedIndex.count == 0{
                nextButton.layer.backgroundColor = UIColor.init(red: 141/255, green: 141/255, blue: 141/255, alpha: 1).cgColor
            }
            
        } else {
            arrFoodIntolerance?[indexPath.row].isSelected = true
            cell?.viewOfImage.layer.borderWidth = 4
            cell?.viewOfImage.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            nextButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            
            arraySelectedFood?.append(arrFoodIntolerance?[indexPath.row].foodId ?? 0)
            arrSelectedIndex.append(selectedIndexPath!)
            print("\(String(describing: arrSelectedIndex.count))")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: (collectionView.bounds.width)/3 - 10 , height: 140)
        return cellSize
        
    }
    
}

extension FoodAllergyViewController{
    
    func postRequestToGetFoodIntolerance() -> Void{
        self.view.isUserInteractionEnabled = false
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getFoodIntolerance, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (response, error, errorType, statusCode) in
            
            let res = response as? [String:Any]
            let title = res?["title"] as? String
            self.foodAllergyLabel.text = title
            if let data = res?["data"] as? [[String:Any]]{
                self.arrFoodIntolerance = data.map({SelectFoodIntoleranceDataModel.init(with: $0)})
            }
            
            self.collectionView.reloadData()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    
}
