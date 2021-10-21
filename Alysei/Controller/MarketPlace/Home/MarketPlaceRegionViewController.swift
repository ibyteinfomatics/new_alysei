//
//  MarketPlaceRegionViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/27/21.
//

import UIKit

class MarketPlaceRegionViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var arrRegion : [MyStoreProductDetail]?
    var listIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.addShadow()
        callRegionApi()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}

extension MarketPlaceRegionViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrRegion?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketPlaceRegionCViewCell", for: indexPath) as? MarketPlaceRegionCViewCell else {return UICollectionViewCell()}
        cell.lblRegionName.text = arrRegion?[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceProductListViewController") as? MarketPlaceProductListViewController else {return}
        nextVC.pushedFromVC = .region
        nextVC.listType = self.listIndex
        nextVC.keywordSearch = arrRegion?[indexPath.row].name
        nextVC.optionId = arrRegion?[indexPath.row].id
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
extension MarketPlaceRegionViewController{
    func callRegionApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kMarketPlaceRegion, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictResponse, error, errorType, statusCode in
            let response = dictResponse as? [String:Any]
            if let data = response?["data"] as? [[String:Any]]{
                self.arrRegion = data.map({MyStoreProductDetail.init(with: $0)})
            }
            self.collectionView.reloadData()
        }
        
    }
}
class MarketPlaceRegionCViewCell: UICollectionViewCell{
    
    @IBOutlet weak var imgRegion: UIImageView!
    @IBOutlet weak var vwRegion : UIView!
    @IBOutlet weak var lblRegionName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vwRegion.layer.cornerRadius = self.vwRegion.frame.height / 2
        vwRegion.layer.masksToBounds = true
        vwRegion.addShadow()
        vwRegion.layer.borderWidth = 0.5
        vwRegion.layer.borderColor = UIColor.black.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

    }
    
}
