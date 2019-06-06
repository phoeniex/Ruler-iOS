//
//  RegexRule.swift
//  Pods
//
//  Created by Siwasit Anmahapong on 11/14/17.
//
//

import Foundation

open class RegexRule: StringRule {
  
  private var expression: NSRegularExpression!
  
  public required init(expression: NSRegularExpression) {
    super.init()
    self.expression = expression
  }
  
  public convenience init(pattern: String) throws {
    let expression = try NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
    self.init(expression: expression)
  }
  
  open override func validate(string: String) -> Bool {
    let matches = expression.matches(in: string, range: NSRange(location: 0, length: string.count))
    return matches.count > 0
  }
}
