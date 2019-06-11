//
//  StringValidateRule.swift
//  Pods
//
//  Created by Siwasit Anmahapong on 11/14/17.
//
//

import Foundation

open class StringRule: Rule {
  
  public init() {}
  
  open func validate(candidate: Any?) -> Bool {
    guard let string = candidate as? String else {
      return false
    }
    return validate(string: string)
  }
  
  open func validate(string: String) -> Bool {
    return true
  }
  
}
