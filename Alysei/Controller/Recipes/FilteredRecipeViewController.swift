//
//  FilteredRecipeViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 30/09/21.
//

import UIKit
var searching = false
var isFilterLoading = false

class FilteredRecipeViewController: UIViewController {

    @IBOutlet weak var searchRecipeTextField: UITextField!
    @IBOutlet weak var filteredCollectionView: UICollectionView!
    @IBOutlet weak var labelRecipe: UILabel!
    @IBOutlet weak var viewHeader: UIView!
    
    @IBOutlet weak var viewFilter: UIView!
    var searchRecipeModel : SearchRecipeDataModel?
    var arrSearchRecipeDataModel: [DataRecipe]? = []
    var indexOfPageToRequest = 1
   
   
    var searchText = String()
    var updatedText = String()
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        if searching == true{
            
//            if isFrom == "Meal"{
//                self.viewHeader.isHidden = true
//                self.labelRecipe.text = searchTitle
//                callSearchRecipe("keyword=", searchTitle, indexOfPageToRequest)
//            }
//            else if isFrom == "Ingridients"{
//                self.viewHeader.isHidden = true
//                self.labelRecipe.text = searchTitle
//                callSearchRecipe("keyword=", searchTitle, indexOfPageToRequest)
//            }
//            else if isFrom == "Region"{
//                self.viewHeader.isHidden = true
//                self.labelRecipe.text = searchTitle
//                callSearchRecipe("keyword=", searchTitle, indexOfPageToRequest)
//            }
           
//            else{
//                self.viewHeader.isHidden = false
//                self.labelRecipe.text = searchText
                callSearchRecipe(searchTitle, indexOfPageToRequest)
//            }
            
            
        }
        else if isFilterLoading == true{
            self.viewHeader.isHidden = true
            getFilterRecipe()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellNib = UINib(nibName: "MyRecipeCollectionViewCell", bundle: nil)
        self.filteredCollectionView.register(cellNib, forCellWithReuseIdentifier: "MyRecipeCollectionViewCell")
        self.searchRecipeTextField.delegate = self
        self.searchRecipeTextField.autocorrectionType = .no
        viewHeader.layer.cornerRadius = 10
        labelRecipe.connect(with: searchRecipeTextField)
        filteredCollectionView.delegate = self
        filteredCollectionView.dataSource = self
        if searching == true{
            self.searchRecipeTextField.resignFirstResponder()
//            if isFrom == "Meal"{
//
//                callSearchRecipe("keyword=", searchTitle, indexOfPageToRequest)
//            }
//            else if isFrom == "Ingridients"{
//
//                callSearchRecipe("keyword=", searchTitle, indexOfPageToRequest)
//            }
//            else if isFrom == "Region"{
//
//                callSearchRecipe("keyword=", searchTitle, indexOfPageToRequest)
//            }
            callSearchRecipe(searchTitle, indexOfPageToRequest)
        }
        else{
            self.searchRecipeTextField.becomeFirstResponder()
            
        }
    }
    

   
    @IBAction func tapBack(_ sender: Any) {
        searching = false
        isFrom = ""
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func tapToGoFilter(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterRecipeViewController") as! FilterRecipeViewController
        self.searchRecipeTextField.resignFirstResponder()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callSearchRecipe(_ text: String, _ pageNo: Int?){

        TANetworkManager.sharedInstance.requestApi(withServiceName: "\(APIUrl.Recipes.getSearchRecipe)\(text)&page=pageNo" , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
            
        
            switch statusCode{
            case 200:
            
                let dictResponse = dictResponse as? [String:Any]
                
                if let data = dictResponse?["data"] as? [String:Any]{
                    self.searchRecipeModel = SearchRecipeDataModel.init(with: data)
                    if self.indexOfPageToRequest == 1 { self.arrSearchRecipeDataModel?.removeAll() }
                    self.arrSearchRecipeDataModel?.append(contentsOf: self.searchRecipeModel?.dataRecipe ?? [DataRecipe(with: [:])])
                    searching = true
                    self.viewFilter.isHidden = false
                    self.filteredCollectionView.reloadData()
                    
                }
            case 409:
                self.arrSearchRecipeDataModel?.removeAll()
                self.filteredCollectionView.reloadData()
                self.viewFilter.isHidden = true
                self.showAlert(withMessage: "No Recipe found")
                
            default:
               
                self.showAlert(withMessage: "No Recipe found")
                self.viewFilter.isHidden = false
            }
            
            
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height - (self.view.frame.height * 2) {
            if isFilterLoading == false{
                if indexOfPageToRequest < searchRecipeModel?.lastPage ?? 0{
                    self.showAlert(withMessage: "No More Data Found")
                }else{
                // increments the number of the page to request
                indexOfPageToRequest += 1

                // call your API for more data
                    if isFrom == "Meal" || isFrom == "Ingridients" || isFrom == "Region"{
//
                        callSearchRecipe(searchTitle, indexOfPageToRequest)
                    }
//                    else if isFrom == "Ingridients"{
//
//                        callSearchRecipe("keyword=", searchTitle, indexOfPageToRequest)
//                    }
//                    else if isFrom == "Region"{
//
//                        callSearchRecipe("keyword=", searchTitle, indexOfPageToRequest)
//                    }
                    else{
                        callSearchRecipe(searchTitle, indexOfPageToRequest)
                    }
                   

                // tell the table view to reload with the new data
                self.filteredCollectionView.reloadData()
                }
            }
            else{
                if indexOfPageToRequest < searchRecipeModel?.lastPage ?? 0{
                    self.showAlert(withMessage: "No More Data Found")
                }else{
                // increments the number of the page to request
                indexOfPageToRequest += 1

                // call your API for more data
                     getFilterRecipe()

                // tell the table view to reload with the new data
                self.filteredCollectionView.reloadData()
                }
            }
           
        }
    }
    
    func getFilterRecipe() -> Void{
       
        let formattedArray = (selectedIngridientId.map{String($0)}).joined(separator: ",")
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getFilterRecipe + "\(strTime )" + "&no_of_ingredients=" + "\(strNoOfIngridient )" + "&meal_type=" + "\(strMeal)" + "&cousin_id=" + "\(strCuisin)" + "&child_ingredient=" + "\(formattedArray)" + "&parent_ingredient=" + "\(parentRecipeId)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (response, error, errorType, statusCode) in
            
          
            switch statusCode{
            case 200:
            
                let dictResponse = response as? [String:Any]
                
                if let data = dictResponse?["data"] as? [String:Any]{
                    
                    self.searchRecipeModel = SearchRecipeDataModel.init(with: data)
                    if self.indexOfPageToRequest == 1 {self.arrSearchRecipeDataModel?.removeAll() }
                    self.arrSearchRecipeDataModel?.append(contentsOf: self.searchRecipeModel?.dataRecipe ?? [DataRecipe(with: [:])])
                   searching = true
                    self.filteredCollectionView.reloadData()
                }
            case 409:
                
                self.arrSearchRecipeDataModel?.removeAll()
                self.filteredCollectionView.reloadData()
                self.showAlert(withMessage: "No Recipe found")
                
            default:
               
                self.showAlert(withMessage: "No Recipe found")
            }
            
        }
    }
}
extension FilteredRecipeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//          return  self.arrayTrending?.count ?? 0
        if searching == false{
            return 0
        }
        else{
            return arrSearchRecipeDataModel?.count ?? 0
        }
       
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyRecipeCollectionViewCell", for: indexPath) as? MyRecipeCollectionViewCell {
            
            cell.editRecipeButton.isHidden = true
            cell.deaftButton.isHidden = true
                let imgUrl = (kImageBaseUrl + (arrSearchRecipeDataModel?[indexPath.item].image?.imgUrl ?? ""))
                
                cell.recipeImageView.setImage(withString: imgUrl)
            
                cell.recipeImageView.contentMode = .scaleAspectFill
              
                 if arrSearchRecipeDataModel?[indexPath.item].name == ""{
                    cell.recipeName.text = "NA"
                 }
                 else{
                    cell.recipeName.text = arrSearchRecipeDataModel?[indexPath.item].name
                 }
                cell.likeLabel.text = "\(arrSearchRecipeDataModel?[indexPath.item].totalLikes ?? 0)" + " " + "Likes"
            
            if arrSearchRecipeDataModel?[indexPath.item].username == ""{
               cell.userNameLabel.text = "NA"
            }
            else{
                cell.userNameLabel.text = arrSearchRecipeDataModel?[indexPath.item].username
            }
                
                cell.timeLabel.text = "\( arrSearchRecipeDataModel?[indexPath.item].hours ?? 0)" + " " + "hours" + " " + "\( arrSearchRecipeDataModel?[indexPath.item].minutes ?? 0)" + " " + "minutes"
                cell.servingLabel.text = "\(arrSearchRecipeDataModel?[indexPath.item].serving ?? 0)" + " " + "Serving"
                cell.typeLabel.text = arrSearchRecipeDataModel?[indexPath.item].meal?.mealName ?? "NA"
            
            if arrSearchRecipeDataModel?[indexPath.row].avgRating ?? "0.0" == "0.0" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
               
            }
            else if arrSearchRecipeDataModel?[indexPath.row].avgRating ?? "0.0" == "0.5" {
                cell.rating1ImgVw.image = UIImage(named: "Group 1142")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
               cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrSearchRecipeDataModel?[indexPath.row].avgRating ?? "0.0" == "1.0" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
               cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }
            else if arrSearchRecipeDataModel?[indexPath.row].avgRating ?? "0.0" == "1.5" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "Group 1142")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
               cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrSearchRecipeDataModel?[indexPath.row].avgRating ?? "0.0" == "2.0" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }
            else if arrSearchRecipeDataModel?[indexPath.row].avgRating ?? "0.0" == "2.5" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "Group 1142")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrSearchRecipeDataModel?[indexPath.row].avgRating ?? "0.0" == "3.0" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }
            else if arrSearchRecipeDataModel?[indexPath.row].avgRating ?? "0.0" == "3.5" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating4ImgvW.image = UIImage(named: "Group 1142")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrSearchRecipeDataModel?[indexPath.row].avgRating ?? "0.0" == "4.0" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }
            else if arrSearchRecipeDataModel?[indexPath.row].avgRating ?? "0.0" == "4.5" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell.rating5ImgVw.image = UIImage(named: "Group 1142")
            }else if arrSearchRecipeDataModel?[indexPath.row].avgRating ?? "0.0" == "5.0" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star")
            }
            return cell
           
           
        }
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
        return CGSize(width: (self.filteredCollectionView.frame.width), height: 260.0)
       }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if delegate != nil {
//            delegate?.cellTapped()
//            }
//
//}

}

extension FilteredRecipeViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchRecipeTextField.becomeFirstResponder()
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        searchText = string
        
        
        if searchText.count > 0 {
            searching = true
            if let text = textField.text,
                       let textRange = Range(range, in: text) {
                       let updateText = text.replacingCharacters(in: textRange,
                                                                   with: string)
                updatedText = updateText
                
                callSearchRecipe(updatedText, indexOfPageToRequest)
                    }
            
        }
        else{
            searching = false
            filteredCollectionView.reloadData()
        }
        
        return true
    }
}

extension UILabel {
    @objc
    func input(textField: UITextField) {
        self.text = textField.text
    }
    
    func connect(with textField:UITextField){
            textField.addTarget(self, action: #selector(UILabel.input(textField:)), for: .editingChanged)
        }
}

