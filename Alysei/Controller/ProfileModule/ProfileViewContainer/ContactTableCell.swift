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
    }
}
