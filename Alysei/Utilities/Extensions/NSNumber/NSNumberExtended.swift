//
//  NSNumberExtended.swift
//  OneClickWash
//
//  Created by RUCHIN SINGHAL on 04/10/16.
//  Copyright © 2016 Appslure. All rights reserved.
//

import Foundation

extension NSNumber
{
  static func getNSNumber(message: Any?) -> NSNumber
  {
    guard let number = message as? NSNumber else
    {
      guard let strNumber = message as? String else
      {
        return 0
      }
      guard let intNumber = Int(strNumber) else
      {
        guard let doubleNumber = Double(strNumber) else
        {
          return 0
        }
        return NSNumber(value: Double(doubleNumber))
      }
      return NSNumber(value: Int(intNumber))
    }
    return number
  }
}
