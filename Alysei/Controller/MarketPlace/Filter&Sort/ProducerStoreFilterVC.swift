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
}

class ProducerStoreFilterVC: UIViewController {
    
    @IBOutlet weak var optionTableView: UITableView!
    @IBOutlet weak var subOptionTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    var selectedIndex = 0
    var arrOption = ["Categories","Properties","Italian Region","Distance","Ratings"]
    var arrConservationOption = ["Categories","Properties","Italian Region","FDA Certfied"]
    var arrDistance = ["Within 5 Miles","Within 10 Miles","Within 20 Miles","Within 40 Miles","Within 100 Miles"]
    var arrRating = ["Most rated stores","5 star stores", "Most searched"]
    var arrFdaCertified = ["Yes","No"]
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
        }else{
            for option in arrConservationOption {
                self.arrFilterOptions.append(FilterModel(name: option, isSelected: false))
            }
        }
        for option in arrDistance{
            self.arrDistanceOption.append(FilterModel(name: option, isSelected: false))
        }
        for option in arrRating{
            self.arrRatingOptions.append(FilterModel(name: option, isSelected: false))
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
            if selectedIndex == 3{
              return  arrDistanceOption.count
            }else if selectedIndex == 4{
                return arrRatingOptions.count
            }
            return arrList?.count ?? 0
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
            if selectedIndex == 3 {
                cell.labelSubOptions.text = arrDistanceOption[indexPath.row].name
            }else if selectedIndex == 4 && loadFilter == .producerStore{
                cell.labelSubOptions.text = arrRatingOptions[indexPath.row].name
            }else if selectedIndex == 4 && loadFilter == .conservationFood{
                cell.labelSubOptions.text = arrFdaCertified[indexPath.row]
            }else{
                cell.configProductSearch(arrList?[indexPath.row] ?? MyStoreProductDetail(with: [:]), identifyList)
               
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
            switch indexPath.row {
            case 0:
                
                identifyList = 4
                callOptionApi(1)
            case 1:
                identifyList = 5
                callOptionApi(1)
            case 2:
                identifyList = 3
                callOptionApi(1)
            case 3, 4:
                self.subOptionTableView.reloadData()
            default:
                print("Invalid")
                
            }
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


