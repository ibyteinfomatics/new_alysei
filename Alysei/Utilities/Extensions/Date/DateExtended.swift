//
//  DateExtended.swift
//  OneClickWash
//
//  Created by RUCHIN SINGHAL on 06/11/16.
//  Copyright © 2016 Appslure. All rights reserved.
//

import Foundation

let D_MINUTE	= 60.0
let D_HOUR		= 3600.0
let D_DAY     = 86400.0
let D_WEEK		= 604800.0
let D_YEAR		= 31556926.0

extension Date
{
  //MARK: ----------Class Methods----------
  static func currentCalendar() -> Calendar
  {
    var sharedCalendar: Calendar? = nil
    if (sharedCalendar == nil)
    {
      sharedCalendar = Calendar.autoupdatingCurrent
    }
    return sharedCalendar!
  }
  
  static func dateWithDaysFromNow(days: NSInteger) -> Date
  {
    return Date().dateByAddingDays(days: days)
  }
  
  static func dateAfterDate(date: Date) -> Date
  {
    return date.dateByAddingDays(days: 1)
  }
  
  static func dateWithDaysBeforeNow(days: NSInteger) -> Date
  {
    return Date().dateBySubstractingDays(days: days)
  }
  
  static func dateTomorrow() -> Date
  {
    return Date.dateWithDaysFromNow(days: 1)
  }
  
  static func dateYesterday() -> Date
  {
    return Date.dateWithDaysBeforeNow(days: 1)
  }
  
  static func dateWithHoursFromNow(hours: NSInteger) -> Date
  {
    return Date().dateByAddingHours(hours: hours)
  }
  
  static func dateWithHoursBeforeNow(hours: NSInteger) -> Date
  {
    return Date().dateBySubstractingHours(hours: hours)
  }
  
  static func dateWithMinutesFromNow(minutes: NSInteger) -> Date
  {
    return Date().dateByAddingMinutes(minutes: minutes)
  }
  
  static func dateWithMinutesBeforeNow(minutes: NSInteger) -> Date
  {
    return Date().dateBySubstractingMinutes(minutes: minutes)
  }
  
  static func dateFromString(date: String, withCurrentFormat format:String) -> Date
  {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    
    return dateFormatter.date(from: date) ?? Date()
  }
  
  static func getTimeFromSeconds(seconds: Int) -> String
  {
    let year = seconds / 31536000
    let month = seconds / 2592000
    let week = seconds / 604800
    let day = seconds / 86400
    let hour = seconds / 3600
    let min = seconds / 60
    let sec = seconds % 60
    
    if year > 0
    {
      return "\(year) y"
    }
    else if month > 0
    {
      return "\(month) M"
    }
    else if week > 0
    {
      return "\(week) w"
    }
    else if day > 0
    {
      return "\(day) d"
    }
    else if hour > 0
    {
      return "\(hour) h"
    }
    else if min > 0
    {
      return "\(min) m"
    }
    else
    {
      return "\(sec) s"
    }
    
    //    if hour == 0
    //    {
    //      return "\(min) m"
    //    }
    //    else
    //    {
    //      if min == 0
    //      {
    //        return "\(hour) h"
    //      }
    //      else
    //      {
    //        return "\(hour) h" + " \(min) m"
    //      }
    //    }
  }
  
