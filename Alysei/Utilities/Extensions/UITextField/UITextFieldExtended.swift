//
//  UITextFieldExtended.swift
//  OneClickWash
//
//  Created by RUCHIN SINGHAL on 19/10/16.
//  Copyright © 2016 Appslure. All rights reserved.
//

import Foundation
import UIKit


extension UITextField {
    func addImageToRight(_ imageName: String) {
        self.rightViewMode = .always
        let baseView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: self.frame.height))
        let image = UIImageView(frame: CGRect(x: 5.0, y: 3.0, width: 40.0, height: baseView.frame.height - 6.0))
        image.image = UIImage(named: imageName)
        image.contentMode = .center
        baseView.addSubview(image)
        self.rightView = baseView
    }
}


class UITextFieldExtended: UITextFieldBorderWidthAndColor
{
  
  override func layoutSubviews()
  {
    super.layoutSubviews()
    if bottomSublayer
    {
      setBottomBorderWithCALayer()
    }
  }
    
//    override func becomeFirstResponder() -> Bool {
//    
//        layer.sublayerBorderWidth = 1
//        super.becomeFirstResponder()
//        return true
//    }
//    override func resignFirstResponder() -> Bool {
//        layer.sublayerBorderWidth = 0.5
//        super.resignFirstResponder()
//        return true
//    }
// 

 fileprivate func setBottomBorderWithCALayer()
  {
    let border = CALayer()
    border.backgroundColor = sublayerBorderColor?.cgColor
    
    border.frame = CGRect(x: 0, y: self.frame.size.height - sublayerBorderWidth, width: self.frame.size.width, height: sublayerBorderWidth)
    self.layer.addSublayer(border)
  }
    
    @IBInspectable var isAttributedPlaceholder: Bool = false {
        didSet
        {
          self.attributedPlaceholder = NSAttributedString(string: String.getString(self.placeholder), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
    }
}

//extension CALayer {
//    var sublayerBorderWidth: CGFloat {
//        set {
//            self.borderWidth = 0.5
//        }
//        get {
//            return 1
//        }
//    }
//}
