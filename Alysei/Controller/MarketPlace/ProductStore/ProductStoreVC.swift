//
//  ProductStoreVC.swift
//  Alysei
//
//  Created by Gitesh Dang on 10/4/21.
//

import UIKit

class ProductStoreVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblHeading: UILabel!
    var indexOfPageToRequest = 1
    var listType: Int?
    var arrProductList:ProductsStore?
    var pushedFromVC: PushedFrom?
    var optionId: Int?
    var keywordSearch: String?
    
    
    var arrSelectedCategories = [Int]()
    var arrSelectedProperties = [Int]()
    var arrSelectedItalianRegion = [Int]()
    var arrSelectedDistance = [Int]()
    var arrSelectedRating = [Int]()
    //var arrSelectedMethod = [Int]()
    var selectFdaCertified = [Int]()
    var selectedSortProducer = [Int]()
    var selectedOptionsMethod = [Int]()
    
    var lastPage: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblHeading.text = keywordSearch
        callMyStoreProductApi(1)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        indexOfPageToRequest = 1
        
    }
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func filterAction(_ sender: UIButton){
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ProducerStoreFilterVC") as? ProducerStoreFilterVC else{return}
        nextVC.identifyList = 4
        nextVC.loadFilter = .producerStore
        nextVC.arrSelectedCategories = self.arrSelectedCategories
        nextVC.arrSelectedProperties = self.arrSelectedProperties
        nextVC.arrSelectedItalianRegion = self.arrSelectedItalianRegion
        nextVC.arrSelectedDistance = self.arrSelectedDistance
        nextVC.arrSelectedRating = self.arrSelectedRating
       
        nextVC.selectFdaCertified = self.selectFdaCertified
        nextVC.selectedSortProducer = self.selectedSortProducer
        nextVC.selectedOptionsMethod = self.selectedOptionsMethod
        nextVC.callApiCallBack = { arrSelectedCategories,arrSelectedProperties,arrSelectedItalianRegion,arrSelectedDistance,arrSelectedRating,selectFdaCertified,selectedSortProducer,selectedOptionsMethod,arrSelectedPropertiesName,arrSelectedMethodName in
            
        self.callBoxFilterApi(arrSelectedCategories,arrSelectedProperties,arrSelectedItalianRegion,arrSelectedDistance,arrSelectedRating,selectFdaCertified,selectedSortProducer,selectedOptionsMethod,arrSelectedPropertiesName,arrSelectedMethodName)
            
            self.arrSelectedCategories = nextVC.arrSelectedCategories
            self.arrSelectedProperties = nextVC.arrSelectedProperties
           self.arrSelectedItalianRegion =  nextVC.arrSelectedItalianRegion
            self.arrSelectedDistance = nextVC.arrSelectedDistance
            self.arrSelectedRating = nextVC.arrSelectedRating
            
            self.selectFdaCertified = nextVC.selectFdaCertified
            self.selectedSortProducer = nextVC.selectedSortProducer
            self.selectedOptionsMethod = nextVC.selectedOptionsMethod
            
        }
        nextVC.clearFilterApi = { loadfilter in
            self.listType = 1
            self.callMyStoreProductApi(1)
        }

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height - (self.view.frame.height * 2) {
            if indexOfPageToRequest > arrProductList?.lastPage ?? 0{
                self.showAlert(withMessage: "No More Data Found")
            }else{
                // increments the number of the page to request
                indexOfPageToRequest += 1
                
                // call your API for more data
                callMyStoreProductApi(indexOfPageToRequest)
                
                // tell the table view to reload with the new data
                self.tableView.reloadData()
            }
        }
    }
}

extension ProductStoreVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProductList?.myStoreProduct?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        let data = arrProductList?.myStoreProduct?[indexPath.row]
        let imgUrl = (kImageBaseUrl + (data?.logo_id ?? ""))
        cell.imgStore.setImage(withString: imgUrl)
        cell.lblStoreName.text = data?.storeName
        cell.lblAddress.text = data?.location
        cell.lblTotalRating.text = data?.avg_rating
        cell.lblTotalReview.text = (data?.total_reviews ?? "0") + " Reviews"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "StoreDescViewController") as? StoreDescViewController else{return}
        let data = arrProductList?.myStoreProduct?[indexPath.row]
        nextVC.passStoreId = "\(data?.marketplace_store_id ?? 0)"
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

extension ProductStoreVC {
    func callMyStoreProductApi(_ pageNo: Int?){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kMarketPlaceProduct + "\(listType ?? 0)" + "?page=" + "\(pageNo ?? 0)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictResponse, error, errorType, statusCode in
            switch statusCode{
            case 200:
                let response = dictResponse as? [String:Any]
                if let data = response?["data"] as? [String:Any]{
                    self.lastPage = data["last_page"] as? Int
                    self.arrProductList = ProductsStore.init(with: data)
                }
            default:
                print("No Data")
            }
            self.tableView.reloadData()
        }
    }
    func callBoxFilterApi(_ arrSelectedCategories: [Int]?, _ arrSelectedProperties: [Int]?,_ arrSelectedItalianRegion: [Int]?,_ arrSelectedDistance: [Int]?,_ arrSelectedRating: [Int]?,_ selectFdaCertified: [Int]?,_ selectedSortProducer: [Int]?,_ selectedOptionsMethod: [Int]?, _ arrSelectedPropertiesName: [String]?,_ arrSelectedMethodName: [String]?){
        
       // let formattedPropertiesArray = (arrSelectedPropertiesName.map{String($0)}).joined(separator: ",")
    
        let selectedPropertyString = arrSelectedPropertiesName?.joined(separator: ",")
        let selectedMethodString = arrSelectedMethodName?.joined(separator: ",")
        
        let selectedCategoryStringId = arrSelectedCategories.map(String.init)
        let selectedRegionStringId = arrSelectedItalianRegion.map(String.init)
        let selectedRatingStringId = arrSelectedRating.map(String.init)
        //let selectedCategoryStringId = str
        
        let urlString = APIUrl.kMarketplaceBoxFilterApi + "?property=" + "\(selectedPropertyString ?? "")" + "&method=" + "\(selectedMethodString ?? "")" + "&category=" + "\(selectedCategoryStringId ?? "")" + "&region=" + "\(selectedRegionStringId ?? "")" + "&fda_certified=" + "\(selectFdaCertified?.first ?? -1)" + "&sort_by_producer=" + "\(selectedSortProducer?.first ?? -1)" + "&rating=" + "\(selectedRatingStringId ?? "")"
        let urlString1 = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        TANetworkManager.sharedInstance.requestApi(withServiceName:urlString1, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictresponse, error, errortype, statusCode in
            switch statusCode{
            case 200:
                let response = dictresponse as? [String:Any]
               
                if let data = response?["data"] as? [String:Any]{
                    self.lastPage = data["last_page"] as? Int
                    self.arrProductList = ProductsStore.init(with: data)
                }
            default:
                print("No Data")
            }
            self.tableView.reloadData()
        }
    }
    
    
}

class ProductTableViewCell: UITableViewCell{
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblTotalReview: UILabel!
    @IBOutlet weak var lblTotalRating: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var imgStore: UIImageView!
    @IBOutlet weak var vwContainer: UIView!
    
    override func awakeFromNib() {
        vwContainer.addShadow()
    }
    
}
