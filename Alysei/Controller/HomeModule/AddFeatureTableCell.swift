//
//  AddFeatureTableCell.swift
//  Alysie
//
//  Created by Alendra Kumar on 18/01/21.
//

import UIKit

class AddFeatureTableCell: UITableViewCell {

    @IBOutlet weak var txtFieldAddFeature: UITextField!
    @IBOutlet weak var lblAddFeature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        txtFieldAddFeature.borderStyle = UITextField.BorderStyle.none
    }
    
    public func configure(_ indexPath: IndexPath){
      
        lblAddFeature.text = StaticArrAddFeature.kAddFeatureDict[indexPath.item].lbl
        txtFieldAddFeature.placeholder = StaticArrAddFeature.kAddFeatureDict[indexPath.item].placeholder
    }

}
