//
//  TrueRule.swift
//  Pods
//
//  Created by Siwasit Anmahapong on 11/14/17.
//
//

import Foundation

open class TrueRule: NSObject, Rule {
  
  open func validate(candidate: Any?) -> Bool {
    if let candidate = candidate as? NSNumber {
      return candidate.boolValue
    } else {
      return candidate as? Bool == true
    }
  }
  
}
