//
//  UILabelExtended.swift
//  TheBeaconApp
//
//  Created by Ruchin Singhal on 26/10/16.
//  Copyright © 2016 finoit. All rights reserved.
//

import UIKit

class UILabelExtended: UILabelCornerRadius
{
}

extension UILabel
{
    func setAttributedString(completeString:String,firstString:String,firstFont:UIFont = UIFont.systemFont(ofSize: 15),firstTextColor:UIColor = .black,otherString:String,otherFont:UIFont = UIFont.boldSystemFont(ofSize: 15), otherTextColor:UIColor = .black) -> Void
    {
        let attributedString = NSMutableAttributedString(string:completeString)
        let aString = NSString(string: completeString)
        let rangeFirst = (aString.range(of: firstString))
        
        let attributeFirst = [
          NSAttributedString.Key.font : firstFont,
          NSAttributedString.Key.foregroundColor : firstTextColor,
            ]
        
        attributedString.addAttributes(attributeFirst, range: rangeFirst)
        
        let rangeOther = (aString.range(of: otherString))
        let attributeOther = [
          NSAttributedString.Key.font : otherFont,
          NSAttributedString.Key.foregroundColor : otherTextColor,
            ]
        
        attributedString.addAttributes(attributeOther, range: rangeOther)
        self.attributedText = attributedString
 }
}
