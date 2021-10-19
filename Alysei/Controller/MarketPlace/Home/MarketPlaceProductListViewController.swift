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
      
    @IBOutlet weak var searchtextField: UITextField!
    var listType:Int?
    var keywordSearch: String?
    var pushedFromVC : PushedFrom?
    var optionId: Int?
    var indexOfPageToRequest = 1
    var lastPage: Int?
    // var arrList: [MyStoreProductDetail]?
    var arrList: [ProductSearchListModel]?
    
    var arrSelectedCategories = [Int]()
    var arrSelectedProperties = [Int]()
    var arrSelectedItalianRegion = [Int]()
    var arrSelectedDistance = [Int]()
    var arrSelectedRating = [Int]()
    //var arrSelectedMethod = [Int]()
    var selectFdaCertified = [Int]()
    var selectedSortProducer = [Int]()
    var selectedOptionsMethod = [Int]()
    var arrSelectedPropertiesName = [String]()
    var arrSelectedMethodName = [String]()
    
    
    var selecteMethodFilterName :String?
    var selectePropertiesFilterName :String?
    var selecteCategoryFilterId :String?
    var selectedRegionFilterId: String?
    var sortFilterId: String?
    var fdaFilterId: String?
    var selectRatingId: String?
    var searchProductString: String?
    
    //var selectFdaCertifiedId: String?
    
    
    //var homearrList: []
    override func viewDidLoad() {
        super.viewDidLoad()
        if pushedFromVC == .region{
            callRegionProductListApi(1)
        }else if pushedFromVC == .category{
            callCategoryProductListApi(1)
        }else if pushedFromVC == .conservation {
            callConservationListApi(1)
        }else if pushedFromVC == .fdaCertified || pushedFromVC == .myFav {
            callOptionApi(1)
        }else if pushedFromVC == .properties {
            callConservationListApi(1)
        }else{
            self.callProductListApi()
        }
        searchtextField.delegate = self
   
        lblHeading.text = keywordSearch
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnFilterAction(_ sender: UIButton){
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ProducerStoreFilterVC") as? ProducerStoreFilterVC else{return}
       // nextVC.identifyList = 4
        if pushedFromVC == .region {
            nextVC.loadFilter =  .region
        }else if pushedFromVC == .category{
            nextVC.loadFilter =  .category
        }else if pushedFromVC == .properties{
            nextVC.loadFilter =  .properties
        }else if  pushedFromVC == .fdaCertified {
            nextVC.loadFilter =  .fdaCertified
        }else if pushedFromVC == .myFav{
            nextVC.loadFilter =  .myFav
        }else{
        nextVC.loadFilter = .conservationFood
        }
        nextVC.arrSelectedCategories = self.arrSelectedCategories
        nextVC.arrSelectedProperties = self.arrSelectedProperties
        nextVC.arrSelectedItalianRegion = self.arrSelectedItalianRegion
        nextVC.arrSelectedDistance = self.arrSelectedDistance
        nextVC.arrSelectedRating = self.arrSelectedRating
       
        nextVC.selectFdaCertified = self.selectFdaCertified
        nextVC.selectedSortProducer = self.selectedSortProducer
        nextVC.selectedOptionsMethod = self.selectedOptionsMethod
        nextVC.arrSelectedMethodName =  self.arrSelectedMethodName
        nextVC.arrSelectedPropertiesName = self.arrSelectedPropertiesName
        
        nextVC.callApiCallBack = { arrSelectedCategories,arrSelectedProperties,arrSelectedItalianRegion,arrSelectedDistance,arrSelectedRating,selectFdaCertified,selectedSortProducer,selectedOptionsMethod,arrSelectedPropertiesName,arrSelectedMethodName in
            self.arrSelectedCategories = nextVC.arrSelectedCategories
            self.arrSelectedProperties = nextVC.arrSelectedProperties
           self.arrSelectedItalianRegion =  nextVC.arrSelectedItalianRegion
            self.arrSelectedDistance = nextVC.arrSelectedDistance
            self.arrSelectedRating = nextVC.arrSelectedRating
            
            self.selectFdaCertified = nextVC.selectFdaCertified
            self.selectedSortProducer = nextVC.selectedSortProducer
            self.selectedOptionsMethod = nextVC.selectedOptionsMethod
            self.arrSelectedMethodName = nextVC.arrSelectedMethodName
            self.arrSelectedPropertiesName = nextVC.arrSelectedPropertiesName
        self.callBoxFilterApi(arrSelectedCategories,arrSelectedProperties,arrSelectedItalianRegion,arrSelectedDistance,arrSelectedRating,selectFdaCertified,selectedSortProducer,selectedOptionsMethod,arrSelectedPropertiesName,arrSelectedMethodName)
            
        }
        nextVC.clearFilterApi = { loadfilter in
            self.arrSelectedCategories = [Int]()
            self.arrSelectedProperties = [Int]()
           self.arrSelectedItalianRegion =  [Int]()
            self.arrSelectedDistance = [Int]()
            self.arrSelectedRating = [Int]()
            
            self.selectFdaCertified = [Int]()
            self.selectedSortProducer = [Int]()
            self.selectedOptionsMethod = [Int]()
            self.arrSelectedMethodName = [String]()
           
            self.arrSelectedPropertiesName = [String]()
            if loadfilter == .region{
                self.callRegionProductListApi(1)
            }else if loadfilter == .category {
                self.callCategoryProductListApi(1)
        }else if loadfilter == .conservationFood {
            self.callConservationListApi(1)
        }else if loadfilter == .fdaCertified || loadfilter == .myFav {
                self.callOptionApi(1)
        }else if loadfilter == .properties {
                self.callConservationListApi(1)
            }else{
                self.callProductListApi()
            }
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height - (self.view.frame.height * 2) {
            if indexOfPageToRequest < lastPage ?? 0{
                self.showAlert(withMessage: "No More Data Found")
            }else{
                // increments the number of the page to request
                indexOfPageToRequest += 1
                
                // call your API for more data
                if pushedFromVC == .region{
                    callRegionProductListApi(indexOfPageToRequest)
                }else if pushedFromVC == .category{
                    callCategoryProductListApi(indexOfPageToRequest)
                }else if pushedFromVC == .conservation {
                    callConservationListApi(indexOfPageToRequest)
                }else if pushedFromVC == .fdaCertified  || pushedFromVC == .myFav{
                    callOptionApi(indexOfPageToRequest)
                }else if pushedFromVC == .properties {
                    callConservationListApi(indexOfPageToRequest)
                }else{
                    self.callProductListApi()
                }
                    // tell the table view to reload with the new data
                    self.tableView.reloadData()
                }
            }
            
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
extension MarketPlaceProductListViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
                   let textRange = Range(range, in: text) {
                   let updatedText = text.replacingCharacters(in: textRange,
                                                               with: string)
          
            self.searchProductString = updatedText
            self.callBoxFilterApi(arrSelectedCategories,arrSelectedProperties,arrSelectedItalianRegion,arrSelectedDistance,arrSelectedRating,selectFdaCertified,selectedSortProducer,selectedOptionsMethod,arrSelectedPropertiesName,arrSelectedMethodName)
            }
                return true
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
    func callRegionProductListApi(_ pageNo: Int?){
        let urlString = APIUrl.kGetProductByRegionId + "\(optionId ?? 0)"
        let urlString1 = (urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") + "&page=" + "\(pageNo ?? 0)"
        TANetworkManager.sharedInstance.requestApi(withServiceName: urlString1 , requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictresponse, error, errorType, statusCode in
            
            let response = dictresponse as? [String:Any]
            if let data = response?["data"] as? [String:Any]{
                self.lastPage = data["last_page"] as? Int
                if let subData = data["data"] as? [[String:Any]]{
                    self.arrList = subData.map({ProductSearchListModel.init(with: $0)})
                }
            }
            self.tableView.reloadData()
        }
        
    }
    func callCategoryProductListApi(_ pageNo : Int?){
        let urlString = APIUrl.kGetProductByCategoryId + "\(optionId ?? 0)"
        let urlString1 = (urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") + "&page=" + "\(pageNo ?? 0)"
        TANetworkManager.sharedInstance.requestApi(withServiceName: urlString1 , requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictresponse, error, errorType, statusCode in
            
            let response = dictresponse as? [String:Any]
            if let data = response?["data"] as? [String:Any]{
                self.lastPage = data["last_page"] as? Int
                if let subData = data["data"] as? [[String:Any]]{
                    self.arrList = subData.map({ProductSearchListModel.init(with: $0)})
                }
            }
            self.tableView.reloadData()
        }
        
    }
    func callConservationListApi(_ pageNo : Int?){
        let urlString = APIUrl.kMarketPlaceProductBox + "\(listType ?? 0)" + "&keyword=" + "\(keywordSearch ?? "")" + "&page=" + "\(pageNo ?? 0)"
        let urlString1 = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        TANetworkManager.sharedInstance.requestApi(withServiceName: urlString1 , requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictresponse, error, errorType, statusCode in
            
            let response = dictresponse as? [String:Any]
            if let data = response?["data"] as? [String:Any]{
                self.lastPage = data["last_page"] as? Int
                if let subData = data["data"] as? [[String:Any]]{
                    self.arrList = subData.map({ProductSearchListModel.init(with: $0)})
                }
            }
            self.tableView.reloadData()
        }
        
    }
    func callOptionApi(_ pageNo: Int?){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kMarketPlaceProduct + "\(listType ?? 0)" + "?page=" + "\(pageNo ?? 0)" , requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictresponse, error, errortype, statusCode in
            switch statusCode{
            case 200:
                let response = dictresponse as? [String:Any]
                if let data = response?["data"] as? [String:Any]{
                    self.lastPage = data["last_page"] as? Int
                    if let subData = data["data"] as? [[String:Any]]{
                        self.arrList = subData.map({ProductSearchListModel.init(with: $0)})
                    }
                }
            default:
                print("No Data")
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
    
    func callBoxFilterApi(_ arrSelectedCategories: [Int]?, _ arrSelectedProperties: [Int]?,_ arrSelectedItalianRegion: [Int]?,_ arrSelectedDistance: [Int]?,_ arrSelectedRating: [Int]?,_ selectFdaCertified: [Int]?,_ selectedSortProducer: [Int]?,_ selectedOptionsMethod: [Int]?, _ arrSelectedPropertiesName: [String]?,_ arrSelectedMethodName: [String]?){
        
       // let formattedPropertiesArray = (arrSelectedPropertiesName.map{String($0)}).joined(separator: ",")
    
        let selectedPropertyString = arrSelectedPropertiesName?.joined(separator: ",")
         selectePropertiesFilterName = selectedPropertyString
        
       
        let selectedMethodStringName = arrSelectedMethodName?.joined(separator: ",")
        selecteMethodFilterName = selectedMethodStringName
    
        
        
        let stringCatArray = arrSelectedCategories?.compactMap({String($0)}) //{ String($0)!}
        let selectedCategoryStringId = stringCatArray?.joined(separator: ",")
        
        if pushedFromVC == .category{
            selecteCategoryFilterId = "\(optionId ?? 0)"
        }else{
            selecteCategoryFilterId = selectedCategoryStringId
        }
        
        
        let stringRegionArray = arrSelectedItalianRegion?.compactMap({String($0)}) //{ String($0)!}
        let selectedRegionStringId = stringRegionArray?.joined(separator: ",")
        if pushedFromVC == .region {
            selectedRegionFilterId = "\(optionId ?? 0)"
        }else{
            selectedRegionFilterId = selectedRegionStringId
        }
        
       
        let stringRatingArray = arrSelectedRating?.compactMap({String($0)})
        let selectedRatingStringId = stringRatingArray?.joined(separator: ",")
        if selectedRatingStringId == "0"{
            selectRatingId = "1"
        }else if selectedRatingStringId == "1"{
            selectRatingId = "2"
        }else if selectedRatingStringId == "2"{
            selectRatingId = "3"
        }else{
            selectRatingId = ""
        }
        
        let stringFdaArray = selectFdaCertified?.compactMap({String($0)})
        let selectedFdaCertificate = stringFdaArray?.joined(separator: ",")
        if pushedFromVC == .fdaCertified {
            fdaFilterId = "1"
        }else{
            if selectedFdaCertificate == "0"{
            fdaFilterId = "1"
            }else if selectedFdaCertificate == "1"{
                fdaFilterId = "0"
            }else{
                fdaFilterId = ""
            }
        }
        
        let stringSortArray = selectedSortProducer?.compactMap({String($0)})
        let selectedSortProducerStringId = stringSortArray?.joined(separator: ",")
        if selectedSortProducerStringId == "0" {
            sortFilterId = "1"
        }else if selectedSortProducerStringId == "1"{
            sortFilterId = "0"
        }else{
            sortFilterId = ""
        }
    
        
<<<<<<< HEAD
        let urlString = APIUrl.kMarketplaceBoxFilterApi + "property=" + "\(selectePropertiesFilterName ?? "")" + "&method=" + "\(selecteMethodFilterName ?? "")" + "&category=" + "\(selecteCategoryFilterId ?? "")" + "&region=" + "\(selectedRegionFilterId ?? "")" + "&fda_certified=" + "\(fdaFilterId ?? "")" + "&sort_by_product= " + "" + "&sort_by_producer=" + "\(sortFilterId ?? "")" + "&rating=" + "\(selectRatingId ?? "")" + "sort_by_product=" + "" + "keyword=" + "\(searchProductString ?? "")" + "&title=" + "\(self.keywordSearch ?? "")" + "&boxid=" + "\(self.listType ?? -1)" + "&type=" + "2"
        
=======
        let urlString = APIUrl.kMarketplaceBoxFilterApi + "property=" + "\(selectePropertiesFilterName ?? "")" + "&method=" + "\(selecteMethodFilterName ?? "")" + "&category=" + "\(selecteCategoryFilterId ?? "")" + "&region=" + "\(selectedRegionFilterId ?? "")" + "&fda_certified=" + "\(fdaFilterId ?? "")" + "&sort_by_producer=" + "\(sortFilterId ?? "")" + "&rating=" + "\(selectRatingId ?? "")" + "type=2"
>>>>>>> dd09bd8e0753c5e971d90da271d2dd35db961992
        let urlString1 = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        TANetworkManager.sharedInstance.requestApi(withServiceName:urlString1, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictresponse, error, errortype, statusCode in
            switch statusCode{
            case 200:
                let response = dictresponse as? [String:Any]
                if let data = response?["data"] as? [String:Any]{
                    self.lastPage = data["last_page"] as? Int
                    if let subData = data["data"] as? [[String:Any]]{
                        self.arrList = subData.map({ProductSearchListModel.init(with: $0)})
                    }
                }
            default:
                print("No Data")
            }
            self.tableView.reloadData()
        }
    }
    
    
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
