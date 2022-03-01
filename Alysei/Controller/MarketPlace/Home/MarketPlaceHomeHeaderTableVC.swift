//
//  MarketPlaceHomeHeaderTableVC.swift
//  Alysei
//
//  Created by Gitesh Dang on 1/6/22.
//

import UIKit

class MarketPlaceHomeHeaderTableVC: UITableViewCell {
    @IBOutlet weak var headerCollectionView: UICollectionView!
    
    var marketPlaceOptions = ["pStore", "cnsrvationMtd" , "ItlanRgn" ,"4", "prdctPrprties", "fda", "myFav", "mostPoplr", "promotion"]
    var arrMarketPlace = [MarketPlaceConstant.kProducerStore,MarketPlaceConstant.kConservationMethod,MarketPlaceConstant.kItalianRegion,MarketPlaceConstant.kCategories,MarketPlaceConstant.kProductProperties,MarketPlaceConstant.kFDACertified,MarketPlaceConstant.kMyFavourite,MarketPlaceConstant.kMostPospular,MarketPlaceConstant.kPromotions]
    
    var callback:((Int) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension MarketPlaceHomeHeaderTableVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = headerCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketPlaceHomeCollectionVCell", for: indexPath) as? MarketPlaceHomeCollectionVCell else {return UICollectionViewCell()}
        cell.imgView.image = UIImage(named: marketPlaceOptions[indexPath.row])
        
        let firstWord = arrMarketPlace[indexPath.row].components(separatedBy: " ")
        if firstWord.first == firstWord.last{
            cell.lblOption.text = (firstWord.first ?? "")
        }else{
            cell.lblOption.text = (firstWord.first ?? "") + "\n" + (firstWord.last ?? "")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3 , height: collectionView.frame.width / 3)
         
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callback?(indexPath.row)
    }
  
}
