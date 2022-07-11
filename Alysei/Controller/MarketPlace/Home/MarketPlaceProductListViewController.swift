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
//    @IBOutlet weak var vwSearch: UIView!
//    @IBOutlet weak var hghtSearch: NSLayoutConstraint!
    @IBOutlet weak var lblNoProduct: UILabel!
    @IBOutlet weak var lblTryAgain: UILabel!
    @IBOutlet weak var searchtextField: UITextField!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var blankScreen: UIView!
    @IBOutlet weak var vwSearchUnderLine: UIView!
    
    var listType:Int?
    var keywordSearch: String?
    var filterTitle: String?
    var pushedFromVC : PushedFrom?
    var optionId: Int?
    var indexOfPageToRequest = 1
    var lastPage: Int?
    // var arrList: [MyStoreProductDetail]?
    var arrList: [ProductSearchListModel]?
    var arrListAppData = [ProductSearchListModel]()
    
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
    
    var isSearch = false
    var selecteMethodFilterName :String?
    var selectePropertiesFilterName :String?
    var selecteCategoryFilterId :String?
    var selectedRegionFilterId: String?
    var sortFilterId: String?
    var fdaFilterId: String?
    var selectRatingId: String?
    var searchProductString: String?
    var modifiedRatingArray = [Int]()
    var selectedRatingStringId : String?
    var stringRatingArray = [String]()
    var typeFirst = true
    var entityIndex: Int?
    
    
    //var selectFdaCertifiedId: String?
    
    
    //var homearrList: []
    override func viewDidLoad() {
        super.viewDidLoad()
        blankScreen.isHidden = true
        lblNoProduct.text = MarketPlaceConstant.kNoProductFound
        lblTryAgain.text = MarketPlaceConstant.kTryAgain
        if pushedFromVC == .viewAllEntities{
            btnSearch.isHidden = true
            btnFilter.isHidden = true
            callAllEntitiesApi(entityIndex ?? 0,1)
        }else{
            btnSearch.isHidden = false
        if pushedFromVC == .region{
            self.btnFilter.isHidden = false
            callRegionProductListApi(1)
        }else if pushedFromVC == .category{
            self.btnFilter.isHidden = false
            callCategoryProductListApi(1)
        }else if pushedFromVC == .conservation {
            self.btnFilter.isHidden = false
            callConservationListApi(1)
        }else if pushedFromVC == .fdaCertified{
            self.btnFilter.isHidden = false
            callOptionApi(1)
        }else if pushedFromVC == .myFav {
            self.btnFilter.isHidden = true
            callOptionApi(1)
        }else if pushedFromVC == .properties {
            self.btnFilter.isHidden = false
            callConservationListApi(1)
        }else{
            self.callProductListApi()
        }
        }
        //self.vwSearch.isHidden = true
        //vwSearch.layer.cornerRadius = 20
        searchtextField.delegate = self
        searchtextField.attributedPlaceholder = NSAttributedString(string: MarketPlaceConstant.kSearch,
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        lblHeading.text = keywordSearch
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchtextField.isHidden = true
        self.vwSearchUnderLine.isHidden = true
        self.lblHeading.isHidden = false
        self.searchtextField.resignFirstResponder()
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        //self.walkView1Trailing.constant = self.view.frame.width
       
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if isSearch == false{
//            self.arrListAppData = [ProductSearchListModel]()
//            if pushedFromVC == .region{
//                self.btnFilter.isHidden = false
//                callRegionProductListApi(1)
//            }else if pushedFromVC == .category{
//                self.btnFilter.isHidden = false
//                callCategoryProductListApi(1)
//            }else if pushedFromVC == .conservation {
//                self.btnFilter.isHidden = false
//                callConservationListApi(1)
//            }else if pushedFromVC == .fdaCertified{
//                self.btnFilter.isHidden = false
//                callOptionApi(1)
//            }else if pushedFromVC == .myFav {
//                self.btnFilter.isHidden = true
//                callOptionApi(1)
//            }else if pushedFromVC == .properties {
//                self.btnFilter.isHidden = false
//                callConservationListApi(1)
//            }else{
//                self.callProductListApi()
//            }
//        }
    //}
    @IBAction func btnBackAction(_ sender: UIButton){
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: MarketplaceHomePageVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    @IBAction func btnSearch(_ sender: UIButton){
        self.searchtextField.isHidden = false
        self.vwSearchUnderLine.isHidden = false
        self.lblHeading.isHidden = true
        self.searchtextField.becomeFirstResponder()
        self.isSearch = true
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
        
        nextVC.callApiCallBack = {
            arrSelectedCategories,arrSelectedProperties,arrSelectedItalianRegion,arrSelectedDistance,arrSelectedRating,selectFdaCertified,selectedSortProducer,selectedOptionsMethod,arrSelectedPropertiesName,arrSelectedMethodName in
            
            self.arrListAppData = [ProductSearchListModel]()
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
            self.callBoxFilterApi(arrSelectedCategories,arrSelectedProperties,arrSelectedItalianRegion,arrSelectedDistance,arrSelectedRating,selectFdaCertified,selectedSortProducer,selectedOptionsMethod,arrSelectedPropertiesName,arrSelectedMethodName,1)
            
        }
        nextVC.clearFilterApi = { loadfilter in
            //self.arrList?.removeAll()
            self.arrListAppData.removeAll()
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
            if indexOfPageToRequest > lastPage ?? 0{
                // self.showAlert(withMessage: "No More Data Found")
                print("No Data")
            }else{
                // increments the number of the page to request
                indexOfPageToRequest += 1
                if pushedFromVC == .viewAllEntities{
                    
                    callAllEntitiesApi(entityIndex ?? 0,indexOfPageToRequest)
                }else{
                if isSearch == false{
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
                }else if isSearch == true{
                    self.callBoxFilterApi(arrSelectedCategories,arrSelectedProperties,arrSelectedItalianRegion,arrSelectedDistance,arrSelectedRating,selectFdaCertified,selectedSortProducer,selectedOptionsMethod,arrSelectedPropertiesName,arrSelectedMethodName,indexOfPageToRequest)
                }
                }
                // tell the table view to reload with the new data
                self.tableView.reloadData()
            }
        }
        
    }
}

extension MarketPlaceProductListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return arrList?.count ?? 0
        return arrListAppData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketPlaceProductListTableVCell", for: indexPath) as? MarketPlaceProductListTableVCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        //cell.configCell(arrList?[indexPath.row] ?? ProductSearchListModel(with: [:]))
        if arrListAppData.count == 0 {
            print("No Data")
        }else{
        cell.configCell(arrListAppData[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ProductDetailVC") as? ProductDetailVC else {return}
        nextVC.marketplaceProductId = "\(self.arrListAppData[indexPath.row].marketplaceProductId ?? 0)"
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
extension MarketPlaceProductListViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
//            if updatedText == "" {
//                callOptionApi(1)
//                self.isSearch = false
//            }else{
//                self.searchProductString = updatedText
//                self.callBoxFilterApi(arrSelectedCategories,arrSelectedProperties,arrSelectedItalianRegion,arrSelectedDistance,arrSelectedRating,selectFdaCertified,selectedSortProducer,selectedOptionsMethod,arrSelectedPropertiesName,arrSelectedMethodName)
//            }
            self.isSearch = true
            self.arrListAppData = [ProductSearchListModel]()
            
            if updatedText == "" {
                self.arrListAppData = [ProductSearchListModel]()
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
                self.isSearch = false
                self.typeFirst = true
            }else if isSearch == true {
                self.searchProductString = updatedText
            self.callBoxFilterApi(arrSelectedCategories,arrSelectedProperties,arrSelectedItalianRegion,arrSelectedDistance,arrSelectedRating,selectFdaCertified,selectedSortProducer,selectedOptionsMethod,arrSelectedPropertiesName,arrSelectedMethodName,1)
            }
            if typeFirst == true{
                self.arrListAppData = [ProductSearchListModel]()
                self.typeFirst = false
            }
            
        }
        return true
    }
}
extension MarketPlaceProductListViewController{
    func callProductListApi(){
        let urlString = APIUrl.kMarketPlaceProductBox + "\(listType ?? 0)" + "&keyword=" + "\(keywordSearch ?? "")"
        let urlString1 = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        TANetworkManager.sharedInstance.requestApi(withServiceName: urlString1 , requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictresponse, error, errorType, statusCode in
            switch statusCode{
            case 200:
            let response = dictresponse as? [String:Any]
            if let data = response?["data"] as? [[String:Any]]{
                self.arrList = data.map({ProductSearchListModel.init(with: $0)})
            }
            for i in 0..<(self.arrList?.count ?? 0){
                self.arrListAppData.append(self.arrList?[i] ?? ProductSearchListModel(with: [:]))
            }
                if self.arrListAppData.count == 0 {
                    self.blankScreen.isHidden = false
                }else{
                    self.blankScreen.isHidden = true
                }
            case 409:
                if self.indexOfPageToRequest == 1{
                    self.blankScreen.isHidden = false
                }
            default:
            if (self.arrListAppData.count == 0) {
                self.blankScreen.isHidden = false
//                self.showAlert(withMessage: "No product found") {
//                    self.navigationController?.popViewController(animated: true)
//                }
            }else{
                self.blankScreen.isHidden = true
                print("No More Data")
            }
        }
            self.tableView.reloadData()
        
    }
    }
    func callRegionProductListApi(_ pageNo: Int?){
        let urlString = APIUrl.kGetProductByRegionId + "\(optionId ?? 0)"
        let urlString1 = (urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") + "&page=" + "\(pageNo ?? 0)"
        TANetworkManager.sharedInstance.requestApi(withServiceName: urlString1 , requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictresponse, error, errorType, statusCode in
            switch statusCode{
            case 200:
            let response = dictresponse as? [String:Any]
            if let data = response?["data"] as? [String:Any]{
                self.lastPage = data["last_page"] as? Int
                if let subData = data["data"] as? [[String:Any]]{
                    self.arrList = subData.map({ProductSearchListModel.init(with: $0)})
                }
                for i in 0..<(self.arrList?.count ?? 0){
                    self.arrListAppData.append(self.arrList?[i] ?? ProductSearchListModel(with: [:]))
                }
            }
                if self.arrListAppData.count == 0 {
                    self.blankScreen.isHidden = false
                }else{
                    self.blankScreen.isHidden = true
                }
            case 409:
                if self.indexOfPageToRequest == 1{
                    self.blankScreen.isHidden = false
                }
            default:
                if (self.arrListAppData.count == 0) {
                    self.blankScreen.isHidden = false
//                 self.showAlert(withMessage: "No product found") {
//                    self.navigationController?.popViewController(animated: true)
//                }
                }else{
                    self.blankScreen.isHidden = true
                    print("No More Data")
                }
        }
            self.tableView.reloadData()
        }
    }
    func callCategoryProductListApi(_ pageNo : Int?){
        let urlString = APIUrl.kGetProductByCategoryId + "\(optionId ?? 0)"
        let urlString1 = (urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") + "&page=" + "\(pageNo ?? 0)"
        TANetworkManager.sharedInstance.requestApi(withServiceName: urlString1 , requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictresponse, error, errorType, statusCode in
            switch statusCode{
            case 200:
            let response = dictresponse as? [String:Any]
            if let data = response?["data"] as? [String:Any]{
                self.lastPage = data["last_page"] as? Int
                if let subData = data["data"] as? [[String:Any]]{
                    self.arrList = subData.map({ProductSearchListModel.init(with: $0)})
                }
                for i in 0..<(self.arrList?.count ?? 0){
                    self.arrListAppData.append(self.arrList?[i] ?? ProductSearchListModel(with: [:]))
                }
            }
                if self.arrListAppData.count == 0 {
                    self.blankScreen.isHidden = false
                }else{
                    self.blankScreen.isHidden = true
                }
            case 409:
                if self.indexOfPageToRequest == 1{
                    self.blankScreen.isHidden = false
                }
            default:
            if (self.arrListAppData.count == 0) {
                self.blankScreen.isHidden = true
//                self.showAlert(withMessage: "No product found") {
//                    self.navigationController?.popViewController(animated: true)
//                }
            }else{
                self.blankScreen.isHidden = false
                print("No More Data")
            }
        }
            self.tableView.reloadData()
        
    }
    }
    func callConservationListApi(_ pageNo : Int?){
        let urlString = APIUrl.kMarketPlaceProductBox + "\(listType ?? 0)" + "&keyword=" + "\(keywordSearch ?? "")" + "&page=" + "\(pageNo ?? 0)"
        let urlString1 = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        TANetworkManager.sharedInstance.requestApi(withServiceName: urlString1 , requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictresponse, error, errorType, statusCode in
            switch statusCode{
            case 200:
            let response = dictresponse as? [String:Any]
            if let data = response?["data"] as? [String:Any]{
                self.lastPage = data["last_page"] as? Int
                if let subData = data["data"] as? [[String:Any]]{
                    self.arrList = subData.map({ProductSearchListModel.init(with: $0)})
                }
                for i in 0..<(self.arrList?.count ?? 0){
                    self.arrListAppData.append(self.arrList?[i] ?? ProductSearchListModel(with: [:]))
                }
            }
                if self.arrListAppData.count == 0 {
                    self.blankScreen.isHidden = false
                }else{
                    self.blankScreen.isHidden = true
                }
            case 409:
                if self.indexOfPageToRequest == 1 {
                    self.blankScreen.isHidden = false
                }
            default:
                if (self.arrListAppData.count == 0) {
                    self.blankScreen.isHidden = false
//                    self.showAlert(withMessage: "No product found") {
//                        self.navigationController?.popViewController(animated: true)
//                    }
                }else{
                    self.blankScreen.isHidden = true
                    print("No More Data")
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
                    for i in 0..<(self.arrList?.count ?? 0){
                        self.arrListAppData.append(self.arrList?[i] ?? ProductSearchListModel(with: [:]))
                    }
                }
                if self.arrListAppData.count == 0 {
                    self.blankScreen.isHidden = false
                }else{
                    self.blankScreen.isHidden = true
                }
            case 409:
                if self.indexOfPageToRequest == 1{
                    self.blankScreen.isHidden = false
                }
            default:
                if (self.arrListAppData.count == 0) {
                    self.blankScreen.isHidden = false
//                    self.showAlert(withMessage: "No product found") {
//                        self.navigationController?.popViewController(animated: true)
//                    }
              
                }else{
                    self.blankScreen.isHidden = true
                    print("No More Data")
                }
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
    
    func callBoxFilterApi(_ arrSelectedCategories: [Int]?, _ arrSelectedProperties: [Int]?,_ arrSelectedItalianRegion: [Int]?,_ arrSelectedDistance: [Int]?,_ arrSelectedRating: [Int]?,_ selectFdaCertified: [Int]?,_ selectedSortProducer: [Int]?,_ selectedOptionsMethod: [Int]?, _ arrSelectedPropertiesName: [String]?,_ arrSelectedMethodName: [String]?, _ page: Int?){
        
        // let formattedPropertiesArray = (arrSelectedPropertiesName.map{String($0)}).joined(separator: ",")
        self.arrListAppData = [ProductSearchListModel]()
        let selectedPropertyString = arrSelectedPropertiesName?.joined(separator: ",")
        selectePropertiesFilterName = selectedPropertyString
        
        
        let selectedMethodStringName = arrSelectedMethodName?.joined(separator: ",")
        selecteMethodFilterName = selectedMethodStringName
        
        
        
        let stringCatArray = arrSelectedCategories?.compactMap({String($0)}) //{ String($0)!}
        let selectedCategoryStringId = stringCatArray?.joined(separator: ",")
        
//        if pushedFromVC == .category{
//            selecteCategoryFilterId = "\(optionId ?? 0)"
//        }else{
            selecteCategoryFilterId = selectedCategoryStringId
      //  }
        
        
        let stringRegionArray = arrSelectedItalianRegion?.compactMap({String($0)}) //{ String($0)!}
        let selectedRegionStringId = stringRegionArray?.joined(separator: ",")
//        if pushedFromVC == .region {
//            selectedRegionFilterId = "\(optionId ?? 0)"
//        }else{
            selectedRegionFilterId = selectedRegionStringId
      //  }
    
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
        
        let stringFdaArray = selectFdaCertified?.compactMap({String($0)})
        let selectedFdaCertificate = stringFdaArray?.joined(separator: ",")
        
            if selectedFdaCertificate == "0"{
                fdaFilterId = "1"
            }else if selectedFdaCertificate == "1"{
                fdaFilterId = "0"
            }else{
                fdaFilterId = ""
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
        
        if pushedFromVC == .conservation || pushedFromVC == .properties{
            self.filterTitle = keywordSearch
        }else if pushedFromVC == .fdaCertified {
            self.filterTitle = ""
        }else{
            self.filterTitle = "\(optionId ?? 0)"
        }
        
        let urlString = APIUrl.kMarketplaceBoxFilterApi + "property=" + "\(selectePropertiesFilterName ?? "")" + "&method=" + "\(selecteMethodFilterName ?? "")" + "&category=" + "\(selecteCategoryFilterId ?? "")" + "&region=" + "\(selectedRegionFilterId ?? "")" + "&fda_certified=" + "\(fdaFilterId ?? "")" + "&sort_by_product=" + "\(sortFilterId ?? "")" + "&sort_by_producer=" + "" + "&rating=" + "\(selectedRatingStringId ?? "")" + "&keyword=" + "\(searchProductString ?? "")" + "&title=" + "\(self.filterTitle ?? "")" + "&box_id=" + "\(self.listType ?? 0)" + "&type=" + "2" + "&page=" + "\(page ?? 1)"
        
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
                    for i in 0..<(self.arrList?.count ?? 0){
                        self.arrListAppData.append(self.arrList?[i] ?? ProductSearchListModel(with: [:]))
                    }
                }else{
                    self.arrListAppData = [ProductSearchListModel]()
                }
                if self.arrListAppData.count == 0 {
                    self.blankScreen.isHidden = false
                }else{
                    self.blankScreen.isHidden = true
                }
            case 409:
               // self.arrListAppData = [ProductSearchListModel]()
                if self.indexOfPageToRequest == 1 {
                    self.blankScreen.isHidden = false
                }
               
                //self.showAlert(withMessage: "No products found")
            default:
                if (self.arrListAppData.count == 0) {
                    self.blankScreen.isHidden = true
                //self.showAlert(withMessage: "No products found")
                }else{
                    self.blankScreen.isHidden = false
                    print("No More Data")
                }
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
                   
                    if let subData = data["data"] as? [[String:Any]]{
                        self.arrList = subData.map({ProductSearchListModel.init(with: $0)})
                    }
                    for i in 0..<(self.arrList?.count ?? 0){
                        self.arrListAppData.append(self.arrList?[i] ?? ProductSearchListModel(with: [:]))
                    }
                }
//                else{
//                    self.arrListAppData = [ProductSearchListModel]()
//                }
                if self.arrListAppData.count == 0 {
                    self.blankScreen.isHidden = false
                }else{
                    self.blankScreen.isHidden = true
                }
            case 409:
                if indexOfPageToRequest == 1 {
                    self.blankScreen.isHidden = false
                }
                //self.showAlert(withMessage: "No products found")
            default:
                if (self.arrListAppData.count == 0) {
                    self.blankScreen.isHidden = false
               // self.showAlert(withMessage: "No products found")
                }else{
                    self.blankScreen.isHidden = true
                    print("No More Data")
                }
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
    @IBOutlet weak var imgProduct: ImageLoader!
    @IBOutlet weak var lblPriceHeight: NSLayoutConstraint!
    @IBOutlet weak var lblSampleHeight: NSLayoutConstraint!
    @IBOutlet weak var vwbottomTop: NSLayoutConstraint!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgProduct.image = UIImage(named: "image_placeholder")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblAvalblForSample.text = MarketPlaceConstant.kAvailableForSample
    }
    
    
    func configCell(_ data: ProductSearchListModel){
        
        lblProductName.text = data.title
        if (kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.voyagers.rawValue)" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.travelAgencies.rawValue)" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.restaurant.rawValue)" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.voiceExperts.rawValue)" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.producer.rawValue)"){
            lblCost.isHidden = true
            lblPriceHeight.constant = 0
        }else{
            lblCost.isHidden = false
            lblPriceHeight.constant = 26.33
        }
        lblCost.text = "$" + (data.product_price ?? "")
        lblStoreName.text = data.store_name
        lblProductType.text = data.product_category_name
        lblTotalRating.text = "\(data.total_reviews ?? 0)" + MarketPlaceConstant.kSRatings
        let baseUrl = data.product_gallery?.first?.baseUrl ?? ""
        
        //if let imgUrl = URL(string: baseUrl + String.getString(data.product_gallery?.first?.attachment_url)){
        // self.imgProduct.loadImageUrl(imgUrl)
         let imgUrl = String.getString(baseUrl + String.getString(data.product_gallery?.first?.attachment_url))
      
            self.imgProduct.setImage(withString: imgUrl)
        
        if (kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.voyagers.rawValue)" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.travelAgencies.rawValue)" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.restaurant.rawValue)" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.producer.rawValue)") {
            lblAvalblForSample.isHidden = true
            imgSample.isHidden = true
            lblSampleHeight.constant = 0
            vwbottomTop.constant = 44
        }else{
        if data.available_for_sample == AppConstants.CYes {
            lblAvalblForSample.isHidden = false
            imgSample.isHidden = false
            lblSampleHeight.constant = 18.67
            vwbottomTop.constant = 15
        }else {
            lblAvalblForSample.isHidden = true
            imgSample.isHidden = true
            lblSampleHeight.constant = 0
            vwbottomTop.constant = 20
        }
        }
        lblAvg_Rating.text = "\(data.avg_rating ?? "0")"
    }
    
}

