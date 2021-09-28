//
//  MarketPlaceRegionViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/27/21.
//

import UIKit

class MarketPlaceRegionViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.addShadow()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}

extension MarketPlaceRegionViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketPlaceRegionCViewCell", for: indexPath) as? MarketPlaceRegionCViewCell else {return UICollectionViewCell()}
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceProductListViewController") as? MarketPlaceProductListViewController else {return}
    
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

class MarketPlaceRegionCViewCell: UICollectionViewCell{
    
    @IBOutlet weak var imgRegion: UIImageView!
    @IBOutlet weak var vwRegion : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vwRegion.layer.cornerRadius = 35
        vwRegion.layer.masksToBounds = true
        vwRegion.addBorder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

    }
    
}
