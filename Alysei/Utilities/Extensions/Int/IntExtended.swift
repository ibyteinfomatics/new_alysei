//
//  IntExtended.swift
//  TheBeaconApp
//
//  Created by Ruchin Singhal on 21/12/16.
//  Copyright © 2016 finoit. All rights reserved.
//

import Foundation

extension Int{

  var boolValue: Bool { return self != 0 }
  
  static func getInt(_ value: Any?) -> Int
  {
    guard let intValue = value as? Int else
    {
      let strInt = String.getString(value)
      guard let intValueOfString = Int(strInt) else { return 0 }
      
      return intValueOfString
    }
    return intValue
  }
    
    
    func toString() -> String
    {
        return String(describing:self)
    }
  
}
