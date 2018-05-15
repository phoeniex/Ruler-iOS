//
//  StringRangeRule.swift
//  Pods
//
//  Created by Siwasit Anmahapong on 11/14/17.
//
//

import Foundation

open class StringRangeRule: StringRule {
  
  private var range: ClosedRange<Int>!
  private var inverted: Bool = false
  
  public required init(_ range: ClosedRange<Int>, inverted: Bool = false) {
    self.range = range
    self.inverted = inverted
  }
  
  public convenience init(min: Int = 0, max: Int = Int.max, inverted: Bool = false) {
    self.init(min...max, inverted: inverted)
  }
  
  open override func validate(string: String) -> Bool {
    return range.contains(string.count) == !inverted
  }
  
}
