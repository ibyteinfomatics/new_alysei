//
//  VIewAllRegionViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 13/12/21.
//

import UIKit

class ViewAllRegionViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchIngridientTextField: UITextField!
    
    var arraySearchByRegion : [SelectRegionDataModel]? = []
    var searchText = String()
    var searching1 = false
//    var delegate: SearchRecipeDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "SearchByRegionCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "SearchByRegionCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        searchIngridientTextField.delegate = self
        getSearchByRegion()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        headerView.drawBottomShadow()
    }
    
    @IBAction func tapBack(_ sender: Any) {
        if searching1 == true{
        self.searching1 = false
        self.searchIngridientTextField.text = ""
        getSearchByRegion()
    }
    else{
        self.navigationController?.popViewController(animated: true)
    }
    
    }
    
    @IBAction func tapCross(_ sender: Any) {
        self.searchIngridientTextField.text = nil
        getSearchByRegion()
    }
    
    func getSearchByRegion(){
        self.view.isUserInteractionEnabled = false
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getRecipeHomeScreen
                                                   , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in

            let dictResponse = dictResponse as? [String:Any]

            if let data = dictResponse?["data"] as? [String:Any]{

                if let regions = data["regions"] as? [[String:Any]]{
                    let region = regions.map({SelectRegionDataModel.init(with: $0)})
                    arraySearchByRegion = region
                    print("\(String(describing: arraySearchByRegion?.count))")
                }

            }
            self.collectionView.reloadData()
            self.view.isUserInteractionEnabled = true
    }
    }
    
//    func callSearchMeal(){
//
//        TANetworkManager.sharedInstance.requestApi(withServiceName: "\(APIUrl.Recipes.getSearchMeal)\(searchText)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
//            switch statusCode{
//            case 200:
//                let dictResponse = dictResponse as? [String:Any]
//
//                if let data = dictResponse?["data"] as? [[String:Any]]{
//                    self.arraySearchByMeal = data.map({SelectMealDataModel.init(with: $0)})
//                    self.searching1 = true
//                    self.collectionView.reloadData()
//
//                }
//            case 409:
//                self.arraySearchByMeal?.removeAll()
//                self.collectionView.reloadData()
//                self.showAlert(withMessage: "No Meal Found")
//            default:
//                self.arraySearchByMeal?.removeAll()
//                self.collectionView.reloadData()
//                self.showAlert(withMessage: "Internal Server Error")
//
//            }
//
//
//
//        }
//    }
}


extension ViewAllRegionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arraySearchByRegion?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchByRegionCollectionViewCell", for: indexPath) as? SearchByRegionCollectionViewCell {
            
            //            let imgUrl = (kImageBaseUrl + (arraySearchByRegion?[indexPath.item].regionImage?.imgUrl ?? ""))
            if (arraySearchByRegion?[indexPath.item].regionImage?.imgUrl ?? "") == ""{
                cell.countryImgVw.image = UIImage(named: "image_placeholder.png")
            }
            else{
                if let strUrl = "\((arraySearchByRegion?[indexPath.item].regionImage?.baseUrl ?? "") + (arraySearchByRegion?[indexPath.item].regionImage?.imgUrl ?? ""))".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
                   let imgUrl = URL(string: strUrl) {
                    print("ImageUrl-----------------------------------------\(imgUrl)")
                    cell.countryImgVw.loadImageWithUrl(imgUrl) // call this line for getting image to yourImageView
                }
            }
            //            cell.countryImgVw.setImage(withString: imgUrl)
            cell.outerView.layer.cornerRadius = cell.outerView.frame.width/2
            cell.outerView.layer.borderWidth = 1
            cell.outerView.layer.borderColor = UIColor.lightGray.cgColor
            cell.countryImgVw.contentMode = .scaleAspectFit
            
            cell.countryNameLbl.text = arraySearchByRegion?[indexPath.item].regionName ?? ""
            return cell
        }
        
        return UICollectionViewCell()
    }
    
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchTitle = arraySearchByRegion?[indexPath.row].regionName ?? ""
        searchId = "\(arraySearchByRegion?[indexPath.row].regionId ?? -1)"
        isFrom = "Region"
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
extension ViewAllRegionViewController: UITextFieldDelegate{
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
//            callSearchMeal()
           hideKeyboardWhenTappedAround()
        }
        else{
            self.searching1 = false
            self.searchIngridientTextField.text = nil
            getSearchByRegion()
            collectionView.reloadData()
        }
      }
        return true
    }
    
}
