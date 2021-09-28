//
//  ProfileCompletionTableViewCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 4/14/21.
//

import UIKit

protocol AnimationProfileCallBack {
  
  func animateViews(_ indexPath: Int,cell: ProfileCompletionTableViewCell)
}

class ProfileCompletionTableViewCell: UITableViewCell {
    //MARK: - IBOutlet -
    
    @IBOutlet weak var imgViewCircle: UIImageView!
   
    @IBOutlet weak var lbleTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var viewLine: UIView!
  
    //MARK: - Properties -
  
    var delegate: AnimationProfileCallBack?
  
    override func awakeFromNib() {
      super.awakeFromNib()
    }
  
    //MARK: - Public Methods -
    
    public func configure(_ indexPath: IndexPath,currentIndex:Int){
      
      //lbleTitle.text = StaticArrayData.ArrayProducerProfileCompletionDict[indexPath.row].name
      //lblDescription.text = StaticArrayData.kMemb9ershipData[indexPath.row].status
        //self.viewLine.isHidden = (indexPath.row == (StaticArrayData.ArrayProducerProfileCompletionDict.count - 1)) ? true : false
        //self.viewLine.isHidden = (indexPath.row == ()) ? true : false
    
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

        if indexPath.row == currentIndex{

          print(indexPath.row)
          print(currentIndex)
          self.delegate?.animateViews(currentIndex, cell: self)
        }
      }
    
  }

}
