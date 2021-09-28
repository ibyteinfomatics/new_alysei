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
    
    
    var arrRecentSearch: [ProductSearchListModel]?
    var isSearchEnable = false
    override func viewDidLoad() {
        super.viewDidLoad()
        vwHeader.addShadow()
        txtSearch.delegate = self
        callRecentListApi()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}

extension SearchProductVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRecentSearch?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchProductTableVC", for: indexPath) as? SearchProductTableVC else { return UITableViewCell()}
        cell.selectionStyle = .none
        if isSearchEnable == false{
        cell.lblSearchText.text = arrRecentSearch?[indexPath.row].searchKeyword
            cell.lblProductCategoryName.isHidden = true
        }else{
            cell.lblSearchText.text = arrRecentSearch?[indexPath.row].title
            cell.lblProductCategoryName.isHidden = false
            cell.lblProductCategoryName.text = arrRecentSearch?[indexPath.row].product_category_name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SearchProductListVC") as? SearchProductListVC else {return}
        if isSearchEnable == false{
            nextVC.selectProductName = arrRecentSearch?[indexPath.row].searchKeyword
        }else{
            nextVC.selectProductName = arrRecentSearch?[indexPath.row].title
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
                self.arrRecentSearch = data.map({ProductSearchListModel.init(with: $0)})
            }
            self.searchTableView.reloadData()
        }
    }
    
    func callSearchApi(_ text: String){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kProductKeywordSearch + "\(text)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            switch statusCode{
            case 200:
            let response = dictResponse as? [String:Any]
            if  let data = response?["data"] as? [[String:Any]]{
                self.arrRecentSearch = data.map({ProductSearchListModel.init(with: $0)})
            }
            self.searchTableView.reloadData()
            case 409:
                self.arrRecentSearch = [ProductSearchListModel]()
                self.searchTableView.reloadData()
                self.showAlert(withMessage: "No Product found")
                
            default:
                print("No Data")
                //self.showAlert(withMessage: "No Product found")
            }
        }
    }
}
