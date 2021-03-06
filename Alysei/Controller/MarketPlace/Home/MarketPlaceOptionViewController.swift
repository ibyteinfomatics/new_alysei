//
//  MarketPlaceOptionViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/27/21.
//

import UIKit

class MarketPlaceOptionViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblHead: UILabel!
    var listIndex: Int?
    var indexOfPageToRequest = 1
    var arrOptions: [MyStoreProductDetail]?
    var passHeading: String?
   // var listType: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblHead.text = passHeading
        headerView.drawBottomShadow()
        callOptionApi()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for i in 0..<(self.arrOptions?.count ?? 0) {
            self.arrOptions?[i].isOptionSelected = false
        }
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        // calculates where the user is in the y-axis
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        if offsetY > contentHeight - scrollView.frame.size.height - (self.view.frame.height * 2) {
//            if indexOfPageToRequest < arrOptions?.lastPage ?? 0{
//                self.showAlert(withMessage: "No More Data Found")
//            }else{
//            // increments the number of the page to request
//            indexOfPageToRequest += 1
//
//            // call your API for more data
//                callMyStoreProductApi(indexOfPageToRequest)
//
//            // tell the table view to reload with the new data
//            self.tableView.reloadData()
//            }
//        }
//    }
//}
}

extension MarketPlaceOptionViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOptions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketPlaceOptionTableViewCell", for: indexPath) as? MarketPlaceOptionTableViewCell else {return UITableViewCell()}
        if listIndex == 4{
        cell.lblOption?.text = arrOptions?[indexPath.row].name
        }else if listIndex == 6{
            cell.lblOption?.text = arrOptions?[indexPath.row].title
        }else{
            cell.lblOption?.text = arrOptions?[indexPath.row].option
        }
        if arrOptions?[indexPath.row].isOptionSelected == true{
            cell.btnSelect.image = UIImage(named: "SelectSort")
        }else{
                cell.btnSelect.image = UIImage(named: "UnselectSort")
            }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        for i in 0..<(arrOptions?.count ?? 0){
            self.arrOptions?[i].isOptionSelected = false
        }
        arrOptions?[indexPath.row].isOptionSelected = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceProductListViewController") as? MarketPlaceProductListViewController else {return}
            nextVC.listType = self.listIndex


            if self.listIndex == 4{
                nextVC.pushedFromVC = .category
                nextVC.keywordSearch = self.arrOptions?[indexPath.row].name
                nextVC.optionId = self.arrOptions?[indexPath.row].marketplace_product_category_id
            }else if self.listIndex == 5 {
                nextVC.pushedFromVC = .properties
                nextVC.keywordSearch = self.arrOptions?[indexPath.row].option
            }else{
                nextVC.pushedFromVC = .conservation
                nextVC.keywordSearch = self.arrOptions?[indexPath.row].option
            }

            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
        self.tableView.reloadData()
        
    }
}

extension MarketPlaceOptionViewController{
    func callOptionApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kMarketPlaceProduct + "\(listIndex ?? 0)" , requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictResponse, error, errortype, statusCode in
            switch statusCode{
            case 200:
            if let response = dictResponse as? [String:Any]{
                if let data = response["data"] as? [[String:Any]]{
                    self.arrOptions = data.map({MyStoreProductDetail.init(with: $0)})
                }
            }
            default:
                print("No Data")
            }
            
            for i in 0..<(self.arrOptions?.count ?? 0) {
                self.arrOptions?[i].isSelected = false
            }
            self.tableView.reloadData()
        }
    }
}
class MarketPlaceOptionTableViewCell: UITableViewCell{
    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblOption: UILabel!
    @IBOutlet weak var btnSelect: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        vwContainer.addShadow()
    }
    
}
