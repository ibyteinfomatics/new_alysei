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
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var searchRecipeTextField: UITextField!
    @IBOutlet weak var filteredCollectionView: UICollectionView!
    @IBOutlet weak var labelRecipe: UILabel!
    @IBOutlet weak var viewHeader: UIView!
    
    @IBOutlet weak var viewFilter: UIView!
    @IBOutlet weak var BlankView: UIView!
    @IBOutlet weak var noRecipeLabel: UILabel!
    @IBOutlet weak var FilterBtn: UIButton!
    var searchRecipeModel : SearchRecipeDataModel?
    var arrSearchRecipeDataModel: [DataRecipe]? = []
    var indexOfPageToRequest = 1
    
    var searchText = String()
    var updatedText = String()
 
    override func viewWillAppear(_ animated: Bool) {
        
        searchRecipeTextField.placeholder = RecipeConstants.kSearchRecipe
        noRecipeLabel.text = RecipeConstants.kNoRecipe
        FilterBtn.setTitle(RecipeConstants.kFilter, for: .normal)
        
        indexOfPageToRequest = 1
        if searching == true{
            
            if isFrom == "Meal"{
                self.viewHeader.isHidden = true
                self.labelRecipe.text = searchTitle
                callSearchRecipe(searchTitle, "", indexOfPageToRequest, "", "", "", "", "", "")
                
            }
            else if isFrom == "Ingridients"{
                self.viewHeader.isHidden = true
                self.labelRecipe.text = searchTitle
                callSearchRecipe(searchTitle, "", indexOfPageToRequest, "", "", "", "", "", "")
                
            }
            else if isFrom == "Region"{
                self.viewHeader.isHidden = true
                self.labelRecipe.text = searchTitle
                callSearchRecipe(searchTitle, "", indexOfPageToRequest, "", "", "", "", "", "")
                
            }
            
            else{
                self.viewHeader.isHidden = false
                self.viewFilter.isHidden = true
                self.labelRecipe.text = updatedText
                callSearchRecipe(updatedText, "", indexOfPageToRequest, "", "", "", "", "", "")
            }
            
        }
        else if isFilterLoading == true{
            
            if isFrom == "Meal" {
                self.viewHeader.isHidden = true
                let formattedArray = (selectedIngridientId.map{String($0)}).joined(separator: ",")
                
                callSearchRecipe(searchTitle, "", indexOfPageToRequest, strTime, strNoOfIngridient, strMeal, strCuisin, formattedArray, parentRecipeId)
                
            }
            else if isFrom == "Ingridients"  {
                self.viewHeader.isHidden = true
                let formattedArray = (selectedIngridientId.map{String($0)}).joined(separator: ",")
                
                callSearchRecipe(searchTitle, "", indexOfPageToRequest, strTime, strNoOfIngridient, strMeal, strCuisin, formattedArray, parentRecipeId)
            }
            else if isFrom == "Region" {
                self.viewHeader.isHidden = true
                let formattedArray = (selectedIngridientId.map{String($0)}).joined(separator: ",")
                callSearchRecipe(searchTitle, "", indexOfPageToRequest, strTime, strNoOfIngridient, strMeal, strCuisin, formattedArray, parentRecipeId)
            }
            else{
                self.viewHeader.isHidden = true
                let formattedArray = (selectedIngridientId.map{String($0)}).joined(separator: ",")
                
                callSearchRecipe(updatedText, "", indexOfPageToRequest, strTime, strNoOfIngridient, strMeal, strCuisin, formattedArray, parentRecipeId)

            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        BlankView.isHidden = true
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
            if isFrom == "Region"{
                callSearchRecipe(searchTitle, "", indexOfPageToRequest, "", "", "", "", "", "")
            }
            else{
                callSearchRecipe(searchTitle, "", indexOfPageToRequest, "", "", "", "", "", "")
            }
            
        }
        else{
            self.viewFilter.isHidden = true
            self.searchRecipeTextField.becomeFirstResponder()
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.headerView.drawBottomShadow()
    }
    
    
    @IBAction func tapBack(_ sender: Any) {
        searching = false
        isFrom = ""
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
    
    
    @IBAction func tapCross(_ sender: Any) {
        self.searchRecipeTextField.text = nil
        self.labelRecipe.text = ""
        self.viewFilter.isHidden = true
        self.BlankView.isHidden = true
        filteredCollectionView.isHidden = true
    }
    
    @IBAction func tapToGoFilter(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterRecipeViewController") as! FilterRecipeViewController
        self.searchRecipeTextField.resignFirstResponder()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension FilteredRecipeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
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
            let imgUrl = ((arrSearchRecipeDataModel?[indexPath.item].base_url ?? "") + (arrSearchRecipeDataModel?[indexPath.item].imageUrl ?? ""))
            
            cell.recipeImageView.setImage(withString: imgUrl)
            
            cell.recipeImageView.contentMode = .scaleAspectFill
            
            if arrSearchRecipeDataModel?[indexPath.item].name == ""{
                cell.recipeName.text = RecipeConstants.kNA
            }
            else{
                cell.recipeName.text = arrSearchRecipeDataModel?[indexPath.item].name
            }
            cell.likeLabel.text = "\(arrSearchRecipeDataModel?[indexPath.item].totalLikes ?? 0)" + " " + RecipeConstants.kHours
            
            if arrSearchRecipeDataModel?[indexPath.item].username == ""{
                cell.userNameLabel.text = RecipeConstants.kNA
            }
            else{
                cell.userNameLabel.text = arrSearchRecipeDataModel?[indexPath.item].username
            }
            
            cell.timeLabel.text = "\( arrSearchRecipeDataModel?[indexPath.item].hours ?? 0)" + " " + RecipeConstants.kHours + " " + "\( arrSearchRecipeDataModel?[indexPath.item].minutes ?? 0)" + " " + RecipeConstants.kMinutes
            cell.servingLabel.text = "\(arrSearchRecipeDataModel?[indexPath.item].serving ?? 0)" + " " + RecipeConstants.kServingHome
            cell.typeLabel.text = arrSearchRecipeDataModel?[indexPath.item].meal ?? RecipeConstants.kNA
            
            if arrSearchRecipeDataModel?[indexPath.item].isFavourite == 0{
                cell.heartBtn.setImage(UIImage(named: "like_icon_white.png"), for: .normal)
            }
            else{
                cell.heartBtn.setImage(UIImage(named: "liked_icon.png"), for: .normal)
            }
            
            if arrSearchRecipeDataModel?[indexPath.row].avgRating == "0.0" || arrSearchRecipeDataModel?[indexPath.row].avgRating  == "0" {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }  else if (arrSearchRecipeDataModel?[indexPath.row].avgRating  ?? "0") >= ("0.1") && (arrSearchRecipeDataModel?[indexPath.row].avgRating  ?? "0") <= ("0.9") {
                cell.rating1ImgVw.image = UIImage(named: "HalfStar")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrSearchRecipeDataModel?[indexPath.row].avgRating == ("1.0") || arrSearchRecipeDataModel?[indexPath.row].avgRating  == ("1") {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if (arrSearchRecipeDataModel?[indexPath.row].avgRating ?? "0") >= ("1.1") && (arrSearchRecipeDataModel?[indexPath.row].avgRating ?? "0") <= ("1.9"){
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "HalfStar")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrSearchRecipeDataModel?[indexPath.row].avgRating == ("2.0") || arrSearchRecipeDataModel?[indexPath.row].avgRating  == ("2"){
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if (arrSearchRecipeDataModel?[indexPath.row].avgRating ?? "0") >= ("2.1") && (arrSearchRecipeDataModel?[indexPath.row].avgRating  ?? "0") <= ("2.9"){
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "HalfStar")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrSearchRecipeDataModel?[indexPath.row].avgRating  == ("3.0") || arrSearchRecipeDataModel?[indexPath.row].avgRating  == ("3"){
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if (arrSearchRecipeDataModel?[indexPath.row].avgRating ?? "0") >= ("3.1") && (arrSearchRecipeDataModel?[indexPath.row].avgRating  ?? "0") <= ("3.9") {
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating4ImgvW.image = UIImage(named: "HalfStar")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if arrSearchRecipeDataModel?[indexPath.row].avgRating  == ("4.0") || arrSearchRecipeDataModel?[indexPath.row].avgRating  == ("4"){
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
            }else if (arrSearchRecipeDataModel?[indexPath.row].avgRating  ?? "0") >= ("4.1") && (arrSearchRecipeDataModel?[indexPath.row].avgRating  ?? "0") <= ("4.9"){
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell.rating5ImgVw.image = UIImage(named: "HalfStar")
            }else if arrSearchRecipeDataModel?[indexPath.row].avgRating  == ("5.0") || arrSearchRecipeDataModel?[indexPath.row].avgRating  == ("5"){
                cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star")
            }else{cell.rating1ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating2ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating3ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating4ImgvW.image = UIImage(named: "icons8_christmas_star_2")
                cell.rating5ImgVw.image = UIImage(named: "icons8_christmas_star_2")
                print("Invalid Rating")
            }
            return cell
        }
       
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: (self.filteredCollectionView.frame.width), height: 260.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewRecipeViewController") as! ViewRecipeViewController
        recipeId = (arrSearchRecipeDataModel?[indexPath.row].recipeId)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension FilteredRecipeViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchRecipeTextField.becomeFirstResponder()
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updateText = text.replacingCharacters(in: textRange,
                                                      with: string)
            if updateText.count > 0 {
                searching = true
                filteredCollectionView.isHidden = false
                
                updatedText = updateText
                
                callSearchRecipe(updatedText,"", indexOfPageToRequest, "", "", "", "", "", "")
            }
            else{
                searching = false
                self.viewFilter.isHidden = true
                self.BlankView.isHidden = true
                filteredCollectionView.reloadData()
            }
            
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

extension FilteredRecipeViewController{
    
    func callSearchRecipe(_ text: String, _ regionId: String?, _ pageNo: Int?, _ time: String?, _ noOfIngridient: String?, _ meal: String?, _ cousin: String?, _ childIngridient: String?, _ parentId: String?){
        
        let originalUrl = "\(APIUrl.Recipes.getSearchRecipe)\(text)" + "&region_id=" + "\(regionId ?? "")" + "&page=" + "\(pageNo ?? 0)" + "&cook_time=" + "\(time ?? "" )" + "&no_of_ingredients=" + "\(noOfIngridient ?? "" )" + "&meal_type=" + "\(meal ?? "")" + "&cousin_id=" + "\(cousin ?? "")" + "&child_ingredient=" + "\(childIngridient ?? "")" + "&parent_ingredient=" + "\(parentId ?? "")"
        
        let urlString = originalUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: urlString, requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
            
            
            switch statusCode{
            case 200:
                
                let dictResponse = dictResponse as? [String:Any]
                
                if let data = dictResponse?["data"] as? [String:Any]{
                    self.searchRecipeModel = SearchRecipeDataModel.init(with: data)
                    if self.indexOfPageToRequest == 1 { self.arrSearchRecipeDataModel?.removeAll()
                    }
                    self.arrSearchRecipeDataModel?.append(contentsOf: self.searchRecipeModel?.dataRecipe ?? [DataRecipe(with: [:])])
                    searching = true
                    self.viewFilter.isHidden = false
                    self.BlankView.isHidden = true
                    self.filteredCollectionView.reloadData()
                    
                }
            case 409:
               
                if  self.indexOfPageToRequest == 1{
                    self.BlankView.isHidden = false
                    self.arrSearchRecipeDataModel?.removeAll()
                    self.filteredCollectionView.reloadData()
                    self.viewFilter.isHidden = true
                }
            default:
                
                if self.arrSearchRecipeDataModel?.count == 0{
                    
                    if self.arrSearchRecipeDataModel?.count == 0 {
                        self.BlankView.isHidden = false
                    }else{
                        self.BlankView.isHidden = true
                    }
                }else{
                    //  self.blankView.isHidden = false
                    print("No Data")
                }
                
            }
            self.filteredCollectionView.reloadData()
            
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height - (self.view.frame.height * 2) {
            if isFilterLoading == false{
                if indexOfPageToRequest > searchRecipeModel?.lastPage ?? 0{
                    print(1)
                }else{
                    // increments the number of the page to request
                    indexOfPageToRequest += 1
                    
                    // call your API for more data
                    if isFrom == "Meal"{
                        
                        callSearchRecipe(searchTitle, "", indexOfPageToRequest, "", "", "", "", "", "")
                        
                    }
                    else if isFrom == "Ingridients"{
                        
                        callSearchRecipe(searchTitle, "", indexOfPageToRequest, "", "", "", "", "", "")
                        
                    }
                    else if isFrom == "Region"{
                        
                        callSearchRecipe(searchTitle, "", indexOfPageToRequest, "", "", "", "", "", "")
                        
                    }
                    
                    else{
                        callSearchRecipe(updatedText, "", indexOfPageToRequest, "", "", "", "", "", "")
                    }
                    
                    // tell the table view to reload with the new data
                    self.filteredCollectionView.reloadData()
                    
                }
            }
            else{
                if indexOfPageToRequest > searchRecipeModel?.lastPage ?? 0{
                    //                    self.showAlert(withMessage: "No More Data Found")
                }else{
                    // increments the number of the page to request
                    indexOfPageToRequest += 1
                    let formattedArray = (selectedIngridientId.map{String($0)}).joined(separator: ",")
                    
                    // call your API for more data
                    if isFrom == "Meal" {
                        callSearchRecipe(searchTitle, "", indexOfPageToRequest, strTime, strNoOfIngridient, strMeal, strCuisin, formattedArray, parentRecipeId)
                        
                    }
                    else if isFrom == "Ingridients"  {
                        
                        callSearchRecipe(searchTitle, "", indexOfPageToRequest, strTime, strNoOfIngridient, strMeal, strCuisin, formattedArray, parentRecipeId)
                    }
                    else if isFrom == "Region" {
                        callSearchRecipe(searchTitle, "", indexOfPageToRequest, strTime, strNoOfIngridient, strMeal, strCuisin, formattedArray, parentRecipeId)
                    }
                    else{
                        callSearchRecipe(updatedText, "", indexOfPageToRequest, strTime, strNoOfIngridient, strMeal, strCuisin, formattedArray, parentRecipeId)
                        
                    }
                    
                    // tell the table view to reload with the new data
                    self.filteredCollectionView.reloadData()
                }
            }
            
        }
    }
    
}
