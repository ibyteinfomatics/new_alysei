//
//  HubStateListTableViewCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 7/15/21.
//

import UIKit

class HubStateListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblStateName: UILabel!
    @IBOutlet weak var btnCheckBox: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(_ data: CountryHubs){
        lblStateName.text = data.name
    }

}
