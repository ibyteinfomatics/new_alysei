//
//  UITextViewExtended.swift
//  TheBeaconApp
//
//  Created by Ruchin Singhal on 28/10/16.
//  Copyright © 2016 finoit. All rights reserved.
//

import UIKit

class UITextViewExtended: UITextViewSubLayerBorderWidthAndColor
{
  override func layoutSubviews()
  {
    super.layoutSubviews()
    if bottomSublayer
    {
      setBottomBorderWithCALayer()
    }
  }
  
  fileprivate func setBottomBorderWithCALayer()
  {
    let border = CALayer()
    border.backgroundColor = sublayerBorderColor?.cgColor
    
    border.frame = CGRect(x: 0, y: self.frame.size.height - sublayerBorderWidth, width: self.frame.size.width, height: sublayerBorderWidth)
    self.layer.addSublayer(border)
  }
}


public extension UITextView {
  
  /// Scroll to the bottom of text view
  func scrollToBottom() {
    let range = NSMakeRange((text as NSString).length - 1, 1)
    scrollRangeToVisible(range)
  }
  
  /// Scroll to the top of text view
  func scrollToTop() {
    let range = NSMakeRange(0, 1)
    scrollRangeToVisible(range)
  }
}
