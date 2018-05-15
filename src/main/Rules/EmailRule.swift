//
//  EmailRule.swift
//  Pods
//
//  Created by Siwasit Anmahapong on 11/14/17.
//
//

import Foundation

open class EmailRule: RegexRule {
  
  public convenience init() {
    do {
      try self.init(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
    } catch {
      fatalError("Cannot init EmailRule")
    }
  }
  
}
