//
//  UIButtonExtended.swift
//  OneClickWash
//
//  Created by RUCHIN SINGHAL on 15/09/16.
//  Copyright © 2016 Appslure. All rights reserved.
//

import UIKit

class UIButtonExtended: UIButtonSublayerBorderWidthAndColor{
  


  override func layoutSubviews(){
    
    super.layoutSubviews()
    if makeCircle
    {
      layer.cornerRadius = self.bounds.size.width / 2
      clipsToBounds = true
    }
    
    if leftSublayer
    {
      setLeftBorderWithCALayer()
    }
    
    if rightSublayer
    {
      setRightBorderWithCALayer()
    }
    
    if bottomSublayer
    {
      setBottomBorderWithCALayer()
    }
    
    if topSublayer
    {
      setTopBorderWithCALayer()
    }
  }
  
  fileprivate func setLeftBorderWithCALayer()
  {
    let border = CALayer()
    border.backgroundColor = self.isSelected ? sublayerBorderColorSelected?.cgColor : sublayerBorderColorNormal?.cgColor
    
    border.frame = CGRect(x: 0, y: 0, width: sublayerBorderWidth, height: self.frame.size.height)
    self.layer.addSublayer(border)
  }
  
  fileprivate func setRightBorderWithCALayer()
  {
    let border = CALayer()
    border.backgroundColor = self.isSelected ? sublayerBorderColorSelected?.cgColor : sublayerBorderColorNormal?.cgColor
    
    border.frame = CGRect(x: self.frame.size.width - sublayerBorderWidth, y: 0, width: sublayerBorderWidth, height: self.frame.size.height)
    self.layer.addSublayer(border)
  }
  
  fileprivate func setTopBorderWithCALayer()
  {
    let border = CALayer()
    border.backgroundColor = self.isSelected ? sublayerBorderColorSelected?.cgColor : sublayerBorderColorNormal?.cgColor
    
    border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: sublayerBorderWidth)
    self.layer.addSublayer(border)
  }
  
  fileprivate func setBottomBorderWithCALayer()
  {
    let border = CALayer()
    border.backgroundColor = self.isSelected ? sublayerBorderColorSelected?.cgColor : sublayerBorderColorNormal?.cgColor
    
    border.frame = CGRect(x: 0, y: self.frame.size.height - sublayerBorderWidth, width: self.frame.size.width, height: sublayerBorderWidth)
    self.layer.addSublayer(border)
  }
}

extension UIButton{
  
  func underline(borderColor: UIColor = AppColors.green.color, title: String) {
    
      
    let attributes : [NSAttributedString.Key : Any] = [
    NSAttributedString.Key.font : AppFonts.regular(14.0).font,
    NSAttributedString.Key.foregroundColor : borderColor.cgColor,
    NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
    ]
    
    let attributeString = NSMutableAttributedString(string: title,
                                                        attributes: attributes)
    self.setAttributedTitle(attributeString, for: .normal)
  }
  
  
  func underlined(borderColor: UIColor = UIColor.white){
     
     let border = CALayer()
     let width = CGFloat(1.0)
     border.borderColor = borderColor.cgColor
     border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
     border.borderWidth = self.frame.size.width
     self.layer.addSublayer(border)
     self.layer.masksToBounds = true
   }
   
   func drawButtonBottomShadow() -> Void{
     
     layer.shadowColor = AppColors.gray.color.cgColor
     layer.shadowOffset = CGSize(width: 0,height: 1)
     layer.shadowOpacity = 1
     layer.shadowRadius = 1
     layer.masksToBounds = false
   }
    
    func roundedButton(_ corners: UIRectCorner){
    
           
     let maskPath1 = UIBezierPath(roundedRect: self.bounds,
                                         byRoundingCorners: corners,
                                         cornerRadii: CGSize(width: 5, height: 5))
     let maskLayer1 = CAShapeLayer()
     maskLayer1.frame = self.bounds
     maskLayer1.path = maskPath1.cgPath
     self.layer.mask = maskLayer1
    
    }
  
   func makeBorderGradient(){
    
    let gradient = CAGradientLayer()
    gradient.frame =  CGRect(origin: .zero, size: self.frame.size)
    gradient.colors = [AppColors.gradientDarkGreen.color.cgColor, AppColors.gradientGreen.color.cgColor]
    gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
    gradient.cornerRadius = self.frame.size.height/2
    self.layer.cornerRadius = self.frame.size.height/2
    
    let shape = CAShapeLayer()
    shape.lineWidth = 3
    shape.path = UIBezierPath(rect: self.bounds).cgPath
    shape.strokeColor = UIColor.black.cgColor
    shape.fillColor = UIColor.clear.cgColor
    shape.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    gradient.mask = shape
    self.layer.addSublayer(gradient)
  }
  
  public func addButtonGradient(){
    
    let gradient:CAGradientLayer = CAGradientLayer()
    gradient.frame.size = self.frame.size
    gradient.colors = [AppColors.red.color.cgColor,AppColors.orange.color.cgColor]
    gradient.locations = [0.0,1.0]
    gradient.startPoint = CGPoint(x: 0.0, y: 0.9)
    gradient.endPoint = CGPoint(x: 0.9, y: 1.0)
    self.layer.insertSublayer(gradient, at: 0)
  }
}

extension UIView{
  
  public func addViewGradient(){
    
    let gradient:CAGradientLayer = CAGradientLayer()
    gradient.frame.size = self.frame.size
    gradient.colors = [AppColors.orange.color.cgColor,AppColors.red.color.cgColor]
    gradient.locations = [0.0,1.0]
    gradient.startPoint = CGPoint(x: 0.0, y: 0.9)
    gradient.endPoint = CGPoint(x: 0.9, y: 1.0)
    self.layer.insertSublayer(gradient, at: 0)
  }
}
