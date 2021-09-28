//
//  RangeExtended.swift
//  TheBeaconApp
//
//  Created by Ruchin Singhal on 14/11/16.
//  Copyright © 2016 finoit. All rights reserved.
//

import UIKit

extension NSRange
{
  func toRange(string: String) -> Range<String.Index>
  {
    return string.startIndex..<string.index(string.startIndex, offsetBy: length)
  }
}
