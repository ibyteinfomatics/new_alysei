//
//  UIviewCornerRadius.swift
//  TheBeaconApp
//
//  Created by Ruchin Singhal on 04/11/16.
//  Copyright © 2016 finoit. All rights reserved.
//

import UIKit

class UIviewCornerRadius: UIViewBorderWidthAndColor
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
class AnimationView: UIView {
    enum Direction: Int {
        case FromLeft = 0
        case FromRight = 1
    }

    @IBInspectable var direction : Int = 0
    @IBInspectable var delay :Double = 0.0
    @IBInspectable var duration :Double = 0.0
    override func layoutSubviews() {
        initialSetup()
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.2, options: .curveEaseIn, animations: {
            if let superview = self.superview {
                           if self.direction == Direction.FromLeft.rawValue {
                               self.center.x += superview.bounds.width
                           } else {
                               self.center.x -= superview.bounds.width
                           }
                       }
        })
    }
    func initialSetup() {
        if let superview = self.superview {
            if direction == Direction.FromLeft.rawValue {
             self.center.x -= superview.bounds.width
            } else {
                self.center.x += superview.bounds.width
            }

        }
    }
}
