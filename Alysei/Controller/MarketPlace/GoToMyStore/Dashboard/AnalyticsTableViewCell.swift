//
//  AnalyticsTableViewCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/24/21.
//

import UIKit
import DropDown

class AnalyticsTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnReport: UIButton!
    var dataDropDown = DropDown()
    
    var analyticsArr = ["Total Product","Total Product","Total Categories","Total Review"]
    var analyticsValue = ["112","42","12","100"]
    var analyticsColor = ["#2594FF","#4AAE4E","#FF9025","#FF3B25"]
    var arrData = ["Yearly","Monthly","Weekly","Yesterday","Today"]
    var totalProduct: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
           
        }
        dataDropDown.cellHeight = 40
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
    func configeCell(_ totalProduct: String){
        self.totalProduct = totalProduct
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
        cell.lblValue.text = analyticsValue[indexPath.row]
        cell.configCell(self.totalProduct ?? "")
        let color = UIColor.init(hexString: analyticsColor[indexPath.row]).cgColor
        cell.containeView.layer.backgroundColor = color
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 185 )
    }
    
}
