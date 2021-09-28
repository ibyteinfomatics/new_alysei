//
//  UIButtonCornerRadius.swift
//  OneClickWash
//
//  Created by RUCHIN SINGHAL on 15/09/16.
//  Copyright © 2016 Appslure. All rights reserved.
//

import UIKit

class UIButtonCornerRadius: UIButton
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
