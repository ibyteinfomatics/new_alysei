//
//  UITextViewBorderWidthAndColor.swift
//  TheBeaconApp
//
//  Created by Ruchin Singhal on 28/10/16.
//  Copyright © 2016 finoit. All rights reserved.
//

import UIKit

class UITextViewBorderWidthAndColor: UITextView
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
