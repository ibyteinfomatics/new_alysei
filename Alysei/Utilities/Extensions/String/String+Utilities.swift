//
//  String+Utilities.swift
//  HealthTotal
//
//  Created by Office on 23/05/16.
//  Copyright © 2016 Collabroo. All rights reserved.
//

import Foundation
import UIKit

extension String
{
    init(any anyValue:Any?)
    {
        self = ""
        
        if let str = anyValue as? String
        {
            self = String(format: "%@", str).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        else if let num = anyValue as? NSNumber
        {
            self = String(format: "%@", num).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }

    var isBackSpace:Bool
    {
        let  char = self.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        return (isBackSpace == -92)
    }
    
    var removingNewlines: String
    {
      return components(separatedBy: .newlines).joined()
    }
    

  // To Check Whether Email is valid
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat
    {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
      let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstrainedHeight height: CGFloat,font: UIFont) -> CGFloat
    {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
      let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.width
    }

  
  // To Check Whether Email is valid
  func isValidString() -> Bool
  {
    let str = self.trimAllWhiteSpace()
    
    if str.isEmpty { return false }
    
    if self == "<null>" || self == "(null)"
    {
        return false
    }
    
        return true
    }
  
  // To Check Whether Phone Number is valid
  func isValidPhoneNumber() -> Bool
  {
    if self.isStringEmpty()
    {
      return false
    }
    let phoneRegex = "^\\d{10}$"
    let phoneText = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
    let isValid = phoneText.evaluate(with: self) as Bool
    return isValid
  }
  
  // To Check Whether URL is valid
  func isURL() -> Bool
  {
    let urlRegex = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+" as String
    let urlText = NSPredicate(format: "SELF MATCHES %@", urlRegex)
    let isValid = urlText.evaluate(with: self) as Bool
    return isValid
  }
  
  // To Check Whether Image URL is valid
  func isImageURL() -> Bool
  {
    if self.isURL()
    {
      if self.range(of: ".png") != nil || self.range(of: ".jpg") != nil || self.range(of: ".jpeg") != nil
      {
        return true
      }
      else
      {
        return false
      }
    }
    else
    {
      return false
    }
  }
  
  static func getString(_ message: Any?) -> String
  {
    guard let strMessage = message as? String else
    {
      guard let doubleValue = message as? Double else
      {
        guard let intValue = message as? Int else
        {
          guard let int64Value = message as? Int64 else
          {
            return ""
          }
          return String(int64Value)
        }
        return String(intValue)
      }
      
      let formatter = NumberFormatter()
      formatter.minimumFractionDigits = 0
      formatter.maximumFractionDigits = 2
      formatter.minimumIntegerDigits = 1
      guard let formattedNumber = formatter.string(from: NSNumber(value: doubleValue)) else
      {
        return ""
      }
      return formattedNumber
    }
    return strMessage.stringByTrimmingWhiteSpaceAndNewLine()
  }
  
  static func getTextLength(_ message: Any?) -> Int
  {
    return String.getString(message).stringByTrimmingWhiteSpaceAndNewLine().count
  }
  
  static func checkForValidNumericString(_ message: AnyObject?) -> Bool
  {
    guard let strMessage = message as? String else
    {
      return true
    }
    
    if strMessage == "" || strMessage == "0"
    {
      return true
    }
    return false
  }
  
  
  // To Check Whether String is empty
  func isEmpty() -> Bool
  {
    return self.stringByTrimmingWhiteSpace().count == 0 ? true : false
  }
  
  mutating func removeSubString(subString: String) -> String
  {
    if self.contains(subString)
    {
      guard let stringRange = self.range(of: subString) else { return self }
      return self.replacingCharacters(in: stringRange, with: "")
    }
    return self
  }
  
  /*
   // To check whether String contains Only Letters
   func stringContainsOnlyLetters() -> Bool
   {
   let characterSet = NSCharacterSet.letterCharacterSet()
   return self.rangeOfCharacterFromSet(characterSet) != nil ? true : false
   }
   
   // To check whether String contains Only Numbers
   func stringContainsOnlyNumbers() -> Bool
   {
   let characterSet = NSCharacterSet.decimalDigitCharacterSet()
   return self.rangeOfCharacterFromSet(characterSet) != nil ? true : false
   }
   */
  
  // Get string by removing White Space & New Line
  func stringByTrimmingWhiteSpaceAndNewLine() -> String
  {
    return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
  }
  
  // Get string by removing White Space
  func stringByTrimmingWhiteSpace() -> String
  {
    return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
  }
  
  func getSubStringFrom(begin: String.Index, to end: String.Index) -> String{
    
    let str = String(self[begin...end])
    return str
  }
    
    
    // MARK: - Validator Methods
    
    // To check string is empty or not.
    func isStringEmpty() -> Bool {
        
        return self.trimWhiteSpace().count == 0 ? true : false
    }
    
    
    // To check for valid email.
    func isEmail() -> Bool {
      
      
        if self.isStringEmpty() {
            return false
        }
        let emailRegex = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}" as String
        let emailText  = NSPredicate(format: "SELF MATCHES %@",emailRegex)
        let isValid    = emailText.evaluate(with: self) as Bool
        return isValid
    }
    
  func isPassword() -> Bool {
    
    
      if self.isStringEmpty() {
          return false
      }
    
//    ^                         Start anchor
//    (?=.*[A-Z].*[A-Z])        Ensure string has two uppercase letters.
//    (?=.*[!@#$&*])            Ensure string has one special case letter.
//    (?=.*[0-9].*[0-9])        Ensure string has two digits.
//    (?=.*[a-z].*[a-z].*[a-z]) Ensure string has three lowercase letters.
//    .{8}                      Ensure string is of length 8.
//    $
    
      let passwordRegex = "^(?=.*[0-9])(?=.*[$@$#!%*?&€₹]).{8,}$"
        
      let passwordText  = NSPredicate(format: "SELF MATCHES %@ ",passwordRegex)
      let isValid    = passwordText.evaluate(with: self) as Bool
      return isValid
  }
  
  

  
    // To check for valid phone number. Allows only digits with the exact length 10.
    func isPhoneNumber() -> Bool {
        if self.isStringEmpty() {
            return false
        }
        let phoneRegex = "^\\d{10}$"
        let phoneText  = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let isValid    = phoneText.evaluate(with: self) as Bool
        return isValid
    }
    
    
    // MARK: - Formatting Methods
    
    // To get string value from the passed value(Int, Double, String etc). If string value is not found, it will return empty string.
    static func getStringValue(_ message: Any?) -> String {
        guard let strMessage = message as? String else {
            guard let doubleValue = message as? Double else {
                guard let intValue = message as? Int else {
                    guard let int64Value = message as? Int64 else {
                        return ""
                    }
                    return String(int64Value)
                }
                return String(intValue)
            }
            
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 2
            formatter.minimumIntegerDigits  = 1
            guard let formattedNumber = formatter.string(from: NSNumber(value: doubleValue)) else {
                return ""
            }
            return formattedNumber
        }
        return strMessage.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // To get length of string value.
    static func getLength(_ message: Any?) -> Int {
        return String.getStringValue(message).trimmingCharacters(in: .whitespacesAndNewlines).count
    }
    
    // To get new string by removing passed substring.
    
    mutating func removeSubstring(subString: String) -> String {
        if self.contains(subString) {
            guard let stringRange = self.range(of: subString) else { return self }
            return self.replacingCharacters(in: stringRange, with: "")
        }
        return self
    }
    
    // Get new string with trimming white space.
    func trimWhiteSpace() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    // Get new string with trimming all white space.
    func trimAllWhiteSpace() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    // To get the full API Url by adding the path.
    func fullAPI(path: String) -> String {
        if path.count > 0 {
            return self+"\(path)"
        }
        return self
    }
    // To get the index of String.
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
//    subscript (r: Range<Int>) -> String {
//        let start = index(startIndex, offsetBy: r.lowerBound)
//        let end = index(startIndex, offsetBy: r.upperBound)
//        String(return self[Range(s)tart ..< end)]
//    }


    var length: Int { return self.count }
    
    var toBool:Bool { return  self.isValidString() && self == "1" }
    
    var toInt:Int
    {
        return Int(self) ?? 0
    }
    
    var toFloat: Float
    {
        return Float(self) ?? 0.0
    }
    
    var toDouble: Double
    {
        return Double(self) ?? 0.0
    }
    
    func contains(comparsionString aString: String) -> Bool
    {
        return (self.range(of: aString) != nil) ? true : false
    }
    
    //case insensitive contains
    func contains(ignoreCase aString: String?)-> Bool
    {
        guard let aString = aString else { return false }
        
        return (self.lowercased().range(of: aString.lowercased()) != nil) ? true : false
    }
    
    func contains(ignoreCase arrString:[String]?)-> Bool
    {
        guard let arrString = arrString else { return false }
        
        return arrString.filter { self.lowercased().contains(ignoreCase: $0.lowercased()) }.count > 0
    }
    
    
    var isNumber: Bool {
        
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
//    func getStartingCharacters(upto: Int) -> String {
//
//        if let index = self.index(self.startIndex, offsetBy: upto, limitedBy: self.endIndex) {
//
//            String(return self[self.start)Index..<index]
//        }
//        return self
//    }
    
    func getOnlyNumbers() -> String{
       return String(describing: filter { String($0).rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789")) != nil })
    }
  
 
  func htmlAttributedString() -> NSAttributedString? {
    
      guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
      guard let html = try? NSMutableAttributedString(
              data: data,
              options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
              documentAttributes: nil) else { return nil }
      return html
  }
  
 
      func emojiToImage() -> UIImage? {
          let size = CGSize(width: 30, height: 35)
          UIGraphicsBeginImageContextWithOptions(size, false, 0)
          UIColor.white.set()
          let rect = CGRect(origin: CGPoint(), size: size)
          UIRectFill(rect)
          (self as NSString).draw(in: rect, withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)])
          let image = UIGraphicsGetImageFromCurrentImageContext()
          UIGraphicsEndImageContext()
          return image
      }

    
}

func checkForInteger(_ doubleValue: Double) -> Bool
{
    if doubleValue.truncatingRemainder(dividingBy: 1) == 0
    {
        return true
    }
    else
    {
        return false
    }
}

func postedFormattedTime(str: String) -> String
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
    dateFormatter.timeZone = TimeZone.init(identifier: "GMT") //Current time zone
    let dateStr = dateFormatter.date(from: (str)) //according to date format your date string
    
    
    let calender:Calendar = Calendar.current
    let components: DateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: (dateStr ?? Date()), to: Date())
    var returnString:String = ""
    
    if components.second! < 60 {
        returnString = ""
    }
    
    if components.minute! > 1{
        returnString = String(describing: components.minute!) + " Mins ago"
    }
    else if components.minute! == 1 {
        
        returnString = "1 minute ago"
    }
    
    if components.hour! > 1{
        returnString = String(describing: components.hour!) + " Hours ago"
    }
    else if components.hour == 1 {
        
        returnString = "An hour ago"
    }
    
    if components.day! > 1{
        returnString = String(describing: components.day!) + " Days ago"
    }
    else if components.day! == 1 {
        
        returnString = "Yesterday"
    }
    
    if components.month! > 1{
        returnString = String(describing: components.month!)+" Months ago"
    }
    else if components.month! == 1 {
        
        returnString = "A month ago"
    }
    
    if components.year! > 1 {
        returnString = String(describing: components.year!)+" Years ago"
    }
    else if components.year! == 1 {
        
        returnString = "A year ago"
    }
    
    if String.getLength(returnString) > 0 {
        return returnString
    } else {
        return "0 min ago"
    }
}

extension String {
  