  static func getChatMessageTime(seconds: Double) -> String
  {
    let currentUnixDate =  Date.getUnixTimeStampFromDate(date: Date())
    let timeDifference = currentUnixDate - seconds
    
    if timeDifference >= 0
    {
      let hour = timeDifference / 3600
      let min = timeDifference / 60
      let sec = timeDifference
      
      if Int(hour) >= 1 && Int(hour) < 24
      {
        if Date.getDateFromUnixTimeStamp(timeStamp: seconds).isYesterday()
        {
          return Date.getDateFromUnixTimeStamp(timeStamp: seconds).stringWithFormat(format: "dd/MM/yy")
        }
        else
        {
          return Date.getDateFromUnixTimeStamp(timeStamp: seconds).stringWithFormat(format: "hh:mm a")
        }
      }
      else if Int(min) >= 1 && Int(min) < 60
      {
        return Date.getDateFromUnixTimeStamp(timeStamp: seconds).stringWithFormat(format: "hh:mm a")
        //return Int(min) == 1 ? "\(Int(min)) min ago" : "\(Int(min)) mins ago"
      }
      else if sec >= 0 && sec < 60
      {
        return Date.getDateFromUnixTimeStamp(timeStamp: seconds).stringWithFormat(format: "hh:mm a")
        //return "Just Now"
      }
      else
      {
        return Date.getDateFromUnixTimeStamp(timeStamp: seconds).stringWithFormat(format: "dd/MM/yy")
      }
    }
    else
    {
      return Date().stringWithFormat(format: "hh:mm a")
    }
  }
  
  static func getDateAndTimeToShow(seconds: Double) -> String
  {
    let currentUnixDate =  Date.getUnixTimeStampFromDate(date: Date())
    
    let timeDifference = seconds - currentUnixDate
    
    if timeDifference > 0
    {
      let year = timeDifference / 31536000
      let month = timeDifference / 2592000
      let week = timeDifference / 604800
      let day = timeDifference / 86400
      //let hour = seconds / 3600
      //let min = seconds / 60
      //let sec = seconds.truncatingRemainder(dividingBy: 60)
      
      if year >= 1 || month >= 1 || week >= 1
      {
        return Date.getDateFromUnixTimeStamp(timeStamp: Double(seconds)).stringWithFormat(format: "MMM dd, hh:mm a")
      }
      else if day >= 1
      {
        return (day == 1) ? "\(Int(day)) day left" : "\(Int(day)) days left"
      }
      else
      {
        return Date.getDateFromUnixTimeStamp(timeStamp: seconds).stringWithFormat(format: "hh:mm a")
      }
    }
    else
    {
      return Date.getDateFromUnixTimeStamp(timeStamp: seconds).stringWithFormat(format: "hh:mm a")
    }
  }
  
  static func changeDateFormat(date: String, currentFormat format: String, requiredFormat rFormat: String) -> String
  {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    
    let dateHere = dateFormatter.date(from: date)
    return (dateHere ?? Date()).stringWithFormat(format: rFormat)
  }
  
  static func getUTCTime(date: Date) -> Date
  {
    let tz = TimeZone.current
    let seconds = -(tz.secondsFromGMT(for: date))
    return Date(timeInterval: Double(seconds), since: date)
  }
  
  static func getLocalDateFromUTC(date: Date) -> Date
  {
    let tz = TimeZone.current
    let seconds = (tz.secondsFromGMT(for: date))
    return Date(timeInterval: Double(seconds), since: date)
  }
  
  static func getUnixTimeStampFromDate(date: Date) -> Double
  {
    let calendar = Calendar.current
    
    let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
    
    var components = DateComponents()
    components.year = dateComponents.year
    components.month = dateComponents.month
    components.day = dateComponents.day
    components.hour = dateComponents.hour
    components.minute = dateComponents.minute
    components.second = dateComponents.second
    
    let combinedDate = calendar.date(from: components)
    return Double(Date.getLocalDateFromUTC(date: Date.getUTCTime(date: combinedDate ?? Date())).timeIntervalSince1970)
  }
  
  static func getUnixTimeStampFromDate(date: Date, andIntegerTime time: Int) -> Int
  {
    let calendar = Calendar.current
    
    let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
    
    var components = DateComponents()
    components.year = dateComponents.year
    components.month = dateComponents.month
    components.day = dateComponents.day
    components.hour = time
    components.minute = 0
    components.second = 0
    
    let combinedDate = calendar.date(from: components)
    return Int(Date.getLocalDateFromUTC(date: Date.getUTCTime(date: combinedDate ?? Date())).timeIntervalSince1970)
  }
  
