//
//  HubCitiesListTableViewCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 7/15/21.
//

import UIKit

class HubCitiesListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var btnSelected: UIButton!
    @IBOutlet weak var viewContainer: UIView!
    var city:CountryHubs?{didSet{self.awakeFromNib()}}
    var selectedHubs:((CountryHubs?)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblCountryName.text = city?.name
        self.btnSelected.isSelected = city?.isSelected ?? false
        
        if btnSelected.isSelected == true{
            self.viewContainer.layer.backgroundColor = UIColor.init(hexString: "#4BB3FD").cgColor
        }else{
            self.viewContainer.layer.backgroundColor = UIColor.white.cgColor
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func selectedCity(_ sender: UIButton) {
//        self.city?.isSelected = !(self.city?.isSelected ?? false)
//        self.awakeFromNib()
        self.selectedHubs?(self.city)
    }
    
}
