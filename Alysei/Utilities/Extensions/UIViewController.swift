//
//  UIViewController.swift
//  VisitorManagementSystem
//
//  Created by MacBook 1 on 26/10/19.
//  Copyright © 2019 CodeAegis. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  
  static func id() -> String {
    
    return String(describing: self)
  }
  
  static func segueIdentifier() -> String {
    
    return "show" + String(describing: self)
  }
}


extension UIView {
    
    func addShadow(){
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 1
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

class BackButton : UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc func backButtonTapped() {
        self.parentViewController?.dismiss(animated: true, completion: nil)
        self.parentViewController?.navigationController?.popViewController(animated: true)
    }
}
extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}


extension Array {
    func uniqueArray<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>()
        var arrayOrdered = [Element]()
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        return arrayOrdered
    }
}
