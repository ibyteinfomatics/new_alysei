//
//  FeaturedTableViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 18/11/21.
//

import UIKit

class FeaturedTableViewCell: UITableViewCell {

    @IBOutlet weak var featuredCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self
        
        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "SearchByRegionCollectionViewCell", bundle: nil)
        self.featuredCollectionView.register(cellNib, forCellWithReuseIdentifier: "SearchByRegionCollectionViewCell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension FeaturedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchByRegionCollectionViewCell", for: indexPath) as? SearchByRegionCollectionViewCell {
            
////            let imgUrl = (kImageBaseUrl + (arraySearchByRegion?[indexPath.item].regionImage?.imgUrl ?? ""))
//            if let strUrl = "\(kImageBaseUrl + (arraySearchByRegion?[indexPath.item].regionImage?.imgUrl ?? ""))".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
//                  let imgUrl = URL(string: strUrl) {
//                 print("ImageUrl-----------------------------------------\(imgUrl)")
//                cell.countryImgVw.loadImageWithUrl(imgUrl) // call this line for getting image to yourImageView
//            }
////            cell.countryImgVw.setImage(withString: imgUrl)
//            cell.countryImgVw.layer.cornerRadius = cell.countryImgVw.frame.height/2
//            cell.countryImgVw.contentMode = .scaleAspectFit
//
//
//            cell.countryNameLbl.text = arraySearchByRegion?[indexPath.item].regionName ?? ""
            return cell
        }
        
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
//        if delegate != nil {
//            delegate?.cellTappedForSearchRecipe()
//
//            }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
        return CGSize(width: self.featuredCollectionView.frame.width/3 - 20, height: 150.0)
       }

}

