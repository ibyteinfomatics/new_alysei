//
//  MarketPlaceProductListViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/27/21.
//

import UIKit

class MarketPlaceProductListViewController: UIViewController {
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblHeading: UILabel!
    var listType:Int?
    var keywordSearch: String?
    var pushedFromVC : PushedFrom?
    var optionId: Int?
    // var arrList: [MyStoreProductDetail]?
    var arrList: [ProductSearchListModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        if pushedFromVC == .region{
            callRegionProductListApi()
        }else if pushedFromVC == .category{
            callCategoryProductListApi()
        }else{
        self.callProductListApi()
        }
        lblHeading.text = keywordSearch
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}

extension MarketPlaceProductListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketPlaceProductListTableVCell", for: indexPath) as? MarketPlaceProductListTableVCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        cell.configCell(arrList?[indexPath.row] ?? ProductSearchListModel(with: [:]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ProductDetailVC") as? ProductDetailVC else {return}
        nextVC.marketplaceProductId = "\(self.arrList?[indexPath.row].marketplaceProductId ?? 0)"
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

extension MarketPlaceProductListViewController{
    func callProductListApi(){
        let urlString = APIUrl.kMarketPlaceProductBox + "\(listType ?? 0)" + "&keyword=" + "\(keywordSearch ?? "")"
        let urlString1 = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        TANetworkManager.sharedInstance.requestApi(withServiceName: urlString1 , requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictresponse, error, errorType, statusCode in
            
            let response = dictresponse as? [String:Any]
            if let data = response?["data"] as? [[String:Any]]{
                self.arrList = data.map({ProductSearchListModel.init(with: $0)})
            }
            self.tableView.reloadData()
        }
        
    }
    func callRegionProductListApi(){
        let urlString = APIUrl.kGetProductByRegionId + "\(optionId ?? 0)"
        let urlString1 = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        TANetworkManager.sharedInstance.requestApi(withServiceName: urlString1 , requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictresponse, error, errorType, statusCode in
            
            let response = dictresponse as? [String:Any]
            if let data = response?["data"] as? [[String:Any]]{
                self.arrList = data.map({ProductSearchListModel.init(with: $0)})
            }
            self.tableView.reloadData()
        }
        
    }
    func callCategoryProductListApi(){
        let urlString = APIUrl.kGetProductByCategoryId + "\(optionId ?? 0)"
        let urlString1 = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        TANetworkManager.sharedInstance.requestApi(withServiceName: urlString1 , requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictresponse, error, errorType, statusCode in
            
            let response = dictresponse as? [String:Any]
            if let data = response?["data"] as? [[String:Any]]{
                self.arrList = data.map({ProductSearchListModel.init(with: $0)})
            }
            self.tableView.reloadData()
        }
        
    }
//    func callFdaCertifiedProductListApi(){
//        let urlString = APIUrl.kGetProductByCategoryId + "\(optionId ?? 0)"
//        let urlString1 = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//        TANetworkManager.sharedInstance.requestApi(withServiceName: urlString1 , requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictresponse, error, errorType, statusCode in
//
//            let response = dictresponse as? [String:Any]
//            if let data = response?["data"] as? [[String:Any]]{
//                self.arrList = data.map({ProductSearchListModel.init(with: $0)})
//            }
//            self.tableView.reloadData()
//        }
//
//    }
}

class MarketPlaceProductListTableVCell: UITableViewCell{
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblAvg_Rating: UILabel!
    @IBOutlet weak var lblTotalRating: UILabel!
    @IBOutlet weak var lblAvalblForSample: UILabel!
    @IBOutlet weak var lblCost: UILabel!
    @IBOutlet weak var lblProductType: UILabel!
    @IBOutlet weak var imgSample: UIImageView!
    @IBOutlet weak var imgProduct: UIImageView!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func configCell(_ data: ProductSearchListModel){
        lblProductName.text = data.title
        lblCost.text = "$" + (data.product_price ?? "")
        lblStoreName.text = data.store_name
        lblProductType.text = data.product_category_name
        lblTotalRating.text = "\(data.total_reviews ?? 0) ratings"
        self.imgProduct.setImage(withString: kImageBaseUrl + String.getString(data.product_gallery?.first?.attachment_url))
        if data.available_for_sample == "Yes" {
            lblAvalblForSample.isHidden = false
            imgSample.isHidden = false
        }else {
            lblAvalblForSample.isHidden = true
            imgSample.isHidden = true
        }
        lblAvg_Rating.text = "\(data.avg_rating ?? "0")"
    }
    
}