  static func getUnixTimeStampFromDate(date: Date, andTime time: Date) -> Int
  {
    let calendar = Calendar.current
    
    let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
    let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)
    
    var components = DateComponents()
    components.year = dateComponents.year
    components.month = dateComponents.month
    components.day = dateComponents.day
    components.hour = timeComponents.hour
    components.minute = timeComponents.minute
    components.second = timeComponents.second
    
    let combinedDate = calendar.date(from: components)
    return Int(Date.getUTCTime(date: combinedDate ?? Date()).timeIntervalSince1970)
  }
  
  static func getDateFromUnixTimeStamp(timeStamp: Double) -> Date
  {
    return Date(timeIntervalSince1970: timeStamp)
  }
  
  static func getDateFromUnixTimeStampInMilliSeconds(timeStamp: Double) -> Date
  {
    return Date(timeIntervalSince1970: timeStamp/1000)
  }
  
  static func date(date: Date, isBetweenDate beginDate: Date, andDate endDate: Date) -> Bool
  {
    if date.compare(beginDate) == .orderedAscending
    {
      return false
    }
    
    if date.compare(endDate) == .orderedDescending
    {
      return false
    }
    
    return true
  }
  
  func toMillis() -> Int64! {
    
    return Int64(self.timeIntervalSince1970 * 1000)
  }
  
  
  //MARK: ----------Object Methods----------
  func lastDayOfMonth() -> Date
  {
    let calendar = Calendar.current
    let dayRange = calendar.range(of: .day, in: .month, for: self)
    let dayCount = dayRange?.count
    
    var comp = calendar.dateComponents([.year, .month, .day], from: self)
    comp.day = dayCount
    
    return calendar.date(from: comp)!
  }
  
  func stringWithDateStyle(dateStyle: DateFormatter.Style, timeStyle tStyle: DateFormatter.Style) -> String
  {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = dateStyle
    dateFormatter.timeStyle = tStyle
    return dateFormatter.string(from: self)
  }
  
  func shortString() -> String
  {
    return self.stringWithDateStyle(dateStyle: .short, timeStyle: .short)
  }
  
  func shortTimeString() -> String
  {
    return self.stringWithDateStyle(dateStyle: .none, timeStyle: .short)
  }
  
  func shortDateString() -> String
  {
    return self.stringWithDateStyle(dateStyle: .short, timeStyle: .none)
  }
  
  func mediumString() -> String
  {
    return self.stringWithDateStyle(dateStyle: .medium, timeStyle: .medium)
  }
  
  func mediumDateString() -> String
  {
    return self.stringWithDateStyle(dateStyle: .medium, timeStyle: .none)
  }
  
  func mediumTimeString() -> String
  {
    return self.stringWithDateStyle(dateStyle: .none, timeStyle: .medium)
  }
  
  func longString() -> String
  {
    return self.stringWithDateStyle(dateStyle: .long, timeStyle: .long)
  }
  
  func longTimeString() -> String
  {
    return self.stringWithDateStyle(dateStyle: .none, timeStyle: .long)
  }
  
  func longDateString() -> String
  {
    return self.stringWithDateStyle(dateStyle: .long, timeStyle: .none)
  }
  
  func isEqualToDateIgnoringTime(date: Date) -> Bool
  {
    let dateComponent1 = Date.currentCalendar().dateComponents([.year, .month, .day, .weekOfMonth, .hour, .minute, .second, .weekday, .weekdayOrdinal], from: self)
    
    let dateComponent2 = Date.currentCalendar().dateComponents([.year, .month, .day, .weekOfMonth, .hour, .minute, .second, .weekday, .weekdayOrdinal], from: date)
    
    return (dateComponent1.year == dateComponent2.year) && (dateComponent1.month == dateComponent2.month) && (dateComponent1.day == dateComponent2.day)
  }
  
  func isLessThanTime(date: Date) -> Bool
  {
    let dateComponent1 = Date.currentCalendar().dateComponents([.hour, .minute, .second], from: self)
    let dateComponent2 = Date.currentCalendar().dateComponents([.hour, .minute, .second], from: date)
    
    return (dateComponent1.hour! < dateComponent2.hour!)
  }
  
  func isToday() -> Bool
  {
    return self.isEqualToDateIgnoringTime(date: Date())
  }
  
  func isTomorrow() -> Bool
  {
    return self.isEqualToDateIgnoringTime(date: Date.dateTomorrow())
  }
  
  func isYesterday() -> Bool
  {
    return self.isEqualToDateIgnoringTime(date: Date.dateYesterday())
  }
  
  func isSameWeekAsDate(date: Date) -> Bool
  {
    let dateComponent1 = Date.currentCalendar().dateComponents([.year, .month, .day, .weekOfMonth, .hour, .minute, .second, .weekday, .weekdayOrdinal], from: self)
    
    let dateComponent2 = Date.currentCalendar().dateComponents([.year, .month, .day, .weekOfMonth, .hour, .minute, .second, .weekday, .weekdayOrdinal], from: date)
    
    if dateComponent1.weekOfMonth != dateComponent2.weekOfMonth
    {
      return false
    }
    return self.timeIntervalSince(date) < D_WEEK
  }
  
  func isThisWeek() -> Bool
  {
    return self.isSameWeekAsDate(date: Date())
  }
  
  func isNextWeek() -> Bool
  {
    let timeInterval = Date().timeIntervalSinceReferenceDate + D_WEEK
    let newDate = Date(timeIntervalSinceReferenceDate: timeInterval)
    
    return self.isSameWeekAsDate(date: newDate)
  }
  
  func isLastWeek() -> Bool
  {
    let timeInterval = Date().timeIntervalSinceReferenceDate - D_WEEK
    let newDate = Date(timeIntervalSinceReferenceDate: timeInterval)
    
    return self.isSameWeekAsDate(date: newDate)
  }
  
  func isSameMonthAsDate(date: Date) -> Bool
  {
    let dateComponent1 = Date.currentCalendar().dateComponents([.year, .month], from: self)
    let dateComponent2 = Date.currentCalendar().dateComponents([.year, .month], from: date)
    
    return (dateComponent1.year == dateComponent2.year) && (dateComponent1.month == dateComponent2.month)
  }
  
  func isThisMonth() -> Bool
  {
    return self.isSameMonthAsDate(date: Date())
  }
  
  func isLastMonth() -> Bool
  {
    return self.isSameMonthAsDate(date: Date().dateBySubstractingMonth(month: 1))
  }
  
  func isNextMonth() -> Bool
  {
    return self.isSameMonthAsDate(date: Date().dateByAddingMonth(month: 1))
  }
  
  func isSameYearAsDate(date: Date) -> Bool
  {
    let dateComponent1 = Date.currentCalendar().dateComponents([.year], from: self)
    let dateComponent2 = Date.currentCalendar().dateComponents([.year], from: date)
    
    return (dateComponent1.year == dateComponent2.year)
  }
  
  func isThisYear() -> Bool
  {
    return self.isSameYearAsDate(date: Date())
  }
  
  func isNextYear() -> Bool
  {
    let dateComponent1 = Date.currentCalendar().dateComponents([.year], from: self)
    let dateComponent2 = Date.currentCalendar().dateComponents([.year], from: Date())
    
    return dateComponent1.year == (dateComponent2.year! + 1)
  }
  
  func isLastYear() -> Bool
  {
    let dateComponent1 = Date.currentCalendar().dateComponents([.year], from: self)
    let dateComponent2 = Date.currentCalendar().dateComponents([.year], from: Date())
    
    return dateComponent1.year! == (dateComponent2.year! - 1)
  }
  
  func isEarlierThanDate(date: Date) -> Bool
  {
    return self.compare(date) == .orderedAscending
  }
  
  func isLaterThanDate(date: Date) -> Bool
  {
    return self.compare(date) == .orderedDescending
  }
  
  func isInPast() -> Bool
  {
    return self.isEarlierThanDate(date: Date())
  }
  
  func isInFuture() -> Bool
  {
    return self.isLaterThanDate(date: Date())
  }
  
  func isTypicallyWeekend() -> Bool
  {
    let components = Date.currentCalendar().dateComponents([.weekday], from: self)
    
    if components.weekday == 1 || components.weekday == 7
    {
      return true
    }
    return false
  }
  
  func isTypicallyWorkday() -> Bool
  {
    return !self.isTypicallyWeekend()
  }
  
  func dateAtStartOfDay() -> Date
  {
    var dateComponent = Date.currentCalendar().dateComponents([.year, .month, .day, .weekOfMonth, .hour, .minute, .second, .weekday, .weekdayOrdinal], from: self)

    dateComponent.hour = 0
    dateComponent.minute = 0
    dateComponent.second = 0
    return Date.currentCalendar().date(from: dateComponent)!
  }
  
  func dateAtEndOfDay() -> Date
  {
    var dateComponent = Date.currentCalendar().dateComponents([.year, .month, .day, .weekOfMonth, .hour, .minute, .second, .weekday, .weekdayOrdinal], from: self)
    
    dateComponent.hour = 23
    dateComponent.minute = 59
    dateComponent.second = 59
    return Date.currentCalendar().date(from: dateComponent)!
  }
  
  func minutesAfterDate(date: Date) -> NSInteger
  {
    let ti = self.timeIntervalSince(date)
    return NSInteger(ti / D_MINUTE)
  }
  
  func minutesBeforeDate(date: Date) -> NSInteger
  {
    let ti = date.timeIntervalSince(self)
    return NSInteger(ti / D_MINUTE)
  }
  
  func hoursBeforeDate(date: Date) -> NSInteger
  {
    let ti = date.timeIntervalSince(self)
    return NSInteger(ti / D_HOUR)
  }
  
  func hoursAfterDate(date: Date) -> NSInteger
  {
    let ti = self.timeIntervalSince(date)
    return NSInteger(ti / D_HOUR)
  }
  
  func daysBeforeDate(date: Date) -> NSInteger
  {
    let ti = date.timeIntervalSince(self)
    return NSInteger(ti / D_DAY)
  }
  
  func daysAfterDate(date: Date) -> NSInteger
  {
    let ti = self.timeIntervalSince(date)
    return NSInteger(ti / D_DAY)
  }
  
  func yearsBeforeDate(date: Date) -> NSInteger
  {
    let ti = date.timeIntervalSince(self)
    return NSInteger(ti / D_YEAR)
  }
  
  func yearsAfterDate(date: Date) -> NSInteger
  {
    let ti = self.timeIntervalSince(date)
    return NSInteger(ti / D_YEAR)
  }
  
  func nearestHour() -> NSInteger
  {
    let timeInterval = Date().timeIntervalSinceReferenceDate + (30.0 * D_MINUTE)
    let newDate = Date(timeIntervalSinceReferenceDate: timeInterval)
    
    let dateComponent = Date.currentCalendar().dateComponents([.hour], from: newDate)
    return dateComponent.hour!
  }
  
  func hour() -> NSInteger
  {
    let dateComponent = Date.currentCalendar().dateComponents([.year, .month, .day, .weekOfMonth, .hour, .minute, .second, .weekday, .weekdayOrdinal], from: self)
    return dateComponent.hour!
  }
  
  func minute() -> NSInteger
  {
    let dateComponent = Date.currentCalendar().dateComponents([.year, .month, .day, .weekOfMonth, .hour, .minute, .second, .weekday, .weekdayOrdinal], from: self)
    return dateComponent.minute!
  }
  
  func seconds() -> NSInteger
  {
    let dateComponent = Date.currentCalendar().dateComponents([.year, .month, .day, .weekOfMonth, .hour, .minute, .second, .weekday, .weekdayOrdinal], from: self)
    return dateComponent.second!
  }
  
  func day() -> NSInteger
  {
    let dateComponent = Date.currentCalendar().dateComponents([.year, .month, .day, .weekOfMonth, .hour, .minute, .second, .weekday, .weekdayOrdinal], from: self)
    return dateComponent.day!
  }
  
  func month() -> NSInteger
  {
    let dateComponent = Date.currentCalendar().dateComponents([.year, .month, .day, .weekOfMonth, .hour, .minute, .second, .weekday, .weekdayOrdinal], from: self)
    return dateComponent.month!
  }
  
  func week() -> NSInteger
  {
    let dateComponent = Date.currentCalendar().dateComponents([.year, .month, .day, .weekOfMonth, .hour, .minute, .second, .weekday, .weekdayOrdinal], from: self)
    return dateComponent.weekOfMonth!
  }
  
  func weekday() -> NSInteger
  {
    let dateComponent = Date.currentCalendar().dateComponents([.year, .month, .day, .weekOfMonth, .hour, .minute, .second, .weekday, .weekdayOrdinal], from: self)
    return dateComponent.weekday!
  }
  
  func nthWeekday() -> NSInteger
  {
    let dateComponent = Date.currentCalendar().dateComponents([.year, .month, .day, .weekOfMonth, .hour, .minute, .second, .weekday, .weekdayOrdinal], from: self)
    return dateComponent.weekdayOrdinal!
  }
  
  func year() -> NSInteger
  {
    let dateComponent = Date.currentCalendar().dateComponents([.year, .month, .day, .weekOfMonth, .hour, .minute, .second, .weekday, .weekdayOrdinal], from: self)
    return dateComponent.year!
  }
  
  func stringWithFormat(format: String) -> String{
    
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
    dateFormatter.dateFormat = format
    
    return dateFormatter.string(from: self)
  }
  
  func stringWithFormatWithOutTimeZone(format: String) -> String{
    
    let dateFormatter = DateFormatter()
    //dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
    dateFormatter.dateFormat = format
    
    return dateFormatter.string(from: self)
  }
  
  func dateByAddingMinutes(minutes: NSInteger) -> Date
  {
    let timeInterval = self.timeIntervalSinceReferenceDate + (Double(minutes) * D_MINUTE)
    let newDate = Date(timeIntervalSinceReferenceDate: timeInterval)
    
    return newDate
  }
  
  func dateBySubstractingMinutes(minutes: NSInteger) -> Date
  {
    return dateByAddingMinutes(minutes: minutes * -1)
  }
  
  func dateByAddingHours(hours: NSInteger) -> Date
  {
    let timeInterval = self.timeIntervalSinceReferenceDate + (Double(hours) * D_HOUR)
    let newDate = Date(timeIntervalSinceReferenceDate: timeInterval)
    
    return newDate
  }
  
  func dateBySubstractingHours(hours: NSInteger) -> Date
  {
    return dateByAddingHours(hours: hours * -1)
  }
  
  func dateByAddingDays(days: NSInteger) -> Date
  {
    var dateComponents = DateComponents()
    dateComponents.day = days
    
    if self.day() == 1 && days < 0
    {
      dateComponents.month = -1
    }
    else if self.day() == self.lastDayOfMonth().day() && days >= 1
    {
      dateComponents.month = 1
      switch self.month()
      {
      case 2:
        dateComponents.day = dateComponents.day! + 3
      case 4,6,9,11:
        dateComponents.day = dateComponents.day! + 1
      default:
        break
      }
      
    }
    
    let newDate = Calendar.current.date(byAdding: dateComponents, to: self, wrappingComponents: true)
    return newDate!
  }
  
  func dateBySubstractingDays(days: NSInteger) -> Date
  {
    return self.dateByAddingDays(days: days * -1)
  }
  
  func dateByAddingMonth(month: NSInteger) -> Date
  {
    var dateComponents = DateComponents()
    dateComponents.month = month
    
    let newDate = Calendar.current.date(byAdding: dateComponents, to: self, wrappingComponents: true)
    return newDate!
  }
    
    func dateByAdding(days: Int = 0, months: Int = 0, years: Int = 0) -> Date {
        
        let calendar = Calendar.current
        var dateComponents =  DateComponents()
        dateComponents.day = days
        dateComponents.month = months
        dateComponents.year = years
        let newDate = calendar.date(byAdding: dateComponents, to: self)
        return newDate!
    }

  func dateBySubstractingMonth(month: NSInteger) -> Date
  {
    return self.dateByAddingMonth(month: month * -1)
  }
  
  func dateByAddingYear(year: NSInteger) -> Date
  {
    var dateComponents = DateComponents()
    dateComponents.year = year
    
    let newDate = Calendar.current.date(byAdding: dateComponents, to: self, wrappingComponents: true)
    return newDate!
  }
  
  func dateBySubstractingYear(year: NSInteger) -> Date
  {
    return self.dateByAddingYear(year: year * -1)
  }

  func dateToString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

