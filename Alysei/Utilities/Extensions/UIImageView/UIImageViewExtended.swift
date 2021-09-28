//
//  UIImageViewExtended.swift
//  TheBeaconApp
//
//  Created by Ruchin Singhal on 04/11/16.
//  Copyright © 2016 finoit. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import MobileCoreServices


class UIImageViewExtended: UIImageViewCornerRadius
{
  
}

extension UIImage{
  func imageWithSize(size: CGSize, roundedRadius radius: CGFloat) -> UIImage? {
    
    UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
    if let currentContext = UIGraphicsGetCurrentContext() {
      let rect = CGRect(origin: .zero, size: size)
      currentContext.addPath(UIBezierPath(roundedRect: rect,
                                          byRoundingCorners: .allCorners,
                                          cornerRadii: CGSize(width: radius, height: radius)).cgPath)
      currentContext.clip()
      
      //Don't use CGContextDrawImage, coordinate system origin in UIKit and Core Graphics are vertical oppsite.
      draw(in: rect)
      currentContext.drawPath(using: .fillStroke)
      let roundedCornerImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return roundedCornerImage
    }
    return nil
  }
    
}

extension UIImageView
{
    func setImage(withString strURL:String,placeholder:UIImage? = nil,_ handler:(((UIImage?) ->Void)?) = nil) -> Void{
      
      if let encoded = strURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded){
        self.af.setImage(withURL: url, placeholderImage: placeholder)
      }
      else { self.image = placeholder; handler?(nil) }
   
    }
  
}

extension UIImageView {
  
  private static let kRotationAnimationKey = "rotationanimationkey"
  
  func rotate(duration: Double = 35) {
    
    if layer.animation(forKey: UIImageView.kRotationAnimationKey) == nil {
      let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
      
      rotationAnimation.fromValue = 0.0
      rotationAnimation.toValue = Float.pi * 2.0
      rotationAnimation.duration = duration
      rotationAnimation.repeatCount = Float.infinity
      
      layer.add(rotationAnimation, forKey: UIImageView.kRotationAnimationKey)
    }
  }
  
  func stopRotating() {
    
    if layer.animation(forKey: UIImageView.kRotationAnimationKey) != nil {
      layer.removeAnimation(forKey: UIImageView.kRotationAnimationKey)
    }
  }
  
  func vibrate(){
    
      let animation = CABasicAnimation(keyPath: "position")
      animation.duration = 0.5
      animation.repeatCount = 600
      animation.autoreverses = true
      animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4.0, y: self.center.y))
      animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4.0, y: self.center.y))
      self.layer.add(animation, forKey: "position")
    
  }
 }


class ImageWithoutRender: UIImage {
  
  override func withRenderingMode(_ renderingMode: UIImage.RenderingMode) -> UIImage {
    return self
  }
}


extension UIButton{
  
  func vibrate(){
    
    let animation = CABasicAnimation(keyPath: "position")
    animation.duration = 0.5
    animation.repeatCount = 600
    animation.autoreverses = true
    animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4.0, y: self.center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4.0, y: self.center.y))
    self.layer.add(animation, forKey: "position")
    
  }
}

// Declares in-memory image cache
protocol ImageCacheType: class {
    // Returns the image associated with a given url
    func image(for url: URL) -> UIImage?
    // Inserts the image of the specified url in the cache
    func insertImage(_ image: UIImage?, for url: URL)
    // Removes the image of the specified url in the cache
    func removeImage(for url: URL)
    // Removes all images from the cache
    func removeAllImages()
    // Accesses the value associated with the given key for reading and writing
    subscript(_ url: URL) -> UIImage? { get set }
}
