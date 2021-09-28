//
//  SelectRecipeCategaryViewController.swift
//  Alysei Recipe Module
//
//  Created by mac on 28/07/21.
//

import UIKit

var selectRecipeCategoryJson: [String : Any] = [:]

class SelectRecipeCategaryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UITextFieldDelegate {
 
    
    @IBOutlet weak var recipeCategaryView: UIView!
    @IBOutlet weak var searchRecipe: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var selectRecipeCollectionView: UICollectionView!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var searchBarCategoryTextField: UITextField!
    
    var newSearchModel: [SelectRecepiDataModel]?
    var arrFilterData : [SelectRecepiDataModel]?
    var isSearch : Bool!
    var selectionTracking: [[Bool?]] = []
    var categoryId : Int?
    var selectedIndexPath: IndexPath? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnBack.isHidden = true
        self.nextButton.isHidden = true
        selectRecipeCollectionView.delegate = self
        selectRecipeCollectionView.dataSource = self
        recipeCategaryView.layer.masksToBounds = false
        recipeCategaryView.layer.shadowRadius = 2
        recipeCategaryView.layer.shadowOpacity = 0.2
        recipeCategaryView.layer.shadowColor = UIColor.lightGray.cgColor
        recipeCategaryView.layer.shadowOffset = CGSize(width: 0 , height:2)
        searchRecipe.layer.cornerRadius = 5
        nextButton.layer.borderWidth = 1
        nextButton.layer.cornerRadius = 24
        nextButton.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
        
        isSearch = false
        self.searchBarCategoryTextField.delegate = self

        callselectRecipeCategory()
        

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        if isSearch! {
//            return arrFilterData?.count ?? 0
//            }
//            else{

                return self.newSearchModel?.count ?? 0
//            }
         
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectRecipeCollectionViewCell", for: indexPath) as! SelectRecipeCollectionViewCell
        
//        if isSearch! {
//            let imgUrl = (kImageBaseUrl + (self.arrFilterData![indexPath.row].imageId?.imgUrl ?? ""))
//
//            cell.img.setImage(withString: imgUrl)
//            cell.lbl.text = self.arrFilterData![indexPath.row].name
//            cell.lbl?.font = UIFont(name: "Montserrat-Bold", size: 16)
//            cell.img.layer.cornerRadius = cell.img.frame.height/2
//
//
//            }
//            else{

                let imgUrl = (kImageBaseUrl + (self.newSearchModel?[indexPath.row].imageId?.imgUrl ?? ""))

                cell.img.setImage(withString: imgUrl)
                 cell.imgSelected.alpha  = 0
                cell.lbl.text = self.newSearchModel?[indexPath.row].name
                cell.lbl?.font = UIFont(name: "Montserrat-Bold", size: 16)
//                cell.img.layer.cornerRadius = cell.img.frame.height/2
                cell.imgSelected.layer.cornerRadius = cell.imgSelected.frame.height/2
               
//            }

        cell.contentView.isUserInteractionEnabled = false

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
        return CGSize(width: self.selectRecipeCollectionView.frame.width / 4, height: 200.0)
       }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = selectRecipeCollectionView.cellForItem(at: indexPath){
            cell.contentView.backgroundColor = .white
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = selectRecipeCollectionView.cellForItem(at: indexPath){
            cell.contentView.backgroundColor = nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = selectRecipeCollectionView.cellForItem(at: indexPath as IndexPath) as? SelectRecipeCollectionViewCell
         let selectedCategory = newSearchModel?[indexPath.row].recipeCategoryId
         self.categoryId = selectedCategory
        if selectedIndexPath == indexPath {
                    // it was already selected
                    selectedIndexPath = nil
                    selectRecipeCollectionView.deselectItem(at: indexPath, animated: false)
            cell?.imgSelected.alpha = 0
            self.nextButton.isHidden = true
            self.btnBack.isHidden = true
            print("deselect")
                } else {
                    // wasn't yet selected, so let's remember it
                    selectedIndexPath = indexPath
                    cell?.imgSelected.alpha = 1
                    self.nextButton.isHidden = false
                    self.btnBack.isHidden = false
                    print("select")
                }

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = selectRecipeCollectionView.cellForItem(at: indexPath as IndexPath) as? SelectRecipeCollectionViewCell
        cell?.imgSelected.alpha = 0
        self.selectedIndexPath = nil
        print("previous Deselect")
    }
    
    
//
//        if selectionTracking[indexPath.section][indexPath.row] != nil {
//            selectionTracking[indexPath.section][indexPath.row] = !selectionTracking[indexPath.section][indexPath.row]!
//
//        }
//        else{
//            selectionTracking[indexPath.section][indexPath.row] = true
//        }

//        selectRecipeCollectionView?.reloadData()
        

    
  
    @IBAction func cancelButton(_ sender: UIButton) {
        
        let cancelPopUpVC = self.storyboard?.instantiateViewController(withIdentifier: "CancelPopUpViewController") as! CancelPopUpViewController
       
        cancelPopUpVC.modalPresentationStyle = .overFullScreen
        cancelPopUpVC.modalTransitionStyle = .crossDissolve
        cancelPopUpVC.Callback = {
            let cancelPopVC = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverRecipeViewController") as! DiscoverRecipeViewController
            cancelPopVC.checkbutton = 2
            self.navigationController?.pushViewController(cancelPopVC, animated: true)
            
        }
        self.present(cancelPopUpVC, animated: true)
        
    }
    
    
    @IBAction func nextButton(_ sender: UIButton) {
        let addIngrediantsVC = self.storyboard?.instantiateViewController(withIdentifier: "AddIngredientsViewController") as! AddIngredientsViewController
        
        selectRecipeCategoryJson = ["selected_category" : categoryId ?? 0]
        
        self.navigationController?.pushViewController(addIngrediantsVC, animated: true)
        
    }
    @IBAction func backButton(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- textfield

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{

        var searchText  = searchBarCategoryTextField.text! + string

        if string  == "" {
            searchText = (searchText as String).getSubStringFrom(begin: searchText.index(before: searchText.startIndex), to: searchText.endIndex)
//                .substring(to: searchText.index(before: searchText.endIndex))
        }

        if searchText == "" {
            isSearch = false
            selectRecipeCollectionView.reloadData()
        }
        else{
            getSearchArrayContains(searchText)
        }

        return true
    }
    
    // Predicate to filter data
    func getSearchArrayContains(_ text : String) {
        let predicate : NSPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", text)
        arrFilterData = (newSearchModel! as NSArray).filtered(using: predicate) as? [SelectRecepiDataModel]
        isSearch = true
        selectRecipeCollectionView.reloadData()
    }
    
}

extension SelectRecipeCategaryViewController{
    
    func callselectRecipeCategory(){
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getrecipeCategory, requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
       
            let dictResponse = dictResponse as? [String:Any]
            
//            if let data = dictResponse?["data"] as? [String:Any]{
//
//                self.newSearchModel = SelectRecepiDataModel.init(with: data)
//                self.selectRecipeCollectionView.reloadData()

                if let data = dictResponse?["data"] as? [[String:Any]]{
                    self.newSearchModel = data.map({SelectRecepiDataModel.init(with: $0)})
                    self.selectRecipeCollectionView.reloadData()


            }
        }
    }
}

