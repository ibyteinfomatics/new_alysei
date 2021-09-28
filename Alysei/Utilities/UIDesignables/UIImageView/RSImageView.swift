//
//  RSImageView.swift
//  HPProTrain
//
//  Created by CodeAegis iMac 1 on 23/06/19.
//  Copyright © 2019 XantaTech. All rights reserved.
//

import UIKit

@IBDesignable
class RSImageViewCustomisation: UIImageView {
  
  @IBInspectable var cornerRadius: CGFloat = 0 {
    
    didSet {
      layer.cornerRadius = cornerRadius
      layer.masksToBounds = false
    }
  }
  
  @IBInspectable var isCircle: Bool = false {
    
    didSet {
      layer.masksToBounds = cornerRadius > 0
    }
  }
  
  @IBInspectable var borderWidth: CGFloat = 0 {
    
    didSet {
      layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable var borderColor: UIColor? {
    
    didSet {
      layer.borderColor = borderColor?.cgColor
    }
  }
}