func stringToDate(_ str: String, _ format: String) -> Date?
{
    let formatter = DateFormatter()
    formatter.dateFormat = format
    if str == ""
    {
      return nil
    }
    return formatter.date(from: str)
}

func getCurrentDate() -> Date
{
    var now = Date()
    var nowComponents = DateComponents()
    let calendar = Calendar.current
    nowComponents.year = Calendar.current.component(.year, from: now)
    nowComponents.month = Calendar.current.component(.month, from: now)
    nowComponents.day = Calendar.current.component(.day, from: now)
    nowComponents.hour = Calendar.current.component(.hour, from: now)
    nowComponents.minute = Calendar.current.component(.minute, from: now)
    nowComponents.second = Calendar.current.component(.second, from: now)
    nowComponents.timeZone = NSTimeZone.local
    now = calendar.date(from: nowComponents)!
    return now as Date
}

func getAge(dob: String) -> String{
  
  if dob.isEmpty == true{
    return ""
  }
  else{
    
   let dob = stringToDate(dob,"dd/MM/yyyy")!
   let age = Calendar.current.dateComponents([.month], from: dob, to: Date()).month!
   return String.getString(age/12)
  }
}

func UTCToLocalTime(UTCDateString: String,format: String) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format //Input Format
    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
    let UTCDate = dateFormatter.date(from: UTCDateString)
    dateFormatter.dateFormat = format // Output Format
    dateFormatter.timeZone = TimeZone.current
    let UTCToCurrentFormat = dateFormatter.string(from: UTCDate!)
    return UTCToCurrentFormat
}


