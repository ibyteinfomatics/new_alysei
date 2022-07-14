//
//  ProducerStoreFilterVC.swift
//  Alysei
//
//  Created by Gitesh Dang on 10/7/21.
//

import UIKit
enum loadFilter{
    case producerStore
    case conservationFood
    case region
    case category
    case properties
    case fdaCertified
    case myFav
}
enum checkHitApi : String{
    case method = "Conservation Method"
    case categories = "Product Category"
    case properties = "Properties"
    case fdaCertified = "FDA Certified"
    case sortProducer
    case region = "Italian Regions"
    case distance = "Distance"
    case rating = " Ratings"
    case producers = "Producers"
    case productName = "Products"

}
enum checkItalianHitApi : String{
    case method = "Metodo"
    case categories = "Metodo di Conservazione"
    case properties = "Proprietà"
    case fdaCertified = "Certificato FDA"
    case sortProducer
    case region =  "Regioni Italiane"
    case distance =  "Distanza"
    case rating = " Recensioni"
    case producers =  "Produttori"
    case productName =  "Prodotti"
    
}


class ProducerStoreFilterVC: UIViewController {
    
    @IBOutlet weak var optionTableView: UITableView!
    @IBOutlet weak var subOptionTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var btnClearFilter: UIButton!
    @IBOutlet weak var btnApplyFilter: UIButton!
    
    var selectedIndex = 0
    
        //var arrOption = ["Categories","Properties","Italian Region","Distance","Ratings"]
    var arrOption = [MarketPlaceConstant.kProductCategories,MarketPlaceConstant.kProperties,MarketPlaceConstant.kItalianRegion,MarketPlaceConstant.kRatings,MarketPlaceConstant.kFDACertified]
    var arrConservationOption = [MarketPlaceConstant.kProductCategories,MarketPlaceConstant.kProperties,MarketPlaceConstant.kItalianRegion,MarketPlaceConstant.kFDACertified]
    var arrRegionOption = [MarketPlaceConstant.kProducts,MarketPlaceConstant.kConservationMethod,MarketPlaceConstant.kProductCategories,MarketPlaceConstant.kProperties,MarketPlaceConstant.kFDACertified]
    var arrCategoriesOption = [MarketPlaceConstant.kConservationMethod,MarketPlaceConstant.kProperties,MarketPlaceConstant.kFDACertified]
    var arrPropertiesOption = [MarketPlaceConstant.kConservationMethod,MarketPlaceConstant.kFDACertified,MarketPlaceConstant.kProductCategories]
    //var arrFdaCertifiedOption = ["Producers","Product Name","Italian Region","Categories"]
    var arrFdaCertifiedOption = [MarketPlaceConstant.kProducts,MarketPlaceConstant.kItalianRegion,MarketPlaceConstant.kProductCategories]
    var arrMyFavOption = [MarketPlaceConstant.kProducers,MarketPlaceConstant.kConservationMethod,MarketPlaceConstant.kProductCategories,MarketPlaceConstant.kProperties,MarketPlaceConstant.kFDACertified,MarketPlaceConstant.kDistance,MarketPlaceConstant.kRatings]
    
    var arrDistance = [MarketPlaceConstant.kWithIn5Miles,MarketPlaceConstant.kWithIn10Miles,MarketPlaceConstant.kWithIn20Miles,MarketPlaceConstant.kWithIn40Miles,MarketPlaceConstant.kWithIn100Miles]
    var arrRating = [MarketPlaceConstant.kMostratedstores,MarketPlaceConstant.k5StarStores,MarketPlaceConstant.kMostSearched]
    var arrFdaCertified = [MarketPlaceConstant.kYes,MarketPlaceConstant.kNo]
    var arrSortProducer = [MarketPlaceConstant.kSortByAtoZ,MarketPlaceConstant.kSortByZtoA]
    var arrFilterOptions = [FilterModel]()
    var arrDistanceOption = [FilterModel]()
    var arrRatingOptions = [FilterModel]()
    var arrOptionFdaCert = [FilterModel]()
    var arrOptionSortProducers = [FilterModel]()
    var loadingFirstTime = true
    var arrList: [MyStoreProductDetail]?
    var lastPage: Int?
    var indexOfPageToRequest = 1
    var identifyList: Int?
    var loadDistance = false
    var loadFilter : loadFilter?
    var checkApi: checkHitApi?
    
    var selectedId: Int?
    var selectedOptionsId = [Int]()
    
    var arrSelectedCategories = [Int]()
    var arrSelectedProperties = [Int]()
    var arrSelectedItalianRegion = [Int]()
    var arrSelectedDistance = [Int]()
    var arrSelectedRating = [Int]()
    //var arrSelectedMethod = [Int]()
    var selectFdaCertified = [Int]()
    var selectedSortProducer = [Int]()
    var selectedOptionsMethod = [Int]()
    
