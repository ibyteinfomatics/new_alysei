//
//  SettingsScreenCollectionVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 3/31/21.
//

import UIKit

class SettingsScreenCollectionVC: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imgViewSettings: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContainer.layer.cornerRadius = 10
       
        
    }
    
//    override func layoutSubviews()
//    {
//        super.layoutSubviews()
//
//        let shadowPath = UIBezierPath(rect: bounds)
//        layer.masksToBounds = false
//        layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
//        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//        layer.shadowOpacity = 0.5
//        layer.shadowPath = shadowPath.cgPath
//    }
    public func configure(_ indexPath: IndexPath){
//        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "3"{
//            imgViewSettings.image = UIImage.init(named: StaticArrayData.kSettingPrducrColScreenDict[indexPath.item].image)
//            textLabel.text = StaticArrayData.kSettingPrducrColScreenDict[indexPath.item].name
//        }else
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "3"{
            imgViewSettings.image = UIImage.init(named: StaticArrayData.kSettingPrducrColScreenDict[indexPath.item].image)
            textLabel.text = StaticArrayData.kSettingPrducrColScreenDict[indexPath.item].name
        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId == "10"{
            imgViewSettings.image = UIImage.init(named: StaticArrayData.kSettingVoyaColScreenDict[indexPath.item].image)
            textLabel.text = StaticArrayData.kSettingVoyaColScreenDict[indexPath.item].name
        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId == "9"{
            imgViewSettings.image = UIImage.init(named: StaticArrayData.kSettingRestColScreenDict[indexPath.item].image)
            textLabel.text = StaticArrayData.kSettingRestColScreenDict[indexPath.item].name
        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId == "7"{
            imgViewSettings.image = UIImage.init(named: StaticArrayData.kSettingExpertColScreenDict[indexPath.item].image)
            textLabel.text = StaticArrayData.kSettingExpertColScreenDict[indexPath.item].name
        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId == "8"{
            imgViewSettings.image = UIImage.init(named: StaticArrayData.kSettingTravlColScreenDict[indexPath.item].image)
            textLabel.text = StaticArrayData.kSettingTravlColScreenDict[indexPath.item].name
        }else {
            imgViewSettings.image = UIImage.init(named: StaticArrayData.kSettingImprtrColScreenDict[indexPath.item].image)
            textLabel.text = StaticArrayData.kSettingImprtrColScreenDict[indexPath.item].name
        }
        
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let autoLayoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        
        // Specify you want _full width_
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        
        // Calculate the size (height) using Auto Layout
        let autoLayoutSize = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.defaultLow)
        let autoLayoutFrame = CGRect(origin: autoLayoutAttributes.frame.origin, size: autoLayoutSize)
        
        // Assign the new size to the layout attributes
        autoLayoutAttributes.frame = autoLayoutFrame
        return autoLayoutAttributes
    }
    
    
}

