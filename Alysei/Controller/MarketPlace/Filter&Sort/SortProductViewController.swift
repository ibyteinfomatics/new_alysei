//
//  SortProductViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/4/21.
//

import UIKit

class SortProductViewController: UIViewController {
    
    @IBOutlet weak var viewPopularity: UIView!
    @IBOutlet weak var viewRatings: UIView!
    @IBOutlet weak var viewPriceLowToHigh: UIView!
    @IBOutlet weak var viewPriceHighToLow: UIView!
    @IBOutlet weak var viewNewestFirst: UIView!
    @IBOutlet weak var imgPopularity: UIImageView!
    @IBOutlet weak var imgRatings: UIImageView!
    @IBOutlet weak var imgPriceLowToHigh: UIImageView!
    @IBOutlet weak var imgPriceHighToLow: UIImageView!
    @IBOutlet weak var imgNewestFirst: UIImageView!
    
    var arrSortProductList: [ProductSearchListModel]?
    var callBackPassData: (([ProductSearchListModel]) -> Void)? = nil
    var selectProductName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let popularityTap = UITapGestureRecognizer(target: self, action: #selector(showPopularData(_ :)))
        self.viewPopularity.addGestureRecognizer(popularityTap)
        
        let ratingTap = UITapGestureRecognizer(target: self, action: #selector(showRatingData(_ :)))
        self.viewRatings.addGestureRecognizer(ratingTap)
        
        let priceLowToHighTap = UITapGestureRecognizer(target: self, action: #selector(showpriceLowToHighData(_ :)))
        self.viewPriceLowToHigh.addGestureRecognizer(priceLowToHighTap)
        
        let priceHighToLowTap = UITapGestureRecognizer(target: self, action: #selector(showPriceHighToLowData(_ :)))
        self.viewPriceHighToLow.addGestureRecognizer(priceHighToLowTap)
        
        let newestTap = UITapGestureRecognizer(target: self, action: #selector(showNewestFirstData(_ :)))
        self.viewNewestFirst.addGestureRecognizer(newestTap)
    }
    
    @objc func showPopularData(_ tap: UITapGestureRecognizer){
        imgPopularity.image = UIImage(named: "SelectSort")
        callSearchApi("1")
    }
    @objc func showRatingData(_ tap: UITapGestureRecognizer){
        imgRatings.image = UIImage(named: "SelectSort")
        callSearchApi("2")
    }
    @objc func showpriceLowToHighData(_ tap: UITapGestureRecognizer){
        imgPriceLowToHigh.image = UIImage(named: "SelectSort")
        callSearchApi("3")
    }
    @objc func showPriceHighToLowData(_ tap: UITapGestureRecognizer){
        imgPriceHighToLow.image = UIImage(named: "SelectSort")
        callSearchApi("4")
    }
    @objc func showNewestFirstData(_ tap: UITapGestureRecognizer){
        imgNewestFirst.image = UIImage(named: "SelectSort")
        callSearchApi("5")
    }
}
extension SortProductViewController {
    func callSearchApi(_ text: String){
        let urlString = APIUrl.kProductListing + "\(selectProductName ?? "")" + "&available_for_sample=" + "" + "&sort_by=" + "\(text)" + "&category=" + "" + "&price_rfrom=" + "" + "&price_to="
        let urlString1 = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        TANetworkManager.sharedInstance.requestApi(withServiceName: urlString1, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let response = dictResponse as? [String:Any]
            if  let data = response?["data"] as? [[String:Any]]{
                self.arrSortProductList = data.map({ProductSearchListModel.init(with: $0)})
            }
            self.dismiss(animated: true) {
                self.callBackPassData?(self.arrSortProductList ?? [ProductSearchListModel]())
            }
            
        }
    }
}
