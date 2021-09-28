//
//  StepTableViewCell.swift
//  New Recipe module
//
//  Created by mac on 20/08/21.
//

import UIKit

class StepTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var stepView: UIView!
    
    
    var numberArray = ["1","2","3","4","5","6","7","8","9","10","11","12","13"]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
extension StepTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:StepCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "StepCollectionViewCell", for: indexPath) as! StepCollectionViewCell
        cell.stepButton.setTitle((numberArray[indexPath.row]), for: .normal)
        print("\(numberArray[indexPath.row])")
        return cell
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (self.collectionView.frame.size.width/7), height: 35)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        stepLabel.text = numberArray[indexPath.row]
        
    }
    
    
    
}
