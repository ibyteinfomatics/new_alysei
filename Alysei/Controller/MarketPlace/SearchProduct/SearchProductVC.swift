//
//  SearchProductVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 7/28/21.
//
import UIKit

class SearchProductVC: UIViewController {
    
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
   
    
    var arrLoadRecentSearch: [ProductSearchListModel]?
    var arrRecentSearch: [ProductSearchListModel]?
    var isSearchEnable = false
    var indexOfPageToRequest = 1
    var searchTxt: String?
    var lastPage:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        vwHeader.drawBottomShadow()
        txtSearch.delegate = self
        callRecentListApi()
        txtSearch.placeholder = MarketPlaceConstant.kSearchForProductBrands
        
        // Do any additional setup after loading the view.
    }
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height - (self.view.frame.height * 2) {
            if indexOfPageToRequest > lastPage ?? 0{
                print("No Data")
            }else{
            // increments the number of the page to request
               
                if isSearchEnable == false{
                    print("No loading")
                }else{
                    self.indexOfPageToRequest += 1
                callSearchApi(self.searchTxt ?? "")
                }
            // call your API for more data
              

            // tell the table view to reload with the new data
            self.searchTableView.reloadData()
            }
        }
    }
}

extension SearchProductVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLoadRecentSearch?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchProductTableVC", for: indexPath) as? SearchProductTableVC else { return UITableViewCell()}
        cell.selectionStyle = .none
        if isSearchEnable == false{
        cell.lblSearchText.text = arrLoadRecentSearch?[indexPath.row].searchKeyword
            cell.lblProductCategoryName.isHidden = true
        }else{
            cell.lblSearchText.text = arrLoadRecentSearch?[indexPath.row].title
            cell.lblProductCategoryName.isHidden = false
            cell.lblProductCategoryName.text = arrLoadRecentSearch?[indexPath.row].product_category_name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SearchProductListVC") as? SearchProductListVC else {return}
        if isSearchEnable == false{
            nextVC.selectProductName = arrLoadRecentSearch?[indexPath.row].searchKeyword
        }else{
            nextVC.selectProductName = arrLoadRecentSearch?[indexPath.row].title
        }
       
          self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
extension SearchProductVC : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
                   let textRange = Range(range, in: text) {
                   let updatedText = text.replacingCharacters(in: textRange,
                                                               with: string)
            isSearchEnable = true
            self.searchTxt = updatedText
            callSearchApi(updatedText)
                }
                return true
    }
}
extension SearchProductVC {
    func callRecentListApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kProductRecentSearch, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let response = dictResponse as? [String:Any]
            if  let data = response?["data"] as? [[String:Any]]{
                self.arrLoadRecentSearch = data.map({ProductSearchListModel.init(with: $0)})
            }
            self.searchTableView.reloadData()
        }
    }
    
    func callSearchApi(_ text: String){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kProductKeywordSearch + "\(text)" + "&page=\(indexOfPageToRequest)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            switch statusCode{
            case 200:
            let response = dictResponse as? [String:Any]
 
                let outerData = response?["data"] as? [String:Any]
                self.lastPage = outerData?["last_page"] as? Int
            if  let data = outerData?["data"] as? [[String:Any]]{
                if self.indexOfPageToRequest == 1 {self.arrLoadRecentSearch?.removeAll()}
                self.arrRecentSearch = data.map({ProductSearchListModel.init(with: $0)})
                self.arrLoadRecentSearch?.append(contentsOf: self.arrRecentSearch ?? [ProductSearchListModel.init(with: [:])])
            }
                
            self.searchTableView.reloadData()
            case 409:
                if self.arrLoadRecentSearch?.count != 0{
                    print("Data exist")
                }else{
                self.arrLoadRecentSearch = [ProductSearchListModel]()
                self.searchTableView.reloadData()
                    self.showAlert(withMessage: MarketPlaceConstant.kNoProductFound)
                }
                
            default:
                print("No Data")
                //self.showAlert(withMessage: "No Product found")
            }
        }
    }
}
