//
//  ViewAllViewController.swift
//  Preferences
//
//  Created by mac on 27/08/21.
//

import UIKit

var parentIngridientId = Int()

class ViewAllViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchIngridientTextField: UITextField!
    
    var arraySearchByIngridient : [IngridentArray]? = []
    var searchText = String()
    var searching1 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchIngridientTextField.delegate = self
        searchIngridientTextField.translatesAutoresizingMaskIntoConstraints = true
        searchIngridientTextField.keyboardType = .default
        getSearchByIngridients()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        headerView.drawBottomShadow()
    }
    
    @IBAction func tapBack(_ sender: Any) {
        if searching == true{
            self.searching1 = false
            self.searchIngridientTextField.text = ""
            getSearchByIngridients()
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func tapCross(_ sender: Any) {
        self.searchIngridientTextField.text = nil
        getSearchByIngridients()
    }
    
    func getSearchByIngridients(){
        self.view.isUserInteractionEnabled = false
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getRecipeHomeScreen
                                                   , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                
                if let ingridients = data["ingredients"] as? [[String:Any]]{
                    let ingridient = ingridients.map({IngridentArray.init(with: $0)})
                    self.arraySearchByIngridient = ingridient
                    print("\(String(describing: arraySearchByIngridient?.count))")
                }
            }
            self.collectionView.reloadData()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    func callSearchIngridients(){
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: "\(APIUrl.Recipes.searchIngridient)\(searchText)&type=1" , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
            switch statusCode{
            case 200:
                let dictResponse = dictResponse as? [String:Any]
                
                if let data = dictResponse?["data"] as? [[String:Any]]{
                    self.arraySearchByIngridient = data.map({IngridentArray.init(with: $0)})
                    self.searching1 = true
                    self.collectionView.reloadData()
                    
                }
            case 409:
                self.arraySearchByIngridient?.removeAll()
                self.collectionView.reloadData()
                self.showAlert(withMessage: "No Ingridient Found")
            default:
                self.arraySearchByIngridient?.removeAll()
                self.collectionView.reloadData()
                self.showAlert(withMessage: "Internal Server Error")
            }
        }
    }
    
}
extension ViewAllViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arraySearchByIngridient?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ViewAllCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewAllCollectionViewCell", for: indexPath) as! ViewAllCollectionViewCell
        let imgUrl = ((arraySearchByIngridient?[indexPath.item].imageId?.baseUrl ?? "") + (arraySearchByIngridient?[indexPath.item].imageId?.imgUrl ?? ""))
        
        cell.ingredientsImage.setImage(withString: imgUrl)
        cell.ingredientsImage.layer.cornerRadius = cell.ingredientsImage.frame.height/2
        cell.ingredientsImage.contentMode = .scaleAspectFill
        cell.ingredientsImage.layer.borderWidth = 1
        cell.ingredientsImage.layer.borderColor = UIColor.lightGray.cgColor
        cell.ingredientsLabel.text = arraySearchByIngridient?[indexPath.item].ingridientTitle
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isFrom = "Ingridients"
        searchTitle = arraySearchByIngridient?[indexPath.row].ingridientTitle ?? ""
        searchId = "\(arraySearchByIngridient?[indexPath.row].recipeIngredientIds ?? -1)"
        parentIngridientId = (arraySearchByIngridient?[indexPath.item].recipeIngredientIds)!
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilteredRecipeViewController") as! FilteredRecipeViewController
        searching = true
        vc.indexOfPageToRequest = 1
        
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
extension ViewAllViewController: UITextFieldDelegate{
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
                callSearchIngridients()
                hideKeyboardWhenTappedAround()
            }
            else{
                self.searching1 = false
                self.searchIngridientTextField.text = nil
                getSearchByIngridients()
                collectionView.reloadData()
            }
        }
        return true
    }
}
