//
//  RStextField.swift
//  VServeManager
//
//  Created by Valet2You on 18/03/19.
//  Copyright © 2019 ViralOps. All rights reserved.
//

import UIKit

@IBDesignable
class RSTextFieldCustomisation: UITextField {
	
	// MARK: - Layout
	override public func layoutSubviews() {
		
		super.layoutSubviews()
		updateUnderLineFrame()
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
	
	@IBInspectable var applyShadow: Bool = false {
		didSet {
			self.layer.shadowColor = UIColor.black.cgColor
			self.layer.shadowOpacity = 0.5
			self.layer.shadowOffset = .zero
			self.layer.shadowRadius = 1
		}
	}
	
	/// Applies underline to the text field with the specified width
	@IBInspectable var underLineWidth: CGFloat = 0.0 {
		
		didSet {
			applyUnderLine()
		}
	}
	
	/// Sets the underline color
  @IBInspectable var underLineColor: UIColor = .systemGroupedBackground {
		didSet {
			applyUnderLine()
		}
	}
	
	@IBInspectable var placeHolderColor: UIColor? {
		
		didSet {
			self.attributedPlaceholder = NSAttributedString(string: String.getString(self.placeholder), attributes:[NSAttributedString.Key.foregroundColor: placeHolderColor ?? .lightText])
		}
	}
	
	// MARK: - Underline
	private var underLineLayer = CALayer()
	private func applyUnderLine() {
		
		// Apply underline only if the text view's has no borders
		if borderStyle == UITextField.BorderStyle.none {
			underLineLayer.removeFromSuperlayer()
			updateUnderLineFrame()
			updateUnderLineUI()
			layer.addSublayer(underLineLayer)
			layer.masksToBounds = true
		}
	}
	
	private func updateUnderLineFrame() {
		
		var rect = bounds
		rect.origin.y = bounds.height - underLineWidth
		rect.size.height = underLineWidth
		underLineLayer.frame = rect
	}
	
	private func updateUnderLineUI() {
		
		underLineLayer.backgroundColor = underLineColor.cgColor
	}
	
	@IBInspectable var leftPaddingViewImage: UIImage? {
		didSet
		{
			if leftPaddingViewImage != nil
			{
				let viewLeft = UIView(frame: CGRect.init(x: 0, y: 0, width: 44.0, height: 44.0))
				
				let imgView = UIImageView.init(frame: CGRect.init(x: 6, y: 0, width: viewLeft.frame.size.height - 6, height: viewLeft.frame.size.height))
				imgView.contentMode = .left
				imgView.image = leftPaddingViewImage
				viewLeft.addSubview(imgView)
        
        let lblLine = UILabel.init(frame: CGRect.init(x: 32, y: 12, width: 1, height: 20))
        lblLine.backgroundColor = UIColor.lightGray
        viewLeft.addSubview(lblLine)
				
				self.leftView = viewLeft
				self.leftViewMode = .always
			}
		}
	}
  
  @IBInspectable var leftPaddingWidth: CGFloat = 0.0 {
    didSet
    {
      let viewLeft = UIView(frame: CGRect.init(x: 0, y: 0, width: leftPaddingWidth, height: self.frame.size.height))
      self.leftView = viewLeft
      self.leftViewMode = .always
    }
  }
    @IBInspectable var rightPaddingWidth: CGFloat = 0.0 {
      didSet
      {
        let viewLeft = UIView(frame: CGRect.init(x: 0, y: 0, width: rightPaddingWidth, height: self.frame.size.height))
        self.rightView = viewLeft
        self.leftViewMode = .always
      }
    }
}
