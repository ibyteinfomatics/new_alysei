//
//  UITextFieldSubLayerBorderWidthAndColor.swift
//  OneClickWash
//
//  Created by RUCHIN SINGHAL on 19/10/16.
//  Copyright © 2016 Appslure. All rights reserved.
//

import UIKit

class UITextFieldSubLayerBorderWidthAndColor: UITextFieldPaddingView
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
  }
}

