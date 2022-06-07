//
//  ContactTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 23/01/21.
//

import UIKit

class ContactTableCell: UITableViewCell {

    @IBOutlet var iconView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
  }

    func updateDisplay(_ viewModel: ContactDetail.view.tableCellModel!) {
        self.iconView.image = UIImage(named: viewModel.imageName)
        self.titleLabel.text = "\(viewModel.title)"
        self.detailLabel.text = "\(viewModel.value)"
        if  viewModel.value == nil || viewModel.value == "null"{
            self.detailLabel.isHidden = true
            self.titleLabel.isHidden = true
            self.iconView.isHidden = true
        }else{
            self.detailLabel.isHidden = false
            self.titleLabel.isHidden = false
            self.iconView.isHidden = false
        }
        if titleLabel.text == MarketPlaceConstant.kCWebsite || titleLabel.text == AppConstants.Facebook{
            self.detailLabel.textColor = UIColor.link
            
        }else{
            self.detailLabel.textColor = UIColor.black
        }
    }
}
