//
//  FalseRule.swift
//  Pods
//
//  Created by Siwasit Anmahapong on 11/14/17.
//
//

import Foundation

open class FalseRule: Rule {
  
  public init() {}
  
  open func validate(candidate: Any?) -> Bool {
    if let candidate = candidate as? NSNumber {
      return candidate.boolValue == false
    } else {
      return candidate as? Bool == false
    }
  }
  
}
