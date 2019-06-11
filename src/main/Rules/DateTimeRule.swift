//
//  DateRule.swift
//  Pods
//
//  Created by Rawipon Srivibha on 2/22/18.
//
//

import Foundation

open class DateTimeRule: Rule {
  private var minimumDate: Date
  private var maximumDate: Date
  private var dateFormatter: DateFormatter!
  
  // Default of validate length is current date to next 100 years
  public required init(min: Date?, max: Date?, formatter: String?) {
    //set default, if not
    minimumDate = min ?? Date()
    maximumDate = max ?? Date(timeIntervalSinceNow: 31557600 * 100)
    
    dateFormatter = DateFormatter()
    dateFormatter.dateFormat = formatter ?? "dd/MM/yy-hh:mm:ss"
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    dateFormatter.locale = Locale.current
  }
  
  open func validate(candidate: Any?) -> Bool {
    if let candidate = candidate as? Date {
      return isInRange(date: candidate)
    } else if let candidate = candidate as? String {
      // convert to Date
      guard let dateFormatter = dateFormatter else { return false }
      guard let date = dateFormatter.date(from: candidate) else { return false }
      return isInRange(date: date)
    } else {
      return false
    }
  }
  
  private func isInRange(date: Date) -> Bool {
    if date <= minimumDate { return false }
    if date >= maximumDate { return false }
    return true
  }
}
