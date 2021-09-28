//
//  BusinessSearchTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 27/01/21.
//

import UIKit

class BusinessSearchTableCell: UITableViewCell {

    var searchTappedCallback:(() -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func btnSearchAction(_ sender: UIButton){
        searchTappedCallback?()
    }

}

