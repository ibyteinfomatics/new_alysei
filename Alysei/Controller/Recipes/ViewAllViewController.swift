//
//  ViewAllViewController.swift
//  Preferences
//
//  Created by mac on 27/08/21.
//

import UIKit

class ViewAllViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchIngridientTextField: UITextField!
    var arraySearchByIngridient : [IngridentArray]? = []
    var searchText = String()
    var searching = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchIngridientTextField.delegate = self
        searchIngridientTextField.translatesAutoresizingMaskIntoConstraints = true
        headerView.layer.masksToBounds = false
        headerView.layer.shadowRadius = 2
        headerView.layer.shadowOpacity = 0.2
        headerView.layer.shadowColor = UIColor.lightGray.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0 , height:2)
        searchIngridientTextField.keyboardType = .default
        getSearchByIngridients()
    }
    
    @IBAction func tapBack(_ sender: Any) {
        if searching == true{
            self.searching = false
            self.searchIngridientTextField.text = ""
            getSearchByIngridients()
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func getSearchByIngridients(){
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
    }
    }
    
    func callSearchIngridients(){

        TANetworkManager.sharedInstance.requestApi(withServiceName: "\(APIUrl.Recipes.searchIngridient)\(searchText)&type=1" , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [[String:Any]]{
                self.arraySearchByIngridient = data.map({IngridentArray.init(with: $0)})
                self.searching = true
                self.collectionView.reloadData()

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
        let imgUrl = (kImageBaseUrl + (arraySearchByIngridient?[indexPath.item].imageId?.imgUrl ?? ""))
        
        cell.ingredientsImage.setImage(withString: imgUrl)
        cell.ingredientsImage.layer.cornerRadius = cell.ingredientsImage.frame.height/2
        cell.ingredientsImage.contentMode = .scaleAspectFill
        cell.ingredientsLabel.text = arraySearchByIngridient?[indexPath.item].ingridientTitle
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchTitle = arraySearchByIngridient?[indexPath.row].ingridientTitle ?? ""
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilteredRecipeViewController") as! FilteredRecipeViewController
        vc.searching = true
        vc.indexOfPageToRequest = 1
        vc.searchText = searchTitle
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellSize = CGSize(width: (collectionView.bounds.width)/3 - 10, height: 180)
        return cellSize
    }
}
extension ViewAllViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchIngridientTextField.becomeFirstResponder()
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        searchText = string
        if searchText.count > 0 {
            
            callSearchIngridients()
           hideKeyboardWhenTappedAround()
        }
        else{
            self.searching = false
            getSearchByIngridients()
            collectionView.reloadData()
        }
        
        return true
    }
}
