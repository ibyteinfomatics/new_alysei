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
    var arrProductList: [ProductSearchListModel]?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var selectedSampleIndex: Int?
    var selectedCategoryId: [String]?
    var selectedPriceRangeIndex:Int?
    var selectedCategoryCheckIndex: [Int]?
    var firstLoading = true
    //var trimmedProductName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sortFilterView.addShadow()
        lblTitle.text = selectProductName
        //trimmedProductName = selectProductName?.replacingOccurrences(of: " ", with: "")
        print("selectProductName-------------------\(selectProductName ?? "")")
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
            self.arrProductList = filterproductList
            self.selectedSampleIndex = selectedSampleIndex
            self.selectedCategoryCheckIndex = selectedCategoryIndex
            self.selectedCategoryId = nextVC.selectedCategoryProductId
            self.selectedPriceRangeIndex = selectPriceRangeIndex
            
            self.firstLoading = isFirstloading ?? true
            self.tableView.reloadData()
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SearchProductListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProductList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableVCell", for: indexPath) as? ProductListTableVCell else {return UITableViewCell()}
        cell.configCell(arrProductList?[indexPath.row] ?? ProductSearchListModel(with: [:]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ProductDetailVC") as? ProductDetailVC else {return}
        nextVC.marketplaceProductId = "\(arrProductList?[indexPath.row].marketplaceProductId ?? 0)"
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
        
        let urlString = APIUrl.kProductListing + "\(text)" + "&available_for_sample=" + "" + "&sort_by=" + "" + "&category=" + "" + "&price_rfrom=" + "" + "&price_to="
        let urlString1 = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        TANetworkManager.sharedInstance.requestApi(withServiceName: urlString1, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            switch statusCode{
            case 200:
                let response = dictResponse as? [String:Any]
                if  let data = response?["data"] as? [[String:Any]]{
                    self.arrProductList = data.map({ProductSearchListModel.init(with: $0)})
                }
                self.tableView.reloadData()
            default:
                self.showAlert(withMessage: "No products found")
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
        lblReview.text = "\(data.total_reviews ?? 0) ratings"
        self.imgProduct.setImage(withString: kImageBaseUrl + String.getString(data.product_gallery?.first?.attachment_url))
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
