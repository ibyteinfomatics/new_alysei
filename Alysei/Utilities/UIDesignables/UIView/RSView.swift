//
//  RSView.swift
//  VServeManager
//
//  Created by Valet2You on 18/03/19.
//  Copyright © 2019 ViralOps. All rights reserved.
//

import UIKit

@IBDesignable
class RSViewCustomisation: UIView {
  
  override public func layoutSubviews() {
    
    super.layoutSubviews()
    if self.applyShadow == false { self.clipsToBounds = true }
  }
  
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
  
  @IBInspectable var gradientColor1: UIColor = UIColor.white {
    didSet {
      self.setGradient()
    }
  }
  
  @IBInspectable var gradientColor2: UIColor = UIColor.white {
    didSet {
      self.setGradient()
    }
  }
  
  @IBInspectable var gradientStartPoint: CGPoint = .zero {
    didSet {
      self.setGradient()
    }
  }
  
  @IBInspectable var gradientEndPoint: CGPoint = .init(x: 0.0, y: 1.0) {
    didSet {
      self.setGradient()
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
  
  private func setGradient() {
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [self.gradientColor1.cgColor, self.gradientColor2.cgColor]
    gradientLayer.startPoint = self.gradientStartPoint
    gradientLayer.endPoint = self.gradientEndPoint
    gradientLayer.frame = CGRect.init(x: 0, y: 0, width: (self.bounds.size.width * FunctionsConstants.kScreenWidth) / 320, height: FunctionsConstants.kScreenHeight)
    if let topLayer = self.layer.sublayers?.first, topLayer is CAGradientLayer {
      
      topLayer.removeFromSuperlayer()
    }
    self.layer.addSublayer(gradientLayer)
  }
}

extension UIView {
  
  func setGradient(withGradientStartColor startColor: UIColor, andGradientEndColor endColor: UIColor) {
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
    gradientLayer.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    if let topLayer = self.layer.sublayers?.first, topLayer is CAGradientLayer {
      
      topLayer.removeFromSuperlayer()
    }
    self.layer.addSublayer(gradientLayer)
  }
  
  func removeGradient() {
    
    if let topLayer = self.layer.sublayers?.first, topLayer is CAGradientLayer {
      
      topLayer.removeFromSuperlayer()
    }
  }
}
