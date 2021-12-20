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
    var dataDropDown = DropDown()
    
    var analyticsArr = ["Total Product","Total Enquiry","Total Categories","Total Review"]
   // var analyticsValue = ["112","42","12","100"]
    var analyticsColor = ["#2594FF","#4AAE4E","#FF9025","#FF3B25"]
    var arrData = ["Yearly","Monthly","Weekly","Yesterday","Today"]
    var totalProduct: Int?
    var totalCategory: Int?
    var totalEnquiry: Int?
    var totalReview: Int?
    var logobaseUrl: String?
    var bannerbaseUrl:String?
    var callApi:(() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnReport.setTitle("Yearly", for: .normal)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnOpenDropDown(_ sender: UIButton){
        openDropDown()
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
