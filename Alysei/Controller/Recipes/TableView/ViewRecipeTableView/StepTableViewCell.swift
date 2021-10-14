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
    var delegate: StepDelegate?
    var tapViewStep:(()->())?
    var arrStep = String()
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        // Initialization code
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
            
        }
        else{
            cell.stepButton.layer.borderColor = UIColor.clear.cgColor
        }
        
        
        return cell
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (self.collectionView.frame.size.width/7), height: 35)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        stepTableViewCellCurrentIndex = indexPath.item
        collectionView.reloadData()
//        if currentIndex == indexPath.item{
//            if delegate != nil {
                delegate?.cellStepTapped(index: indexPath.item)
//                }
//            tapViewStep!()
//        }
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StepsViewController") as! StepsViewController
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