func findDateDiff(time1Str: String, time2Str: String) -> (Int,Int,Int) {
  
  let timeformatter = DateFormatter()
  timeformatter.dateFormat = "HH:mm:ss"
  
  guard let time1 = timeformatter.date(from: time1Str),
    let time2 = timeformatter.date(from: time2Str) else { return (0,0,0) }
  
  let interval = time2.timeIntervalSince(time1)
  
  let hour = interval / 3600;
  let minute = interval.truncatingRemainder(dividingBy: 3600) / 60
  let seconds = Int(interval) % 60
  
  return(Int(hour),Int(minute),seconds)
  //return "\(intervalInt < 0 ? "-" : "+") \(Int(hour)) Hours \(Int(minute)) Minutes"
}


func timeString(time:TimeInterval,format: String = "%02i:%02i:%02i") -> String {
  
  let hours = Int(time) / 3600
  let minutes = Int(time) / 60 % 60
  let seconds = Int(time) % 60
  return String(format: format, hours, minutes, seconds)
}

func timeStringMinAndSec(time:TimeInterval,format: String = "%02i:%02i") -> String {
  
  _ = Int(time) / 3600
  let minutes = Int(time) / 60 % 60
  let seconds = Int(time) % 60
  return String(format: format, minutes, seconds)
}
