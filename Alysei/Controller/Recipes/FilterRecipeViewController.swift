//
//  FilterViewController.swift
//  Filter App
//
//  Created by mac on 06/09/21.
//

import UIKit

class FilterRecipeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    var arrayChildIngridient : [IngridentArray]? = []
    var arrayCuisine : [SelectCuisineDataModel]? = []
    var arrayMeal : [SelectMealDataModel]? = []
    var filterNameArray = ["Cook Time","No. of Ingredients","Meal Type","Cuisines", "Ingridients"]
    var titleTimeArray = ["<3 min",
                     "<5 min",
                     "<15 min",
                     "<30 min",
                     "<45 min",
                     "<1 hr",
                     "<2 hr"]
    var titleNoOfIngridientArray = ["<2",
                               "<5",
                               "<10",
                               "<20",
                               "<30",
                               "<50"]
    var mealTypeArray = ["Breakfast & Brunch", "Lunch"]
    var cuisinesArray = ["Italian"]
    var ingridientsArray = ["Test ingredient", "Test Ingredient-3", "Chilli flakes"]
    
    private var selected = [String]()
    private var titlesCount = [[String](),[String](),[String](),[String](),[String]()]
    var titles = [String]()
//        = [[String](),[String](),[SelectMealDataModel](),[SelectCuisineDataModel](),[IngridentArray]()]
//    var myArray:[(a:String,b:String,c:String, d: )] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.layer.masksToBounds = false
        headerView.layer.shadowRadius = 2
        headerView.layer.shadowOpacity = 0.2
        headerView.layer.shadowColor = UIColor.lightGray.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0 , height:2)
        
        footerView.layer.masksToBounds = false
        footerView.layer.shadowRadius = 2
        footerView.layer.shadowOpacity = 0.8
        footerView.layer.shadowColor = UIColor.gray.cgColor
        footerView.layer.shadowOffset = CGSize(width: 0 , height:2)
        
        nextButton.layer.borderWidth = 1
        nextButton.layer.cornerRadius = 24
        nextButton.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
        
        collectionView.delegate = self
        collectionView.dataSource = self
//        titles = [titleTimeArray, titleNoOfIngridientArray, arrayMeal, arrayCuisine, arrayChildIngridient]
        //titles.append(titleTimeArray)
        //titles.append(titleNoOfIngridientArray)
        //titles.append(arrayMeal as Any)
        let layout = TagFlowLayout()
        layout.estimatedItemSize = CGSize(width: 140, height: 40)
        collectionView.collectionViewLayout = layout
        
    }
    
    @IBAction func clearAllTapped(_ sender: UIButton) {
        titlesCount = [[String](),[String](),[String](),[String](),[String]()]
        collectionView.reloadData()
    }
    
    @IBAction func tapback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapViewResult(_ sender: Any) {
        isFilterLoading = true
        self.navigationController?.popViewController(animated: true)
    }
}
extension FilterRecipeViewController:  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return titles.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titles[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell",
                                                            for: indexPath) as? TagCollectionViewCell else {
            return TagCollectionViewCell()
        }
        cell.tagLabel.text = titles[indexPath.section][indexPath.row]
        cell.tagLabel.preferredMaxLayoutWidth = collectionView.frame.width - 16
        
        if titlesCount[indexPath.section].contains(titles[indexPath.section][indexPath.row]) {
            cell.backgroundColor = UIColor(red: 59/255, green: 156/255, blue: 128/255, alpha: 1)
            cell.tagLabel.textColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
           
        } else {
            cell.backgroundColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
            cell.tagLabel.textColor = .black
        }
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TagCollectionViewCell, let text = cell.tagLabel.text else {return}
    
        if titlesCount[indexPath.section].contains(text) {
            titlesCount[indexPath.section] = titlesCount[indexPath.section].filter{$0 != text}
            print("Deselect",titlesCount[indexPath.section])
           
            
        } else {
            titlesCount[indexPath.section].append(text)
            print("Select",titlesCount[indexPath.section])
        }
       collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
            
            if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TagCollectionReusableView", for: indexPath) as? TagCollectionReusableView {
                sectionHeader.tagHeaderLabel.text = filterNameArray[indexPath.section]
                sectionHeader.tagCountLabel.text = "(\(titlesCount[indexPath.section].count))"
                return sectionHeader
                
            }
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 300, height: 50)

    }
}

extension FilterRecipeViewController{
    
    func getChildIngridients() -> Void{
        TANetworkManager.sharedInstance.requestApi(withServiceName: "\(APIUrl.Recipes.getChildIngridient)\(parentId)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [[String:Any]]{
                self.arrayChildIngridient = data.map({IngridentArray.init(with: $0)})
                
            }
        
            self.collectionView.reloadData()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    func getCuisine() -> Void{
        self.view.isUserInteractionEnabled = false
       TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getCuisine, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (response, error, errorType, statusCode) in
           
           let res = response as? [String:Any]
           
           if let data = res?["data"] as? [[String:Any]]{
               self.arrayCuisine = data.map({SelectCuisineDataModel.init(with: $0)})
           }
           
        self.collectionView.reloadData()
        self.view.isUserInteractionEnabled = true
       }
    }
    
    func getMeal() -> Void{
       self.view.isUserInteractionEnabled = false
       TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getrecipeMeal, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (response, error, errorType, statusCode) in
           
           let res = response as? [String:Any]
           
           if let data = res?["data"] as? [[String:Any]]{
               self.arrayMeal = data.map({SelectMealDataModel.init(with: $0)})
           }
          
        self.collectionView.reloadData()
           self.view.isUserInteractionEnabled = true
       }
    }
    
   
   
}
