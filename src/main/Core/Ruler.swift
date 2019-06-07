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

open class Ruler<UserInfoType> {
  
  private var candidates: [Candidate<UserInfoType>] = []
  
  public init() {}
  
  open func add(_ rulable: Rulable? = nil, rule: Rule, userInfo: UserInfoType? = nil) {
    let candidate = Candidate(rulable: rulable, rule: rule, userInfo: userInfo)
    candidates.append(candidate)
  }
  
  open func add(_ rulable: Rulable, rules: [Rule], userInfo: UserInfoType? = nil) {
    for rule in rules {
      add(rulable, rule: rule, userInfo: userInfo)
    }
  }
  
  open func add(_ rulable: Rulable, rules: [(rule: Rule, userInfo: UserInfoType)]) {
    for info in rules {
      add(rulable, rule: info.rule, userInfo: info.userInfo)
    }
  }
  
  open func validate() -> RuleError<UserInfoType>? {
    for candidate in candidates {
      guard candidate.validate() else {
        return candidate.error
      }
    }
    return nil
  }
  
  open func validateAll() -> [RuleError<UserInfoType>] {
    var errors: [RuleError<UserInfoType>] = []
    for candidate in candidates {
      if !candidate.validate() {
        errors.append(candidate.error)
      }
    }
    return errors
  }
  
}

private struct Candidate<UserInfoType> {
  var rulable: Rulable?
  var rule: Rule
  var userInfo: UserInfoType?
  
  func validate() -> Bool {
    return rule.validate(candidate: rulable?.candidateValue)
  }
  
  var error: RuleError<UserInfoType> {
    return RuleError(candidate: rulable, rule: rule, userInfo: userInfo)
  }
}
