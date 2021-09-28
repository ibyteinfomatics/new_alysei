//
//  UILabelCornerRadius.swift
//  TheBeaconApp
//
//  Created by Ruchin Singhal on 04/11/16.
//  Copyright © 2016 finoit. All rights reserved.
//

import UIKit

class UILabelCornerRadius: UILabelBorderWidthAndColor
{
  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
      layer.cornerRadius = cornerRadius
      layer.masksToBounds = cornerRadius > 0
    }
  }
  
  @IBInspectable var makeCircle: Bool = false {
    didSet
    {
      layer.masksToBounds = cornerRadius > 0
    }
  }
}
