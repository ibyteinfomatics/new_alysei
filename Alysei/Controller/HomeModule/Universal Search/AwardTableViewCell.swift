//
//  AwardTableViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 18/11/21.
//

import UIKit

class AwardTableViewCell: UITableViewCell {

    @IBOutlet weak var awardCollectionView: UICollectionView!
    
    @IBOutlet weak var noItemLabel: UILabel!
    var openUrlCallBack: ((String) -> Void)? = nil
    var apiCallback: (() -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        awardCollectionView.delegate = self
        awardCollectionView.dataSource = self
        
        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "AwardCollectionViewCell", bundle: nil)
        self.awardCollectionView.register(cellNib, forCellWithReuseIdentifier: "AwardCollectionViewCell")
       
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == awardCollectionView{
        if(self.awardCollectionView.contentOffset.y >= (self.awardCollectionView.contentSize.height - self.awardCollectionView.bounds.size.height)) {
            apiCallback?()
        }
        }
    }
    
}
extension AwardTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arraySearchByAward?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = self.awardCollectionView.dequeueReusableCell(withReuseIdentifier: "AwardCollectionViewCell", for: indexPath) as? AwardCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.competitionName.text = arraySearchByAward?[indexPath.item].awardName
        
        
        cell.winningproduct.text = "Winning Product: \(arraySearchByAward?[indexPath.item].winningProduct ?? "" )"
        
        /*if let attributedString = self.createAttributedString(stringArray: ["Winning Product: ", "\( awardModel?.data?[indexPath.item].winningProduct ?? "" )"], attributedPart: 1, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]) {
                   
            cell.winningproduct.attributedText = attributedString//awardModel?.data?[indexPath.item].winningProduct
                
        }*/
        
        if arraySearchByAward?[indexPath.item].medal?.name == "Silver"{
            cell.awardimg.image = UIImage(named: "silver")
            cell.rewardImageWidth.constant = 31
        } else if arraySearchByAward?[indexPath.item].medal?.name == "Gold"{
            cell.awardimg.image = UIImage(named: "gold")
            cell.rewardImageWidth.constant = 31
        } else if arraySearchByAward?[indexPath.item].medal?.name == "Bronze"{
            cell.awardimg.image = UIImage(named: "bronze")
            cell.rewardImageWidth.constant = 31
        }else if  arraySearchByAward?[indexPath.item].medal?.name == "Winner"{
            cell.awardimg.image = UIImage(named: "Winner")
            cell.rewardImageWidth.constant = 54
        }
        
        
        cell.rewardImage.layer.cornerRadius = 10

        cell.rewardImage.setImage(withString: String.getString((arraySearchByAward?[indexPath.item].attachment?.baseUrl)!) + ((arraySearchByAward?[indexPath.item].attachment?.attachmenturl)!), placeholder: UIImage(named: "image_placeholder"))

       // cell.rewardImage.setImage(withString: String.getString(kImageBaseUrl+(arraySearchByAward?[indexPath.item].attachment?.attachmenturl)! ), placeholder: UIImage(named: "image_placeholder"))
        
        //let baseUrl = arraySearchByAward?[indexPath.item].attachment?.baseUrl ?? ""
      //  cell.rewardImage.setImage(withString: String.getString(baseUrl+(arraySearchByAward?[indexPath.item].attachment?.attachmenturl)! ), placeholder: UIImage(named: "image_placeholder"))
        

        return cell

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = arraySearchByAward?[indexPath.item].competitionurl ?? ""
        print("Awardid----------------\(arraySearchByAward?[indexPath.item].competitionurl ?? "")")
        openUrlCallBack?(url)
        

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 290)
    }
    
    
}
