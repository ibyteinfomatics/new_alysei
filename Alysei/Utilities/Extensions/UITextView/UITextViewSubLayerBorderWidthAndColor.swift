//
//  UITextViewSubLayerBorderWidthAndColor.swift
//  Clipaz
//
//  Created by RUCHIN SINGHAL on 11/02/17.
//  Copyright © 2017 Amit Singh. All rights reserved.
//

import UIKit

class UITextViewSubLayerBorderWidthAndColor: UITextViewBorderWidthAndColor
{
  @IBInspectable var sublayerBorderWidth: CGFloat = 0.0 {
    didSet
    {
    }
  }
  
  @IBInspectable var sublayerBorderColor: UIColor? {
    didSet
    {
    }
  }
  
  @IBInspectable var bottomSublayer: Bool = false {
    didSet
    {
    }
  }}
