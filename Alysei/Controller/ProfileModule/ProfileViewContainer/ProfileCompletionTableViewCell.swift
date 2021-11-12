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
    var animationCallback:((_ index: Int?, _ cell: ProfileCompletionTableViewCell) -> Void)? = nil
    //MARK: - Properties -
  
    var delegate: AnimationProfileCallBack?
  
    override func awakeFromNib() {
      super.awakeFromNib()
    }
  
    //MARK: - Public Methods -
    
    public func configure(_ indexPath: IndexPath,currentIndex:Int){
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {


          print(indexPath.row)
          print(currentIndex)
           // self.animationCallback?(currentIndex,self)
            self.animationCallback?(indexPath.row,self)
         // self.delegate?.animateViews(currentIndex, cell: self)
        //   }
      }
    
  }

}
