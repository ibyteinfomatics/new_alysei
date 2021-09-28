//
//  RSLabel.swift
//  VServeManager
//
//  Created by Valet2You on 04/06/19.
//  Copyright © 2019 ViralOps. All rights reserved.
//

import UIKit

@IBDesignable
class RSLabelCustomisation: UILabel {
  
  override func layoutSubviews() {
    
    super.layoutSubviews()
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
}
