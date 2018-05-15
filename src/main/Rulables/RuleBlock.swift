//
//  RulableBlock.swift
//  Pods
//
//  Created by Siwasit Anmahapong on 11/14/17.
//
//

import Foundation

public class RuleBlock: NSObject, Rulable {
  
  private var block: (()->Any?)!
  
  public init(_ block: @escaping ()->Any?) {
    self.block = block
  }
  
  public var candidateValue: Any? {
    return block()
  }
  
}
