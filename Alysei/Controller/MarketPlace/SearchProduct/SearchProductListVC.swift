//
//  SearchProductListVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 7/29/21.
//

import UIKit

class SearchProductListVC: UIViewController {
    
    @IBOutlet weak var sortFilterView: UIView!
    var selectProductName: String?
    var arrProductList = [ProductSearchListModel]()
    var searchProductList : [ProductSearchListModel]?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var blankView: UIView!
    @IBOutlet weak var btnSort: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var lblNoMoreProduct: UILabel!
    @IBOutlet weak var lbltryAgain: UILabel!
    
    var selectedSampleIndex: Int?
    var selectedCategoryId: [String]?
    var selectedPriceRangeIndex:Int?
    var selectedCategoryCheckIndex: [Int]?
    var firstLoading = true
    //var trimmedProductName : String?
    var lastPage:Int?
    var indexOfPageToRequest = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        blankView.isHidden = true
        btnSort.setTitle(MarketPlaceConstant.kSort, for: .normal)
        btnFilter.setTitle(MarketPlaceConstant.kFilter, for: .normal)
        lblNoMoreProduct.text = MarketPlaceConstant.kNoProductFound
        lbltryAgain.text =  MarketPlaceConstant.kTryAgain
        self.sortFilterView.addShadow()
        lblTitle.text = selectProductName
        //trimmedProductName = selectProductName?.replacingOccurrences(of: " ", with: "")
       
        callSearchListApi(selectProductName ?? "")
        self.firstLoading = true
        // Do any additional setup after loading the view.
    }
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func seacrhAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSortAction(_ sender: UIButton){
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SortProductViewController") as? SortProductViewController else {return}
        nextVC.selectProductName = self.selectProductName
        nextVC.callBackPassData = { arrSortList in
            
            self.arrProductList = arrSortList
            self.tableView.reloadData()
        }
        self.present(nextVC, animated: true, completion: nil)
    }
    @IBAction func btnFilterAction(_ sender: UIButton){
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "FilterViewController") as? FilterViewController else {return}
        nextVC.selectedProductName = self.selectProductName
        if self.firstLoading == true {
            print("No pass")
        }else{
        
        nextVC.selectedSampleIndex = self.selectedSampleIndex
        nextVC.selectedCategoryProductId = self.selectedCategoryId ?? [""]
        nextVC.firstLoading = self.firstLoading
        nextVC.selectedPriceRangeIndex = self.selectedPriceRangeIndex
        nextVC.selectedCategoryCheckIndex = self.selectedCategoryCheckIndex ?? [-1]
        }
        nextVC.passDataCallBack = { filterproductList,selectedSampleIndex,selectedCategoryProductId,selectedCategoryIndex,selectPriceRangeIndex, isFirstloading in
            self.arrProductList = filterproductList ?? [ProductSearchListModel(with: [:])]
            self.selectedSampleIndex = selectedSampleIndex
            self.selectedCategoryCheckIndex = selectedCategoryIndex
            self.selectedCategoryId = nextVC.selectedCategoryProductId
            self.selectedPriceRangeIndex = selectPriceRangeIndex
            
            self.firstLoading = isFirstloading ?? true
            self.tableView.reloadData()
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
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
               
                self.indexOfPageToRequest += 1
                callSearchListApi(selectProductName ?? "")

            // call your API for more data
              

            // tell the table view to reload with the new data
            self.tableView.reloadData()
            }
        }
    }
}

extension SearchProductListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProductList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableVCell", for: indexPath) as? ProductListTableVCell else {return UITableViewCell()}
        cell.configCell(arrProductList[indexPath.row] ?? ProductSearchListModel(with: [:]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ProductDetailVC") as? ProductDetailVC else {return}
        nextVC.marketplaceProductId = "\(arrProductList[indexPath.row].marketplaceProductId ?? 0)"
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SearchProductListVC {
    //    func callSearcListhApi(_ text: String){
    //        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kProductSearch + "keyword=" + "\(text)" + "&available_for_sample=" + "" + "&sort_by=" + "" + "&category=" + "" + "&price_rfrom=" + "" + "&price_to=" + "", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
    //            let response = dictResponse as? [String:Any]
    //            switch statusCode{
    //            case 200:
    //
    //            if  let data = response?["data"] as? [[String:Any]]{
    //                self.arrProductList = data.map({ProductSearchListModel.init(with: $0)})
    //            }
    //            self.tableView.reloadData()
    //            default:
    //                self.showAlert(withMessage: "No products found")
    //            }
    //        }
    //    }
    
    func callSearchListApi(_ text: String){
        
        let urlString = APIUrl.kProductListing + "\(text)" + "&available_for_sample=" + "" + "&sort_by=" + "" + "&category=" + "" + "&price_rfrom=" + "" + "&price_to=" + "&page=" + "\(self.indexOfPageToRequest)"
        let urlString1 = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        TANetworkManager.sharedInstance.requestApi(withServiceName: urlString1, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            switch statusCode{
            case 200:
                let response = dictResponse as? [String:Any]
//                if  let data = response?["data"] as? [[String:Any]]{
//                    self.arrProductList = data.map({ProductSearchListModel.init(with: $0)})
//                }
              
                let outerData = response?["data"] as? [String:Any]
                self.lastPage = outerData?["last_page"] as? Int
            if  let data = outerData?["data"] as? [[String:Any]]{
                if self.indexOfPageToRequest == 1 {self.arrProductList.removeAll()}
                self.searchProductList = data.map({ProductSearchListModel.init(with: $0)})
               
            }
                for i in 0..<(self.searchProductList?.count ?? 0){
                    self.arrProductList.append(self.searchProductList?[i] ?? ProductSearchListModel.init(with: [:]))
                }
                if self.arrProductList.count == 0 {
                    self.blankView.isHidden = false
                }else{
                    self.blankView.isHidden = true
                }
                self.tableView.reloadData()
                
            case 409:
                if self.arrProductList.count != 0 {
                    print("Product Exist")
                }else{
                    self.blankView.isHidden = false
                    self.showAlert(withMessage: MarketPlaceConstant.kNoProductFound)
                }
            default:
                self.blankView.isHidden = false
                self.showAlert(withMessage: MarketPlaceConstant.kNoProductFound)
            }
        }
    }
}
class ProductListTableVCell: UITableViewCell{
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblProductCategoryName: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var imgAvailableForSample: UIImageView!
    @IBOutlet weak var lblSampleAvailabel: UILabel!
    @IBOutlet weak var lblAvgRating: UILabel!
    @IBOutlet weak var vwCategory: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vwCategory.layer.backgroundColor = UIColor.init(hexString: "#9CD39A").cgColor
    }
    
    func configCell(_ data: ProductSearchListModel){
        lblProductName.text = data.title
        lblProductPrice.text = "$" + (data.product_price ?? "")
        lblStoreName.text = data.store_name
        lblProductCategoryName.text = data.product_category_name
        lblReview.text = "\(data.total_reviews ?? 0)" + MarketPlaceConstant.kSRatings
        let baseUrl = data.product_gallery?.first?.baseUrl ?? ""
        self.imgProduct.setImage(withString: baseUrl + String.getString(data.product_gallery?.first?.attachment_url))
        if data.available_for_sample == "Yes" {
            lblSampleAvailabel.isHidden = false
            imgAvailableForSample.isHidden = false
        }else {
            lblSampleAvailabel.isHidden = true
            imgAvailableForSample.isHidden = true
        }
        lblAvgRating.text = "\(data.avg_rating ?? "0")"
    }
}
