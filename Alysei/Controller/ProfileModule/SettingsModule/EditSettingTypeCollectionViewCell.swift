//
//  EditSettingTypeCollectionViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 07/04/21.
//

import UIKit

class EditSettingTypeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imgViewSettings: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContainer.layer.cornerRadius = 10

    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()

        let shadowPath = UIBezierPath(rect: bounds)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 0.5
        layer.shadowPath = shadowPath.cgPath
    }
    public func configure(_ indexPath: IndexPath){
       
    if kSharedUserDefaults.loggedInUserModal.memberRoleId == "10"{
            imgViewSettings.image = UIImage.init(named: StaticArrayData.kEditSettingVoyColScreenDict[indexPath.item].image)
            textLabel.text = StaticArrayData.kEditSettingVoyColScreenDict[indexPath.item].name
    }else{
        imgViewSettings.image = UIImage.init(named: StaticArrayData.kEditSettingUserColScreenDict[indexPath.item].image)
        textLabel.text = StaticArrayData.kEditSettingUserColScreenDict[indexPath.item].name
    }
}
}

