//
//  AnalyticsTableViewCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/24/21.
//

import UIKit
import DropDown

var selectSort: Int?

class AnalyticsTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnReport: UIButton!
    @IBOutlet weak var lblAnalytics: UILabel!
    @IBOutlet weak var btnDownload: UIButton!
    var dataDropDown = DropDown()
    
    var analyticsArr = [MarketPlaceConstant.kTotalProduct,MarketPlaceConstant.kTotalEnquiry,MarketPlaceConstant.kTotalCategories,MarketPlaceConstant.kTotalReviews]
   // var analyticsValue = ["112","42","12","100"]
    var analyticsColor = ["#2594FF","#4AAE4E","#FF9025","#FF3B25"]
    var arrData = [MarketPlaceConstant.kYearly,MarketPlaceConstant.kMonthly,MarketPlaceConstant.kWeekly,MarketPlaceConstant.kYesterday,MarketPlaceConstant.kToday]
    var totalProduct: Int?
    var totalCategory: Int?
    var totalEnquiry: Int?
    var totalReview: Int?
    var logobaseUrl: String?
    var bannerbaseUrl:String?
    var callApi:(() -> Void)? = nil
    var callPop: (() -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        lblAnalytics.text = MarketPlaceConstant.kAnalytics
        btnReport.setTitle(MarketPlaceConstant.kYearly, for: .normal)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnOpenDropDown(_ sender: UIButton){
        openDropDown()
    }
    @IBAction func btnDownload(_ sender: Any){
    
        
        let userId = kSharedUserDefaults.loggedInUserModal.userId
        let wUrl = "https://api.alysei.com/download/marketplace/analyst/1/" + "\(userId ?? "0")"
        guard let url = URL(string: wUrl) else {
          return //be safe
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(url){_ in
                self.callPop?()
            }
    }
    }
    @objc func openDropDown(){
        dataDropDown.dataSource = self.arrData
        dataDropDown.show()
        dataDropDown.anchorView = self.btnReport
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btnReport.setTitle(item, for: .normal)
            selectSort = index + 1
            self.callApi?()
        }
        dataDropDown.cellHeight = 40
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
    func configeCell(_ totalProduct: Int, _ totalCategory: Int, _ totalEnquiry: Int, _ totalReview: Int, _ logobaseUrl: String, _ bannerbaseUrl: String){
        self.totalProduct = totalProduct
        self.totalCategory = totalCategory
        self.totalEnquiry = totalEnquiry
        self.totalReview = totalReview
        self.logobaseUrl = logobaseUrl
        self.bannerbaseUrl = bannerbaseUrl
        self.collectionView.reloadData()
    }

}

extension AnalyticsTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return analyticsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnalyticsCollectionViewCell", for: indexPath) as? AnalyticsCollectionViewCell else {return UICollectionViewCell()}
        cell.lblTitle.text = analyticsArr[indexPath.row]
       // cell.lblValue.text = analyticsValue[indexPath.row]
        cell.configCell(self.totalProduct ?? 0, self.totalCategory ?? 0, self.totalEnquiry ?? 0, self.totalReview ?? 0, index: indexPath.row)
        let color = UIColor.init(hexString: analyticsColor[indexPath.row]).cgColor
        cell.containeView.layer.backgroundColor = color
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 185 )
    }
    
}
