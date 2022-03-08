//
//  FilterViewController.swift
//  Filter App
//
//  Created by mac on 06/09/21.
//

import UIKit
var arrayChildIngridient : [IngridentArray]? = []
var strTime = String()
var strNoOfIngridient = String()
var strMeal = String()
var strCuisin = String()
var selectedIngridientId = [String]()
var parentRecipeId = String()
var isFilter = String()

var str1 = String()
var str2 = String()
var titleTimeArraySelecetd = [IndexPath]()
class FilterRecipeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var clearAllBtn: UIButton!
    
    var selectedIndexPath: IndexPath? = nil
    var selectedIndexPath1: IndexPath? = nil
    var selectedIndexPath2: IndexPath? = nil
    var selectedIndexPath3: IndexPath? = nil
    var selectedIndexPath4: IndexPath? = nil
    var isSelected = false
    var arrayCuisine : [SelectCuisineDataModel]? = []
    var arrayMeal : [SelectMealDataModel]? = []
    var filterNameArray = [String]()
    
   
    var titleTimeArray = ["<3 min",
                          "<5 min",
                          "<15 min",
                          "<30 min",
                          "<45 min",
                          "<1 hr",
                          "<2 hr"]
    var titleNoOfIngridientArray = ["<5",
                                    "<10",
                                    "<20",
                                    "<30",
                                    "<40",
                                    "<60"]
    
    private var selected = [String]()
    private var titlesCount = [[String]()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterLabel.text = RecipeConstants.kFilter
        clearAllBtn.setTitle(RecipeConstants.kClearAll, for: .normal)
        nextButton.setTitle(RecipeConstants.kViewResult, for: .normal)
        collectionView.allowsMultipleSelection = false

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
        
        let layout = TagFlowLayout()
        layout.estimatedItemSize = CGSize(width: 100, height: 40)
        collectionView.collectionViewLayout = layout
        
        if isFrom == "Ingridients"{
            titlesCount = [[String](),[String](),[String](),[String](),[String]()]
            filterNameArray = [RecipeConstants.kCookTime,RecipeConstants.kNoOfIngredient,RecipeConstants.kMealType,RecipeConstants.kCuisine, RecipeConstants.kIngredient]
        }
        else if isFrom == "Meal"{
            titlesCount = [[String](),[String](),[String]()]
            filterNameArray = [RecipeConstants.kCookTime,RecipeConstants.kNoOfIngredient,RecipeConstants.kCuisine]
        }
        else{
            titlesCount = [[String](),[String](),[String](),[String]()]
            filterNameArray = [RecipeConstants.kCookTime,RecipeConstants.kNoOfIngredient,RecipeConstants.kMealType,RecipeConstants.kCuisine]
        }
        
        getMeal()
        getCuisine()
        getChildIngridients()
        
    }
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      self.headerView.drawBottomShadow()
    }
    
    @IBAction func clearAllTapped(_ sender: UIButton) {
        titlesCount = [[String](),[String](),[String](),[String](),[String]()]
        let cell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? TagCollectionViewCell
        str1 = String()
        str2 = String()
        strTime = String()
        strNoOfIngridient = String()
        strMeal = String()
        strCuisin = String()
        selectedIngridientId = [String]()
        parentRecipeId = String()
        selectedIndexPath = nil
        selectedIndexPath1 = nil
        selectedIndexPath2 = nil
        selectedIndexPath3 = nil
        selectedIndexPath4 = nil
        cell?.isSelected = false
        collectionView.reloadData()
    }
    
    @IBAction func tapback(_ sender: Any) {
        searching = false
        str1 =  String()
        str2 =  String()
        strTime = String()
        strNoOfIngridient = String()
        strMeal = String()
        strCuisin = String()
        selectedIngridientId = [String]()
        parentRecipeId = String()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapViewResult(_ sender: Any) {
        isFilterLoading = true
        searching = false
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
extension FilterRecipeViewController:  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if isFrom == "Ingridients"{
            return 5
        }
        else if isFrom == "Meal"{
            return 3
        }
        else{
            return 4
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isFrom == "Ingridients"{
            switch section{
            case 0:
                return titleTimeArray.count
            case 1:
                return titleNoOfIngridientArray.count
            case 2:
                return arrayMeal?.count ?? 0
            case 3:
                return arrayCuisine?.count ?? 0
            case 4:
                return arrayChildIngridient?.count ?? 0
            default:
                break
            }
        }
        else if isFrom == "Meal"{
            switch section{
            case 0:
                return titleTimeArray.count
            case 1:
                return titleNoOfIngridientArray.count
            case 2:
                return arrayCuisine?.count ?? 0
            default:
                break
            }
        }
        else{
            switch section{
            case 0:
                return titleTimeArray.count
            case 1:
                return titleNoOfIngridientArray.count
            case 2:
                return arrayMeal?.count ?? 0
            case 3:
                return arrayCuisine?.count ?? 0
            default:
                break
            }
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell",
                                                            for: indexPath) as? TagCollectionViewCell,  let text = cell.tagLabel.text else {
            return TagCollectionViewCell()
        }
        
        if isFrom == "Ingridients"{
            switch indexPath.section{
            case 0:
                collectionView.allowsMultipleSelection = false
                cell.tagLabel.text = titleTimeArray[indexPath.row]
                cell.tagLabel.preferredMaxLayoutWidth = collectionView.frame.width - 16
                
              if selectedIndexPath == indexPath {
                    cell.isSelected = true
                }

               else if str1.contains(comparsionString: titleTimeArray[indexPath.row]) {
                    cell.isSelected = true
                   titlesCount[indexPath.section] = ["1"]
                }
              
                
               
            case 1:
                collectionView.allowsMultipleSelection = false
                cell.tagLabel.text = titleNoOfIngridientArray[indexPath.row]
                cell.tagLabel.preferredMaxLayoutWidth = collectionView.frame.width - 16
                
                if selectedIndexPath1 == indexPath {
                    cell.isSelected = true
//                    for title in titleNoOfIngridientArray{
//                        if title == str2{
//                            cell.isSelected = true
//                            titlesCount[indexPath.section] = ["1"]
//                        }
//                     }
                }
                
                
                else if str2.contains(comparsionString: titleNoOfIngridientArray[indexPath.row]) {
                     cell.isSelected = true
                    titlesCount[indexPath.section] = ["1"]
                 }
            
            case 2:
                cell.tagLabel.text = arrayMeal?[indexPath.row].mealName
                cell.tagLabel.preferredMaxLayoutWidth = collectionView.frame.width - 16
                
                if selectedIndexPath2 == indexPath {
                    cell.isSelected = true
                }
                else if strMeal.contains(comparsionString: "\(arrayMeal?[indexPath.row].recipeMealId ?? 0)") {
                     cell.isSelected = true
                    titlesCount[indexPath.section] = ["1"]
                 }

            case 3:
                cell.tagLabel.text = arrayCuisine?[indexPath.row].cuisineName
                cell.tagLabel.preferredMaxLayoutWidth = collectionView.frame.width - 16
                
                if selectedIndexPath3 == indexPath {
                    cell.isSelected = true
                }
                else if strCuisin.contains(comparsionString: "\(arrayCuisine?[indexPath.row].cuisineId ?? 0)") {
                     cell.isSelected = true
                     titlesCount[indexPath.section] = ["1"]
                 }
                
            case 4:
                cell.tagLabel.text = arrayChildIngridient?[indexPath.row].ingridientTitle
                cell.tagLabel.preferredMaxLayoutWidth = collectionView.frame.width - 16
               
                
                if selectedIngridientId.contains(obj: String.getString(arrayChildIngridient?[indexPath.row].recipeIngredientIds)){
                    cell.backgroundColor = UIColor(red: 59/255, green: 156/255, blue: 128/255, alpha: 1)
                    cell.tagLabel.textColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
                    titlesCount[indexPath.section] = [text]
                
                } else {
                    cell.backgroundColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
                    cell.tagLabel.textColor = .black
                    
                }
            default:
                break
                
            }
        }
        else if isFrom == "Meal"{
            switch indexPath.section{
            case 0:
                cell.tagLabel.text = titleTimeArray[indexPath.row]
                cell.tagLabel.preferredMaxLayoutWidth = collectionView.frame.width - 16
                
                if selectedIndexPath == indexPath {
                      cell.isSelected = true
                  }

                 else if str1.contains(comparsionString: titleTimeArray[indexPath.row]) {
                      cell.isSelected = true
                    titlesCount[indexPath.section] = ["1"]
                  }
                
            case 1:
                cell.tagLabel.text = titleNoOfIngridientArray[indexPath.row]
                cell.tagLabel.preferredMaxLayoutWidth = collectionView.frame.width - 16
                
                if selectedIndexPath1 == indexPath {
                    cell.isSelected = true
//                    for title in titleNoOfIngridientArray{
//                        if title == str2{
//                            cell.isSelected = true
//                            titlesCount[indexPath.section] = ["1"]
//                        }
//                     }
                }
                else if str2.contains(comparsionString: titleNoOfIngridientArray[indexPath.row]) {
                     cell.isSelected = true
                    titlesCount[indexPath.section] = ["1"]
                 }
                
            case 2:
                cell.tagLabel.text = arrayCuisine?[indexPath.row].cuisineName
                cell.tagLabel.preferredMaxLayoutWidth = collectionView.frame.width - 16
                
                if selectedIndexPath2 == indexPath {
                    cell.isSelected = true
                }
                else if strCuisin.contains(comparsionString: "\(arrayCuisine?[indexPath.row].cuisineId ?? 0)") {
                     cell.isSelected = true
                    titlesCount[indexPath.section] = ["1"]
                 }
                
            default:
                break
                
            }
        }
        else{
            switch indexPath.section{
            case 0:
                cell.tagLabel.text = titleTimeArray[indexPath.row]
                cell.tagLabel.preferredMaxLayoutWidth = collectionView.frame.width - 16
                
                if selectedIndexPath == indexPath {
                      cell.isSelected = true
                  }

                 else if str1.contains(comparsionString: titleTimeArray[indexPath.row]) {
                      cell.isSelected = true
                    titlesCount[indexPath.section] = ["1"]
                  }
                
            case 1:
                cell.tagLabel.text = titleNoOfIngridientArray[indexPath.row]
                cell.tagLabel.preferredMaxLayoutWidth = collectionView.frame.width - 16
                
                if selectedIndexPath1 == indexPath {
                    cell.isSelected = true
//                    for title in titleNoOfIngridientArray{
//                        if title == str2{
//                            cell.isSelected = true
//                            titlesCount[indexPath.section] = ["1"]
//                        }
//                     }
                }
                else if str2.contains(comparsionString: titleNoOfIngridientArray[indexPath.row]) {
                     cell.isSelected = true
                    titlesCount[indexPath.section] = ["1"]
                 }
                
            case 2:
                cell.tagLabel.text = arrayMeal?[indexPath.row].mealName
                cell.tagLabel.preferredMaxLayoutWidth = collectionView.frame.width - 16
                
                if selectedIndexPath2 == indexPath {
                    cell.isSelected = true
                }
                else if strMeal.contains(comparsionString: "\(arrayMeal?[indexPath.row].recipeMealId ?? 0)") {
                     cell.isSelected = true
                    titlesCount[indexPath.section] = ["1"]
                 }

            case 3:
                cell.tagLabel.text = arrayCuisine?[indexPath.row].cuisineName
                cell.tagLabel.preferredMaxLayoutWidth = collectionView.frame.width - 16
                
                if selectedIndexPath3 == indexPath {
                    cell.isSelected = true
                }
                else if strCuisin.contains(comparsionString: "\(arrayCuisine?[indexPath.row].cuisineId ?? 0)") {
                     cell.isSelected = true
                    titlesCount[indexPath.section] = ["1"]
                 }
                
            default:
                break
                
            }
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TagCollectionViewCell,
              let text = cell.tagLabel.text else {return}
        if isFrom == "Ingridients"{
            switch indexPath.section{
            case 0:
                
                guard selectedIndexPath != indexPath else { return }
                if let index = selectedIndexPath {
                    let cell1 = collectionView.cellForItem(at: index) as! TagCollectionViewCell
                    cell1.isSelected = false
                    
                }
               
                let cellcook = collectionView.cellForItem(at: indexPath) as! TagCollectionViewCell
                cellcook.isSelected = true
                selectedIndexPath = indexPath
                titlesCount[indexPath.section] = ["1"]
                 str1 = titleTimeArray[selectedIndexPath!.item]
                strTime = str1.westernArabicNumeralsOnly
                
               
                
            case 1:
                
                guard selectedIndexPath1 != indexPath else { return }
                if let index = selectedIndexPath1 {
                    let cell = collectionView.cellForItem(at: index) as! TagCollectionViewCell
                    cell.isSelected = false
                }
                
                
                let cell = collectionView.cellForItem(at: indexPath) as! TagCollectionViewCell
                cell.isSelected = true
                selectedIndexPath1 = indexPath
                titlesCount[indexPath.section] = ["1"]
                str2 = titleNoOfIngridientArray[selectedIndexPath1!.item]
                strNoOfIngridient = str1.westernArabicNumeralsOnly
                
            case 2:
                
                guard selectedIndexPath2 != indexPath else { return }
                if let index = selectedIndexPath2 {
                    let cell = collectionView.cellForItem(at: index) as! TagCollectionViewCell
                    cell.isSelected = false
                }
                
                
                
                let cell = collectionView.cellForItem(at: indexPath) as! TagCollectionViewCell
                cell.isSelected = true
                selectedIndexPath2 = indexPath
                titlesCount[indexPath.section] = ["1"]
                strMeal = "\(arrayMeal?[selectedIndexPath2!.item].recipeMealId ?? 0)"
                
            case 3:
                
                guard selectedIndexPath3 != indexPath else { return }
                if let index = selectedIndexPath3 {
                    let cell = collectionView.cellForItem(at: index) as! TagCollectionViewCell
                    cell.isSelected = false
                }
                
                
                let cell = collectionView.cellForItem(at: indexPath) as! TagCollectionViewCell
                cell.isSelected = true
                selectedIndexPath3 = indexPath
                titlesCount[indexPath.section] = ["1"]
                strCuisin = "\(arrayCuisine?[selectedIndexPath3!.item].cuisineId ?? 0)"
                
            case 4:
                let id = "\(arrayChildIngridient?[indexPath.row].recipeIngredientIds ?? 0)"
               parentRecipeId = "\(arrayChildIngridient?[indexPath.item].parent ?? -1)"

                if selectedIngridientId.contains(obj: String.getString(arrayChildIngridient?[indexPath.row].recipeIngredientIds)){
                    selectedIngridientId = selectedIngridientId.filter { $0 != id }
                    titlesCount[indexPath.section] = titlesCount[indexPath.section].filter{$0 != text}
                } else {
                    selectedIngridientId.append(id)
                    titlesCount[indexPath.section].append(text)
                    selectedIndexPath4 = indexPath
                }
                
                
            
//                if selectedIndexPath4 != indexPath && !titlesCount[indexPath.section].contains(arrayChildIngridient?[indexPath.row].ingridientTitle ?? ""){
//                                    selectedIndexPath4 = indexPath
//                                    titlesCount[indexPath.section].append(text)
//                                    let id = "\(arrayChildIngridient?[indexPath.row].recipeIngredientIds ?? 0)"
//                                    selectedIngridientId.append(id)
//
//                                    parentRecipeId = "\(arrayChildIngridient?[indexPath.item].parent ?? -1)"
//                                }
//                                else if selectedIndexPath4 == indexPath || titlesCount[indexPath.section].contains(arrayChildIngridient?[indexPath.row].ingridientTitle ?? ""){
//                                    titlesCount[indexPath.section] = titlesCount[indexPath.section].filter{$0 != text}
//                                }
                
            default:
                break
            }
        }
        else if isFrom == "Meal"{
            switch indexPath.section{
            case 0:
                guard selectedIndexPath != indexPath else { return }
                if let index = selectedIndexPath {
                    let cell = collectionView.cellForItem(at: index) as! TagCollectionViewCell
                    cell.isSelected = false
                    
                }
                
                
                let cell = collectionView.cellForItem(at: indexPath) as! TagCollectionViewCell
                cell.isSelected = true
                selectedIndexPath = indexPath
                titlesCount[indexPath.section] = ["1"]
                 str1 = titleTimeArray[selectedIndexPath!.item]
                strTime = str1.westernArabicNumeralsOnly
              
                
            case 1:
                guard selectedIndexPath1 != indexPath else { return }
                if let index = selectedIndexPath1 {
                    let cell = collectionView.cellForItem(at: index) as! TagCollectionViewCell
                    cell.isSelected = false
                }
                
                
                let cell = collectionView.cellForItem(at: indexPath) as! TagCollectionViewCell
                cell.isSelected = true
                selectedIndexPath1 = indexPath
                titlesCount[indexPath.section] = ["1"]
                str2 = titleNoOfIngridientArray[selectedIndexPath1!.item]
                strNoOfIngridient = str1.westernArabicNumeralsOnly
                
            case 2:
                guard selectedIndexPath2 != indexPath else { return }
                if let index = selectedIndexPath2 {
                    let cell = collectionView.cellForItem(at: index) as! TagCollectionViewCell
                    cell.isSelected = false
                }
                
                
                let cell = collectionView.cellForItem(at: indexPath) as! TagCollectionViewCell
                cell.isSelected = true
                selectedIndexPath2 = indexPath
                titlesCount[indexPath.section] = ["1"]
                strCuisin = "\(arrayCuisine?[selectedIndexPath2!.item].cuisineId ?? 0)"
            default:
                break
            }
        }
        else{
            switch indexPath.section{
            case 0:
                guard selectedIndexPath != indexPath else { return }
                if let index = selectedIndexPath {
                    let cell = collectionView.cellForItem(at: index) as! TagCollectionViewCell
                    cell.isSelected = false
                    
                }
                
                
                let cell = collectionView.cellForItem(at: indexPath) as! TagCollectionViewCell
                cell.isSelected = true
                selectedIndexPath = indexPath
                titlesCount[indexPath.section] = ["1"]
                 str1 = titleTimeArray[selectedIndexPath!.item]
                strTime = str1.westernArabicNumeralsOnly
              
            case 1:
                guard selectedIndexPath1 != indexPath else { return }
                if let index = selectedIndexPath1 {
                    let cell = collectionView.cellForItem(at: index) as! TagCollectionViewCell
                    cell.isSelected = false
                }
                
                
                let cell = collectionView.cellForItem(at: indexPath) as! TagCollectionViewCell
                cell.isSelected = true
                selectedIndexPath1 = indexPath
                titlesCount[indexPath.section] = ["1"]
                str2 = titleNoOfIngridientArray[selectedIndexPath1!.item]
                strNoOfIngridient = str1.westernArabicNumeralsOnly
                
            case 2:
                guard selectedIndexPath2 != indexPath else { return }
                if let index = selectedIndexPath2 {
                    let cell = collectionView.cellForItem(at: index) as! TagCollectionViewCell
                    cell.isSelected = false
                }
                
                
                let cell = collectionView.cellForItem(at: indexPath) as! TagCollectionViewCell
                cell.isSelected = true
                selectedIndexPath2 = indexPath
                titlesCount[indexPath.section] = ["1"]
                strMeal = "\(arrayMeal?[selectedIndexPath2!.item].recipeMealId ?? 0)"
            case 3:
                guard selectedIndexPath3 != indexPath else { return }
                if let index = selectedIndexPath3 {
                    let cell = collectionView.cellForItem(at: index) as! TagCollectionViewCell
                    cell.isSelected = false
                }
                
                
                let cell = collectionView.cellForItem(at: indexPath) as! TagCollectionViewCell
                cell.isSelected = true
                selectedIndexPath3 = indexPath
                titlesCount[indexPath.section] = ["1"]
                strCuisin = "\(arrayCuisine?[selectedIndexPath3!.item].cuisineId ?? 0)"
            default:
                break
            }
        }
        
        UIView.performWithoutAnimation{
            let section = IndexSet(integer: indexPath.section)
            collectionView.reloadSections(section)
        }
//
//        collectionView.reloadData()
        
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
        return CGSize(width: 300, height: 60)
        
    }
}

extension FilterRecipeViewController{
    
    func getChildIngridients() -> Void{
        TANetworkManager.sharedInstance.requestApi(withServiceName: "\(APIUrl.Recipes.getChildIngridient)\(parentIngridientId)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [[String:Any]]{
                arrayChildIngridient = data.map({IngridentArray.init(with: $0)})
                
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
extension String {
    var westernArabicNumeralsOnly: String {
        let pattern = UnicodeScalar("0")..."9"
        return String(unicodeScalars
                        .compactMap { pattern ~= $0 ? Character($0) : nil })
    }
}
extension UICollectionView {
   func reloadItems(inSection section:Int) {
      reloadItems(at: (0..<numberOfItems(inSection: section)).map {
         IndexPath(item: $0, section: section)
      })
   }
}
