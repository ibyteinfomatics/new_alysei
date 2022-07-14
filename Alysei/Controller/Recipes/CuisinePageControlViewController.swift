//
//  CuisinePageControlViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 03/09/21.
//

import UIKit

var arrayPreferencesModelData = [PreferencesDataModel]()
var arrayPreference: PreferencesDataModel?
var arraySelectedCuisine: [Int]? = []

class CuisinePageControlViewController: UIViewController {
    
    @IBOutlet weak var favCuisineLabel: UILabel!
    @IBOutlet weak var cuisineCollectionView: UICollectionView!
    
    @IBOutlet weak var btnCusineNext: UIButton!
    @IBOutlet weak var cuisinePageControl: UIPageControl!
    
    var thisWidth:CGFloat = 0
    var arrCuisine = [SelectCuisineDataModel]()
    var cuisineID : Int?
    var selectedIndexPath: IndexPath? = nil
    var arrSelectedIndex = [IndexPath]() // This is selected cell Index array
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //    favCuisineLabel.text = RecipeConstants.kPreference1
       
        preferenceNumber = 1
        cuisineCollectionView.delegate = self
        cuisineCollectionView.dataSource = self
        
        cuisinePageControl.hidesForSinglePage = true
        
        btnCusineNext.layer.cornerRadius = 30
        
        btnCusineNext.layer.backgroundColor  = UIColor.init(red: 141/255, green: 141/255, blue: 141/255, alpha: 1).cgColor
        self.tabBarController?.tabBar.isHidden = true
        
        postRequestToGetCuisine()
    }
    

    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        btnCusineNext.setTitle(RecipeConstants.kNext, for: .normal)
        tabBarController?.tabBar.isHidden = true
        edgesForExtendedLayout = UIRectEdge.bottom
        extendedLayoutIncludesOpaqueBars = true
    }
    
    @IBAction func tapNext(_ sender: Any) {
        
        if btnCusineNext.layer.backgroundColor == UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor{
            let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "FoodAllergyViewController") as! FoodAllergyViewController
            
            arrayPreference = PreferencesDataModel.init(id: arraySelectedCuisine ?? [], preference: preferenceNumber)
            arrayPreferencesModelData.append(arrayPreference ?? PreferencesDataModel(id: [], preference: 0))
            self.navigationController?.pushViewController(viewAll, animated: true)
        }
    }
    
    
    @IBAction func tapSkip(_ sender: Any) {
        let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "FoodAllergyViewController") as! FoodAllergyViewController
        let indexPath = IndexPath(row: (selectedIndexPath?.row ?? 0), section: 0)
        self.arrSelectedIndex.append(indexPath)
        let cell = cuisineCollectionView.cellForItem(at: indexPath) as? CuisinePageControlCollectionViewCell
        cell?.imageCuisineSelected.isHidden = true
        self.btnCusineNext.isHidden = true
        self.arrSelectedIndex.removeAll()
        self.arrCuisine[indexPath.item].isSelected = false
        self.navigationController?.pushViewController(viewAll, animated: true)
    }
    
}

extension CuisinePageControlViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(_collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCuisine.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cuisineCollectionView.dequeueReusableCell(withReuseIdentifier: "CuisinePageControlCollectionViewCell", for: indexPath) as! CuisinePageControlCollectionViewCell
        let imgUrl = ((arrCuisine[indexPath.row].imageId?.baseUrl ?? "") + (self.arrCuisine[indexPath.row].imageId?.imgUrl ?? ""))
        cell.imageCuisine.setImage(withString: imgUrl)
        cell.cuisineNameLabel.text = self.arrCuisine[indexPath.row].cuisineName
        cell.imageCuisine.layer.cornerRadius = cell.imageCuisine.frame.height/2
        cell.imageCuisineSelected.layer.cornerRadius = cell.imageCuisineSelected.frame.height/2
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.cuisinePageControl.currentPage = indexPath.section
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.cuisineCollectionView.frame.width, height: 300.0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = cuisineCollectionView.cellForItem(at: indexPath as IndexPath) as? CuisinePageControlCollectionViewCell
        selectedIndexPath = indexPath
        let selectedCuisine = arrCuisine[indexPath.row].cuisineId
        self.cuisineID = selectedCuisine
        if  arrCuisine[indexPath.row].isSelected == true {
            arrCuisine[indexPath.row].isSelected = false
            // it was already selected
            
            cuisineCollectionView.deselectItem(at: indexPath, animated: false)
            cell?.imageCuisineSelected.isHidden = true
            
            for (index,item) in arrSelectedIndex.enumerated(){
                if item == indexPath{
                    arrSelectedIndex.remove(at: index)
                }
            }
            for (index,item) in arraySelectedCuisine!.enumerated(){
                if item == arrCuisine[indexPath.row].cuisineId{
                    arraySelectedCuisine?.remove(at: index)
                }
            }
            if arrSelectedIndex.count == 0{
                btnCusineNext.layer.backgroundColor  = UIColor.init(red: 141/255, green: 141/255, blue: 141/255, alpha: 1).cgColor
            }
            print("deselect")
        } else {
            // wasn't yet selected, so let's remember it
            arrCuisine[indexPath.row].isSelected = true
            btnCusineNext.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            cell?.imageCuisineSelected.isHidden = false
            arraySelectedCuisine?.append(cuisineID ?? 0)
            arrSelectedIndex.append(selectedIndexPath!)
            print("\(String(describing: arrSelectedIndex.count))")
            print("select")
        }
        
    }
}

extension CuisinePageControlViewController{
    
    func postRequestToGetCuisine() -> Void{
        self.view.isUserInteractionEnabled = false
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getCuisine, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (response, error, errorType, statusCode) in
            
            let res = response as? [String:Any]
            let title = res?["title"] as? String
            self.favCuisineLabel.text = title
            
            if let data = res?["data"] as? [[String:Any]]{
                self.arrCuisine = data.map({SelectCuisineDataModel.init(with: $0)})
            }
            self.cuisineCollectionView.reloadData()
            self.view.isUserInteractionEnabled = true
        }
        
    }
    
}
