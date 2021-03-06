//
//  ViewAllMealViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 27/09/21.
//

import UIKit

class ViewAllMealViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchIngridientTextField: UITextField!
    
    var arraySearchByMeal : [SelectMealDataModel]? = []
    var searchText = String()
    var searching1 = false
    var delegate: SearchRecipeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = RecipeConstants.kByMeal
        searchIngridientTextField.placeholder = RecipeConstants.kSearchMeal
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchIngridientTextField.delegate = self
        searchIngridientTextField.autocorrectionType = .no
        getSearchByMeal()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        headerView.drawBottomShadow()
    }
    
    @IBAction func tapBack(_ sender: Any) {
        if searching1 == true{
            self.searching1 = false
            self.searchIngridientTextField.text = ""
            getSearchByMeal()
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func tapCross(_ sender: Any) {
        self.searchIngridientTextField.text = nil
        self.getSearchByMeal()
    }
    
    func getSearchByMeal(){
        self.view.isUserInteractionEnabled = false
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getRecipeHomeScreen
                                                   , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                
                if let meals = data["meals"] as? [[String:Any]]{
                    let meal = meals.map({SelectMealDataModel.init(with: $0)})
                    self.arraySearchByMeal = meal
                    print("\(String(describing: arraySearchByMeal?.count))")
                }
                
            }
            self.collectionView.reloadData()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    func callSearchMeal(){
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: "\(APIUrl.Recipes.getSearchMeal)\(searchText)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
            switch statusCode{
            case 200:
                let dictResponse = dictResponse as? [String:Any]
                
                if let data = dictResponse?["data"] as? [[String:Any]]{
                    self.arraySearchByMeal = data.map({SelectMealDataModel.init(with: $0)})
                    self.searching1 = true
                    self.collectionView.reloadData()
                    
                }
            case 409:
                self.arraySearchByMeal?.removeAll()
                self.collectionView.reloadData()
                self.showAlert(withMessage: RecipeConstants.kNoMeal)
            default:
                self.arraySearchByMeal?.removeAll()
                self.collectionView.reloadData()
                self.showAlert(withMessage: RecipeConstants.kInternalServerEr)
            }
        }
    }
}

extension ViewAllMealViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arraySearchByMeal?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ViewAllCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewAllCollectionViewCell", for: indexPath) as! ViewAllCollectionViewCell
        let imgUrl = ((arraySearchByMeal?[indexPath.item].imageId?.baseUrl ?? "") + (arraySearchByMeal?[indexPath.item].imageId?.imgUrl ?? ""))
        
        cell.ingredientsImage.setImage(withString: imgUrl)
        cell.ingredientsImage.layer.cornerRadius = cell.ingredientsImage.frame.height/2
        cell.ingredientsImage.contentMode = .scaleAspectFill
        cell.ingredientsImage.layer.borderWidth = 1
        cell.ingredientsImage.layer.borderColor = UIColor.lightGray.cgColor
        cell.ingredientsLabel.text = arraySearchByMeal?[indexPath.item].mealName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isFrom = "Meal"
        mealType = arraySearchByMeal?[indexPath.row].mealName ?? ""
        searchId = "\(arraySearchByMeal?[indexPath.row].recipeMealId ?? -1)"
        searchTitle = arraySearchByMeal?[indexPath.row].mealName ?? ""
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilteredRecipeViewController") as! FilteredRecipeViewController
        searching = true
        vc.indexOfPageToRequest = 1
        vc.searchText = searchTitle
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if MobileDeviceType.IS_IPHONE_6 == true {
            return CGSize(width: self.collectionView.frame.width/3 - 10 , height: 160.0)
        }
        else{
            return CGSize(width: self.collectionView.frame.width/3 - 25 , height: 160.0)
        }
    }
}
extension ViewAllMealViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchIngridientTextField.becomeFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updateText = text.replacingCharacters(in: textRange,
                                                      with: string)
            searchText = updateText
            if searchText.count > 0 {
                callSearchMeal()
                hideKeyboardWhenTappedAround()
            }
            else{
                self.searching1 = false
                self.searchIngridientTextField.text = nil
                getSearchByMeal()
                collectionView.reloadData()
            }
        }
        return true
    }
}
