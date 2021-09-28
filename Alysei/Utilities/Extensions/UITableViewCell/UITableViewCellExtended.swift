//
//  UITableViewCellExtended.swift
//  TheBeaconApp
//
//  Created by Ruchin Singhal on 28/10/16.
//  Copyright © 2016 finoit. All rights reserved.
//

import UIKit

extension UITableViewCell
{
  static func identifier() -> String
  {
    return String(describing: self)
  }
    
    func clearAllColor() -> Void
    {
        self.subviews.forEach { $0.backgroundColor = .clear }
    }
}

