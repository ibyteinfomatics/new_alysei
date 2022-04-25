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
    @IBOutlet weak var txtSearch: UITextField!
    //@IBOutlet weak var vwSearch: UIView!
    //@IBOutlet weak var hghtSearch: NSLayoutConstraint!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var blankView: UIView!
    @IBOutlet weak var vwSearchUnderLine: UIView!
    @IBOutlet weak var lblNoStoreFound: UILabel!
    @IBOutlet weak var lblTryAgain: UILabel!
        
    var indexOfPageToRequest = 1
    var listType: Int?
    var arrProductList:ProductsStore?
    var pushedFromVC: PushedFrom?
    var optionId: Int?
    var keywordSearch: String?
    //var pushedFromVC: PushedFrom?
    
    var isSearch = false
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
    var modifiedRatingArray = [Int]()
    var selectedRatingStringId : String?
    var stringRatingArray = [String]()
    
    var arrListData = [MyStoreProductDetail]()
    var data : MyStoreProductDetail?
    var searchTxt: String?
    var lastPage: Int?
    var typeFirst = true
   
    override func viewDidLoad() {
        super.viewDidLoad()
        lblNoStoreFound.text = MarketPlaceConstant.kNoStoreFound
        lblTryAgain.text = MarketPlaceConstant.kTryAgain
      //  vwSearch.isHidden =  true
        txtSearch.attributedPlaceholder = NSAttributedString(string: MarketPlaceConstant.kSearch,
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
       // vwSearch.layer.cornerRadius = 20
        //self.hghtSearch.constant = 0
        self.txtSearch.delegate = self
        self.lblHeading.text = keywordSearch
        self.blankView.isHidden = true
        if pushedFromVC == .viewAllEntities{
            self.btnSearch.isHidden = true
            self.btnFilter.isHidden = true
            callAllEntitiesApi(2,1)
        }else{
            self.btnSearch.isHidden = false
            self.btnFilter.isHidden = false
        callMyStoreProductApi(1)
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.txtSearch.isHidden = true
        self.vwSearchUnderLine.isHidden = true
        self.lblHeading.isHidden = false
        self.txtSearch.resignFirstResponder()
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
        nextVC.arrSelectedPropertiesName = self.arrSelectedPropertiesName
        nextVC.arrSelectedMethodName = self.arrSelectedMethodName
        nextVC.callApiCallBack = {
            arrSelectedCategories,arrSelectedProperties,arrSelectedItalianRegion,arrSelectedDistance,arrSelectedRating,selectFdaCertified,selectedSortProducer,selectedOptionsMethod,arrSelectedPropertiesName,arrSelectedMethodName in
           
            self.arrListData = [MyStoreProductDetail]()
            self.indexOfPageToRequest = 1
        self.callBoxFilterApi(arrSelectedCategories,arrSelectedProperties,arrSelectedItalianRegion,arrSelectedDistance,arrSelectedRating,selectFdaCertified,selectedSortProducer,selectedOptionsMethod,arrSelectedPropertiesName,arrSelectedMethodName,1)
            
            self.arrSelectedCategories = nextVC.arrSelectedCategories
            self.arrSelectedProperties = nextVC.arrSelectedProperties
           self.arrSelectedItalianRegion =  nextVC.arrSelectedItalianRegion
            self.arrSelectedDistance = nextVC.arrSelectedDistance
            self.arrSelectedRating = nextVC.arrSelectedRating
            
            self.selectFdaCertified = nextVC.selectFdaCertified
            self.selectedSortProducer = nextVC.selectedSortProducer
            self.selectedOptionsMethod = nextVC.selectedOptionsMethod
            self.arrSelectedPropertiesName = nextVC.arrSelectedPropertiesName
            self.arrSelectedMethodName = nextVC.arrSelectedMethodName
            
        }
        nextVC.clearFilterApi = { loadfilter in
            self.arrListData.removeAll()
            self.arrSelectedCategories = [Int]()
            self.arrSelectedProperties = [Int]()
           self.arrSelectedItalianRegion =  [Int]()
            self.arrSelectedDistance = [Int]()
            self.arrSelectedRating = [Int]()
            
            self.selectFdaCertified = [Int]()
            self.selectedSortProducer = [Int]()
            self.selectedOptionsMethod = [Int]()
            self.arrSelectedPropertiesName = [String]()
            self.arrSelectedMethodName = [String]()
            self.listType = 1
            self.callMyStoreProductApi(1)
        }

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func btnSearch(_ sender: UIButton){
        self.txtSearch.isHidden = false
        self.lblHeading.isHidden = true
        self.txtSearch.becomeFirstResponder()
        self.vwSearchUnderLine.isHidden = false
      //  self.hghtSearch.constant = 40
        self.isSearch = true
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height - (self.view.frame.height * 2) {
            if indexOfPageToRequest > arrProductList?.lastPage ?? 0{
                print("No Data")
                //self.showAlert(withMessage: "No More Data Found")
            }else{
                // increments the number of the page to request
                indexOfPageToRequest += 1
                if pushedFromVC == .viewAllEntities{
                    callAllEntitiesApi(2,indexOfPageToRequest)
                }else{
                // call your API for more data
                if self.isSearch == false{
                callMyStoreProductApi(indexOfPageToRequest)
                }else{
                    self.callBoxFilterApi(arrSelectedCategories,arrSelectedProperties,arrSelectedItalianRegion,arrSelectedDistance,arrSelectedRating,selectFdaCertified,selectedSortProducer,selectedOptionsMethod,arrSelectedPropertiesName,arrSelectedMethodName,indexOfPageToRequest)
                }
                }
                
                // tell the table view to reload with the new data
                self.tableView.reloadData()
            }
        }
    }
}
extension ProductStoreVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as NSString? {
            let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
            self.searchTxt = txtAfterUpdate
            self.isSearch = true
            self.arrListData = [MyStoreProductDetail]()
            if typeFirst == true{
                self.arrListData = [MyStoreProductDetail]()
                self.typeFirst = false
            }
            if self.searchTxt == "" {
                self.arrListData = [MyStoreProductDetail]()
                callMyStoreProductApi(1)
                self.isSearch = false
                self.typeFirst = true
            }else if isSearch == true{
            self.callBoxFilterApi(arrSelectedCategories,arrSelectedProperties,arrSelectedItalianRegion,arrSelectedDistance,arrSelectedRating,selectFdaCertified,selectedSortProducer,selectedOptionsMethod,arrSelectedPropertiesName,arrSelectedMethodName,1)
            }
       
    }
        return true
}
}
extension ProductStoreVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if isSearch == false{
            return arrListData.count
//        }else{
//        return arrProductList?.myStoreProduct?.count ?? 0
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        if arrListData.count == 0 {
            print("No Data")
        }else{
       
       // if isSearch == false{
             data = arrListData[indexPath.row]
//        }else{
//            data = arrProductList?.myStoreProduct?[indexPath.row]
//        }
        
        cell.configCell(data)
            let imgUrl = ((data?.logo_base_url ?? "") + (data?.logo_id ?? ""))
        cell.imgStore.setImage(withString: imgUrl)
        cell.lblStoreName.text = data?.storeName
            cell.lblAddress.text = data?.region?.name
        cell.lblTotalRating.text = data?.avg_rating
            cell.lblProductType.text = data?.product_category_name
            cell.lblTotalReview.text = (data?.total_reviews ?? "0") + MarketPlaceConstant.kSpaceReview
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  guard let nextVC = self.storyboard?.instantiateViewController(identifier: "StoreDescViewController") as? StoreDescViewController else{return}
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "StoreDescrptnViewController") as? StoreDescrptnViewController else{return}
        
