//
//  textEdit.swift
//  OnlyWizYou
//
//  Created by RizwanHaider on 23/03/17.
//  Copyright © 2017 RizwanHaider. All rights reserved.
//

import UIKit

@IBDesignable
class textEdit: UITextField,UITextFieldDelegate {
    
    @IBInspectable var paddingLeft: CGFloat = 0
    @IBInspectable var paddingRight: CGFloat = 0
    @IBInspectable var cornerRadius: CGFloat = 0.0
    open var titleLabel: UILabel!
       open var selectedLineHeight: CGFloat = 1.0
    
        {
        didSet {
            self.layer.cornerRadius = cornerRadius
            
                   // updateLineView()
                    setNeedsDisplay()
            
            }
        }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
    return CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y, width: bounds.size.width - paddingLeft - paddingRight, height: bounds.size.height)
        }
        
        override func editingRect(forBounds bounds: CGRect) -> CGRect
        {
            return textRect(forBounds: bounds)
        }
//    func setPreferences() {
//        self.layer.cornerRadius = 8
//        self.layer.borderColor = UIColor.gray.cgColor
//        self.layer.borderWidth = 2
//    
//    }
    open func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        if editing {
            return CGRect(x: 0, y: 0, width: bounds.size.width, height: titleHeight())
        }
        return CGRect(x: 0, y: titleHeight(), width: bounds.size.width, height: titleHeight())
    }

    open func titleHeight() -> CGFloat {
        if let titleLabel = titleLabel,
            let font = titleLabel.font {
            return font.lineHeight
        }
        return 15.0
    }

    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = CGRect(
            x: 0,
            y: titleHeight(),
            width: bounds.size.width,
            height: bounds.size.height - titleHeight() - selectedLineHeight
        )
        return rect
    }

    
}
