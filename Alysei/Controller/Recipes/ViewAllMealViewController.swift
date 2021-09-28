//
//  ViewAllMealViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 27/09/21.
//

import UIKit

class ViewAllMealViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchIngridientTextField: UITextField!
    var arraySearchByMeal : [SelectMealDataModel]? = []
    var searchText = String()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        searchIngridientTextField.delegate = self
        headerView.layer.masksToBounds = false
        headerView.layer.shadowRadius = 2
        headerView.layer.shadowOpacity = 0.2
        headerView.layer.shadowColor = UIColor.lightGray.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0 , height:2)
        getSearchByMeal()
    }
    
    @IBAction func tapBack(_ sender: Any) {
        if searching == true{
        self.searching = false
        self.searchIngridientTextField.text = ""
        getSearchByMeal()
    }
    else{
        self.navigationController?.popViewController(animated: true)
    }
    
    }
    
    func getSearchByMeal(){
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
    }
    }
    
    func callSearchMeal(){

        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getSearchMeal + searchText , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [[String:Any]]{
                self.arraySearchByMeal = data.map({SelectMealDataModel.init(with: $0)})
                self.searching = true
                self.collectionView.reloadData()

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
        let imgUrl = (kImageBaseUrl + (arraySearchByMeal?[indexPath.item].imageId?.imgUrl ?? ""))
        
        cell.ingredientsImage.setImage(withString: imgUrl)
        cell.ingredientsImage.layer.cornerRadius = cell.ingredientsImage.frame.height/2
        cell.ingredientsImage.contentMode = .scaleAspectFill
        cell.ingredientsLabel.text = arraySearchByMeal?[indexPath.item].mealName
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellSize = CGSize(width: (collectionView.bounds.width)/3 - 10, height: 180)
        return cellSize
    }
}
extension ViewAllMealViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchIngridientTextField.becomeFirstResponder()
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        searchText = string
        if searchText.count > 0 {
            
           callSearchMeal()
           hideKeyboardWhenTappedAround()
        }
        else{
            self.searching = false
           getSearchByMeal()
            collectionView.reloadData()
        }
        
        return true
    }
}
