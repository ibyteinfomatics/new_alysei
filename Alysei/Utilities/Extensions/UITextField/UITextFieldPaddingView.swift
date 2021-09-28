//
//  UITextFieldPaddingView.swift
//  OneClickWash
//
//  Created by RUCHIN SINGHAL on 19/10/16.
//  Copyright © 2016 Appslure. All rights reserved.
//

import UIKit

class UITextFieldPaddingView: UITextField
{
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
        let rightLeft = UIView(frame: CGRect.init(x: 0, y: 0, width: rightPaddingWidth, height: self.frame.size.height))
        self.rightView = rightLeft
        self.rightViewMode = .always
      }
    }

  @IBInspectable var leftPaddingViewImage: UIImage? {
    didSet
    {
      if leftPaddingViewImage != nil
      {
        let viewLeft = UIView(frame: CGRect.init(x: 0, y: 0, width: 60.0, height: 60.0))
        
        let imgView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: viewLeft.frame.size.height, height: viewLeft.frame.size.height))
        imgView.contentMode = .center
        imgView.image = leftPaddingViewImage
        viewLeft.addSubview(imgView)
        
        self.leftView = viewLeft
        self.leftViewMode = .always
      }
    }
  }
  
  @IBInspectable var rightPaddingViewImage: UIImage? {
    didSet
    {
      if rightPaddingViewImage != nil
      {
        let viewRight = UIView(frame: CGRect.init(x: kScreenWidth - 80.0, y: 0, width: 30.0, height: 30.0))
        
        let imgView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: viewRight.frame.size.height, height: viewRight.frame.size.height))
        imgView.contentMode = .center
        imgView.image = rightPaddingViewImage
        viewRight.addSubview(imgView)
        
        self.rightView = viewRight
        self.rightViewMode = .always
      }
    }
  }
  
  @IBInspectable var leftPaddingText: String? {
    didSet
    {
      if leftPaddingText != nil
      {
        let viewLeft = UIView(frame: CGRect.init(x: 0, y: 0, width: 32.0, height: 32.0))
        
        let lblLeftText = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: viewLeft.frame.size.height, height: viewLeft.frame.size.height))
        lblLeftText.text = leftPaddingText
        lblLeftText.font = UIFont.init(name: "Montserrat-Regular", size: 17.0)
        viewLeft.addSubview(lblLeftText)
        
        self.leftView = viewLeft
        self.leftViewMode = .always
      }
    }
  }
    
    @IBInspectable var rightPaddingText: String? {
      didSet
      {
        if rightPaddingText != nil
        {
          let viewRight = UIView(frame: CGRect.init(x: 0, y: 0, width: 32.0, height: 32.0))
          
          let lblRightText = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: viewRight.frame.size.height, height: viewRight.frame.size.height))
            lblRightText.text = rightPaddingText
            lblRightText.font = UIFont.init(name: "Montserrat-Regular", size: 17.0)
          viewRight.addSubview(lblRightText)
          
          self.rightView = viewRight
          self.rightViewMode = .always
        }
      }
    }
}
