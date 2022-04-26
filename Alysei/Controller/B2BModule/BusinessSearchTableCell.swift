//
//  BusinessSearchTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 27/01/21.
//

import UIKit

class BusinessSearchTableCell: UITableViewCell {

    var searchTappedCallback:(() -> Void)? = nil
    
    @IBOutlet weak var btnSearch: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        btnSearch.setTitle(MarketPlaceConstant.kSearch, for: .normal)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func btnSearchAction(_ sender: UIButton){
        searchTappedCallback?()
    }

}

