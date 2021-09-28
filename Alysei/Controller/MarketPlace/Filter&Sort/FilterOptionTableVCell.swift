//
//  FilterOptionTableVCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/5/21.
//

import UIKit

class FilterOptionTableVCell: UITableViewCell {
    @IBOutlet weak var labelOptionName: UILabel!
    @IBOutlet weak var vwBackground: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(_ filterSelectedIndex: Int?, _ data: FilterModel){
        labelOptionName.text = data.name
        if data.isSelected == true{
        vwBackground.layer.backgroundColor = UIColor.white.cgColor
        }else{
            vwBackground.layer.backgroundColor = UIColor.systemGray4.cgColor
        }
    }

}
