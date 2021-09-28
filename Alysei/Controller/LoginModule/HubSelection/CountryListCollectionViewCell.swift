//
//  CountryListCollectionViewCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 7/15/21.
//

import UIKit

class CountryListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblCountryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgFlag.layer.cornerRadius = 32.5
    }
    
    func configCell(_ data: CountryModel){
        lblCountryName.text = data.name

        self.imgFlag.setImage(withString: kImageBaseUrl + String.getString(data.flagId?.attachmentUrl))
    }
}
