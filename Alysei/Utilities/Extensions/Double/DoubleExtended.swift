//
//  DoubleExtended.swift
//  TheBeaconApp
//
//  Created by Ruchin Singhal on 10/12/16.
//  Copyright © 2016 finoit. All rights reserved.
//

import Foundation

extension Double
{
  static func getDouble(_ value: Any?) -> Double
  {
    guard let doubleValue = value as? Double else
    {
      let strDouble = String.getString(value)
      guard let doubleValueOfString = Double(strDouble) else { return 0.0 }
      
      return doubleValueOfString
    }
    return doubleValue
  }
}
