//
//  Ruler.swift
//  Pods
//
//  Created by Siwasit Anmahapong on 11/14/17.
//
//

import Foundation

public protocol Rulable {
  var candidateValue: Any? { get }
}

open class Ruler: NSObject {
  
  private var candidates: [Candidate] = []
  
  open func add(_ rulable: Rulable? = nil, rule: Rule, userInfo: Any? = nil) {
    let candidate = Candidate(rulable: rulable, rule: rule, userInfo: userInfo)
    candidates.append(candidate)
  }
  
  open func add(_ rulable: Rulable, rules: [Rule], userInfo: Any? = nil) {
    for rule in rules {
      add(rulable, rule: rule, userInfo: userInfo)
    }
  }
  
  open func add(_ rulable: Rulable, rules: [(rule: Rule, userInfo: Any)]) {
    for info in rules {
      add(rulable, rule: info.rule, userInfo: info.userInfo)
    }
  }
  
  open func validate() -> RuleError? {
    for candidate in candidates {
      guard candidate.validate() else {
        return candidate.error
      }
    }
    return nil
  }
  
  open func validateAll() -> [RuleError] {
    var errors: [RuleError] = []
    for candidate in candidates {
      if !candidate.validate() {
        errors.append(candidate.error)
      }
    }
    return errors
  }
  
}

private struct Candidate {
  var rulable: Rulable?
  var rule: Rule
  var userInfo: Any?
  
  func validate() -> Bool {
    return rule.validate(candidate: rulable?.candidateValue)
  }
  
  var error: RuleError {
    return RuleError(candidate: rulable, rule: rule, userInfo: userInfo)
  }
}
