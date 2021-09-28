//
//  BoolExtended.swift
//  Clipaz
//
//  Created by RUCHIN SINGHAL on 05/02/17.
//  Copyright © 2017 Amit Singh. All rights reserved.
//

import Foundation

extension Bool
{
  static func getBool(_ value: Any?) -> Bool
  {
    guard let boolValue = value as? Bool else
    {
      let strBool = String.getString(value)
      guard let boolValueOfString = Bool(strBool) else { return false }
      
      return boolValueOfString
    }
    return boolValue
  }
    
    func toInt() -> Int
    {
        return (self == false) ? 0 : 1
    }
    
    func toString() -> String
    {
        return (self == false) ? "0" : "1"
    }
    
    func toStringValue() -> String
    {
        return (self == false) ? "False" : "True"
    }

}
