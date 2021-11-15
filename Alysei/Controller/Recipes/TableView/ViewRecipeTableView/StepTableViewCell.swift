//
//  StepTableViewCell.swift
//  New Recipe module
//
//  Created by mac on 20/08/21.
//

import UIKit

protocol StepDelegate {
    func cellStepTapped(index:Int)
   }
var stepTableViewCellCurrentIndex : Int? = 0
class StepTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var stepView: UIView!
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    var delegate: StepDelegate?
    var tapViewStep:(()->())?
    var arrStep = String()
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView?.contentInsetAdjustmentBehavior = .always
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        var insets = self.collectionView.contentInset
//        let frameWidth = self.contentView.frame.size.width
//             let collectionViewWidth = (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width
//        var left1Insets = ((frameWidth) - (collectionViewWidth * (CGFloat(stepsModel?.count ?? 0)))) * 0.5
//
//               if left1Insets <= 0 {
//                  left1Insets = 0
//               }
//        insets.left = left1Insets
//        self.collectionView.contentInset =  insets
       
    }
    
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
extension StepTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        stepsModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:StepCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "StepCollectionViewCell", for: indexPath) as! StepCollectionViewCell
        
        cell.stepButton.setTitle("\(indexPath.item + 1)", for: .normal)
        if stepTableViewCellCurrentIndex == indexPath.item{
            cell.stepButton.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        else{
            cell.stepButton.layer.borderColor = UIColor.clear.cgColor
        }
        
        
        return cell
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (self.collectionView.frame.size.width/3), height: 35)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if (stepsModel?.count ?? 0) <= 3 {
        let totalCellWidth = 32 * (stepsModel?.count ?? 0)
        let totalSpacingWidth = 1 * ((stepsModel?.count ?? 0) - 1)

        let leftInset = (100 - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        stepTableViewCellCurrentIndex = indexPath.item
        collectionView.reloadData()
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                delegate?.cellStepTapped(index: indexPath.item)

    }
    
    
    
}
