//
//  RuleError.swift
//  Pods
//
//  Created by Siwasit Anmahapong on 11/14/17.
//
//

import Foundation

open class RuleError<UserInfoType> {
  
  open var candidate: Any?
  open var rule: Rule!
  open var userInfo: UserInfoType?
  
  public init(candidate: Any?, rule: Rule, userInfo: UserInfoType?) {
    self.candidate = candidate
    self.rule = rule
    self.userInfo = userInfo
  }
  
}