  func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(string: self)
    for string in strings {
      let range = (self as NSString).range(of: string)
      attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
    guard let characterSpacing = characterSpacing else {return attributedString}
    
    attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
    
    return attributedString
  }
}



extension String {

    enum ContentType {
        case username
        case email
        case mobileNumber
        case address
        case password
        case firstName
        case lastName
        case fullName
        case vat
        case facebook
        case instagram
        case twitter
        case linkedin
        case url
    }

    func isValid(_ type: ContentType) -> Bool {
        var maxChar = 0
        var regex = "[A-Za-z]{1,75}"

        switch type {
        case .username:
            regex = "[A-Z0-9a-z@#$_]{3,20}" // @ # $ _
            maxChar = 20
        case .email:
            regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            maxChar = 75
        case .password:
            regex = "^((?=[a-zA-Z0-9!@#$%^&*_]{8,16}$)(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*_])).{8,16}$"
            maxChar = 16
        case .address:
            regex = "[A-Z0-9a-z@#$_+-\\s]{5,100}"
            maxChar = 100
        case .mobileNumber:
            regex = "[0-9+-]{4,10}"
            maxChar = 10
        case .firstName:
            regex = "[A-Za-z\\s]{1,75}"
            maxChar = 30
        case .lastName:
            regex = "[A-Za-z\\s]{1,75}"
            maxChar = 30
        case .fullName:
            regex = "[A-Za-z\\s]{1,150}"
            maxChar = 50
        case .vat:
            regex = "[A-Z]{5}[0-9]{4}[A-Z]{1}"
            maxChar = 10
        case .url:
//            regex = "(http|https)?://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
            regex = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
            maxChar = 300
        case .facebook:
            regex = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
            maxChar = 300
            if (self.contains("facebook")) || (self.contains("fb")) {
            } else {
                return false
            }
        case .instagram:
            regex = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
            maxChar = 300
            if (self.contains("instagram")){
            } else {
                return false
            }
        case .twitter:
            regex = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
            maxChar = 300
            if (self.contains("twitter")){
            } else {
                return false
            }
        case .linkedin:
            regex = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
            maxChar = 300
            if (self.contains("linkedin")){
            } else {
                return false
            }
        }
        if self.count > maxChar {
            return false
        }
        return validate(regex, matchWith: self)
    }

    private func validate(_ regex: String, matchWith userInput: String) -> Bool {
        let validator = NSPredicate(format: "SELF MATCHES %@", regex)
        let valid = validator.evaluate(with: userInput)
        return valid
    }
}