    var arrSelectedName = [String]()
    var arrSelectedPropertiesName = [String]()
    var arrSelectedMethodName = [String]()
    var selectName: String?
    
    var callApiCallBack: (([Int]?,[Int]?,[Int]?,[Int]?,[Int]?,[Int]?,[Int]?,[Int]?, [String]?,[String]? )-> Void)? = nil
    var clearFilterApi:((loadFilter?) -> Void)? = nil
    //  var loadRating =
    override func viewDidLoad() {
        super.viewDidLoad()
        btnClearFilter.setTitle(MarketPlaceConstant.kClearFilters, for: .normal)
        btnApplyFilter.setTitle(MarketPlaceConstant.kApplyFilters, for: .normal)
        lblHeading.text = MarketPlaceConstant.kFilter
        setUI()
        // Do any additional setup after loading the view.
    }
    
    func setUI(){
        if loadFilter == .producerStore{
            for option in arrOption {
                self.arrFilterOptions.append(FilterModel(name: option, isSelected: false))
            }
        }else if loadFilter == .conservationFood{
            for option in arrConservationOption {
                self.arrFilterOptions.append(FilterModel(name: option, isSelected: false))
            }
        }else if loadFilter == .region{
            for option in arrRegionOption {
                self.arrFilterOptions.append(FilterModel(name: option, isSelected: false))
            }
        }else if loadFilter == .category{
            for option in arrCategoriesOption {
                self.arrFilterOptions.append(FilterModel(name: option, isSelected: false))
            }
        }else if loadFilter == .properties{
            for option in arrPropertiesOption {
                self.arrFilterOptions.append(FilterModel(name: option, isSelected: false))
            }
        }else if loadFilter == .fdaCertified{
            for option in arrFdaCertifiedOption {
                self.arrFilterOptions.append(FilterModel(name: option, isSelected: false))
            }
        }else if loadFilter == .myFav{
            for option in arrMyFavOption {
                self.arrFilterOptions.append(FilterModel(name: option, isSelected: false))
            }
        }
        for option in arrDistance{
            self.arrDistanceOption.append(FilterModel(name: option, isSelected: false))
        }
        for option in arrRating{
            self.arrRatingOptions.append(FilterModel(name: option, isSelected: false))
        }
        for option in arrFdaCertified{
            self.arrOptionFdaCert.append(FilterModel(name: option, isSelected: false))
        }
        for option in arrSortProducer{
            self.arrOptionSortProducers.append(FilterModel(name: option, isSelected: false))
        }
        if loadFilter == .producerStore {
            checkApi = .categories
            identifyList = 4
            callOptionApi(1)
            self.selectedOptionsId = self.arrSelectedCategories
        }else if loadFilter == .conservationFood{
            checkApi = .categories
            identifyList = 4
            callOptionApi(1)
            self.selectedOptionsId = self.arrSelectedCategories
        }else if loadFilter == .region{
            checkApi = .producers
            self.selectedOptionsId = self.selectedSortProducer
        }else if loadFilter == .category {
            checkApi = .method
            identifyList = 2
            callOptionApi(1)
            self.selectedOptionsId = self.selectedOptionsMethod
        }else if loadFilter == .properties {
            checkApi = .method
            identifyList = 2
            callOptionApi(1)
            
            self.selectedOptionsId = self.selectedOptionsMethod
        }else if loadFilter == .fdaCertified {
            checkApi = .producers
            self.selectedOptionsId = self.selectedSortProducer
        }else if loadFilter == .myFav{
            checkApi = .producers
            self.selectedOptionsId = self.selectedSortProducer
        }
       // callOptionApi(indexOfPageToRequest)
    }
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clearFilters(_ sender: UIButton){
        clearFilterApi?(loadFilter)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnApplyFilter(_ sender: UIButton){
    
        callApiCallBack?(arrSelectedCategories,arrSelectedProperties,arrSelectedItalianRegion,arrSelectedDistance,arrSelectedRating,selectFdaCertified,selectedSortProducer,selectedOptionsMethod,arrSelectedPropertiesName,arrSelectedMethodName)
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension ProducerStoreFilterVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == optionTableView {
            return arrFilterOptions.count
        }else{
            
            if checkApi == .distance {
                return arrDistanceOption.count
            }else if checkApi == .rating {
                return  arrRatingOptions.count
            }else if checkApi == .producers {
                return arrSortProducer.count
            }else if checkApi == .fdaCertified {
                return arrFdaCertified.count
            }else{
                return arrList?.count ?? 0
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == optionTableView{
            guard let cell = optionTableView.dequeueReusableCell(withIdentifier: "FilterOptionTableVCell", for: indexPath) as? FilterOptionTableVCell else {return UITableViewCell()}
            //cell.selectionStyle = .none
            if self.loadingFirstTime == true{
                arrFilterOptions[0].isSelected = true
            }
            
            cell.configCell(self.selectedIndex, arrFilterOptions[indexPath.row])
            return cell
        }else{
            guard let cell = subOptionTableView.dequeueReusableCell(withIdentifier: "FilterSubOptionsTableVCell", for: indexPath) as? FilterSubOptionsTableVCell else {return UITableViewCell()}
            cell.selectionStyle = .none
            
            if checkApi == .distance {
                let data = arrDistanceOption[indexPath.row]
                cell.labelSubOptions.text = data.name
                cell.selectedCategory = self.selectedOptionsId
                self.arrSelectedDistance = self.selectedOptionsId
                cell.configStringNameCell(arrDistanceOption[indexPath.row], indexPath.row, .distance)
            }else if checkApi == .rating {
                cell.labelSubOptions.text = arrRatingOptions[indexPath.row].name
                cell.selectedCategory = self.selectedOptionsId
                self.arrSelectedRating = self.selectedOptionsId
                cell.configStringNameCell(arrRatingOptions[indexPath.row], indexPath.row, .rating)
            }else if checkApi == .fdaCertified {
                cell.labelSubOptions.text = arrFdaCertified[indexPath.row]
                cell.selectedCategory = self.selectedOptionsId
                self.selectFdaCertified = self.selectedOptionsId
                cell.configStringNameCell(arrOptionFdaCert[indexPath.row], indexPath.row, .fdaCertified)
            }else if checkApi == .producers {
                cell.labelSubOptions.text = arrSortProducer[indexPath.row]
                cell.selectedCategory = self.selectedOptionsId
                self.selectedSortProducer = self.selectedOptionsId
                cell.configStringNameCell(arrOptionSortProducers[indexPath.row], indexPath.row, .producers)
            }else{
                if checkApi == .categories {
                    self.arrSelectedCategories = self.selectedOptionsId
                }else if checkApi == .properties{
                    self.arrSelectedProperties = self.selectedOptionsId
                    self.arrSelectedPropertiesName = self.arrSelectedName
                }else if checkApi == .region{
                    self.arrSelectedItalianRegion = self.selectedOptionsId
                }else if checkApi == .method{
                    self.selectedOptionsMethod = self.selectedOptionsId
                    self.arrSelectedMethodName = self.arrSelectedName
                }
                cell.selectedCategory = self.selectedOptionsId
                cell.configProductSearch(arrList?[indexPath.row] ?? MyStoreProductDetail(with: [:]), checkApi, indexPath: indexPath.row)
                
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == optionTableView {
            return 50
        }else{
            return 50
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == optionTableView{
            self.loadingFirstTime = false
            _ = self.arrFilterOptions.map{$0.isSelected = false}
            self.arrFilterOptions[indexPath.row].isSelected = true
            self.optionTableView.reloadData()
            selectedIndex = indexPath.row
            if arrFilterOptions[indexPath.row].name == checkHitApi.categories.rawValue ||  arrFilterOptions[indexPath.row].name == checkItalianHitApi.categories.rawValue{
                checkApi = .categories
                //self.selectedOptionsId = []
                self.selectedOptionsId = self.arrSelectedCategories
                identifyList = 4
                callOptionApi(1)
            }else if arrFilterOptions[indexPath.row].name == checkHitApi.properties.rawValue || arrFilterOptions[indexPath.row].name == checkItalianHitApi.properties.rawValue{
                checkApi = .properties
              //  self.selectedOptionsId = []
                self.selectedOptionsId = self.arrSelectedProperties
                self.arrSelectedName = self.arrSelectedPropertiesName
                
                identifyList = 5
                callOptionApi(1)
            }else if arrFilterOptions[indexPath.row].name == checkHitApi.region.rawValue || arrFilterOptions[indexPath.row].name == checkItalianHitApi.region.rawValue{
                checkApi = .region
              //  self.selectedOptionsId = []
                self.selectedOptionsId = self.arrSelectedItalianRegion
                identifyList = 3
                callOptionApi(1)
            }else if arrFilterOptions[indexPath.row].name == checkHitApi.method.rawValue || arrFilterOptions[indexPath.row].name == checkItalianHitApi.method.rawValue{
                checkApi = .method
               // self.selectedOptionsId = []
                self.selectedOptionsId = self.selectedOptionsMethod
                self.arrSelectedName = self.arrSelectedMethodName
                identifyList = 2
                callOptionApi(1)
            }else if  arrFilterOptions[indexPath.row].name == checkHitApi.distance.rawValue || arrFilterOptions[indexPath.row].name == checkItalianHitApi.distance.rawValue{
                checkApi = .distance
               // self.selectedOptionsId = []
                self.selectedOptionsId = self.arrSelectedDistance
            }
            else if arrFilterOptions[indexPath.row].name == checkHitApi.rating.rawValue || arrFilterOptions[indexPath.row].name == checkItalianHitApi.rating.rawValue {
                //self.arrSelectedRating = []
                checkApi = .rating
               // self.selectedOptionsId = []
                self.selectedOptionsId = self.arrSelectedRating
            }else if arrFilterOptions[indexPath.row].name == checkHitApi.producers.rawValue || arrFilterOptions[indexPath.row].name == checkHitApi.productName.rawValue || arrFilterOptions[indexPath.row].name == checkItalianHitApi.producers.rawValue || arrFilterOptions[indexPath.row].name == checkItalianHitApi.productName.rawValue {
                checkApi = .producers
                //self.selectedOptionsId = []
                self.selectedOptionsId = self.selectedSortProducer
            }else if arrFilterOptions[indexPath.row].name == checkHitApi.fdaCertified.rawValue || arrFilterOptions[indexPath.row].name == checkItalianHitApi.fdaCertified.rawValue{
                checkApi = .fdaCertified
               // self.selectedOptionsId = []
                self.selectedOptionsId = self.selectFdaCertified
            }else{
                self.subOptionTableView.reloadData()
            }
            self.subOptionTableView.reloadData()
        }else{
            
            if checkApi == .categories ||  checkApi == .properties ||  checkApi == .region || checkApi == .method{
                if checkApi == .categories{
                    selectedId = arrList?[indexPath.row].marketplace_product_category_id
                }else if checkApi == .properties || checkApi == .method{
                    selectedId = arrList?[indexPath.row].userFieldOptionid
                }else if  checkApi == .region{
                    selectedId = arrList?[indexPath.row].id
                }
                if checkApi == .fdaCertified || checkApi == .method || checkApi == .properties{
                selectName = arrList?[indexPath.row].option
                }else{
                    selectName = arrList?[indexPath.row].name
                }
                if self.selectedOptionsId.contains(selectedId ?? -1){
                    if let itemToRemoveIndex = selectedOptionsId.firstIndex(of: selectedId ?? -1) {
                        self.selectedOptionsId.remove(at: itemToRemoveIndex)
                        if checkApi == .categories {
                            print("No remove")
                        }else{
                        self.arrSelectedName.remove(at: itemToRemoveIndex)
                        }
                    }
                }else{
                    self.selectedOptionsId.append(selectedId ?? -1)
                    if checkApi == .categories {
                        print("No add")
                    }else{
                    self.arrSelectedName.append(selectName ?? "")
                    }
                }
            }else  if checkApi == .distance {
                let selectedIndex = indexPath.row
                if self.selectedOptionsId.contains(selectedIndex){
                    if let itemToRemoveIndex = selectedOptionsId.firstIndex(of: selectedIndex ) {
                        self.selectedOptionsId.remove(at: itemToRemoveIndex)
                    }
                }else{
                    self.selectedOptionsId.append(selectedIndex )
                }
            }else if checkApi == .rating{
                let data = arrRatingOptions[indexPath.row]
                for i in 0..<arrRating.count{
                    arrRatingOptions[i].isSelected = false
                }
                data.isSelected = !(data.isSelected ?? false)
                
                self.selectedOptionsId = []
                self.selectedOptionsId.append(indexPath.row)
                
            }else if checkApi == .fdaCertified{
                let data = arrOptionFdaCert[indexPath.row]
                for i in 0..<arrOptionFdaCert.count{
                    arrOptionFdaCert[i].isSelected = false
                }
                data.isSelected = !(data.isSelected ?? false)
                
                self.selectedOptionsId = []
                self.selectedOptionsId.append(indexPath.row)
            }else if checkApi == .producers{
                let data = arrOptionSortProducers[indexPath.row]
                for i in 0..<arrOptionSortProducers.count{
                    arrOptionSortProducers[i].isSelected = false
                }
                data.isSelected = !(data.isSelected ?? false)
                
                self.selectedOptionsId = []
                self.selectedOptionsId.append(indexPath.row)
            }
            print("selectedOptionsId",selectedOptionsId)
            
            self.subOptionTableView.reloadData()
        }
    }
    
}

extension ProducerStoreFilterVC{
    func callOptionApi(_ pageNo: Int){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kMarketPlaceProduct + "\(identifyList ?? 0)" , requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictResponse, error, errortype, statusCode in
            switch statusCode{
            case 200:
                if let response = dictResponse as? [String:Any]{
                    
                    if let data = response["data"] as? [[String:Any]]{
                        self.arrList = data.map({MyStoreProductDetail.init(with: $0)})
                    }
                    self.subOptionTableView.reloadData()
                }
            default:
                print("No Data")
            }
            
        }
    }
}


