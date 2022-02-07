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
    @IBOutlet weak var btnArrow: UIImageView!
    var data: ProfileCompletionModel?
    var reloadtime: Int?
    
    var animationCallback:((_ index: Int?, _ cell: ProfileCompletionTableViewCell) -> Void)? = nil
    //MARK: - Properties -
  
    var delegate: AnimationProfileCallBack?
  
    override func awakeFromNib() {
      super.awakeFromNib()
    }
  
    //MARK: - Public Methods -
    
    public func configure(_ indexPath: IndexPath,currentIndex:Int){
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

           // self.animationCallback?(currentIndex,self)
           // self.animationCallback?(indexPath.row,self)
//          if indexPath.row == currentIndex {
//              self.animationCallback?(currentIndex,self)
//          }
//         print("Current Index------------\(currentIndex)")
//          print("indexPath.row ------------\(indexPath.row)")
         // if currentIndex == indexPath.row {
              self.delegate?.animateViews(indexPath.row, cell: self)
         // }
          
        //   }
      }
    
  }
    
    func configCell(_ data: ProfileCompletionModel, _ cell: ProfileCompletionTableViewCell, _ index: Int?){
        self.data = data
        
        if data.status == true{
            btnArrow.isHidden = true
            cell.isUserInteractionEnabled = false
        }else{
            btnArrow.isHidden = false
            cell.isUserInteractionEnabled = true
        }
        
    }

}
