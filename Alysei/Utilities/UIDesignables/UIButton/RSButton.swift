//
//  RSButton.swift
//  VServeManager
//
//  Created by Valet2You on 18/03/19.
//  Copyright © 2019 ViralOps. All rights reserved.
//

import UIKit

@IBDesignable
class RSButtonCustomisation: UIButton {
  
  override func layoutSubviews() {
    
    super.layoutSubviews()
    //    if makeCircle {
    //      layer.cornerRadius = self.bounds.size.width / 2
    //      clipsToBounds = true
    //    }
    //
    //    if leftSublayer {
    //      setLeftBorderWithCALayer()
    //    }
    //
    //    if rightSublayer {
    //      setRightBorderWithCALayer()
    //    }
    //
    //    if bottomSublayer {
    //      setBottomBorderWithCALayer()
    //    }
    //
    //    if topSublayer {
    //      setTopBorderWithCALayer()
    //    }
  }
  
  //  fileprivate func setLeftBorderWithCALayer()
  //  {
  //    let border = CALayer()
  //    border.backgroundColor = self.isSelected ? sublayerBorderColorSelected?.cgColor : sublayerBorderColorNormal?.cgColor
  //    border.frame = CGRect(x: 0, y: 0, width: sublayerBorderWidth, height: self.frame.size.height)
  //    self.layer.addSublayer(border)
  //  }
  //
  //  fileprivate func setRightBorderWithCALayer()
  //  {
  //    let border = CALayer()
  //    border.backgroundColor = self.isSelected ? sublayerBorderColorSelected?.cgColor : sublayerBorderColorNormal?.cgColor
  //    border.frame = CGRect(x: self.frame.size.width - sublayerBorderWidth, y: 0, width: sublayerBorderWidth, height: self.frame.size.height)
  //    self.layer.addSublayer(border)
  //  }
  //
  //  fileprivate func setTopBorderWithCALayer()
  //  {
  //    let border = CALayer()
  //    border.backgroundColor = self.isSelected ? sublayerBorderColorSelected?.cgColor : sublayerBorderColorNormal?.cgColor
  //    border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: sublayerBorderWidth)
  //    self.layer.addSublayer(border)
  //  }
  //
  //  fileprivate func setBottomBorderWithCALayer()
  //  {
  //    let border = CALayer()
  //    border.backgroundColor = self.isSelected ? colorSelected?.cgColor : colorNormal?.cgColor
  //    border.frame = CGRect(x: 0, y: self.frame.size.height - sublayerBorderWidth, width: self.frame.size.width, height: sublayerBorderWidth)
  //    self.layer.addSublayer(border)
  //  }
  
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
  
  @IBInspectable var applyShadow: Bool = false {
    didSet {
      self.layer.shadowColor = UIColor.black.cgColor
      self.layer.shadowOpacity = 0.5
      self.layer.shadowOffset = .zero
      self.layer.shadowRadius = 1
    }
  }
}
