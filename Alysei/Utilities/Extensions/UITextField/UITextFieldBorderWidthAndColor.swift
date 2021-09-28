//
//  UITextFieldBorderWidthAndColor.swift
//  TheBeaconApp
//
//  Created by Aman Gupta on 25/10/16.
//  Copyright © 2016 finoit. All rights reserved.
//

import UIKit

class UITextFieldBorderWidthAndColor: UITextFieldSubLayerBorderWidthAndColor
{
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