        //var data = arrListData[indexPath.row]
//        if isSearch {
//
//            data = (arrProductList?.myStoreProduct?[indexPath.row])!
//        } else {
            let data = arrListData[indexPath.row]
       // }
        
        
        nextVC.passStoreId = "\(data.marketplace_store_id ?? 0)"
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
                    self.arrListData.append(contentsOf: self.arrProductList?.myStoreProduct ?? [MyStoreProductDetail]())
                }else{
                    self.arrListData = [MyStoreProductDetail]()
                }
            case 409:
                if self.indexOfPageToRequest == 1{
                    self.blankView.isHidden = false
                }
            default:
                if self.arrListData.count == 0{
                    self.showAlert(withMessage:MarketPlaceConstant.kNoProducer) {
                        self.navigationController?.popViewController(animated: true)
                    }
                    if self.arrListData.count == 0 {
                        self.blankView.isHidden = false
                    }else{
                        self.blankView.isHidden = true
                    }
                }else{
                  //  self.blankView.isHidden = false
                print("No Data")
                }
            }
            self.tableView.reloadData()
        }
    }
    func callBoxFilterApi(_ arrSelectedCategories: [Int]?, _ arrSelectedProperties: [Int]?,_ arrSelectedItalianRegion: [Int]?,_ arrSelectedDistance: [Int]?,_ arrSelectedRating: [Int]?,_ selectFdaCertified: [Int]?,_ selectedSortProducer: [Int]?,_ selectedOptionsMethod: [Int]?, _ arrSelectedPropertiesName: [String]?,_ arrSelectedMethodName: [String]?, _ pageNo: Int?){
        
       
       // let formattedPropertiesArray = (arrSelectedPropertiesName.map{String($0)}).joined(separator: ",")
    
        let selectedPropertyString = arrSelectedPropertiesName?.joined(separator: ",")
        let selectedMethodString = arrSelectedMethodName?.joined(separator: ",")
        
      //  let selectedCategoryStringId = arrSelectedCategories.map(String.init)
       // let selectedRegionStringId = arrSelectedItalianRegion.map(String.init)
        //let selectedRatingStringId = arrSelectedRating.map(String.init)
        
        let stringCatArray = arrSelectedCategories?.compactMap({String($0)}) //{ String($0)!}
        let selectedCategoryStringId = stringCatArray?.joined(separator: ",")
        
        let stringRegionArray = arrSelectedItalianRegion?.compactMap({String($0)}) //{ String($0)!}
        let selectedRegionStringId = stringRegionArray?.joined(separator: ",")
        
        
        //MARK:- Rating
        if arrSelectedRating?.count != 0{
        for i in 0..<(arrSelectedRating?.count ?? 0){
            self.modifiedRatingArray.append((arrSelectedRating?[i] ?? 0) + 1)
        }
         stringRatingArray = modifiedRatingArray.compactMap({String($0)})
        
        }
        else{
            stringRatingArray = arrSelectedRating?.compactMap({String($0)}) ?? [String]()
        }
         selectedRatingStringId = stringRatingArray.joined(separator: ",")
    
        let selectedSortProducerString = String.getString(selectedSortProducer?.first)
        let selectFdaCertifiedString = String.getString(selectFdaCertified?.first)
        
        let urlString = APIUrl.kMarketplaceBoxFilterApi + "property=" + "\(selectedPropertyString ?? "")" + "&method=" + "\(selectedMethodString ?? "")" + "&category=" + "\(selectedCategoryStringId ?? "")" + "&region=" + "\(selectedRegionStringId ?? "")" + "&fda_certified=" + "\(selectFdaCertifiedString )" + "&sort_by_producer=" + "\(selectedSortProducerString )" + "&sort_by_product=" + "" + "&rating=" + "\(selectedRatingStringId ?? "")" + "&type=1" + "&keyword=" + "\(self.searchTxt ?? "")" + "&title=" + "" + "&box_id=1" + "&page=" + "\(pageNo ?? 1)"
        let urlString1 = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        TANetworkManager.sharedInstance.requestApi(withServiceName:urlString1, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictresponse, error, errortype, statusCode in
            switch statusCode{
            case 200:
                let response = dictresponse as? [String:Any]
               
                if let data = response?["data"] as? [String:Any]{
                    self.lastPage = data["last_page"] as? Int
                    self.arrProductList = ProductsStore.init(with: data)
                    self.arrListData.append(contentsOf: self.arrProductList?.myStoreProduct ?? [MyStoreProductDetail]())
                    if self.arrListData.count == 0 {
                        self.blankView.isHidden = false
                    }else{
                        self.blankView.isHidden = true
                    }
                }
            default:
                //self.blankView.isHidden = false
                print("No Data")
            }
            self.tableView.reloadData()
        }
    }
    
    func callAllEntitiesApi(_ entityIndex: Int, _ indexOfPageToRequest: Int){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.getAllEntities +  "\(entityIndex)" + "?page=" + "\(indexOfPageToRequest)" , requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            switch statusCode{
            case 200:
                let response = dictResponse as? [String:Any]
               
                if let data = response?["data"] as? [String:Any]{
                    self.lastPage = data["last_page"] as? Int
                    self.arrProductList = ProductsStore.init(with: data)
                    self.arrListData.append(contentsOf: self.arrProductList?.myStoreProduct ?? [MyStoreProductDetail]())
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
    
    @IBOutlet weak var userRatingStar1: UIImageView!
    @IBOutlet weak var userRatingStar2: UIImageView!
    @IBOutlet weak var userRatingStar3: UIImageView!
    @IBOutlet weak var userRatingStar4: UIImageView!
    @IBOutlet weak var userRatingStar5: UIImageView!
    @IBOutlet weak var lblProductType: UILabel!
    
    var data: MyStoreProductDetail?
    override func awakeFromNib() {
        vwContainer.addShadow()
        
    }
    
    func configCell(_ data: MyStoreProductDetail?){
        self.data = data
        setUserRatngStarUI()
    }
    func setUserRatngStarUI(){
        if self.data?.avg_rating == "0.0" || data?.avg_rating == "0" {
            userRatingStar1.image = UIImage(named: "icons8_star")
            userRatingStar2.image = UIImage(named: "icons8_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        } else if (data?.avg_rating ?? "") >= "0.1" && (data?.avg_rating ?? "") <= "0.9" {
            userRatingStar1.image = UIImage(named: "HalfStar")
            userRatingStar2.image = UIImage(named: "icons8_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.avg_rating == "1.0" || data?.avg_rating == "1" {
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if (data?.avg_rating ?? "") >= "1.1"  && (data?.avg_rating ?? "") <= "1.9"{
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "HalfStar")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.avg_rating == "2.0" || data?.avg_rating == "2"{
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if (data?.avg_rating ?? "") >= "2.1"  && (data?.avg_rating ?? "") <= "2.9"{
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "HalfStar")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.avg_rating == "3.0" || data?.avg_rating == "3"{
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if (data?.avg_rating ?? "") >= "3.1"  && (data?.avg_rating ?? "") <= "3.9" {
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star")
            userRatingStar4.image = UIImage(named: "HalfStar")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if data?.avg_rating == "4.0" || data?.avg_rating == "4"{
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star")
            userRatingStar4.image = UIImage(named: "icons8_christmas_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
        }else if (data?.avg_rating ?? "") >= "4.1"  && (data?.avg_rating ?? "") <= "4.9" {
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star")
            userRatingStar4.image = UIImage(named: "icons8_christmas_star")
            userRatingStar5.image = UIImage(named: "HalfStar")
        }else if data?.avg_rating == "5.0" || data?.avg_rating == "5"{
            userRatingStar1.image = UIImage(named: "icons8_christmas_star")
            userRatingStar2.image = UIImage(named: "icons8_christmas_star")
            userRatingStar3.image = UIImage(named: "icons8_christmas_star")
            userRatingStar4.image = UIImage(named: "icons8_christmas_star")
            userRatingStar5.image = UIImage(named: "icons8_christmas_star")
        }else{userRatingStar1.image = UIImage(named: "icons8_star")
            userRatingStar2.image = UIImage(named: "icons8_star")
            userRatingStar3.image = UIImage(named: "icons8_star")
            userRatingStar4.image = UIImage(named: "icons8_star")
            userRatingStar5.image = UIImage(named: "icons8_star")
            print("Invalid Rating")
        }
    }
}
