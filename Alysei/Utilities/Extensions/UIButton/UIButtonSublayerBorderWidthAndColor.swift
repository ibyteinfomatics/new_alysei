//
//  UIButtonSublayerBorderWidthAndColor.swift
//  OneClickWash
//
//  Created by RUCHIN SINGHAL on 15/09/16.
//  Copyright © 2016 Appslure. All rights reserved.
//

import UIKit

class UIButtonSublayerBorderWidthAndColor: UIButtonBorderWidthAndColor
{
  @IBInspectable var sublayerBorderWidth: CGFloat = 1 {
    didSet
    {
    }
  }
  
  @IBInspectable var sublayerBorderColorSelected: UIColor? {
    didSet
    {
    }
  }
  
  @IBInspectable var sublayerBorderColorNormal: UIColor? {
    didSet
    {
    }
  }
  
  @IBInspectable var leftSublayer: Bool = false {
    didSet
    {
    }
  }
  
  @IBInspectable var rightSublayer: Bool = false {
    didSet
    {
    }
  }
  
  @IBInspectable var bottomSublayer: Bool = false {
    didSet
    {
    }
  }
  
  @IBInspectable var topSublayer: Bool = false {
    didSet
    {
    }
  }
}
