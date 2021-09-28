//
//  CountrySelectionTableViewCell.swift
//  Alysie
//
//  Created by Gitesh Dang on 03/03/21.
//

import UIKit

class CountrySelectionTableViewCell: UITableViewCell {
    
    //MARK: IBOUtlets
    
    @IBOutlet weak var imageFlag:UIImageView!
    @IBOutlet weak var labelCountryName: UILabel!
    @IBOutlet weak var buttonCheckbox: UIButton!
    @IBOutlet weak var viewContainer: UIView!
    var callback: ((Int) -> Void)? = nil

    
    override func awakeFromNib() {
        super.awakeFromNib()
    // MARK: Initialization code
        self.initialSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: IBActions
    
//    @IBAction func btnSelectionAction(_ sender: UIButton){
//        if hubDataArray?.isSelectedProduct == true{
//        self.callback?(sender.tag)
//        }
//    }
    
    //MARK: Initial Functions
    func initialSetup(){
        viewContainer.layer.shadowColor = UIColor.lightGray.cgColor
        viewContainer.layer.shadowOpacity = 0.5
        viewContainer.layer.shadowOffset = .zero
        viewContainer.layer.shadowRadius = 1
    }
    

    //MARK: Config Cell
    func configCell(_ data: CountryModel){
        self.labelCountryName.text = data.name
        self.buttonCheckbox.setImage((data.isSelected == true) ? UIImage(named: "icon_blueSelected") : UIImage(named: "icon_uncheckedBox"), for: .normal)
        self.imageFlag.image = data.emoji?.emojiToImage()
    }
    
}
