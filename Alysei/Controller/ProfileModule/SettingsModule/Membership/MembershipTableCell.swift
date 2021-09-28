//
//  MembershipTableCell.swift
//  ScreenBuild
//
//  Created by Alendra Kumar on 20/01/21.
//

import UIKit

protocol AnimationCallBack {
  
  func animateViews(_ indexPath: Int,cell: MembershipTableCell)
}

class MembershipTableCell: UITableViewCell {

    //MARK: - IBOutlet -
    
    @IBOutlet weak var imgViewCircle: UIImageView!
    @IBOutlet weak var lbleTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var viewLine: UIView!
  
    //MARK: - Properties -
  
    var delegate: AnimationCallBack?
  
    override func awakeFromNib() {
      super.awakeFromNib()
    }
  
    //MARK: - Public Methods -
    
    public func configure(_ indexPath: IndexPath,currentIndex:Int){
      
      lbleTitle.text = StaticArrayData.kMembershipData[indexPath.row].name
      lblDescription.text = StaticArrayData.kMembershipData[indexPath.row].status
      self.viewLine.isHidden = (indexPath.row == 3) ? true : false
    
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {

        if indexPath.row == currentIndex{

          print(indexPath.row)
          print(currentIndex)
          self.delegate?.animateViews(currentIndex, cell: self)
        }
      }
    
  }
    
}


