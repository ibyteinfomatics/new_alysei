//
//  ActiveCountriesCollectionViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 24/03/21.
//

import UIKit

class ActiveCountriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgFlag: ImageLoader!
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var imgContainer: UIView!
    // @IBOutlet weak var checkMarkView: Checkmark!
    @IBOutlet weak var btnCheckBox: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      //  imgFlag.layer.cornerRadius = self.imgFlag.frame.height / 2
        imgFlag.applyshadowWithCorner(containerView: imgContainer, cornerRadious:  self.imgFlag.frame.height / 2)
    }
    
    func configCell(_ data: CountryModel){
        lblCountryName.text = data.name
        if let strUrl = "\(kImageBaseUrl)\(data.flagId?.attachmentUrl ?? "")".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
           let imgUrl = URL(string: strUrl) {
            print("\("FlagImageUrl---------------------------\(imgUrl)")")
            imgFlag.loadImageWithUrl(imgUrl) // call this line for getting image to yourImageView
        }
        self.btnCheckBox.setImage((data.isSelected == true) ? UIImage(named: "icon_blueSelected") : UIImage(named: "icon_uncheckedBox"), for: .normal)
    }
}

extension UIImageView {
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 1
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
}


