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
}
enum checkHitApi : String{
    case method = "Method"
    case categories = "Categories"
    case properties = "Properties"
    case fdaCertified = "FDA Certfied"
    case sortProducer
    case region = "Italian Region"
    case distance = "Distance"
    case rating = "Ratings"
    case producers = "Producers"
    
}

class ProducerStoreFilterVC: UIViewController {
    
    @IBOutlet weak var optionTableView: UITableView!
    @IBOutlet weak var subOptionTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    var selectedIndex = 0
    var arrOption = ["Categories","Properties","Italian Region","Distance","Ratings"]
    var arrConservationOption = ["Categories","Properties","Italian Region","FDA Certfied"]
    var arrRegionOption = ["Producers","Method","Categories","Properties","FDA Certfied"]
    var arrCategoriesOption = ["Method","Properties","FDA Certfied"]
    var arrPropertiesOption = ["Method","FDA Certfied","Categories"]
    var arrDistance = ["Within 5 Miles","Within 10 Miles","Within 20 Miles","Within 40 Miles","Within 100 Miles"]
    var arrRating = ["Most rated stores","5 star stores", "Most searched"]
    var arrFdaCertified = ["Yes","No"]
    var arrSortProducer = ["Sort by A to Z","Sort by Z to A"]
    var arrFilterOptions = [FilterModel]()
    var arrDistanceOption = [FilterModel]()
    var arrRatingOptions = [FilterModel]()
    var loadingFirstTime = true
    var arrList: [MyStoreProductDetail]?
    var lastPage: Int?
    var indexOfPageToRequest = 1
    var identifyList: Int?
    var loadDistance = false
    var loadFilter : loadFilter?
    var checkApi: checkHitApi?
  //  var loadRating =
    override func viewDidLoad() {
        super.viewDidLoad()
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
        }
        for option in arrDistance{
            self.arrDistanceOption.append(FilterModel(name: option, isSelected: false))
        }
        for option in arrRating{
            self.arrRatingOptions.append(FilterModel(name: option, isSelected: false))
        }
        if loadFilter == .region{
            checkApi = .producers
        }else if loadFilter == .category || loadFilter == .properties{
            checkApi = .method
            identifyList = 2
            callOptionApi(1)
        }
        callOptionApi(indexOfPageToRequest)
    }
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clearFilters(_ sender: UIButton){
        
    }
    @IBAction func btnApplyFilter(_ sender: UIButton){
        
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
//            if selectedIndex == 3 && loadFilter == .producerStore {
//                cell.labelSubOptions.text = arrDistanceOption[indexPath.row].name
//            }else if ((selectedIndex == 3) && (loadFilter == .conservationFood)){
//                cell.labelSubOptions.text = arrFdaCertified[indexPath.row]
//            }else if ((selectedIndex == 4) && (loadFilter == .producerStore)){
//                cell.labelSubOptions.text = arrRatingOptions[indexPath.row].name
//            }else if (selectedIndex == 0 && loadFilter == .region){
//                cell.labelSubOptions.text = arrSortProducer[indexPath.row]
//            }else{
//                cell.configProductSearch(arrList?[indexPath.row] ?? MyStoreProductDetail(with: [:]), identifyList)
//
//            }
            
            if checkApi == .distance {
                cell.labelSubOptions.text = arrDistanceOption[indexPath.row].name
            }else if checkApi == .rating {
                cell.labelSubOptions.text = arrRatingOptions[indexPath.row].name
            }else if checkApi == .fdaCertified {
                cell.labelSubOptions.text = arrFdaCertified[indexPath.row]
            }else if checkApi == .producers {
                cell.labelSubOptions.text = arrSortProducer[indexPath.row]
            }else{
                cell.configProductSearch(arrList?[indexPath.row] ?? MyStoreProductDetail(with: [:]), checkApi)
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
            if arrFilterOptions[indexPath.row].name == checkHitApi.categories.rawValue{
                checkApi = .categories
                identifyList = 4
                callOptionApi(1)
            }else if arrFilterOptions[indexPath.row].name == checkHitApi.properties.rawValue{
                checkApi = .properties
                identifyList = 5
                callOptionApi(1)
            }else if arrFilterOptions[indexPath.row].name == checkHitApi.region.rawValue{
                checkApi = .region
                identifyList = 3
                callOptionApi(1)
            }else if arrFilterOptions[indexPath.row].name == checkHitApi.method.rawValue{
                checkApi = .method
                identifyList = 2
                callOptionApi(1)
            }else if  arrFilterOptions[indexPath.row].name == checkHitApi.distance.rawValue{
                checkApi = .distance
            }
            else if arrFilterOptions[indexPath.row].name == checkHitApi.rating.rawValue {
                checkApi = .rating
            }else if arrFilterOptions[indexPath.row].name == checkHitApi.producers.rawValue {
                checkApi = .producers
            }else if arrFilterOptions[indexPath.row].name == checkHitApi.fdaCertified.rawValue{
                checkApi = .fdaCertified
//                identifyList = 2
//                callOptionApi(1)
            }else{
                self.subOptionTableView.reloadData()
            }
//            switch indexPath.row {
//            case 0:
//                identifyList = 4
//                callOptionApi(1)
//            case 1:
//                identifyList = 5
//                callOptionApi(1)
//            case 2:
//                identifyList = 3
//                callOptionApi(1)
//            case 3, 4:
//                self.subOptionTableView.reloadData()
//            default:
//                print("Invalid")
//
//            }
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


